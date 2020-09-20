Describe "Chrome" {
    Context "WebDriver" {
        It "ChromeWebDriver environment variable and path exists" {
            $env:ChromeWebDriver | Should -Not -BeNullOrEmpty
            $env:ChromeWebDriver | Should -BeExactly "C:\SeleniumWebDrivers\ChromeDriver"
            $env:ChromeWebDriver | Should -Exist
        }

        It "chromedriver.exe is installed" {
            "$env:ChromeWebDriver\chromedriver.exe --version" | Should -ReturnZeroExitCode
        }

        It "versioninfo.txt exists" {
            "$env:ChromeWebDriver\versioninfo.txt" | Should -Exist
        }
    }

    Context "Browser" {
        $chromeRegPath = "HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe"
        $chromePath = (Get-ItemProperty $chromeRegPath).'(default)'

        It "Chrome '<chromeRegPath>' registry path exists" -TestCases @{chromeRegPath = $chromeRegPath} {
            $chromeRegPath | Should -Exist
        }

        It "Chrome VersionInfo registry value exists" -TestCases @{chromePath = $chromePath} {
            $versionInfo = (Get-Item $chromePath).VersionInfo
            $versionInfo | Should -Not -BeNullOrEmpty
        }

        It "gupdate service is stopped" {
            $svc = Get-Service -Name gupdate
            $svc.Status | Should -BeExactly Stopped
        }

        It "gupdatem service is stopped" {
            $svc = Get-Service -Name gupdatem
            $svc.Status | Should -BeExactly Stopped
        }

        It "BlockGoogleUpdate firewall rule exists" {
            Get-NetFirewallRule -DisplayName BlockGoogleUpdate | Should -Not -BeNullOrEmpty
        }

        It "<chromePath> is installed" -TestCases @{chromePath = $chromePath} {
            $chromeName = (Get-Item $chromePath).Name
            $chromePath | Should -Exist
            $chromeName | Should -BeExactly "chrome.exe"
        }
    }
}

Describe "Edge" {
    Context "WebDriver" {
        It "EdgeWebDriver environment variable and path exists" {
            $env:EdgeWebDriver | Should -Not -BeNullOrEmpty
            $env:EdgeWebDriver | Should -BeExactly "C:\SeleniumWebDrivers\EdgeDriver"
            $env:EdgeWebDriver | Should -Exist
        }

        It "msedgedriver.exe is installed" {
            "$env:EdgeWebDriver\msedgedriver.exe --version" | Should -ReturnZeroExitCode
        }

        It "versioninfo.txt exists" {
            "$env:EdgeWebDriver\versioninfo.txt" | Should -Exist
        }
    }

    Context "Browser" {
        $edgeRegPath = "HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\msedge.exe"

        It "Edge '<edgeRegPath>' registry path exists" -TestCases @{edgeRegPath = $edgeRegPath} {
            $edgeRegPath | Should -Exist
        }

        It "Edge VersionInfo registry value exists" -TestCases @{edgeRegPath = $edgeRegPath} {
            $versionInfo = (Get-Item (Get-ItemProperty $edgeRegPath).'(Default)').VersionInfo
            $versionInfo | Should -Not -BeNullOrEmpty
        }

        It "msedge.exe is installed" {
            "${env:ProgramFiles(x86)}\Microsoft\Edge\Application\msedge.exe" | Should -Exist
        }
    }
}

Describe "Firefox" {
    Context "WebDriver" {
        It "GeckoWebDriver environment variable and path exists" {
            $env:GeckoWebDriver | Should -Not -BeNullOrEmpty
            $env:GeckoWebDriver | Should -BeExactly "C:\SeleniumWebDrivers\GeckoDriver"
            $env:GeckoWebDriver | Should -Exist
        }

        It "geckodriver.exe is installed" {
            "$env:GeckoWebDriver\geckodriver.exe --version" | Should -ReturnZeroExitCode
        }

        It "versioninfo.txt exists" {
            "$env:GeckoWebDriver\versioninfo.txt" | Should -Exist
        }
    }

    Context "Browser" {
        $firefoxRegPath = "HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\firefox.exe"

        It "Firefox '<firefoxRegPath>' registry path exists" -TestCases @{firefoxRegPath = $firefoxRegPath} {
            $firefoxRegPath | Should -Exist
        }

        It "Firefox VersionInfo registry value exists" -TestCases @{firefoxRegPath = $firefoxRegPath} {
            $versionInfo = (Get-Item (Get-ItemProperty $firefoxRegPath).'(Default)').VersionInfo
            $versionInfo | Should -Not -BeNullOrEmpty
        }

        It "firefox.exe is installed" {
            "$env:ProgramFiles\Mozilla Firefox\firefox.exe" | Should -Exist
        }
    }
}

Describe "Internet Explorer" {
    Context "WebDriver" {
        It "IEWebDriver environment variable and path exists" {
            $env:IEWebDriver | Should -Not -BeNullOrEmpty
            $env:IEWebDriver | Should -BeExactly "C:\SeleniumWebDrivers\IEDriver"
            $env:IEWebDriver | Should -Exist
        }

        It "iedriverserver.exe is installed" {
            "$env:IEWebDriver\IEDriverServer.exe --version" | Should -ReturnZeroExitCode
        }

        It "versioninfo.txt exists" {
            "$env:IEWebDriver\versioninfo.txt" | Should -Exist
        }
    }
}

Describe "Selenium" {
    It "Selenium 'C:\selenium' path exists" {
        "C:\selenium" | Should -Exist
    }

    It "Selenium Server 'selenium-server-standalone.jar' is installed" {
        "C:\selenium\selenium-server-standalone.jar" | Should -Exist
    }

    It "SELENIUM_JAR_PATH environment variable exists" {
        Get-EnvironmentVariable "SELENIUM_JAR_PATH" | Should -BeExactly "C:\selenium\selenium-server-standalone.jar"
    }
}