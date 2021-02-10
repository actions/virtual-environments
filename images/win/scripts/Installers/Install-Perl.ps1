################################################################################
##  File:  Install-Perl.ps1
##  Desc:  Install Perl
################################################################################

Choco-Install -PackageName strawberryperl

Invoke-PesterTests -TestFile "Tools" -TestName "Perl"