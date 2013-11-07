ar_cacheable
============

[![Build Status](https://travis-ci.org/t1732/ar_cacheable.png?branch=master)](https://travis-ci.org/t1732/ar_cacheable)

Cache of each ActiveRecord instance

## Installation

Add this line to your application's Gemfile:

    gem 'ar_cacheable', :github => 't1732/ar_cacheable'

And then execute:

    $ bundle

## Usage

```ruby

class Model < ActiveRecord::Base
  ar_cacheable
end

m = Model.find(params[:id])

# write cache
m.cache.write(:foo, "value", expires_in: 1.minute)
or
m.cache[:foo] = "value"

# read cache
m.cache.read(:foo)
or
m.cache[:foo]

# delete cache
m.cache.delete(:foo)

# check if there is a cache
m.cache.exist?(:foo)

# changes cache
m.name # => "name"
m.update_attributes(:name => "update")
m.reload

m.last_changes # => {"name" => ["name", "update"]}

```
