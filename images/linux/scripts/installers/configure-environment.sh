#Set ImageVersion and ImageOS env variables
echo ImageVersion=$IMAGE_VERSION | tee -a /etc/environment
echo ImageOS=$IMAGE_OS | tee -a /etc/environment

# This directory is supposed to be created in $HOME and owned by user(https://github.com/actions/virtual-environments/issues/491)
mkdir -p /etc/skel/.config/configstore
echo 'export XDG_CONFIG_HOME=$HOME/.config' | tee -a /etc/skel/.bashrc

# Change waagent entries to use /mnt for swapfile
sed -i 's/ResourceDisk.Format=n/ResourceDisk.Format=y/g' /etc/waagent.conf
sed -i 's/ResourceDisk.EnableSwap=n/ResourceDisk.EnableSwap=y/g' /etc/waagent.conf
sed -i 's/ResourceDisk.SwapSizeMB=0/ResourceDisk.SwapSizeMB=4096/g' /etc/waagent.conf

# Add localhost alias to ::1 IPv6
sed -i 's/::1 ip6-localhost ip6-loopback/::1     localhost ip6-localhost ip6-loopback/g' /etc/hosts

# Prepare directory and env variable for toolcache
AGENT_TOOLSDIRECTORY=/opt/hostedtoolcache
mkdir $AGENT_TOOLSDIRECTORY
echo "AGENT_TOOLSDIRECTORY=$AGENT_TOOLSDIRECTORY" | tee -a /etc/environment
chmod -R 777 $AGENT_TOOLSDIRECTORY

# https://www.elastic.co/guide/en/elasticsearch/reference/current/vm-max-map-count.html
# https://www.suse.com/support/kb/doc/?id=000016692
echo 'vm.max_map_count=262144' | tee -a /etc/sysctl.conf