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
end
