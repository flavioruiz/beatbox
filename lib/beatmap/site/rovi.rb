require File.expand_path("../base", __FILE__)

require 'digest/md5'

module Beatmap
module Site

class Rovi < Base

  def search(query, entity, params={})
    params.merge!({
      :apiKey     => @config[:key],
      :facet      => 'type',
      :entityType => entity,
      :query      => query,
      :sig        => Digest::MD5.hexdigest(@config[:key] + @config[:secret] + Time.now.to_i.to_s)
    })

    self.class.get(@config[:url] + '/search/v1/search', :query => params)['searchResponse']['results']
  end

  def album_info(amgpopid, params={})
    params.merge!({
      :apiKey     => @config[:key],
      :amgpopid   => amgpopid,
      :include    => 'tracks',
      :sig        => Digest::MD5.hexdigest(@config[:key] + @config[:secret] + Time.now.to_i.to_s)
    })

    self.class.get(@config[:url] + '/data/v1/album/info', :query => params)['album']
  end

  def find_album_by_name(album, artist)
    results = search(album, 'album')

    results.each do |result|
      album_title = result['album']['title']
      artist_name = result['album']['primaryArtists']['AlbumArtist']['name']

      next unless album_title.match(album)
      next unless artist_name.match(artist)

      amg_album_id = result['album']['ids']['amgPopId']

      return {
        :amg_album_id => amg_album_id,
        :artist       => artist_name,
        :album        => album_title
      }
    end

    return nil
  end

  def find_artist_by_name(artist)
    results = search(artist, 'artist')

    results.each do |result|
      artist_name = result['name']['name']
      next unless artist_name.match(artist)

      amg_artist_id = result['name']['ids']['amgPopId']

      return {
        :amg_artist_id => amg_artist_id,
        :artist        => artist_name,
      }
    end

    return nil
  end

end

end
end

if $0 == __FILE__
bm = Beatmap::Site::Rovi.new({
  :url         => 'http://api.rovicorp.com',
  :key         => 'a26838bw349af7752zr796a7',
  :secret      => 'YGvUSeMXx8'
})

p bm.find_album_by_name('Hot Sauce Committee', 'Beastie Boys')
# p bm.find_artist_by_name('Violens')
end