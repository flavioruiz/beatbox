class SearchController < ApplicationController
  def index
    return unless request.post? 
    render(:json => current_search.resolve(params))
  end
end
