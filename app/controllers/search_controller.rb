class SearchController < ApplicationController
  def index
  end

  def search_results
    render(:json => current_search.resolve(params) })
  end
end
