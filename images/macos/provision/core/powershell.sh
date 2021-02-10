source ~/utils/utils.sh

echo Installing Azure CLI...
brew install azure-cli

echo Installing PowerShell...
brew cask install powershell

# A dummy call of `az` to initialize ~/.azure directory before the modules are installed
az -v

# Install PowerShell modules
psModules=$(get_toolset_value '.powershellModules[].name')
for module in ${psModules[@]}; do
    echo "Installing $module module"
    moduleVersions="$(get_toolset_value ".powershellModules[] | select(.name==\"$module\") | .versions[]?")"
    if [[ -z "$moduleVersions" ]];then
        pwsh -command "& {Install-Module $module -Force -Scope AllUsers}"
    else
        for version in ${moduleVersions[@]}; do
            echo " - $version"
            pwsh -command "& {Install-Module $module -RequiredVersion $version -Force -Scope AllUsers}"
        done
    fi
done

# Enables AzureRm prefix aliases for Az modules
sudo pwsh -command "& {Import-Module Az; Enable-AzureRmAlias -Scope LocalMachine}"

# powershell link was removed in powershell-6.0.0-beta9
sudo ln -s /usr/local/bin/pwsh /usr/local/bin/powershell

# fix ~/.azure directory permissions
sudo chown -R ${USER}: $HOME/.azure