# Shellwords

This module manipulates strings according to the word parsing rules
of the UNIX Bourne shell.

The shellwords() function was originally a port of shellwords.pl,
but modified to conform to the Shell & Utilities volume of the IEEE
Std 1003.1-2008, 2016 Edition [1].

[1] [IEEE Std 1003.1-2008, 2016 Edition, the Shell & Utilities volume](http://pubs.opengroup.org/onlinepubs/9699919799/utilities/contents.html)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'shellwords'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install shellwords

## Usage

```crystal
require 'shellwords'

argv = Shellwords.split('three blind "mice"')
argv #=> ["three", "blind", "mice"]
```

## Development

After checking out the repo, install the shard dependencies. Then, run `crystal spec` to run the specs. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

TODO: add instructions for publishing a new shard version

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/szTheory/shellwords-crystal

