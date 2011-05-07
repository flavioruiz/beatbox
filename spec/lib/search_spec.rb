describe(Search) do

  before(:each) do
    @search = Search::fake
  end

  it "should resolve an artist" do
    results = @search.resolve(:artist_name => "DJ Quik")
    results.size.should == 2
    results[0][:provider].should == :custom
    results[0][:label].should    == 'direct from the artist'
  end

end
