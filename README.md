# OrderTransformer

Note: This gem is in maintenance mode and not actively updated.

The order transformer transforms data from an external format to the desired target format.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'order_transformer'
```

And then run `bundle install`.

## Usage

The gem allows you to define data transformations via a DSL like so:

```ruby
OrderTransformer::DSL.define :some_shop, "v1.0" do
  definition do
    order as: :hash do
      # The core of the transformation process is implemented by using the `transform` method. This maps the input "OrderNumber" field to the output "order_number" field.
      transform "OrderNumber", to: "_order_number"

      # By default, values of input data are not required to be set. To
      # require them, set `optional: false`:
      transform "OrderNumber", to: "_order_number", optional: false

      # If you need to modify the input data, provide a custom transform instruction:
      transform "OrderNumber", to: "_order_number", transformer: ->(order_number) { order_number.to_d }

      # The gem also comes with some default transformers that are always included.
      # See `DefaultTransformers`.
      # The above can be rewritten as:
      transform "OrderNumber", to: "_order_number", transformer: to_d

      # Using multiple inputs is also possible:
      transform "street_1", "street_2", "street_3", to: "_street", transformer: ->(street_1, street_2, street_3) { street_1 || street_2 || street_3 }

    end
  end
end
```

You can collect your own data transformers in a plain Ruby module:

```ruby
module MyTransformers
  def presence(chain = nil)
    chain ||= __create_method_chain(caller(1, 1))
    chain.add ->(value, *_args) { value.presence }
  end
end
```

and include it in your transformer:


```ruby
OrderTransformer::DSL.define :some_shop, "v1.0" do
  include_transformers MyTransformers

  definition do
    order as: :hash do
      transform "OrderNumber", to: "_order_number", transformer: presence
    end
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

### Recommended cycle

#### Dev

- branch new features from development
- develop feature 
- merge into development via squash merge

#### Release

- create branch from development
- change gem version from pre to real via `be gem bump -v patch --pretend` and after check `be gem bump -v patch`
- merge branch (merge commit!) into master
- tag master via `git pull --rebase` && `gem tag` && `git push --tags`

#### Start development for next release

- create branch from master
- bump version to next pre `be gem bump -v pre --pretend` and after check `be gem bump -v pre`
- merge branch (merge commit!) into development
