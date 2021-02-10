#!/bin/bash -e
################################################################################
##  File:  scala.sh
##  Desc:  Installs sbt
################################################################################

# Install sbt
# https://www.scala-sbt.org/1.x/docs/Installing-sbt-on-Linux.html
echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | apt-key add
apt-get -q update
apt-get -y install sbt
