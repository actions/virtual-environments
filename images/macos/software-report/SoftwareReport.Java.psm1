function Get-JavaFullVersion {
    param($JavaRootPath)

    $javaBinPath = Join-Path $javaRootPath "/bin/java"
    $javaVersionOutput = (Get-CommandResult "$javaBinPath -version").Output
    $matchResult = $javaVersionOutput | Select-String '^openjdk version \"([\d\._]+)\"'
    return $matchResult.Matches.Groups[1].Value
}

function Get-JavaVersions {
    $defaultJavaPath = Get-Item env:JAVA_HOME
    $javaVersions = Get-Item env:JAVA_HOME_*_X64
    $sortRules = @{
        Expression = { [Int32]$_.Name.Split("_")[2] }  
        Descending = $false
    }

    return $javaVersions | Sort-Object $sortRules | ForEach-Object {
        $javaPath = $_.Value
        $version = Get-JavaFullVersion $javaPath
        $vendor = $version.StartsWith("1.7") ? "Zulu" : "AdoptOpenJDK"
        $defaultPostfix = ($javaPath -eq $defaultJavaPath) ? " (default)" : ""

        [PSCustomObject] @{
            "Version" = $version + $defaultPostfix
            "Vendor" = $vendor
            "Environment Variable" = $_.Name
        }
    }
}