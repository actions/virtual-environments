#!/bin/sh

# Xamarin can clean their SDKs while updating to newer versions,
# so we should be able to detect it during image generation
downloadAndInstallPKG() {
  local PKG_URL=$1
  local PKG_NAME=${PKG_URL##*/}
  
  download_with_retries $PKG_URL

  echo "Installing $PKG_NAME..."
  sudo installer -pkg "$TMPMOUNT/$PKG_NAME" -target /
}

buildVSMacDownloadUrl() {
    echo "https://dl.xamarin.com/VsMac/VisualStudioForMac-${1}.dmg"
}

buildMonoDownloadUrl() {
  echo "https://dl.xamarin.com/MonoFrameworkMDK/Macx86/MonoFramework-MDK-${1}.macos10.xamarin.universal.pkg"
}

buildXamariniIOSDownloadUrl() {
  echo "https://dl.xamarin.com/MonoTouch/Mac/xamarin.ios-${1}.pkg"
}

buildXamarinMacDownloadUrl() {
  echo "https://dl.xamarin.com/XamarinforMac/Mac/xamarin.mac-${1}.pkg"
}

buildXamarinAndroidDownloadUrl() {
    echo "https://dl.xamarin.com/MonoforAndroid/Mac/xamarin.android-${1}.pkg"
}

installMono() {
  local VERSION=$1

  echo "Installing Mono ${VERSION}..."
  local MONO_FOLDER_NAME=$(echo $VERSION | cut -d. -f 1,2,3)
  local SHORT_VERSION=$(echo $VERSION | cut -d. -f 1,2)
  local PKG_URL=$(buildMonoDownloadUrl $VERSION)
  downloadAndInstallPKG $PKG_URL

  echo "Installing nunit3-console for Mono "$VERSION
  installNunitConsole $MONO_FOLDER_NAME

  echo "Creating short symlink '${SHORT_VERSION}'"
  sudo ln -s ${MONO_VERSIONS_PATH}/${MONO_FOLDER_NAME} ${MONO_VERSIONS_PATH}/${SHORT_VERSION}

  echo "Move to backup folder"
  sudo mv -v $MONO_VERSIONS_PATH/* $TMPMOUNT_FRAMEWORKS/mono/
}

installXamarinIOS() {
  local VERSION=$1

  echo "Installing Xamarin.iOS ${VERSION}..."
  local SHORT_VERSION=$(echo $VERSION | cut -d. -f 1,2)
  local PKG_URL=$(buildXamariniIOSDownloadUrl $VERSION)
  downloadAndInstallPKG $PKG_URL

  echo "Creating short symlink '${SHORT_VERSION}'"
  sudo ln -s ${IOS_VERSIONS_PATH}/${VERSION} ${IOS_VERSIONS_PATH}/${SHORT_VERSION}

  echo "Move to backup folder"
  sudo mv -v $IOS_VERSIONS_PATH/* $TMPMOUNT_FRAMEWORKS/ios/
}

installXamarinMac() {
  local VERSION=$1

  echo "Installing Xamarin.Mac ${VERSION}..."
  local SHORT_VERSION=$(echo $VERSION | cut -d. -f 1,2)
  local PKG_URL=$(buildXamarinMacDownloadUrl $VERSION)
  downloadAndInstallPKG $PKG_URL

  echo "Creating short symlink '${SHORT_VERSION}'"
  sudo ln -s ${MAC_VERSIONS_PATH}/${VERSION} ${MAC_VERSIONS_PATH}/${SHORT_VERSION}

  echo "Move to backup folder"
  sudo mv -v $MAC_VERSIONS_PATH/* $TMPMOUNT_FRAMEWORKS/mac/
}

installXamarinAndroid() {
  local VERSION=$1

  echo "Installing Xamarin.Android ${VERSION}..."
  local SHORT_VERSION=$(echo $VERSION | cut -d. -f 1,2)
  local PKG_URL=$(buildXamarinAndroidDownloadUrl $VERSION)
  downloadAndInstallPKG $PKG_URL

  if [ "$VERSION" == "9.4.1.0" ]; then
    # Fix symlinks for broken Xamarin.Android
    fixXamarinAndroidSymlinksInLibDir $VERSION
  fi

  echo "Creating short symlink '${SHORT_VERSION}'"
  sudo ln -s ${ANDROID_VERSIONS_PATH}/${VERSION} ${ANDROID_VERSIONS_PATH}/${SHORT_VERSION}

  echo "Move to backup folder"
  sudo mv -v $ANDROID_VERSIONS_PATH/* $TMPMOUNT_FRAMEWORKS/android/
}

createBundle() {
  local SYMLINK=$1
  local MONO_SDK=$2
  local IOS_SDK=$3
  local MAC_SDK=$4
  local ANDROID_SDK=$5

  echo "Creating bundle '$SYMLINK' (Mono $MONO_SDK; iOS $IOS_SDK; Mac $MAC_SDK; Android $ANDROID_SDK"
  deleteSymlink ${SYMLINK}
  sudo ln -s ${MONO_VERSIONS_PATH}/${MONO_SDK} ${MONO_VERSIONS_PATH}/${SYMLINK}
  sudo ln -s ${IOS_VERSIONS_PATH}/${IOS_SDK} ${IOS_VERSIONS_PATH}/${SYMLINK}
  sudo ln -s ${MAC_VERSIONS_PATH}/${MAC_SDK} ${MAC_VERSIONS_PATH}/${SYMLINK}
  sudo ln -s ${ANDROID_VERSIONS_PATH}/${ANDROID_SDK} ${ANDROID_VERSIONS_PATH}/${SYMLINK}
}

createBundleLink() {
  local SOURCE=$1
  local TARGET=$2
  echo "Creating bundle symlink '$SOURCE' -> '$TARGET'"
  deleteSymlink ${TARGET}
  sudo ln -s ${MONO_VERSIONS_PATH}/$SOURCE ${MONO_VERSIONS_PATH}/$TARGET
  sudo ln -s ${IOS_VERSIONS_PATH}/$SOURCE ${IOS_VERSIONS_PATH}/$TARGET
  sudo ln -s ${MAC_VERSIONS_PATH}/$SOURCE ${MAC_VERSIONS_PATH}/$TARGET
  sudo ln -s ${ANDROID_VERSIONS_PATH}/$SOURCE ${ANDROID_VERSIONS_PATH}/$TARGET
}

# https://github.com/xamarin/xamarin-android/issues/3457
# Recreate missing symlinks in lib for new Xamarin.Android package
# Symlink path /Library/Frameworks/Xamarin.Android.framework/Libraries
# xbuild -> xamarin.android/xbuild
# xbuild-frameworks -> xamarin.android/xbuild-frameworks
fixXamarinAndroidSymlinksInLibDir() {
  local XAMARIN_ANDROID_VERSION=$1
  local XAMARIN_ANDROID_LIB_PATH="${ANDROID_VERSIONS_PATH}/${XAMARIN_ANDROID_VERSION}/lib"

  if [ -d "${XAMARIN_ANDROID_LIB_PATH}" ]; then
      pushd "${XAMARIN_ANDROID_LIB_PATH}" > /dev/null

      local XAMARIN_ANDROID_XBUILD_DIR="${XAMARIN_ANDROID_LIB_PATH}/xbuild"
      if [ ! -d "${XAMARIN_ANDROID_XBUILD_DIR}" ]; then
          echo "${XAMARIN_ANDROID_XBUILD_DIR}"
          sudo ln -sf xamarin.android/xbuild xbuild
      fi

      local XAMARIN_ANDROID_XBUILD_FRAMEWORKS_DIR="${XAMARIN_ANDROID_LIB_PATH}/xbuild-frameworks"
      if [ ! -d "${XAMARIN_ANDROID_XBUILD_FRAMEWORKS_DIR}" ]; then
          echo "${XAMARIN_ANDROID_XBUILD_FRAMEWORKS_DIR}"
          sudo ln -sf xamarin.android/xbuild-frameworks xbuild-frameworks
      fi

      popd > /dev/null
  fi
}

installNunitConsole() {
  local MONO_VERSION=$1

  cat <<EOF > ${TMPMOUNT}/${NUNIT3_CONSOLE_BIN}
#!/bin/sh
exec /Library/Frameworks/Mono.framework/Versions/${MONO_VERSION}/bin/mono --debug \$MONO_OPTIONS $NUNIT3_PATH/nunit3-console.exe "\$@"
EOF
  sudo chmod +x ${TMPMOUNT}/${NUNIT3_CONSOLE_BIN}
  sudo mv ${TMPMOUNT}/${NUNIT3_CONSOLE_BIN} ${MONO_VERSIONS_PATH}/${MONO_VERSION}/Commands/${NUNIT3_CONSOLE_BIN}
}

downloadNUnitConsole() {
    echo "Downloading NUnit 3..."
    local NUNIT3_LOCATION='https://github.com/nunit/nunit-console/releases/download/3.6.1/NUnit.Console-3.6.1.zip'
    local NUNIT_PATH="/Library/Developer/nunit"
    NUNIT3_PATH="$NUNIT_PATH/3.6.1"

    pushd $TMPMOUNT

    sudo mkdir -p $NUNIT3_PATH
    sudo curl -L -o nunit3.zip $NUNIT3_LOCATION

    echo "Installing NUnit 3..."
    sudo unzip nunit3.zip -d $NUNIT3_PATH
    NUNIT3_CONSOLE_BIN=nunit3-console
    
    popd
}

installNuget() {
  local MONO_VERSION=$1
  local NUGET_VERSION=$2
  local NUGET_URL="https://dist.nuget.org/win-x86-commandline/v${NUGET_VERSION}/nuget.exe"
  echo "Installing nuget $NUGET_VERSION for Mono $MONO_VERSION"
  cd ${MONO_VERSIONS_PATH}/${MONO_VERSION}/lib/mono/nuget
  sudo mv nuget.exe nuget_old.exe
  sudo curl -L -o nuget.exe $NUGET_URL
  sudo chmod a+x nuget.exe
}

createUWPShim() {
  echo "Creating UWP Shim to hack UWP build failure..."
  cat <<EOF > ${TMPMOUNT}/Microsoft.Windows.UI.Xaml.CSharp.Targets
<Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
<Target Name = "Build"/>
<Target Name = "Rebuild"/>
</Project>
EOF

  local UWPTARGET_PATH=/Library/Frameworks/Mono.framework/External/xbuild/Microsoft/WindowsXaml

  sudo mkdir -p $UWPTARGET_PATH/v11.0/
  sudo cp ${TMPMOUNT}/Microsoft.Windows.UI.Xaml.CSharp.Targets $UWPTARGET_PATH/v11.0/
  sudo mkdir -p $UWPTARGET_PATH/v12.0/
  sudo cp ${TMPMOUNT}/Microsoft.Windows.UI.Xaml.CSharp.Targets $UWPTARGET_PATH/v12.0/
  sudo mkdir -p $UWPTARGET_PATH/v14.0/
  sudo cp ${TMPMOUNT}/Microsoft.Windows.UI.Xaml.CSharp.Targets $UWPTARGET_PATH/v14.0/
  sudo mkdir -p $UWPTARGET_PATH/v15.0/
  sudo cp ${TMPMOUNT}/Microsoft.Windows.UI.Xaml.CSharp.Targets $UWPTARGET_PATH/v15.0/
  sudo mkdir -p $UWPTARGET_PATH/v16.0/
  sudo cp ${TMPMOUNT}/Microsoft.Windows.UI.Xaml.CSharp.Targets $UWPTARGET_PATH/v16.0/
}

createBackupFolders() {
  mkdir -p $TMPMOUNT_FRAMEWORKS/mono
  mkdir -p $TMPMOUNT_FRAMEWORKS/ios
  mkdir -p $TMPMOUNT_FRAMEWORKS/mac
  mkdir -p $TMPMOUNT_FRAMEWORKS/android
}

deleteSymlink() {
  sudo rm -f ${MONO_VERSIONS_PATH}/${1}
  sudo rm -f ${IOS_VERSIONS_PATH}/${1}
  sudo rm -f ${MAC_VERSIONS_PATH}/${1}
  sudo rm -f ${ANDROID_VERSIONS_PATH}/${1}
}