# Invokes command and validate that the exit code is 0
function Validate-ZeroExitCode($command) {
    $result = Get-CommandResult $command
    $result.ExitCode | Should -Be 0 -Because $result.Output
}

# Validates that tool is installed and in PATH
function Validate-ToolExist($tool) {
    Get-Command $tool -ErrorAction SilentlyContinue | Should -BeTrue
}

function Validate-ArrayWithoutDuplicates {
    param (
        [AllowEmptyCollection()]
        [Parameter(Mandatory = $true)]
        [array] $Items,
        [string] $Because
    )
    $uniqueList = @()
    $Items | ForEach-Object {
        $uniqueList | Should -Not -Contain $_ -Because $Because
        $uniqueList += $_
    }
}

function Validate-Url {
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $Url
    )

    $result = $true
    try {
        $requestResult = Invoke-WebRequest $Url -DisableKeepAlive -UseBasicParsing -Method Head
        $result = ($requestResult.StatusCode -eq 200)
    } catch {
        $result = $false
    }

    $result | Should -BeTrue -Because "'$Url' should be available, but it is not"
}

function Validate-IdenticalFileContent {
    param (
        [Parameter(Mandatory)]
        [string] $File1,
        [Parameter(Mandatory)]
        [string] $File2
    )

    $File1 | Should -Exist -Because "The content of '$File1' should be identical with content of '$File2' but '$File1' doesn't exist"
    $File2 | Should -Exist -Because "The content of '$File1' should be identical with content of '$File2' but '$File2' doesn't exist"

    $content1 = Get-Content -Raw $File1
    $content2 = Get-Content -Raw $File2
    $content1 | Should -Be $content2 -Because "The content of '$File1' should be identical with content of '$File2' but they are different"
}

function ShouldReturnZeroExitCode {
    Param(
        [String] $ActualValue,
        [switch] $Negate,
        [string] $Because # This parameter is unused by we need it to match Pester asserts signature
    )

    $result = Get-CommandResult $ActualValue

    [bool]$succeeded = $result.ExitCode -eq 0
    if ($Negate) { $succeeded = -not $succeeded }

    if (-not $succeeded)
    {
        $commandOutputIndent = " " * 4
        $commandOutput = ($result.Output | ForEach-Object { "${commandOutputIndent}${_}" }) -join "`n"
        $failureMessage = "Command '${ActualValue}' has finished with exit code ${actualExitCode}`n${commandOutput}"
    }

    return [PSCustomObject] @{
        Succeeded      = $succeeded
        FailureMessage = $failureMessage
    }
}

If (Get-Command -Name Add-AssertionOperator -ErrorAction SilentlyContinue) {
    Add-AssertionOperator -Name ReturnZeroExitCode -InternalName ShouldReturnZeroExitCode -Test ${function:ShouldReturnZeroExitCode}
}