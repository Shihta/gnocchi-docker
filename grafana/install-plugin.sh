#!/bin/sh

set -e
set -x

: "${GF_PATHS_PLUGINS:=/var/lib/grafana/plugins}"
mkdir -p ${GF_PATHS_PLUGINS}/gnocchixyz-gnocchi-datasource
mkdir -p ${GF_PATHS_PLUGINS}/src

if [ "${GRAFANA_PLUGIN_URL}" ]; then
    URL=${GRAFANA_PLUGIN_URL}
else
    URL=$(curl https://api.github.com/repos/gnocchixyz/grafana-gnocchi-datasource/releases/latest | awk -F'"' '/browser_download_url/{print $4}')
fi
curl -qL $URL -o  ${GF_PATHS_PLUGINS}/src/gnocchixyz-gnocchi-datasource.tar.gz

source_tarball="$(tar -tf ${GF_PATHS_PLUGINS}/src/gnocchixyz-gnocchi-datasource.tar.gz --show-transformed-names --strip-components=1 | grep '^dist' || true)"
if [ -z "$source_tarball" ]; then
    tar -xf ${GF_PATHS_PLUGINS}/src/gnocchixyz-gnocchi-datasource.tar.gz --show-transformed-names --strip-components=1 -C ${GF_PATHS_PLUGINS}/gnocchixyz-gnocchi-datasource
else
    tar -xf ${GF_PATHS_PLUGINS}/src/gnocchixyz-gnocchi-datasource.tar.gz --show-transformed-names --strip-components=2 -C ${GF_PATHS_PLUGINS}/gnocchixyz-gnocchi-datasource --wildcards '*/dist'
fi

rm -rf ${GF_PATHS_PLUGINS}/src
