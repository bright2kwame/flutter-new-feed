import 'package:news_feed/new_feed.dart';
import 'package:intl/intl.dart';

class ParseApiData {
//MARK: parse the news feed data
  NewFeed parseFeed(var result) {
    String source = result["source"]["name"];
    String author = result["author"].toString();
    String title = result["title"].toString();
    String description = result["description"].toString();
    String url = getJsonData(result, "url");
    String urlToImage = getJsonData(result, "urlToImage");
    String publishedAt = result["publishedAt"].toString();
    var inputFormat = DateFormat('yyyy-MM-ddTHH:mm:SSZ');
    var parsedDate = inputFormat.parse(publishedAt);
    var outputFormat = DateFormat('hh:mm a');
    String content = result["content"].toString();
    var user = NewFeed(
        source: source,
        author: author,
        title: title,
        description: description,
        url: url,
        urlToImage: urlToImage,
        publishedAt: outputFormat.format(parsedDate).toString(),
        content: content);
    return user;
  }

  String getJsonData(dynamic data, String key) {
    if (data == null || data[key] == null) {
      return "";
    }
    return data[key].toString();
  }
}
