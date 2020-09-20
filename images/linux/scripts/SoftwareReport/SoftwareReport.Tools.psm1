function Get-7zipVersion {
    $7zVersion = 7z i | Select-String "7-Zip" | Take-OutputPart -Part 2
    return "7-Zip $7zVersion"
}

function Get-AnsibleVersion {
    $ansibleVersion = sudo ansible --version | Select-Object -First 1 | Take-OutputPart -Part 1
    return "Ansible $ansibleVersion"
}

function Get-AzCopy7Version {
    $azcopy7Version = azcopy --version | Take-OutputPart -Part 1 | Take-OutputPart -Part 0 -Delimiter "-"
    return "AzCopy7 $azcopy7Version (available by ``azcopy`` alias)"
}

function Get-AzCopy10Version {
    $azcopy10Version = azcopy10 --version | Take-OutputPart -Part 2
    return "AzCopy10 $azcopy10Version (available by ``azcopy10`` alias)"
}

function Get-BazelVersion {
    $bazelVersion = sudo bazel --version | Select-String "bazel" | Take-OutputPart -Part 1
    return "Bazel $bazelVersion"
}

function Get-BazeliskVersion {
    $bazeliskVersion = sudo bazelisk version 2>&1 | Select-String "Bazelisk version:" | Take-OutputPart -Part 2 | Take-OutputPart -Part 0 -Delimiter "v"
    return "Bazelisk $bazeliskVersion"
}

function Get-PodManVersion {
    $podmanVersion = podman --version | Take-OutputPart -Part 2
    return "Podman $podmanVersion"
}

function Get-BuildahVersion {
    $buildahVersion = buildah --version | Take-OutputPart -Part 2
    return "Buildah $buildahVersion"
}

function Get-SkopeoVersion {
    $skopeoVersion = skopeo --version | Take-OutputPart -Part 2
    return "Skopeo $skopeoVersion"
}

function Get-CMakeVersion {
    $cmakeVersion = cmake --version | Select-Object -First 1 | Take-OutputPart -Part 2
    return "CMake $cmakeVersion"
}

function Get-CurlVersion {
    $curlVersion = curl --version | Select-Object -First 1 | Take-OutputPart -Part 0,1
    return $curlVersion
}

function Get-DockerComposeVersion {
    $composeVersion = docker-compose -v | Take-OutputPart -Part 2 | Take-OutputPart -Part 0 -Delimiter ","
    return "Docker Compose $composeVersion"
}

function Get-DockerMobyVersion {
    $dockerVersion = docker -v | Take-OutputPart -Part 2 | Take-OutputPart -Part 0 -Delimiter "+"
    return "Docker-Moby $dockerVersion"
}

function Get-DockerBuildxVersion {
    $buildxVersion = docker buildx version  | Take-OutputPart -Part 1 | Take-OutputPart -Part 0 -Delimiter "+"
    return "Docker-Buildx $buildxVersion"
}

function Get-GitVersion {
    $gitVersion = git --version 2>&1 | Take-OutputPart -Part 2
    return "Git $gitVersion"
}

function Get-GitLFSVersion {
    $gitlfsversion = git-lfs --version 2>&1 | Take-OutputPart -Part 0 | Take-OutputPart -Part 1 -Delimiter "/"
    return "Git LFS $gitlfsversion"
}

function Get-GitFTPVersion {
    $gitftpVersion = git-ftp --version | Take-OutputPart -Part 2
    return "Git-ftp $gitftpVersion"
}

function Get-GoogleCloudSDKVersion {
    return "$(sudo gcloud --version | Select-Object -First 1)"
}

function Get-HavegedVersion {
    $havegedVersion = dpkg-query --showformat='${Version}' --show haveged | Take-OutputPart -Part 0 -Delimiter "-"
    return "Haveged $havegedVersion"
}

function Get-HerokuVersion {
    $herokuVersion = sudo heroku version | Take-OutputPart -Part 0 | Take-OutputPart -Part 1 -Delimiter "/"
    return "Heroku $herokuVersion"
}

function Get-HHVMVersion {
    $hhvmVersion = hhvm --version | Select-Object -First 1 | Take-OutputPart -Part 2
    return "HHVM (HipHop VM) $hhvmVersion"
}

function Get-SVNVersion {
    $svnVersion = svn --version | Select-Object -First 1 | Take-OutputPart -Part 2
    return "SVN $svnVersion"
}

function Get-KustomizeVersion {
    $kustomizeVersion = kustomize version --short | Take-OutputPart -Part 0 | Take-OutputPart -Part 1 -Delimiter "v"
    return "Kustomize $kustomizeVersion"
}

function Get-KindVersion {
    $kindVersion = kind version | Take-OutputPart -Part 1 | Take-OutputPart -Part 0 -Delimiter "v"
    return "Kind $kindVersion"
}

