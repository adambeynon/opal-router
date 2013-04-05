require 'spec_helper'

describe Router do
  let(:router) { Router.new }

  before do
    router.start
  end

  after do
    #router
  end

  def set_native_hash hash
    `window.location.hash = #{hash}`
  end

  describe "#update" do
    it "should update Router.path" do
      set_native_hash '#/hello/world'
      router.update

      router.path.should eq('/hello/world')
    end
  end

  describe "#route" do
    it "should add a route" do
      router.route('/users') {}
      router.routes.size.should eq(1)

      router.route('/hosts') {}
      router.routes.size.should eq(2)
    end
  end

  describe "#match" do
    it "returns nil when no routes on router" do
      router.match('/foo').should be_nil
    end

    it "returns a matching route for the path" do
      a = router.route('/foo') {}
      b = router.route('/bar') {}

      router.match('/foo').should eq(a)
      router.match('/bar').should eq(b)
    end

    it "returns nil when there are no matching routes" do
      router.route('/woosh') {}
      router.route('/kapow') {}

      router.match('/ping').should be_nil
    end
  end
end
