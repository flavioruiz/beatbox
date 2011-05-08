$(document).ready(function(){

  console.log("loading...");

  // http://stackoverflow.com/questions/901115/get-querystring-values-in-javascript
  function getParam(uri,name) {
    var regexS = "[\\?&]"+name+"=([^&#]*)";
    var regex = new RegExp( regexS );
    var results = regex.exec( uri );
    if( results !== null ) {
      return decodeURIComponent(results[1].replace(/\+/g, " "));
    }
  }

  $('a').each(function(){

    // http://somafm.com/buy/multibuy.cgi?mode=amazon&title=The%20Secret%20Door&album=Everthing%20Touches%20Everything&artist=These%20United%20States
    var href = $(this).attr('href');
    console.log("looking at " + href);

    if(href.match(/multibuy.cgi/)) {

      console.log("match");

      var artist = getParam(href,'artist'),
          album  = getParam(href,'album');

      console.log("artist: " + artist);
      console.log("album: " + album);

      if(artist || album) {
        var request = "http://thebuybutton.com/api/resolve?";

        if(artist) request += "artist_name=" + encodeURIComponent(artist);

        if(album) {
          request  += artist ? "&" : "?";
          request  += encodeURIComponent(album)
        }

        console.log('request' + request);

        var that = $(this);

        chrome.extension.sendRequest({'action' : 'fetchBuyButton' , url: request}, function(response) {

          if(response && response[0] && response[0].url) {
            console.log('response[0].url' + response[0].url);
            that.attr('href',response[0].url);
          }
        });
      }
    }
  });

});
