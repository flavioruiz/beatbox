require 'spec_helper'
describe(Search) do

  before(:each) do
    @search = Search::fake
  end

  describe("when resolving by artist_name") do
    it "should resolve exact matches" do
      results = @search.resolve(:artist_name => "DJ Quik")
      results.size.should == 2
      results[0][:provider].should == :custom
      results[0][:label].should    == 'direct from the artist'
    end

    it "should be case insensitive" do
      results = @search.resolve(:artist_name => "dj quik")
      results.size.should == 2
      results[0][:provider].should == :custom
      results[0][:label].should    == 'direct from the artist'
    end
  end
end
