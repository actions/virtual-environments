################################################################################
##  File:  Update-DockerImages.ps1
##  Desc:  Pull some standard docker images.
##         Must be run after docker is installed.
################################################################################

function DockerPull {
    Param ([string]$image)

    Write-Host Installing $image ...
    docker pull $image

    if (!$?) {
      Write-Host "Docker pull failed with a non-zero exit code"
      exit 1
    }
}

$dockerToolset = (Get-ToolsetContent).docker
foreach($dockerImage in $dockerToolset.images) {
  DockerPull $dockerImage
}
