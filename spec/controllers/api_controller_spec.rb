require 'spec_helper'
describe(ApiController, :type => :controller) do
  it "should resolve offers" do
    get(:resolve,:artist_name => "DJ Quik")
    response.should be_success
    json = JSON.parse(response.body)
    json.size.should == 2
  end
end
