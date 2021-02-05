# Shellwords

[![Build Status](https://travis-ci.com/szTheory/shellwords-crystal.svg?branch=master)](https://travis-ci.com/szTheory/shellwords-crystal) [![Docs](https://img.shields.io/badge/docs-available-brightgreen.svg)](https://sztheory.github.io/shellwords-crystal/) [![GitHub release](https://img.shields.io/github/release/szTheory/shellwords-crystal.svg)](https://github.com/szTheory/shellwords-crystal/releases) ![GitHub stars](https://img.shields.io/github/stars/szTheory/shellwords-crystal?style=social)


This module manipulates strings according to the word parsing rules
of the UNIX Bourne shell. Fork of the [Ruby shellwords gem](https://rubygems.org/gems/shellwords).

The shellwords() function was originally a port of shellwords.pl,
but modified to conform to the Shell & Utilities volume of the IEEE
Std 1003.1-2008, 2016 Edition [1].

[1] [IEEE Std 1003.1-2008, 2016 Edition, the Shell & Utilities volume](http://pubs.opengroup.org/onlinepubs/9699919799/utilities/contents.html)

## Installation

1. Add the dependency to your `shard.yml`:

```yaml
dependencies:
  shellwords:
    github: szTheory/shellwords-crystal
```

2. Run `shards install`

## Usage

```crystal
require 'shellwords'

argv = Shellwords.shellsplit('three blind "mice"')
argv #=> ["three", "blind", "mice"]
```

## Development

After checking out the repo, install the shard dependencies. Then, run `crystal spec` to run the specs. You can also run `bin/console` for an interactive prompt that will allow you to experiment.


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/szTheory/shellwords-crystal
