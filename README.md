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

```ruby
MyClass.update_or_create(name: 'Test Name') do |a|
  a.test_column = "Some value"
end
```

update_or_create also works with associations. For example:
```ruby
object.has_many_association.update_or_create(name: 'Test Name) do |a|
  a.test_column = "Some value"
end
```
