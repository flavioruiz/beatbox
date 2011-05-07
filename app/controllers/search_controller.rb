class SearchController < ApplicationController
  def index
    return unless request.post? 
    render :partial => 'search_results', :locals => {:response => current_search.resolve(params)}
  end
end