function Get-KubectlVersion {
    $kubectlVersion = kubectl version --client --short | Take-OutputPart -Part 2 | Take-OutputPart -Part 0 -Delimiter "v"
    return "Kubectl $kubectlVersion"
}

function Get-MinikubeVersion {
    $minikubeVersion = minikube version --short | Take-OutputPart -Part 2 | Take-OutputPart -Part 0 -Delimiter "v"
    return "Minikube $minikubeVersion"
}

function Get-HGVersion {
    $hgVersion = hg --version | Select-Object -First 1 | Take-OutputPart -Part -1 | Take-OutputPart -Part 0 -Delimiter ")"
    return "Mercurial $hgVersion"
}

function Get-M4Version {
    $m4Version = m4 --version | Select-Object -First 1 | Take-OutputPart -Part -1
    return "m4 $m4Version"
}

function Get-LeiningenVersion {
    return "$(lein -v | Take-OutputPart -Part 0,1)"
}

function Get-NewmanVersion {
    return "Newman $(newman --version)"
}

function Get-NvmVersion {
    $nvmVersion = bash -c "source /etc/skel/.nvm/nvm.sh && nvm --version"
    return "nvm $nvmVersion"
}

function Get-PackerVersion {
    return "Packer $(packer --version)"
}

function Get-PhantomJSVersion {
    return "PhantomJS $(phantomjs --version)"
}

function Get-SwigVersion {
    $swigVersion = swig -version | Select-String "SWIG Version" | Take-OutputPart -Part 2
    return "Swig $swigVersion"
}

function Get-TerraformVersion {
    return (terraform version | Select-String "^Terraform").Line.Replace('v','')
}

function Get-UnZipVersion {
    $unzipVersion = unzip -v | Select-Object -First 1 | Take-OutputPart -Part 1
    return "unzip $unzipVersion"
}

function Get-WgetVersion {
    $wgetVersion = wget --version | Select-Object -First 1 | Take-OutputPart -Part 2
    return "wget $wgetVersion"
}

function Get-ZipVersion {
    $zipVersion = zip -v | Select-String "This is Zip" | Take-OutputPart -Part 3
    return "zip $zipVersion"
}

function Get-ZstdVersion {
    $zstdVersion = (zstd --version).Split() -match "v\d+" | ForEach-Object {$_.Replace("v","").Replace(",","")}
    return "zstd $zstdVersion"
}

function Get-JqVersion {
    $jqVersion = jq --version | Take-OutputPart -Part 1 -Delimiter "-"
    return "jq $jqVersion"
}

function Get-AzureCliVersion {
    $azcliVersion = sudo az -v | Select-String "azure-cli" | Take-OutputPart -Part -1
    return "Azure CLI (azure-cli) $azcliVersion"
}

function Get-AzureDevopsVersion {
    $azdevopsVersion = sudo az -v | Select-String "azure-devops" | Take-OutputPart -Part -1
    return "Azure CLI (azure-devops) $azdevopsVersion"
}

function Get-AlibabaCloudCliVersion {
    return "Alibaba Cloud CLI $(aliyun version)"
}

function Get-AWSCliVersion {
    $awsVersion = aws --version 2>&1 | Take-OutputPart -Part 0 | Take-OutputPart -Part 1 -Delimiter "/"
    return "AWS CLI $awsVersion"
}

function Get-AWSCliSessionManagerPluginVersion {
    return "AWS CLI Session manager plugin $(session-manager-plugin --version 2>&1)"
}

function Get-AWSSAMVersion {
    return "AWS SAM CLI $(sam --version | Take-OutputPart -Part -1)"
}

function Get-HubCliVersion {
    $hubVersion = hub --version | Select-String "hub version" | Take-OutputPart -Part 2
    return "Hub CLI $hubVersion"
}

function Get-GitHubCliVersion {
    $ghVersion = gh --version | Select-String "gh version" | Take-OutputPart -Part 2
    return "GitHub CLI $ghVersion"
}

function Get-NetlifyCliVersion {
    $netlifyVersion = sudo netlify --version | Take-OutputPart -Part 0 | Take-OutputPart -Part 1 -Delimiter "/"
    return "Netlify CLI $netlifyVersion"
}

function Get-OCCliVersion {
    $ocVersion = oc version | Take-OutputPart -Part 2 | Take-OutputPart -Part 0 -Delimiter "-"
    return "oc CLI $ocVersion"
}

function Get-ORASCliVersion {
    $orasVersion = oras version | Select-String "^Version:" | Take-OutputPart -Part 1
    return "ORAS CLI $orasVersion"
}

function Get-VerselCliversion {
    return "$(vercel --version 2>&1 | Select-Object -First 1)"
}
