param(
    [UInt32] [Parameter (Mandatory)] $BuildId,
    [String] [Parameter (Mandatory)] $Organization,
    [String] [Parameter (Mandatory)] $Project,
    [String] [Parameter (Mandatory)] $ImageName,
    [String] [Parameter (Mandatory)] $DefinitionId,
    [String] [Parameter (Mandatory)] $AccessToken
)

$Body = @{
    definitionId = $DefinitionId
    variables = @{
      ImageBuildId = @{
        value = $BuildId
      }
      ImageName = @{
        value = $ImageName
      }
    }
    isDraft = "false"
} | ConvertTo-Json -Depth 3

$URL = "https://vsrm.dev.azure.com/$Organization/$Project/_apis/release/releases?api-version=5.1"
$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("'':${AccessToken}"))
$headers = @{
    Authorization = "Basic ${base64AuthInfo}"
}

$NewRelease = Invoke-RestMethod $URL -Body $Body -Method "POST" -Headers $headers -ContentType "application/json"

Write-Host "Created release: $($NewRelease._links.web.href)"