class ApiController <  ApplicationController
  def resolve
    render(:json => current_search.resolve(params))
  end
end
