class ApiController <  ApplicationController
  def resolve
    # Pop the callback function out.
    callback = params[:callback] 
    params.delete(:callback)

    if !callback.blank?
      render(:text => "#{callback}(#{current_search.resolve(params).to_json});")
    else
      render(:json => current_search.resolve(params))
    end
  end
end

=begin
hello(
  {
    [
      {"url":"http://djquikmusic.com/shop.html","label":"direct from the artist","provider":"custom"},
      {"url":"http://www.amazon.com/s/?url=search-alias%3Daps&field-keywords=Gang%20Gang%20Dance+Eye%20Contact&tag=p4kalbrevs-20","label":"buy from amazon","provider":"amazon"}
    ]
);
=end
