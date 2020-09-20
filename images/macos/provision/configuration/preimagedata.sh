#!/bin/bash
source ~/utils/utils.sh

imagedata_file="$HOME/imagedata.json"
image_version=$(echo $IMAGE_VERSION | cut -d _ -f 2)
os_name=$(sw_vers -productName)
os_version=$(sw_vers -productVersion)
os_build=$(sw_vers -buildVersion)
label_version=$(echo $os_version | cut -d. -f1,2)
image_label="macos-${label_version}"
software_url="https://github.com/actions/virtual-environments/blob/${image_label}/${image_version}/images/macos/${image_label}-Readme.md"

if is_Catalina || is_BigSur; then
  cat <<EOF > $imagedata_file
    [
      {
        "group": "Operating System",
        "detail": "${os_name}\n${os_version}\n${os_build}"
      },
      {
        "group": "Virtual Environment",
        "detail": "Environment: ${image_label}\nVersion: ${image_version}\nIncluded Software: ${software_url}"
      }
    ]
EOF
fi

echo "export ImageVersion=$image_version" >> $HOME/.bashrc
echo "export ImageOS=$IMAGE_OS" >> $HOME/.bashrc