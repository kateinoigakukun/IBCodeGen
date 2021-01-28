# IBCodeGen

A tool to transition from Interface Builder to Swift code.

![](./Static/ibcodegen-demo.gif)

## Usage

Please visit: https://kateinoigakukun.github.io/IBCodeGen


## CLI

### Installation

```
$ mint install kateinoigakukun/IBCodeGen@main
# or
$ git clone https://github.com/kateinoigakukun/IBCodeGen
$ cd IBCodeGen
$ swift build -c release && cp .build/release/ibcodegen /usr/local/bin/
```

### Usage

```
$ ibcodegen --help
OVERVIEW: Translate .xib or .storyboard into Swift

USAGE: ibcodegen <input> [--output <output>]

ARGUMENTS:
  <input>                 An input .xib or .storyboard

OPTIONS:
  -o, --output <output>   Write to file
  -h, --help              Show help information.

$ ibcodegen PopcornView.xib -o PopcornView.swift
```

