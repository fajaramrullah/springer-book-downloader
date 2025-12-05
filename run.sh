#!/bin/bash

echo "It depends on curl, sed, lynx, grep, head"

read -p "Input book link: " link

getTitle() {
    local url="$1"
    curl -L -s "$url" | sed -n 's/<title>\(.*\)<\/title>/\1/Ip' | sed -e 's/^[[:space:]]*//'
}

getURL() {
    local url="$1"
    lynx -dump -listonly "$url" | grep 'content.pdf' | head -n1 | awk '{print $2}'
}

echo "Getting file URL..."
title=$( getTitle "$link" )
url=$( getURL "$link" )

if [[ -z "$url" ]]; then
    echo "PDF link not found. Exiting."
    exit 1
fi

echo "Downloading: $url as \"$title.pdf\" ..."
curl --output "$title.pdf" --progress-bar --location "$url"

echo "Download completed."
echo "Thank you for using the script."
echo "Author: Kojee"