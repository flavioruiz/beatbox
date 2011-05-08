class SearchController < ApplicationController
  def index
  end

  def search_results
    render :partial => 'search_results', :locals => { :response => current_search.resolve(params) }
  end
end
