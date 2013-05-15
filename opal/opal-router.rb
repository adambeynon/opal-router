class Router
  attr_reader :path, :routes

  def initialize
    @routes = []
    @location = $window.location

    $window.addEventListener 'hashchange', proc { update }, false
  end

  def route path, &handler
    route = Route.new(path, &handler)
    @routes << route
    route
  end

  def update
    @path = @location.hash.sub(/^#*/, '')

    match @path
  end

  def match path
    @routes.find { |r| r.match path }
  end

  class Route

    # Regexp for matching named params in path
    NAMED = /:(\w+)/

    # Regexp for matching named splats in path
    SPLAT = /\\\*(\w+)/

    attr_reader :regexp, :named

    def initialize pattern, &handler
      @named, @handler = [], handler

      pattern = Regexp.escape pattern

      pattern.gsub(NAMED) { |m| @named << m[1..-1] }
      pattern.gsub(SPLAT) { |m| @named << m[2..-1] }

      pattern = pattern.gsub NAMED, "([^\\/]*)"
      pattern = pattern.gsub SPLAT, "(.*?)"

      @regexp = Regexp.new "^#{pattern}$"
    end

    # Return a hash of all named parts to values if route matches path, or
    # nil otherwise
    def match path
      if match = @regexp.match(path)
        params = {}
        @named.each_with_index { |name, i| params[name] = match[i + 1] }

        @handler.call params if @handler

        return true
      end

      false
    end
  end
end
