#!/bin/bash

#####################################################
# Attempt to scriptify usage of Linux
# as a customer gateway in AMAZON AWS 
# VPC VPN Tunnels 
# http://openfoo.org/blog/amazon_vpc_with_linux.html
#####################################################

# USAGE:
# Read the guide in the link above,
# Verify this script
# Push script to an UBUNTU Precise Instance
# Run the Script

apt-get -y remove --purge ipsec-tools racoon
apt-get -y install ipsec-tools racoon

VPC_CIDR='192.168.0.0/24'

# ==TUNNEL ONE
ECgw_1='23.21.183.65'   # Outside Customer Gateway IP
EVPgw_1='72.21.209.224' # Outside Virtual Private Gateway IP

ICgw_1='169.254.255.78/30' # Inside Customer GW CIDR
IVPgw_1='69.254.255.77/30' # Inside Virt. Priv. GW CIDR

PSK1='<key_here>' # Pre-Shared Key for Tunnel 1

# ==TUNNEL TWO
ECgw_2='23.21.183.65' 
EVPgw_2='72.21.209.225'

ICgw_2='169.254.255.74/30'
IVPgw_2='169.254.255.73/30'

PSK2='<key_here>' # Pre-Shared Key for Tunnel 2

cp /etc/racoon/psk.txt /etc/racoon/psk.txt.orig
cat <<PSKFILE >> /etc/racoon/psk.txt
$EVPgw_1 $PSK1
$EVPgw_2 $PSK2
PSKFILE

cp /etc/ipsec-tools.conf /etc/ipsec-tools.conf.orig
cat <<IPSECFILE >> /etc/ipsec-tools.conf
flush;
spdflush;

spdadd $ICgw_1 $IVPgw_1 any -P out ipsec
  esp/tunnel/$ECgw_1-$EVPgw_1/require;

spdadd $IVPgw_1 $ICgw_1 any -P in ipsec
  esp/tunnel/$EVPgw_1-$ECgw_1/require;

spdadd $ICgw_2 $IVPgw_2 any -P out ipsec
  esp/tunnel/$ECgw_2-$EVPgw_2/require;

spdadd $IVPgw_2 $ICgw_2 any -P in ipsec
  esp/tunnel/$EVPgw_2-$ECgw_2/require;

spdadd $ICgw_1 $VPC_CIDR any -P out ipsec
  esp/tunnel/$ECgw_1-$EVPgw_1/require;

spdadd $VPC_CIDR $ICgw_1 any -P in ipsec
  esp/tunnel/$EVPgw_1-$ECgw_1/require;

spdadd $ICgw_2 $VPC_CIDR any -P out ipsec
  esp/tunnel/$ECgw_2-$EVPgw_2/require;

spdadd $VPC_CIDR $ICgw_2 any -P in ipsec
  esp/tunnel/$EVPgw_2-$ECgw_2/require;
IPSECFILE

cp /etc/racoon/racoon.conf /etc/racoon/racoon.conf.orig
cat <<RACOONCONF >> /etc/racoon/racoon.conf

remote $EVPgw_2 {
        exchange_mode main;
        lifetime time 28800 seconds;
        proposal {
                encryption_algorithm aes128;
                hash_algorithm sha1;
                authentication_method pre_shared_key;
                dh_group 2;
        }
        generate_policy off;
}

remote $EVPgw_1 {
        exchange_mode main;
        lifetime time 28800 seconds;
        proposal {
                encryption_algorithm aes128;
                hash_algorithm sha1;
                authentication_method pre_shared_key;
                dh_group 2;
        }
        generate_policy off;
}

sainfo address $ICgw_1 any address $IVPgw_1 any {
    pfs_group 2;
    lifetime time 3600 seconds;
    encryption_algorithm aes128;
    authentication_algorithm hmac_sha1;
    compression_algorithm deflate;
}

sainfo address $ICgw_2 any address $IVPgw_2 any {
    pfs_group 2;
    lifetime time 3600 seconds;
    encryption_algorithm aes128;
    authentication_algorithm hmac_sha1;
    compression_algorithm deflate;
}
RACOONCONF

ip a a $ICgw_1 dev eth0
ip a a $ICgw_2 dev eth0

/etc/init.d/racoon start
/etc/init.d/setkey start

# ==IGNORE
ping $IVPgw_1
ping $IVPgw_2
