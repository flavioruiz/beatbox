require File.expand_path("../base", __FILE__)

module Beatmap
module Site

class ITunes < Base

  def lookup(params)
    self.class.get(@config[:url] + '/wsLookup', :query => params)['results'] || []
  end

  def search(params)
    self.class.get(@config[:url] + '/wsSearch', :query => params)['results'] || []
  end

  def album_url_by_id(amgAlbumId)
    # return the first one for now. there can be albums with bonus tracks,
    # explicit vs non explicit, etc. first in list is most relevant.
    lookup(:amgAlbumId => amgAlbumId).first['collectionViewUrl']
  end

  def album_url_by_name(album, artist)
    results = search(:term => album, :entity => 'album')

    results.each do |result|
      next unless result['artistName'].match(artist)
      next unless result['collectionName'].match(album)

      return result['collectionViewUrl']
    end

    return nil
  end

  def artist_url_by_name(artist)
    results = search(:term => artist, :entity => 'musicArtist')

    results.each do |result|
      if result['artistName'] =~ /#{artist}/
        return result['artistLinkUrl']
      end
    end

    return nil
  end

end

end
end

if $0 == __FILE__
  bm = Beatmap::Site::ITunes.new({
    :url => 'http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/wa'
  })
end