#!/bin/bash
set -e

# allow the container to be started with `--user`
if [[ "$1" == *nginx* && "$(id -u)" == '0' ]]; then
	chown -R nginx .
	chown -R nginx ${NGX_CACHE_DIR}
	exec gosu nginx "$BASH_SOURCE" "$@"
fi

exec "$@"
