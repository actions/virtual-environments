################################################################################
##  File:  Install-AWS.ps1
##  Desc:  Install AWS tools(AWS CLI, Session Manager Plugin for the AWS CLI, AWS SAM CLI)
################################################################################

# Install AWS CLI
Choco-Install -PackageName awscli

# Install Session Manager Plugin for the AWS CLI
$sessionManagerName = "SessionManagerPluginSetup.exe"
$sessionManagerUrl = "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/windows/$sessionManagerName"
Install-Binary -Url $sessionManagerUrl -Name $sessionManagerName -ArgumentList ("/silent", "/install")
$env:Path = $env:Path + ";$env:ProgramFiles\Amazon\SessionManagerPlugin\bin"

# Install AWS SAM CLI
Install-Binary -Url "https://github.com/awslabs/aws-sam-cli/releases/latest/download/AWS_SAM_CLI_64_PY3.msi" -Name "AWS_SAM_CLI_64_PY3.msi"

Invoke-PesterTests -TestFile "CLI.Tools" -TestName "AWS"