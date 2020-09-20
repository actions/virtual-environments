function Get-BrowserSection {
    return New-MDList -Style Unordered -Lines @(
        (Get-SafariVersion),
        (Get-SafariDriverVersion),
        (Get-ChromeVersion),
        (Get-ChromeDriverVersion),
        (Get-EdgeVersion),
        (Get-EdgeDriverVersion),
        (Get-FirefoxVersion),
        (Get-GeckodriverVersion)
    )
}

function Get-SafariVersion {
    $version = Run-Command "defaults read /Applications/Safari.app/Contents/Info CFBundleShortVersionString"
    $build = Run-Command "defaults read /Applications/Safari.app/Contents/Info CFBundleVersion"
    "Safari $version ($build)"
}

function Get-SafariDriverVersion {
    $version = Run-Command "safaridriver --version" | Take-Part -Part 3,4
    "SafariDriver $version"
}

function Get-ChromeVersion {
    $chromePath = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
    return Run-Command "'${chromePath}' --version"
}

function Get-ChromeDriverVersion {
    $rawOutput = Run-Command "chromedriver --version"
    $version = $rawOutput | Take-Part -Part 1
    return "ChromeDriver ${version}"
}

function Get-EdgeVersion {
    $edgePath = "/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge"
    return Run-Command "'${edgePath}' --version"
}

function Get-EdgeDriverVersion {
    return Run-Command "msedgedriver --version" | Take-Part -Part 0,1
}

function Get-FirefoxVersion {
    $firefoxPath = "/Applications/Firefox.app/Contents/MacOS/firefox"
    return Run-Command "'${firefoxPath}' --version"
}

function Get-GeckodriverVersion {
    return Run-Command "geckodriver --version" | Select-Object -First 1
}