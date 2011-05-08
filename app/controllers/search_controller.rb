class SearchController < ApplicationController
  def index
  end

  def search_results
    logger.tempdebug "current_search is #{current_search.inspect}"
    logger.tempdebug "current_search resolve is is #{current_search.resolve(params).inspect}"
    render :partial => 'search_results', :locals => { :response_data => current_search.resolve(params) }
  end
end
