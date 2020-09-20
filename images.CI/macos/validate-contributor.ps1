param(
    [Parameter(Mandatory)] [string] $RepositoryName,
    [Parameter(Mandatory)] [string] $AccessToken,
    [Parameter(Mandatory)] [string] $SourceBranch,
    [Parameter(Mandatory)] [string] $ContributorAllowList
)

function Build-AuthHeader {
    param(
        [Parameter(Mandatory)] [string] $AccessToken
    )

    $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("'':${AccessToken}"))
    return "Basic ${base64AuthInfo}"
}

function Get-PullRequest {
    param(
        [Parameter(Mandatory)] [string] $RepositoryName,
        [Parameter(Mandatory)] [string] $AccessToken,
        [Parameter(Mandatory)] [UInt32] $PullRequestNumber
    )

    $requestUrl = "https://api.github.com/repos/$RepositoryName/pulls/$PullRequestNumber"
    $authHeader = Build-AuthHeader -AccessToken $AccessToken

    $params = @{
        Method = "GET"
        ContentType = "application/json"
        Uri = $requestUrl
        Headers = @{ Authorization = $authHeader }
    }

    return Invoke-RestMethod @params
}

function Validate-ContributorPermissions {
    param(
        [Parameter(Mandatory)] [string] $ContributorAllowList,
        [Parameter(Mandatory)] [string] $ContributorName
    )

    $allowedContributors = $ContributorAllowList.Split(",").Trim()
    $validСontributor = $allowedContributors | Where-Object { $_ -eq $ContributorName } `
                                             | Select-Object -First 1

    if (-not $validСontributor) {
       Write-Host "Failed to start this build. '$ContributorName' is an unknown contributor"
       Write-Host "Please add '$ContributorName' to the allowed list to run builds"
       exit 1
    }
}

$pullRequestNumber = $SourceBranch.Split("/")[2]

$pullRequestInfo = Get-PullRequest -RepositoryName $RepositoryName `
                                   -AccessToken $AccessToken `
                                   -PullRequestNumber $pullRequestNumber

$contributorName = $pullRequestInfo.user.login

Validate-ContributorPermissions -ContributorAllowList $ContributorAllowList `
                                -ContributorName $contributorName