# opal-router

A simple router for Opal applications.

## Installation

Add to your Gemfile:

```ruby
gem 'opal-router', :git => 'git://github.com/adambeynon/opal-router.git'
```

Then, anywhere in your opal code:

```ruby
require "opal-router"
```

## Usage

```ruby
require "opal-router"

router = Router.new

router.route("/users") do
  puts "need to show all users"
end

router.route("/users/:id") do |params|
  puts "need to show user: #{ params[:id] }"
end


# visit "example.com/#/users"
# visit "example.com/#/users/3"
# visit "example.com/#/users/5"

# => "need to show all users"
# => need to show user: 3
# => need to show user: 5
```

## TODO

* Support older browsers which do not support `onhashchange`.
* Support not-hash style routes with HTML5 routing.

## License

MIT
