#!/usr/bin/env bash

env > ~/Desktop/test.txt

eval `/usr/libexec/path_helper -s`

# Just to be sure
cd `dirname $0`

# Default directories for environment variables passed in.
alfred_workflow_bundleid=${alfred_workflow_bundleid:-com.darksupply.terminus}
alfred_workflow_data=${alfred_workflow_data:-"~/Library/Application Support/Alfred 3/Workflow Data/$alfred_workflow_bundleid"}
alfred_workflow_cache=${alfred_workflow_cache:-"~/Library/Caches/com.runningwithcrayons.Alfred-3/Workflow Data/$alfred_workflow_bundleid"}

# Add terminus to path based on COMPOSER_HOME. It falls back to anywhere in the path based on the user's shell.
COMPOSER_HOME=${COMPOSER_HOME:-$HOME/.composer}
PATH=$COMPOSER_HOME/vendor/bin:$PATH
SITES=""

setup() {
	mkdir -p $alfred_workflow_cache
}

fetch_sites() {
	local SITE_CACHE="$alfred_workflow_cache/sites.json"

	if [[ ! -f $SITE_CACHE ]]; then
		terminus site:list --format=json > $SITE_CACHE
	fi

	SITES="$(cat $SITE_CACHE)"
}

clear_cache() {
	# Safety check, then clear cache.
	if [[ -n $alfred_workflow_cache ]]; then
		rm -rf $alfred_workflow_cache
	fi
}

arg1=$1 && shift

setup

case $arg1 in
open)
	fetch_sites
	php terminusalfred.php "$SITES"
   ;;
cc)
	clear_cache
   ;;
esac
