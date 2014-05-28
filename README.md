# update_or_create

update_or_create is a small RubyGem that adds the method update_or_create to ActiveRecord objects

## Installation

Add this line to your application's Gemfile:

    gem 'update_or_create'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install update_or_create

## Usage
Methods:

1. ```ClassName.update_or_create(find_params, update_params)```

update_or_create also works with associations. For example:
```object.has_many_association.update_or_create(find_params, update_params)```
