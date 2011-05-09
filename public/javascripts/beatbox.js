// assume jQuery 1.6 is loaded
var beatbox = (function() {

  // consts
  var END_POINT = "http://beatbox.heroku.com/api";
  //var END_POINT = "http://localhost:3000/api";
  var VALID_AFFILIATES_PARAMS =  [
    'amazon',
    'itunes',
    'topspin'
  ];

  var VALID_SEARCH_PARAMS = [
    'bbid',
    'artist_name',
    'album_name',
    'album_upc',
    'track_name',
    'track_isrc'
  ];

  // "instance"
  var _affiliateCodes;

  function init(affiliates, end_point) {
    _affiliateCodes = cleanParams(VALID_AFFILIATES_PARAMS, affiliates);
  }

  function search(params, onComplete) {
    var params      = cleanParams(VALID_SEARCH_PARAMS, params);
        result      = null,
        affiliates = new Object;

    // shitty shitty shitty; does this so our get is flat
    jQuery.each(_affiliateCodes, function(key, value) {
      affiliates['affiliate_' + key] = value;
    });

    // Add in the affiliates
    jQuery.extend(params, affiliates);

    jQuery.ajax({
      url: END_POINT + '/resolve',
      dataType: 'jsonp',
      data: params,
      success: onComplete
    });
  }

  function cleanParams(valid_options, dirty_options) {
    var cp = new Object;

    jQuery.each(dirty_options, function(key, value) {
      if (jQuery.inArray(key, valid_options) == -1) {
        return;
      }

      cp[key] = value
    });

    return cp;
  }

  return {
    init:  init,
    search: search
  };


}());
