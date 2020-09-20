################################################################################
##  File:  Install-TypeScript.ps1
##  Desc:  Install Latest TypeScript
################################################################################

npm install -g typescript

Invoke-PesterTests -TestFile "Tools" -TestName "Typescript"
