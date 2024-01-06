#!/bin/bash

FILE="$1"

IFS=$'\n';
for i in `cat $FILE | tr -d '\n' | grep -oP '(<a href="http[s]?://.*?>.*?</a>)'`; do
    echo $i | grep -oP '(?<=>).*?(?=<)' | xargs echo -n
    echo -e -n "\t"
    echo $i | grep -oP '(?<=<a href=")(http[s]?://[^"]*)' | xargs echo -n
    echo -e -n "\t"
    echo $i | grep -oP '(?<=<a href=")(http[s]?://[^"]*)' | xargs -L 1 curl -I -m 5 -s -w "%{http_code}\n" -o /dev/null
done
