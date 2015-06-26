[![Build Status](https://travis-ci.org/flower-pot/tree_outline.svg?branch=master)](https://travis-ci.org/flower-pot/tree_outline)
[![Test Coverage](https://codeclimate.com/github/flower-pot/tree_outline/badges/coverage.svg)](https://codeclimate.com/github/flower-pot/tree_outline/coverage)
[![Code Climate](https://codeclimate.com/github/flower-pot/tree_outline/badges/gpa.svg)](https://codeclimate.com/github/flower-pot/tree_outline)

# TreeOutline

Use TreeOutline to stringify trees. It uses characters from the extended ASCII
character encoding to make them the most beautiful they can be.

The style the tree is formatted in is similar to the way the unix tool `tree`
outputs the the tree of a directory.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tree_outline'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tree_outline

## Usage

All you need is a recursive datastructure such as the below `Node` class. It
contains the attribute `children`, which is an enumeration of `Node`s as well.
The `to_s` method is called to stringify a node itself.

```ruby
require 'tree_outline'

class Node
  attr_reader :name, :children

  def initialize(name, children = [])
    @name = name
    @children = children
  end

  alias_method :to_s, :name
end

my_tree = Node.new('root', [
  Node.new('first'),
  Node.new('second'),
  Node.new('third')
])

puts TreeOutline.new(my_tree).to_s
# root
# ├── first
# ├── second
# └── third
```

## Side-Note

When implementing we noticed that this also makes a interesting, good (and
hard) kata. Try implementing it and see for yourself.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, git tag for
the version, push git commits and tags. Travis CI then runs the tests and when
passed automatically pushes the new gem to
[rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/tree_outline/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
