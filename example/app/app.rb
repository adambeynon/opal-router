require 'opal'
require 'opal-router'

router = Router.new

router.route('/users') {
  puts "Need to show users!"
}

router.route('/users/:id') { |params|
  puts "Need to show user: #{params[:id]}"
}
