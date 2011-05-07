describe(Search) do
  before(:each) do
    @search = Search.new
  end

  it "should smoke" do
    @search.resolve
  end
end
