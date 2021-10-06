class ApiUrl {
  //MARK: get the base url
  String getBaseUrl() {
    var baseTestUrl = "https://newsapi.org/v2/top-headlines?country=us&apiKey=";
    var baseLiveUrl = "https://newsapi.org/v2/top-headlines?country=us&apiKey=";
    const bool _kReleaseMode = const bool.fromEnvironment("dart.vm.product");
    return _kReleaseMode ? baseTestUrl : baseLiveUrl;
  }

  //MARK: news feed
  String getNewsFeedUrl() {
    return getBaseUrl() + "38f6b47b78ae4e29a52e5700dcdb655e";
  }
}
