#!/bin/bash -e
################################################################################
##  File:  java-tools.sh
##  Desc:  Installs Java and related tooling (Ant, Gradle, Maven)
################################################################################

source $HELPER_SCRIPTS/os.sh

function javaTool {
    if [[ "$2" =~ ([1]{0,1}.)?$DEFAULT_JDK_VERSION.* ]]; then
        echo "$1 $2 is equal to default one $DEFAULT_JDK_VERSION"
    else
        echo "$1 $2 is not equal to default one $DEFAULT_JDK_VERSION"
        exit 1
    fi
}

# Install GPG Key for Adopt Open JDK. See https://adoptopenjdk.net/installation.html
wget -qO - "https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public" | apt-key add -
add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/

if isUbuntu16 || isUbuntu18 ; then
    # Install GPG Key for Azul Open JDK. See https://www.azul.com/downloads/azure-only/zulu/
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0xB1998361219BD9C9
    apt-add-repository "deb http://repos.azul.com/azure-only/zulu/apt stable main"
    apt-get update
    apt-get -y install zulu-7-azure-jdk=\*
    # Open JDP Adopt does not exist for Ubuntu 20
    apt-get -y install adoptopenjdk-12-hotspot=\*
    echo "JAVA_HOME_7_X64=/usr/lib/jvm/zulu-7-azure-amd64" | tee -a /etc/environment
    DEFAULT_JDK_VERSION=8
    defaultLabel8="(default)"
fi

if isUbuntu20 ; then
    DEFAULT_JDK_VERSION=11
    defaultLabel11="(default)"
    apt-get update
fi

# Install only LTS versions.
apt-get -y install adoptopenjdk-8-hotspot=\*
apt-get -y install adoptopenjdk-11-hotspot=\*

# Set Default Java version.
if isUbuntu16; then
    # issue: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=825987
    # stackoverflow: https://askubuntu.com/questions/1187136/update-java-alternatives-only-java-but-not-javac-is-changed
    sed -i 's/(hl|jre|jdk|plugin|DUMMY) /(hl|jre|jdk|jdkhl|plugin|DUMMY) /g' /usr/sbin/update-java-alternatives
fi
update-java-alternatives -s /usr/lib/jvm/adoptopenjdk-${DEFAULT_JDK_VERSION}-hotspot-amd64

echo "JAVA_HOME_8_X64=/usr/lib/jvm/adoptopenjdk-8-hotspot-amd64" | tee -a /etc/environment
echo "JAVA_HOME_11_X64=/usr/lib/jvm/adoptopenjdk-11-hotspot-amd64" | tee -a /etc/environment
if isUbuntu16 || isUbuntu18 ; then
echo "JAVA_HOME_12_X64=/usr/lib/jvm/adoptopenjdk-12-hotspot-amd64" | tee -a /etc/environment
fi
echo "JAVA_HOME=/usr/lib/jvm/adoptopenjdk-${DEFAULT_JDK_VERSION}-hotspot-amd64" | tee -a /etc/environment

# Install Ant
apt-fast install -y --no-install-recommends ant ant-optional
echo "ANT_HOME=/usr/share/ant" | tee -a /etc/environment

# Install Maven
curl -sL https://www-eu.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.zip -o maven.zip
unzip -d /usr/share maven.zip
rm maven.zip
ln -s /usr/share/apache-maven-3.6.3/bin/mvn /usr/bin/mvn
echo "M2_HOME=/usr/share/apache-maven-3.6.3" | tee -a /etc/environment

# Install Gradle
# This script downloads the latest HTML list of releases at https://gradle.org/releases/.
# Then, it extracts the top-most release download URL, relying on the top-most URL being for the latest release.
# The release download URL looks like this: https://services.gradle.org/distributions/gradle-5.2.1-bin.zip
# The release version is extracted from the download URL (i.e. 5.2.1).
# After all of this, the release is downloaded, extracted, a symlink is created that points to it, and GRADLE_HOME is set.
wget -O gradleReleases.html https://gradle.org/releases/
gradleUrl=$(grep -m 1 -o "https:\/\/services.gradle.org\/distributions\/gradle-.*-bin\.zip" gradleReleases.html | head -1)
gradleVersion=$(echo $gradleUrl | sed -nre 's/^[^0-9]*(([0-9]+\.)*[0-9]+).*/\1/p')
rm gradleReleases.html
echo "gradleUrl=$gradleUrl"
echo "gradleVersion=$gradleVersion"
curl -sL $gradleUrl -o gradleLatest.zip
unzip -d /usr/share gradleLatest.zip
rm gradleLatest.zip
ln -s /usr/share/gradle-"${gradleVersion}"/bin/gradle /usr/bin/gradle
echo "GRADLE_HOME=/usr/share/gradle" | tee -a /etc/environment

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
for cmd in gradle java javac mvn ant; do
    if ! command -v $cmd; then
        echo "$cmd was not installed or found on path"
        exit 1
    fi
done

javaVersion=$(java -version |& head -n 1 | cut -d\" -f 2)
javaTool "Java" $javaVersion
javacVersion=$(javac -version |& cut -d" " -f2)
javaTool "Javac" $javacVersion
