# TranslateableAttributes ![Travis CI](https://travis-ci.org/tmikoss/translateable_attributes.svg)

Helper methods to display translated values of object attributes (stored in database, plain object properties, ...)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'translateable_attributes'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install translateable_attributes

## Usage

Setup your translations:

```yaml
en:
  states:
    new: 'Initiated'
    completed: 'Done'
```

Extend a class with `TranslateableAttributes::Methods` and call `translate_attributes` method on it, passing a hash of `attribute_name: 'translation.namespace'` to it:

```ruby
class TranslatedClass
  extend TranslateableAttributes::Methods

  translate_attributes state: 'states'
end
```

Use `translated_attribute` class and instance methods to display translated values:

```ruby
TranslatedClass.translated_state('new') #=> 'Initiated'

translated_instance = TranslatedClass.new
translated_instance.state = 'new'
translated_instance.translated_state #=> 'Initiated'
```

In addition, `attributes_for_select` class method is defined that returns all available [translation, value] pairs - useful for select inputs in Rails form builders.

```ruby
TranslatedClass.states_for_select #=> [['Initiated', 'new'], ['Done', 'completed']]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/tmikoss/translateable_attributes/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
