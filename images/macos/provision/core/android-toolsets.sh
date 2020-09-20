#!/bin/bash -e
source ~/utils/utils.sh

ANDROID_PLATFORM_LIST=($(get_toolset_value '.android."platform-list"[]'))
ANDROID_BUILD_TOOLS=($(get_toolset_value '.android."build-tools"[]'))
ANDROID_EXTRA_LIST=($(get_toolset_value '.android."extra-list"[]'))
ANDROID_ADDON_LIST=($(get_toolset_value '.android."addon-list"[]'))

# Get the latest command line tools from https://developer.android.com/studio/index.html
# Release note: https://developer.android.com/studio/releases/sdk-tools.html
ANDROID_OSX_SDK_LOCATION="https://dl.google.com/android/repository/sdk-tools-darwin-3859397.zip"
ANDROID_HOME=$HOME/Library/Android/sdk
ANDROID_OSX_SDK_FILE=tools-macosx.zip

pushd $HOME

# Prevent the warning of sdkmanager
mkdir $HOME/.android
echo "count=0" >> $HOME/.android/repositories.cfg

echo "Downloading android sdk..."
curl -L -o $ANDROID_OSX_SDK_FILE $ANDROID_OSX_SDK_LOCATION

echo "Uncompressing android sdk..."
unzip -q $ANDROID_OSX_SDK_FILE && rm -f $ANDROID_OSX_SDK_FILE
rm -rf $HOME/Library/Android/sdk
mkdir -p $HOME/Library/Android/sdk

echo ANDROID_HOME is $ANDROID_HOME
mv tools $ANDROID_HOME

export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin

SDKMANAGER=$ANDROID_HOME/tools/bin/sdkmanager

# Mark the different Android licenses as accepted
mkdir -p $ANDROID_HOME/licenses
echo "8933bad161af4178b1185d1a37fbf41ea5269c55
d56f5187479451eabf01fb78af6dfcb131a6481e" >> $ANDROID_HOME/licenses/android-sdk-license
echo "84831b9409646a918e30573bab4c9c91346d8abd" >> $ANDROID_HOME/licenses/android-sdk-preview-license

echo "Installing latest tools & platform tools..."
echo y | $SDKMANAGER "tools" "platform-tools"

echo "Installing latest CMake..."
echo y | $SDKMANAGER "cmake;3.6.4111459"

echo "Installing latest ndk..."
echo y | $SDKMANAGER "ndk-bundle"

for platform_name in "${ANDROID_PLATFORM_LIST[@]}"
do
    echo "Installing platform $platform_name ..."
    echo y | $SDKMANAGER "platforms;$platform_name"
done

for build_tools_version in "${ANDROID_BUILD_TOOLS[@]}"
do
    echo "Installing build tools $build_tools_version ..."
    echo y | $SDKMANAGER "build-tools;$build_tools_version"
done

for extra_name in "${ANDROID_EXTRA_LIST[@]}"
do
    echo "Installing extra $extra_name ..."
    echo y | $SDKMANAGER "extras;$extra_name"
done

# Intel x86 Emulator Accelerator (HAXM installer)
# see Issue 31164 notes
# Command needs to be run under sudo.
chmod +x $ANDROID_HOME/extras/intel/Hardware_Accelerated_Execution_Manager/silent_install.sh
sudo $ANDROID_HOME/extras/intel/Hardware_Accelerated_Execution_Manager/silent_install.sh

for addon_name in "${ANDROID_ADDON_LIST[@]}"
do
    echo "Installing add-on $addon_name ..."
    echo y | $SDKMANAGER "add-ons;$addon_name"
done

popd

echo "Installing ProGuard-5..."
PROGUARD_LOCATION="https://github.com/Guardsquare/proguard/archive/proguard5.3.3.tar.gz"
pushd $ANDROID_HOME
cd tools
mv proguard proguard4
mkdir proguard && cd proguard
curl -L -o proguard5.tgz $PROGUARD_LOCATION
tar xzf proguard5.tgz --strip 1 && rm -f proguard5.tgz
cp ../proguard4/proguard-*.txt . # Copy the Proguard Android definitions from the previous version
popd
