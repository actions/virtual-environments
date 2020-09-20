################################################################################
##  File:  Install-Bazel.ps1
##  Desc:  Install Bazel and Bazelisk (A user-friendly launcher for Bazel)
################################################################################

Choco-Install -PackageName bazel

npm install -g @bazel/bazelisk

Invoke-PesterTests -TestFile "Tools" -TestName "Bazel"