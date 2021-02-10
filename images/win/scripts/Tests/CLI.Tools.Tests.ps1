
Describe "Azure CLI" {
    It "Azure CLI" {
        "az --version" | Should -ReturnZeroExitCode
    }
}

Describe "Azure DevOps CLI" {
    It "az devops" {
        "az devops -h" | Should -ReturnZeroExitCode
    }
}

Describe "Aliyun CLI" {
    It "Aliyun CLI" {
        "aliyun version" | Should -ReturnZeroExitCode
    }
}


Describe "AWS" {
    It "AWS CLI" {
        "aws --version" | Should -ReturnZeroExitCode
    }

    It "Session Manager Plugin for the AWS CLI" {
        session-manager-plugin | Out-String | Should -Match "plugin was installed successfully"
    }

    It "AWS SAM CLI" {
        "sam --version" | Should -ReturnZeroExitCode
    }
}


Describe "GitHub CLI" {
    It "gh" {
        "gh --version" | Should -ReturnZeroExitCode
    }
}

Describe "CloudFoundry CLI" {
    It "cf is located in C:\cf-cli" {
        "C:\cf-cli\cf.exe" | Should -Exist
    }

    It "cf" {
        "cf --version" | Should -ReturnZeroExitCode
    }
}

Describe "Hub CLI" {
    It "hub is installed" {
        "hub --version" | Should -ReturnZeroExitCode
    }
}

Describe "Azure Dev Spaces CLI" {
    It "Azure Dev Spaces CLI" {
        "azds --version" | Should -ReturnZeroExitCode
    }
}