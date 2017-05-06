#!/bin/bash
# This script is used to add the MariaDB repos to APT.

# MariaDB Repo File
repo_outfile=/etc/apt/sources.list.d/mariadb.list
# MariaDB Pref File
pref_outfile=/etc/apt/preferences.d/mariadb-enterprise.pref

# MariaDB Repo Contents
repo_contents='# MariaDB Server
# To use a different major version of the server, or to pin to a specific minor version, change URI below.
deb http://downloads.mariadb.com/MariaDB/mariadb-%s/repo/ubuntu xenial main'

# Maria DB Prefs file
pref_contents="
Package: *
Pin: origin downloads.mariadb.com
Pin-Priority: 1000"

# Set MariaDB version.
[[ ! -z "$1" ]] && version=$1 || version=10.1
echo "Setting up MariaDB Repo for version: $version"
echo "Writing $repo_outfile"
printf "$repo_contents\n" $version > $repo_outfile
echo "Writing $pref_outfile"
printf "$pref_contents\n" > $pref_outfile

# These GPG key IDs are used to fetch keys from a keyserver on Ubuntu & Debian
echo "Importing Keys"
key_ids=( 0x8167EE24 0xE3C94F49 0xcbcb082a1bb943db 0xF1656F24C74CD1D8 )
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys "${key_ids[@]}"
