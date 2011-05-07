class Search
  attr_reader(:repository)

  def initialize(repository)
    @repository = repository
  end

  def resolve(params = {})
    candidates = []

    if name = params[:artist_name]
      candidates += repository.find_all do |entry|
        entry[:media][:artist_name] == name
      end
    end

    if name = params[:album_name]
      candidates += repository.find_all do |entry|
        entry[:media][:album_name] == name
      end
    end

    return candidates.map { |x| x[:results] }.flatten
  end

  REPOSITORY = [
    { 
      :media => {
        :artist_name => "DJ Quik",
        :album_name  => "The Book Of David",
      },
      :results => [
        {
          :provider => :custom,
          :url      => "http://djquikmusic.com/shop.html",
          :label    => "direct from the artist"
        },
        {
          :provider => :amazon,
          :url      => "http://www.amazon.com/s/?url=search-alias%3Daps&field-keywords=Gang%20Gang%20Dance+Eye%20Contact&tag=p4kalbrevs-20",
          :label    => "buy from amazon"
        }
      ]
    }
  ].freeze

  def self.fake
    new(REPOSITORY)
  end
end
