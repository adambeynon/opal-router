require 'spec_helper'

describe Router::Route do
  describe "#initialize" do
    let(:route) { Router::Route }
    it "creates a regexp from the given pattern" do
      route.new('foo').regexp.should eq(/^foo$/)
    end

    it "escapes slashes in the pattern" do
      route.new('/foo/bar/').regexp.should eq(/^\/foo\/bar\/$/)
    end

    it "finds named params in regexp" do
      r = route.new('/foo/:bar')
      r.named.should eq(['bar'])

      p = route.new('/:woosh/:kapow')
      p.named.should eq(['woosh', 'kapow'])
    end

    it "produces a regexp to match given pattern" do
      route.new('/foo').regexp.match('/bar').should be_nil
      route.new('/foo').regexp.match('/foo').should be_kind_of(MatchData)
    end
  end
end
