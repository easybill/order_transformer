# OrderTransformer

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/data_transformer`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'order_transformer'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install data_transformer

## Usage

TODO: Write usage instructions here

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

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/data_transformer.


