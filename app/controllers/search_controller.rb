class SearchController < ApplicationController
  def index
  end

  def search_results
    render :partial => 'search_results'
  end
end
