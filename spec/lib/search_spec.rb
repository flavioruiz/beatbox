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

  describe("When there are overrides") do
    before(:all) do
      @artist   = Factory(:user)
      @offer    = @artist.offers.create(:name => "Foo")
      @location = @offer.locations.create(:site => "site_val", :label => "label_val", :uri => "uri_val")
    end

    it "should find override by artist" do
      offers = @search.resolve(:artist_name => @artist.artist_name)
      offers.size.should == 1

      offer = offers.first
      offer[:provider].should  == "site_val"
      offer[:label].should     == "label_val"
      offer[:url].should       == "uri_val"
    end
  end
end
