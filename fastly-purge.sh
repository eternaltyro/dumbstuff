#!/bin/bash

SITE_URL=http://www.inkscape.org
API_ENDPOINT=https://api.fastly.com
CDN_ENDPOINT=https://inkscape.global.ssl.fastly.net
BASE_DIR=/var/www/www.inkscape.org

pushd ${BASE_DIR}
# Optionally add mtime
find . -name '*.js' > /tmp/js.txt
find . -name '*.css' > /tmp/css.txt

echo "Purging CSS files.."
while IFS='' read -r line || [[ -n "$line" ]]; do
  curl -X PURGE ${CDN_ENDPOINT}/${line}
done < /tmp/css.txt

echo "Purging JS files.."
while IFS='' read -r line || [[ -n "$line" ]]; do
  curl -X PURGE ${CDN_ENDPOINT}/${line}
done < /tmp/js.txt

echo "Fin."
