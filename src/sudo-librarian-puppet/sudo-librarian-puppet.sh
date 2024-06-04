#!/usr/bin/env bash

sudo -i <<EOF
cd /etc/puppetlabs/code/environments/production
HOME=/root
/usr/local/bin/librarian-puppet install --verbose
EOF
