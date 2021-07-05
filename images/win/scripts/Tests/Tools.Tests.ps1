Import-Module (Join-Path $PSScriptRoot "..\SoftwareReport\SoftwareReport.Common.psm1") -DisableNameChecking

Describe "7-Zip" {
    It "7z" {
        "7z" | Should -ReturnZeroExitCode
    }
}

Describe "Aria2" {
    It "Aria2" {
        "aria2c --version" | Should -ReturnZeroExitCode
    }
}

Describe "AzCopy" {
    It "AzCopy" {
        "azcopy --version" | Should -ReturnZeroExitCode
    }
}

Describe "Azure Cosmos DB Emulator" {
    $cosmosDbEmulatorRegKey = Get-ChildItem "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*" | Get-ItemProperty | Where-Object { $_.DisplayName -eq 'Azure Cosmos DB Emulator' }
    $installDir = $cosmosDbEmulatorRegKey.InstallLocation

    It "Azure Cosmos DB Emulator install location registry key exists" -TestCases @{installDir = $installDir} {
        $installDir | Should -Not -BeNullOrEmpty
    }

    It "Azure Cosmos DB Emulator exe file exists" -TestCases @{installDir = $installDir} {
        $exeFilePath = Join-Path $installDir 'CosmosDB.Emulator.exe'
        $exeFilePath | Should -Exist
    }
}

Describe "Bazel" {
    It "<ToolName>" -TestCases @(
        @{ ToolName = "bazel" }
        @{ ToolName = "bazelisk" }
    ) {
        "$ToolName --version"| Should -ReturnZeroExitCode
    }
}

Describe "Bicep" {
    It "Bicep" {
        "bicep --version" | Should -ReturnZeroExitCode
    }
}

Describe "CMake" {
    It "cmake" {
        "cmake --version" | Should -ReturnZeroExitCode
    }
}

Describe "CodeQLBundle" {
    It "CodeQLBundle" {
        $CodeQLVersionsWildcard = Join-Path $Env:AGENT_TOOLSDIRECTORY -ChildPath "codeql" | Join-Path -ChildPath "*"
        $CodeQLVersionPath = Get-ChildItem $CodeQLVersionsWildcard | Select-Object -First 1 -Expand FullName
        $CodeQLPath = Join-Path $CodeQLVersionPath -ChildPath "x64" | Join-Path -ChildPath "codeql" | Join-Path -ChildPath "codeql.exe"
        "$CodeQLPath version" | Should -ReturnZeroExitCode
    }
}

Describe "R" {
    It "Rscript" {
        "Rscript --version" | Should -ReturnZeroExitCode
    }
}

Describe "DACFx" {
    It "DACFx" {
        (Get-ItemProperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*).DisplayName -Contains "Microsoft SQL Server Data-Tier Application Framework (x64)" | Should -BeTrue
        $sqlPackagePath = 'C:\Program Files\Microsoft SQL Server\150\DAC\bin\SqlPackage.exe'
        $sqlLocalDBPath = 'C:\Program Files\Microsoft SQL Server\130\Tools\Binn\SqlLocalDB.exe'
        "${sqlPackagePath}" | Should -Exist
        "${sqlLocalDBPath}" | Should -Exist
    }
}

Describe "DotnetTLS" {
    It "Tls 1.2 is enabled" {
        [Net.ServicePointManager]::SecurityProtocol -band "Tls12" | Should -Be Tls12
    }
}

Describe "Jq" {
    It "Jq" {
        "jq -n ." | Should -ReturnZeroExitCode
    }
}

Describe "Julia" {
    It "Julia path exists" {
        "C:\Julia" | Should -Exist
    }

    It "Julia" {
        "julia --version" | Should -ReturnZeroExitCode
    }
}

Describe "Mercurial" {
    It "Mercurial" {
        "hg --version" | Should -ReturnZeroExitCode
    }
}

