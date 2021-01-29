#!/bin/bash

set -eux
root_dir="$(cd "$(dirname $0)/.." && pwd)"

cd $root_dir/Site
toolchain_dir=$HOME/Library/Developer/Toolchains/swift-$(cat .swift-version).xctoolchain/usr

mkdir -p $toolchain_dir/lib/swift_static/CFXMLInterface
cp include/module.map $toolchain_dir/lib/swift_static/CFXMLInterface/module.map

carton bundle --custom-index-page public/index.html

rm $toolchain_dir/lib/swift_static/CFXMLInterface/module.map
