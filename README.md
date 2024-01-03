# Packwerk Yard

> [!WARNING]
> This gem currently depends on a development branch for packwerk !!!
> Once https://github.com/Shopify/packwerk/pull/375 is merged and released, can this gem be safely used.

Add YARD support to packwerk.

## Installation

1. Add this line to your application's Gemfile:

```ruby
gem 'packwerk_yard', github: 'euglena1215/packwerk_yard', group: :development
```

2. Require `packwerk-yard` in your `packwerk.yml`

```yaml
require:
  - packwerk-yard
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/euglena1215/packwerk_yard. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/packwerk_yard/blob/main/CODE_OF_CONDUCT.md).

## Code of Conduct

Everyone interacting in the PackwerkYard project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/packwerk_yard/blob/main/CODE_OF_CONDUCT.md).