Describe "KubernetesTools" {
    It "Kind" {
        "kind version" | Should -ReturnZeroExitCode
    }

    It "kubectl" {
        "kubectl version --client=true --short=true" | Should -ReturnZeroExitCode
    }

    It "Helm" {
        "helm version --short" | Should -ReturnZeroExitCode
    }

    It "minikube" {
        "minikube version --short" | Should -ReturnZeroExitCode
    }
}

Describe "Mingw64" {
    It "<ToolName>" -TestCases @(
        @{ ToolName = "gcc" }
        @{ ToolName = "g++" }
        @{ ToolName = "make" }
    ) {
        "$ToolName --version" | Should -ReturnZeroExitCode
    }
}

Describe "InnoSetup" {
    It "InnoSetup" {
        (Get-Command -Name iscc).CommandType | Should -BeExactly "Application"
    }
}

Describe "GoogleCloudSDK"  {
    It "<ToolName>" -TestCases @(
        @{ ToolName = "bq" }
        @{ ToolName = "gcloud" }
        @{ ToolName = "gsutil" }
    ) {
        "$ToolName version" | Should -ReturnZeroExitCode
    }
}

Describe "NET48" {
    It "NET48" {
        $netPath = (Get-DotnetFrameworkTools).Path.Split("<")[0]
        ${netPath} + "4.8 Tools" | Should -Exist
    }
}

Describe "NSIS" {
    It "NSIS" {
       "makensis /VERSION" | Should -ReturnZeroExitCode
    }
}

Describe "Nuget" {
    It "Nuget" {
       "nuget" | Should -ReturnZeroExitCode
    }
}

Describe "OpenSSL" {
    It "OpenSSL" {
       "openssl version" | Should -ReturnZeroExitCode
    }
}

Describe "Packer" {
    It "Packer" {
       "packer --version" | Should -ReturnZeroExitCode
    }
}

Describe "Perl" {
    It "Perl" {
       "perl --version" | Should -ReturnZeroExitCode
    }
}

Describe "PowerShell Core" {
    It "pwsh" {
        "pwsh --version" | Should -ReturnZeroExitCode
    }

    It "Execute 2+2 command" {
        pwsh -Command "2+2" | Should -BeExactly 4
    }
}

Describe "Pulumi" {
    It "pulumi" {
       "pulumi version" | Should -ReturnZeroExitCode
    }
}

Describe "Sbt" {
    It "sbt" {
        "sbt --version" | Should -ReturnZeroExitCode
    }
}

Describe "ServiceFabricSDK" {
    It "PowerShell Module" {
        Get-Module -Name ServiceFabric -ListAvailable | Should -Not -BeNullOrEmpty
    }
}

Describe "Svn" {
    It "svn" {
        "svn --version --quiet" | Should -ReturnZeroExitCode
    }
}

Describe "Stack" {
    It "Stack" {
        "stack --version" | Should -ReturnZeroExitCode
    }
}

Describe "Typescript" {
    It "tsc" {
        "tsc --version" | Should -ReturnZeroExitCode
    }
}

Describe "Vcpkg" {
    It "vcpkg" {
      "vcpkg version" | Should -ReturnZeroExitCode
    }

    It "env variable VCPKG_INSTALLATION_ROOT is set" {
      $env:VCPKG_INSTALLATION_ROOT | Should -Not -BeNullOrEmpty
    }

    It "VCPKG_INSTALLATION_ROOT directory" {
        $env:VCPKG_INSTALLATION_ROOT | Should -Exist
    }
}

Describe "VSWhere" {
    It "vswhere" {
        "vswhere" | Should -ReturnZeroExitCode
    }
}

Describe "WebPlatformInstaller" {
    It "WebPlatformInstaller" {
        "WebPICMD" | Should -ReturnZeroExitCode
    }
}

Describe "Zstd" {
    It "zstd" {
        "zstd -V" | Should -ReturnZeroExitCode
    }
}

Describe "Pipx" {
    It "Pipx" {
        "pipx --version" | Should -ReturnZeroExitCode
    }
}

Describe "Swig" {
    It "Swig" {
        "swig -version" | Should -ReturnZeroExitCode
    }
}
