#!/usr/bin/env bash

eval `/usr/libexec/path_helper -s`

# Just to be sure
cd `dirname $0`

# Add terminus to path based on COMPOSER_HOME. It falls back to anywhere in the path based on the user's shell.
COMPOSER_HOME=${COMPOSER_HOME:-$HOME/.composer}
PATH=$COMPOSER_HOME/vendor/bin:$PATH

json=$(terminus site:list --format=json)
php terminusalfred.php "$json"