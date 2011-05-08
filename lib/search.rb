class Search
  attr_reader(:repository)

  def initialize(repository)
    @repository = repository
  end

  def resolve(params = {})
    candidates = find_overrides(params)
    return candidates if candidates.any?
    return find_by_api(params)
  end

  def find_overrides(params)
    return [] unless %w{album_amg_id artist_name album_name}.any? { |x| params[x.to_sym].blank? }

    if x = params[:artist_name]
      artist = User::find(:first, :conditions => { :artist_name => x})
      offers = artist.offers if artist
    end

    offers ||= Offer::Album.scoped({})

    if x = params[:album_amg_id]
      offers = offers.scoped(:conditions => { :amg_id => x })
    end

    if x = params[:album_name]
      offers = offers.scoped(:conditions => [ "offers.name LIKE ?", "%#{x}%"])
    end

    offers = offers.first(5).map do |offer|
      locations = offer.locations.map do |location|
        {
          :provider => location.site  ,
          :label    => location.label ,
          :url      => location.label ,
        }
      end
      { :results => locations }
    end

    return offers
  end

  def find_by_api(params)
    candidates = []

    if name = params[:artist_name]
      candidates += repository.find_all do |entry|
        match_string(name,entry[:media][:artist_name])
      end
    end

    if name = params[:album_name]
      candidates += repository.find_all do |entry|
        match_string(name,entry[:media][:album_name])
      end
    end

    offers = candidates.map { |x| x[:results] }.flatten

    return offers
  end

  protected
  def match_string(a,b)
    a.downcase == b.downcase
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
