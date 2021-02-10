$latestPath = [System.Environment]::GetEnvironmentVariable('PATH', [System.EnvironmentVariableTarget]::Machine)
$dotnetPath = "$env:USERPROFILE\.dotnet\tools"

if (-not $latestPath.Contains($dotnetPath))
{
    $latestPath = "$dotnetPath;$latestPath"
    [System.Environment]::SetEnvironmentVariable('PATH', $latestPath, [System.EnvironmentVariableTarget]::Machine)
}