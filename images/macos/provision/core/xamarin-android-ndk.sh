#!/bin/sh
source ~/utils/utils.sh

ANDROID_HOME=$HOME/Library/Android/sdk
ANDROID_NDK_HOME=$ANDROID_HOME/ndk-bundle
SDKMANAGER=$ANDROID_HOME/tools/bin/sdkmanager

# Android NDK v16 is not compatible with old Xamarin.Android SDK
# and fails builds with BundleAssemblies enabled
ANDROID_NDK_15_HOME=$HOME/Library/Android/sdk/android-ndk-r15c
ANDROID_NDK_PACKAGE="android-ndk-r15c-darwin-x86_64.zip"
ANDROID_NDK_URL="https://dl.google.com/android/repository/${ANDROID_NDK_PACKAGE}"

echo "Install and setup Android NDK v15..."
cd $HOME

download_with_retries $ANDROID_NDK_URL

echo "Unzipping $ANDROID_NDK_URL..."
unzip -q $ANDROID_NDK_PACKAGE -d ${ANDROID_HOME}

echo "Removing $ANDROID_NDK_URL..."
rm -rf "$ANDROID_NDK_PACKAGE"

XAMARIN_ANDROID_NDK_PATH=$HOME/Library/Developer/Xamarin
mkdir -p $XAMARIN_ANDROID_NDK_PATH

echo "Preparing symlink for $ANDROID_NDK_15_HOME ..."
ln -s $ANDROID_NDK_15_HOME $XAMARIN_ANDROID_NDK_PATH/android-ndk

# NDK r17 does not include MIPS/MIPS64 toolchains anymore, NDK r16b still provides this a supplement
echo "Checking NDK installation contains required MIPS toolchains…"
NDK_BUNDLE_TOOLCHAINS=$ANDROID_NDK_HOME/toolchains
ANDROID_NDK_R16B_PATH=$ANDROID_HOME/ndk/16.1.4479499
MIPS64_TOOLCHAIN=$NDK_BUNDLE_TOOLCHAINS/mips64el-linux-android-4.9/prebuilt/darwin-x86_64/bin
MIPS_TOOLCHAIN=$NDK_BUNDLE_TOOLCHAINS/mipsel-linux-android-4.9/prebuilt/darwin-x86_64/bin

if [ -d $MIPS64_TOOLCHAIN ] && [ -d $MIPS_TOOLCHAIN ]; then
  echo "MIPS64 and MIPS toolchain already installed for NDK bundle - not reinstalling."
else
    pushd $ANDROID_HOME

    echo "Installing ndk r16b..."
    echo y | $SDKMANAGER "ndk;16.1.4479499"

    echo "Cleaning potential pre-existing MIPS toolchain directories"
    rm -rf ndk-bundle/toolchains/mips*

    echo "Moving MIPS toolchains to $ANDROID_NDK_HOME/toolchains"
    mv $ANDROID_NDK_R16B_PATH/toolchains/mips** ndk-bundle/toolchains/

    echo "Delete ndk r16b..."
    rm -rf $ANDROID_NDK_R16B_PATH

    if [ ! -d $MIPS64_TOOLCHAIN ] || [ ! -d $MIPS_TOOLCHAIN ]; then
        echo "MIPS toolchains not installed correctly! Check whether $ANDROID_NDK_HOME/toolchains/mips* does not exist."
    fi
    popd
fi

# Latest versions of NDK doesn't include GCC, NDK r18 does
echo "Installing ndk r18B..."
echo y | $SDKMANAGER "ndk;18.1.5063045"
echo "export ANDROID_NDK_18R_PATH=${ANDROID_HOME}/ndk/18.1.5063045" >> "${HOME}/.bashrc"