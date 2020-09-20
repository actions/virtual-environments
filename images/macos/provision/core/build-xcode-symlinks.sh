set -e

source ~/utils/utils.sh

# Link the existing Xcodes into the correct location for provisionator.

# These symlinks are necessary for Xamarin team to make sure that xamarin-provisionator can find them.

# Old style provisionator directories. This is maintained for
# backwards compatibility only. Do not add new xcodes here.
ln -sf /Applications/Xcode_8.app /Applications/Xcode8.app
ln -sf /Applications/Xcode_8.1.app /Applications/Xcode81.app
ln -sf /Applications/Xcode_9.app /Applications/Xcode9.app
ln -sf /Applications/Xcode_9.1.app /Applications/Xcode91.app
ln -sf /Applications/Xcode_9.2.app /Applications/Xcode92.app
ln -sf /Applications/Xcode_9.3.app /Applications/Xcode93.app
ln -sf /Applications/Xcode_9.3.app /Applications/Xcode_9.3_beta.app
ln -sf /Applications/Xcode_9.4.app /Applications/Xcode_9.4-beta.app
ln -sf /Applications/Xcode_9.4.app /Applications/Xcode_9.4_beta.app
ln -sf /Applications/Xcode_9.4.app /Applications/Xcode_9.4_beta_2.app