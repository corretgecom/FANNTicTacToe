#!/usr/bin/env bash

mkdir -p /etc/puppet/modules

if [ -d "/etc/puppet/modules/php" ]; then
    puppet module upgrade nodes/php
else
    puppet module install nodes/php
fi
