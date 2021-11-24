#!/bin/bash

set -e

URL="https://jsonplaceholder.typicode.com/comments"

for value in `curl $URL | grep '"id"' | awk '{print $2}' | sed 's/.$//'`; do
    echo $value 
done
