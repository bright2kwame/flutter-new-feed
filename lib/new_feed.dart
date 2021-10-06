class NewFeed {
  String source = "";
  String author = "";
  String title = "";
  String description = "";
  String url = "";
  String urlToImage = "";
  String publishedAt = "";
  String content = "";

  NewFeed({
    this.source = "",
    this.author = "",
    this.title = "",
    this.description = "",
    this.url = "",
    this.urlToImage = "",
    this.publishedAt = "",
    this.content = "",
  });

  NewFeed.empty();

  // Implement toString to make it easier to see information about
  // each NewFeed when using the print statement.
  @override
  String toString() {
    return 'NewFeed{title: $title}';
  }
}
