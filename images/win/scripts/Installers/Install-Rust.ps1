################################################################################
##  File:  Install-Rust.ps1
##  Desc:  Install Rust for Windows
################################################################################

# Rust Env
$env:RUSTUP_HOME = "C:\Rust\.rustup"
$env:CARGO_HOME = "C:\Rust\.cargo"

# Download the latest rustup-init.exe for Windows x64
# See https://rustup.rs/#
$rustupPath = Start-DownloadWithRetry -Url "https://win.rustup.rs/x86_64" -Name "rustup-init.exe"

# Install Rust by running rustup-init.exe (disabling the confirmation prompt with -y)
& $rustupPath -y --default-toolchain=stable --profile=minimal

# Add Rust binaries to the path
Add-MachinePathItem "$env:CARGO_HOME\bin"
$env:Path = Get-MachinePath

# Install common tools
rustup component add rustfmt clippy
cargo install bindgen cbindgen cargo-audit cargo-outdated

# Run script at startup for all users
$cmdRustSymScript = @"
@echo off

if exist $env:CARGO_HOME (
    if not exist %USERPROFILE%\.cargo (
        mklink /J %USERPROFILE%\.cargo $env:CARGO_HOME
    )
)

if exist $env:RUSTUP_HOME (
    if not exist %USERPROFILE%\.rustup (
        mklink /J %USERPROFILE%\.rustup $env:RUSTUP_HOME
    )
)
"@

$cmdPath = "C:\Rust\rustsym.bat"
$cmdRustSymScript | Out-File -Encoding ascii -FilePath $cmdPath

# Cleanup Cargo crates cache
Remove-Item "${env:CARGO_HOME}\registry\*" -Recurse -Force

# Update Run key to run a script at logon
Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "RUSTSYM" -Value $cmdPath

# Create temporary symlinks to properly validate tools version
Set-Location -Path $env:UserProfile
$null = New-Item -Name ".rustup" -Value $env:RUSTUP_HOME -ItemType Junction
$null = New-Item -Name ".cargo" -Value $env:CARGO_HOME -ItemType Junction

Invoke-PesterTests -TestFile "Rust"