param(
    [String] [Parameter (Mandatory=$true)] $RepoUrl,
    [String] [Parameter (Mandatory=$true)] $RepoBranch
)

Write-Host "Clean up default repository"
Remove-Item -path './*' -Recurse -Force

Write-Host "Download ${RepoBranch} branch from ${RepoUrl}"
$env:GIT_REDIRECT_STDERR = '2>&1'
git clone $RepoUrl . -b $RepoBranch --single-branch --depth 1

Write-Host "Latest commit:"
git log --pretty=format:"Date: %cd; Commit: %H - %s; Author: %an <%ae>" -1