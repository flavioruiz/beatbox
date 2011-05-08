class Search
  attr_reader(:repository)

  def initialize(repository)
    @repository = repository

    @rovi = Beatmap::Site::Rovi.new(BEATMAP[:rovi])
    @itunes = Beatmap::Site::ITunes.new(BEATMAP[:itunes])
  end

  # artist_name, album_name, album_amg_id
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

    return [] if offers.count.zero?

    offers.first.locations.map do |location|
      {
        :provider => location.site  ,
        :label    => location.label ,
        :url      => location.uri   ,
      }
    end
  end

  def find_by_api(params)
    candidates = []

    if params[:artist_name] and params[:album_name]
      amgAlbumId = @rovi.find_album_by_name(params[:album_name], params[:artist_name])[:amgAlbumId]

      itunes_url = amgAlbumId ? @itunes.album_url_by_id(amgAlbumId.split(' ').last) : nil
      itunes_url ||= @itunes.album_url_by_name(params[:album_name], params[:artist_name])
      itunes_url ||= @itunes.artist_url_by_name(params[:artist_name])

      candidates << {
        :results => {
          :url      => itunes_url,
          :provider => :itunes,
          :label    => 'buy from iTunes'
        }
      }

      search_term = CGI.escape("#{params[:artist_name]} #{params[:album_name]}")
      candidates << {
        :results => {
          :url      => "http://www.amazon.com/s/?url=search-alias%3Daps&field-keywords=#{search_term}&tag=p4kalbrevs-20",
          :provider => :amazon,
          :label    => 'buy from Amazon'
        }
      }

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
