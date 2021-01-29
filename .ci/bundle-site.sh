#!/bin/bash

set -eux
root_dir="$(cd "$(dirname $0)/.." && pwd)"

cd $root_dir/Site
carton bundle --custom-index-page public/index.html
