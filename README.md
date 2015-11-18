[![Build Status](https://travis-ci.org/spieker/pundit_namespaces.svg?branch=master)](https://travis-ci.org/spieker/pundit_namespaces)
[![Code Climate](https://codeclimate.com/github/spieker/pundit_namespaces/badges/gpa.svg)](https://codeclimate.com/github/spieker/pundit_namespaces)
[![Test Coverage](https://codeclimate.com/github/spieker/pundit_namespaces/badges/coverage.svg)](https://codeclimate.com/github/spieker/pundit_namespaces/coverage)

# PunditNamespaces

Namespaces for Pundit policies.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pundit'
gem 'pundit_namespaces'
```

Install pundit and then include PunditNamespaces in your application controller
and override the `pundit_namespace` method returning the namespace to be used.

```ruby
class ApplicationController < ActionController::Base
  include Pundit
  include PunditNamespaces

  def pundit_namespace
    current_user.class.name
  end
end
```

## Usage

As described in the installation part, the `pundit_namespace` method has to
return the namespace to be used. The policy has then to be namespaced within the
module returned by pundit_namespace.

```ruby
# app/policies/admin/post_policy.rb
module Admin
  class PostPolicy < AdminPolicy
    class Scope < AdminPolicy::Scope
    end
  end
end

# app/policies/user/post_policy.rb
module User
  class PostPolicy < UserPolicy
    class Scope < UserPolicy::Scope
    end
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/pundit_namespaces. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
