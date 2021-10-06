import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'api/api_service.dart';
import 'api/api_url.dart';
import 'api/parse_data.dart';
import 'view_helper.dart';
import 'color.dart';
import 'new_feed.dart';

class FeedDatailPage extends StatefulWidget {
  FeedDatailPage({Key? key, required this.newFeed}) : super(key: key);
  final NewFeed newFeed;

  @override
  _FeedDatailPageState createState() => _FeedDatailPageState();
}

class _FeedDatailPageState extends State<FeedDatailPage> {
  @override
  void initState() {
    super.initState();
  }

  void _startNewsFeedCall() {
    String url = ApiUrl().getNewsFeedUrl().trim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex('#F8F8FD'),
      appBar: ViewHelper().appBar("NEWS FEED"),
      body: _buildMainContentView(),
    );
  }

  Widget _buildMainContentView() {
    print(widget.newFeed.content);
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: 16, right: 16, left: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 8,
              ),
              child: Text(
                widget.newFeed.title,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8, bottom: 8),
              child: Text(
                "Updated: " + widget.newFeed.publishedAt,
                style: TextStyle(
                    color: Colors.grey, fontWeight: FontWeight.normal),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: widget.newFeed.urlToImage.isNotEmpty
                  ? new Image(
                      image:
                          CachedNetworkImageProvider(widget.newFeed.urlToImage),
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                    )
                  : Container(
                      height: 200,
                    ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 32,
              ),
              child: Text(
                widget.newFeed.description,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 16),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 32,
              ),
              child: Text(
                widget.newFeed.content,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
