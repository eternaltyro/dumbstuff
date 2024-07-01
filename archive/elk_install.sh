#!/bin/bash
#
# Install the ELK stack: Elasticsearch, Logstash, Kibana \
#    on a standard Ubuntu14.04 installation.
#
# Date: 2016-Mar-09
# Author: eternaltyro
# Copyrights: Public Domain

##############################################
# Check if script is being run as root
# Most unix systems have root user id set to 0
##############################################
check_root() {
  if [ "$(id -u)" -ne 0 ]; then
    echo "You need root privileges to run this script"
    exit 1
  fi
}
check_root

#############################
# Function to pipe errors to
#############################
err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $@" >&2
}

#############################################################
# Check if system is running Ubuntu by looking up /etc/issue
# Alternatively /etc/debian-version file can also be used
#############################################################
check_ubuntu() {
  grep -qi ubuntu /etc/issue
  [ "$?" -eq 0 ];
}
if ! check_ubuntu; then
  echo "Script works only for Ubuntu. Exiting.."
  exit 1
fi

#####################################################
# Check if java is present by attempting to run Java
#####################################################
check_java() {
  java -version > /dev/null 2>&1
  [ "$?" -eq 0 ];
}

#####################################################
# If Java is not installed, install OpenJDK JRE
#####################################################
install_java() {
  if ! check_java; then
    apt-get -y install openjdk-7-jre-headless
  fi
}

####################################################################
# Prepare system for install of services
# Add GPG key for verifying signatures on packages
# Add package binaries to repository list
# Update the repository information and upgrade the existing packages
######################################################################
sys_prep() {
  install_java
  wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | apt-key add -
  echo "deb http://packages.elastic.co/kibana/4.4/debian stable main" \
    | tee /etc/apt/sources.list.d/kibana-4.x.list
  echo "deb http://packages.elastic.co/elasticsearch/2.x/debian stable main" \
    | tee /etc/apt/sources.list.d/elasticsearch-2.x.list
  echo "deb http://packages.elastic.co/logstash/2.2/debian stable main" \
    | tee /etc/apt/sources.list.d/logstash-2.x.list
  apt-get update
  apt-get -y upgrade
}

########################################################################
# Install ELASTICSEARCH from repository
# Set elasticsearch service to start on system startup but before other
#   services start
########################################################################
install_elasticsearch() {
  echo "Begin Elasticsearch installation.."
  apt-get -y install elasticsearch
  update-rc.d elasticsearch defaults 90 10
  echo "Elasticsearch installation complete."
}

############################################################################
# Install LOGSTASH from repository
# Set logstash service to start on system startup but after elasticsearch
# starts
# Configure logstash to log syslog messages
# input: defines the log input.
# filter: manipulations or regex matches on the input to filter
# output: defines where to send the parsed logs; elasticsearch in this case.
#############################################################################
install_logstash() {
  echo "Begin Logstash installation.."
  apt-get -y install logstash
  update-rc.d logstash defaults 95 9
  echo "input { file { path => \"/var/log/syslog\" } }" \
    | tee /etc/logstash/conf.d/syslog.conf
  echo "filter { }" | tee -a /etc/logstash/conf.d/syslog.conf
  echo "output { elasticsearch { hosts => [\"localhost:9200\"] }
    stdout { codec => rubydebug } }" \
    | tee -a /etc/logstash/conf.d/syslog.conf
  echo "Logstash installation complete."
}

####################################################################
# Install KIBANA from repository
# Set kibana to start on system boot but after elasticsearch starts
# Configure Kibana to point to elasticsearch endpoint
####################################################################
install_kibana() {
  echo "Begin Kibana installation.."
  apt-get -y install kibana
  update-rc.d kibana defaults 95 9
  echo  "elasticsearch.url: \"http://localhost:9200\"" \
    | tee -a /opt/kibana/config/kibana.yml
  echo "Kibana installation complete."
}

#########################################################################
# Check if elasticsearch is up by attempting to access its API endpoint.
# Add a 10second delay to allow the endpoint to come up
#########################################################################
test_e() {
  sleep 10
  curl -X GET http://localhost:9200 > /dev/null 2>&1
  [ "$?" -eq 0 ];
}

#########################################################
# Check if logstash is up by checking service status
# Add a 5 second delay to allow the service to come up
#########################################################
test_l() {
  sleep 5
  service logstash status > /dev/null 2>&1
  [ "$?" -eq 0 ];
}

#######################################################################
# Check if kibana is up by attempting to access its URL endpoint. 
# Add a 10 second delay to allow the service to come up
# Optionally, localhost can be replaced with the public DNS host / IP
#######################################################################
test_k() {
  sleep 10
  curl -X GET http://localhost:5601 > /dev/null 2>&1
  [ "$?" -eq 0 ];
}

############################################################
# Main function running in order:
# 0. Prepare the system: Add repositories, update, etc.
# 1. Install elasticsearch, logstash, kibana in that order
# 2. Start elasticsearch service; once it is up,
# 3. Start logstash; Check and report Logstash status
# 4. Start kibana; Check and report Kibana status
# 5. If any of these fail, exit with error 
############################################################
main() {
  sys_prep
  install_elasticsearch
  install_logstash
  install_kibana
  echo "Starting Elasticsearch.."
  SUCCESS=true
  service elasticsearch start
  echo -n "Elasticsearch Status: "
  if test_e; then
    echo "Running"
    echo "Starting Logstash.."
    service logstash start
    echo -n "Logstash Status: "
    if test_l; then
      echo "Running"
    else
      err "Logstash start failed!"
      SUCCESS=false
    fi
    echo "Starting Kibana.."
    service kibana start
    echo -n "Kibana Status: "
    if test_k; then
      echo "Running"
    else
      err "Kibana start failed!"
      SUCCESS=false
    fi
  else
    err "Elasticsearch start failed!"
    SUCCESS=false
  fi
  if [[ "${SUCCESS}" = "false" ]]; then
    err "One of the components failed to start!"
    err "exiting with error"
    exit 1
  fi
  echo "ELK Stack installation complete!"
}

main
