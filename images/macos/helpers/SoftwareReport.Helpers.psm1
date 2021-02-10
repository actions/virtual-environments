function Run-Command {
    param (
        [Parameter(Mandatory=$true)]
        [string] $Command,
        [switch] $SuppressStderr
    )
    # Bash trick to suppress and show error output because some commands write to stderr (for example, "python --version")
    $redirectOutputArguments = If ($SuppressStderr) { "2> /dev/null" } Else { "2>&1" }
    $stdout = & bash -c "${Command} ${redirectOutputArguments}"

    return $stdout
}

function Take-Part {
    param (
        [Parameter(ValueFromPipeline)]
        [string] $toolOutput,
        [string] $Delimiter = " ",
        [int[]] $Part
    )
    $parts = $toolOutput.Split($Delimiter, [System.StringSplitOptions]::RemoveEmptyEntries)
    $selectedParts = $parts[$Part]
    return [string]::Join($Delimiter, $selectedParts)
}

function New-MDNewLine {
    param (
        [int] $Count = 1
    )
    $newLineSymbol = [System.Environment]::NewLine
    return $newLineSymbol * $Count
}
