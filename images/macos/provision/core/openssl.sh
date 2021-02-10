#!/bin/sh

source ~/utils/utils.sh

echo "Installing OpenSSL..."
export PATH="/usr/local/bin:/usr/local/sbin:~/bin:$PATH"

echo Installing OpenSSL...
/usr/local/bin/brew install openssl

if is_BigSur; then
    ln -sf $(brew --prefix openssl)/bin/openssl /usr/local/bin/openssl
    exit 0
fi

# Install OpenSSL 1.0.2t
# https://www.openssl.org/policies/releasestrat.html - Version 1.0.2 will be supported until 2019-12-31 (LTS)
# To preserve backward compatibility with ruby-toolcache
/usr/local/bin/brew tap-new local/openssl
FORMULA_PATH=$(/usr/local/bin/brew extract openssl local/openssl | grep "Homebrew/Library/Taps")
/usr/local/bin/brew install $FORMULA_PATH

# Set OpenSSL 1.0.2t as default
ln -sf /usr/local/Cellar/openssl@1.0.2t /usr/local/Cellar/openssl
ln -sf /usr/local/Cellar/openssl/1.0.2t/bin/openssl /usr/local/bin/openssl
rm /usr/local/opt/openssl
ln -sf ../Cellar/openssl/1.0.2t /usr/local/opt/openssl

# Resolve dot net core openssl dependency issue for agent
# https://github.com/microsoft/azure-pipelines-agent/blob/master/docs/start/envosx.md
mkdir -p /usr/local/lib/
ln -s /usr/local/opt/openssl@1.0.2t/lib/libcrypto.1.0.0.dylib /usr/local/lib/
ln -s /usr/local/opt/openssl@1.0.2t/lib/libssl.1.0.0.dylib /usr/local/lib/