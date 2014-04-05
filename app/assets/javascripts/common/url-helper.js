// Generated by CoffeeScript 1.6.3
(function() {
  this.URLHelper = (function() {
    function URLHelper() {}

    URLHelper.rankingUrlRegExp = /.*\/countries\/([a-z]+)\/markets\/([a-z]+)\/feeds\/([a-z_]+)\/categories\/(\w+)\/devices\/(\w+)\/rankings(\?.*)?/;

    URLHelper.appUrlRegExp = /.*\/app_items\/(\d+)(\?.*)?/;

    URLHelper.rankingUrl = function(args) {
      var category, country, device, feed, market, urlParam;
      urlParam = URLHelper.parseRankingUrl(window.location);
      country = (args.country || urlParam.country).toLowerCase();
      market = (args.market || urlParam.market).toLowerCase();
      category = (args.category || urlParam.category).toLowerCase();
      device = (args.device || urlParam.device).toLowerCase();
      feed = (args.feed || urlParam.feed).toLowerCase();
      return "/countries/" + country + "/markets/" + market + "/feeds/" + feed + "/categories/" + category + "/devices/" + device + "/rankings";
    };

    URLHelper.parseRankingUrl = function(url) {
      var match;
      match = URLHelper.rankingUrlRegExp.exec(url);
      return {
        country: match[1],
        market: match[2],
        feed: match[3],
        category: match[4],
        device: match[5]
      };
    };

    URLHelper.appItemUrl = function(id) {
      return "/app_items/" + id;
    };

    URLHelper.isRankingUrl = function(url) {
      return (URLHelper.rankingUrlRegExp.exec(url)) != null;
    };

    URLHelper.isAppUrl = function(url) {
      return (URLHelper.appUrlRegExp.exec(url)) != null;
    };

    return URLHelper;

  })();

}).call(this);
