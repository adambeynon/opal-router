class Router
  attr_reader :path, :routes

  def initialize
    @routes = []
  end

  def start

  end

  def route path, &handler
    @routes << [path, handler]
  end

  def update
    @path = `window.location.hash.replace(/^#*/, '')`
  end

  class Route
    NAMED = /:(\w+)/

    attr_reader :regexp, :named

    def initialize pattern
      @named = []

      pattern.gsub(NAMED) { |m| @named << m[1..-1] }

      pattern = Regexp.escape(pattern).gsub(NAMED, "([^\\/]*)")
      @regexp = Regexp.new "^#{pattern}$"
    end
  end
end
