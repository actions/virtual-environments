Import-Module "$PSScriptRoot/../helpers/SoftwareReport.Helpers.psm1" -DisableNameChecking

function Get-DotnetVersionList {
    $sdkRawList = Run-Command "dotnet --list-sdks"
    $sdkVersionList = $sdkRawList | ForEach-Object { Take-Part $_ -Part 0 }
    return ".NET SDK " + [string]::Join(" ", $sdkVersionList)
}

function Get-GoVersion {
    $goOutput = Run-Command "go version" | Take-Part -Part 2
    if ($goOutput.StartsWith("go")) {
        $goOutput = $goOutput.Substring(2)
    }

    return $goOutput
}

function Get-RVersion {
    $rVersion = Run-Command "R --version | grep 'R version'" | Take-Part -Part 2
    return "R $rVersion"
}
function Get-RustVersion {
    $rustVersion = Run-Command "rustc --version" | Take-Part -Part 1
    return "${rustVersion}"
}

function Get-Bindgen {
    $bindgenVersion = Run-Command "bindgen --version" | Take-Part -Part 1
    return "Bindgen $bindgenVersion"
}

function Get-Cbindgen {
    $cbindgenVersion = Run-Command "cbindgen --version" | Take-Part -Part 1
    return "Cbindgen $cbindgenVersion"
}

function Get-Cargooutdated {
    $cargoOutdatedVersion = Run-Command "cargo outdated --version" | Take-Part -Part 1
    return "Cargo-outdated $cargoOutdatedVersion"
}

function Get-Cargoaudit {
    $cargoAuditVersion = Run-Command "cargo audit --version" | Take-Part -Part 1
    return "Cargo-audit $cargoAuditVersion"
}

function Get-RustupVersion {
    $rustupVersion = Run-Command "rustup --version" | Take-Part -Part 1
    return "Rustup ${rustupVersion}"
}

function Get-VcpkgVersion {
    $vcpkgVersion = Run-Command "vcpkg version" | Select-Object -First 1 | Take-Part -Part 5 | Take-Part -Part 0 -Delimiter "-"
    return "Vcpkg ${vcpkgVersion}"
}

function Get-GccVersion {
    $versionList = @("8", "9")
    $versionList | Foreach-Object {
        $version = Run-Command "gcc-${_} --version" | Select-Object -First 1
        "$version  — available by ``gcc-${_}`` alias"
    }
}

function Get-FortranVersion {
    $versionList = @("8", "9")
    $versionList | Foreach-Object {
        $version = Run-Command "gfortran-${_} --version" | Select-Object -First 1
        "$version  — available by ``gfortran-${_}`` alias"
    }
}

function Get-ClangLLVMVersion {
    $clangLLVMVersion = Run-Command "$(brew --prefix llvm)/bin/clang --version" | Select-Object -First 1 | Take-Part -Part 2
    "Clang/LLVM $clangLLVMVersion"
}

function Get-NVMVersion {
    $nvmPath = Join-Path $env:HOME ".nvm" "nvm.sh"
    $nvmInitCommand = ". ${nvmPath} > /dev/null 2>&1 || true"
    $nodejsVersion = Run-Command "${nvmInitCommand} && nvm --version"
    return $nodejsVersion
}

function Get-PipVersion {
    param (
        [Parameter(Mandatory)][ValidateRange(2, 3)]
        [int] $Version
    )

    $command = If ($Version -eq 2) { "pip --version" } Else { "pip3 --version" }
    $commandOutput = Run-Command $command
    $versionPart1 = $commandOutput | Take-Part -Part 1
    $versionPart2 = $commandOutput | Take-Part -Part 4
    $versionPart3 = $commandOutput | Take-Part -Part 5
    return "${versionPart1} ${versionPart2} ${versionPart3}"
}

function Get-NVMNodeVersionList {
    $nvmPath = Join-Path $env:HOME ".nvm" "nvm.sh"
    $nvmInitCommand = ". ${nvmPath} > /dev/null 2>&1 || true"
    $nodejsVersionsRaw = Run-Command "${nvmInitCommand} && nvm ls"
    $nodeVersions = $nodejsVersionsRaw | ForEach-Object { $_.TrimStart(" ").TrimEnd(" *") } | Where-Object { $_.StartsWith("v") }
    return [string]::Join(" ", $nodeVersions)
}

function Build-OSInfoSection {
    $fieldsToInclude = @("System Version:", "Kernel Version:")
    $rawSystemInfo = Invoke-Expression "system_profiler SPSoftwareDataType"
    $parsedSystemInfo = $rawSystemInfo | Where-Object { -not ($_ | Select-String -NotMatch $fieldsToInclude) } | ForEach-Object { $_.Trim() }
    $output = ""
    $parsedSystemInfo[0] -match "System Version: macOS (?<version>\d+\.\d+)" | Out-Null
    $version = $Matches.Version
    $output += New-MDHeader "macOS $version info" -Level 1
    $output += New-MDList -Style Unordered -Lines $parsedSystemInfo -NoNewLine
    return $output
}