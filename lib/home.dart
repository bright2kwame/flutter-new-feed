import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:news_feed/feed_detail.dart';
import 'api/api_service.dart';
import 'api/api_url.dart';
import 'api/parse_data.dart';
import 'view_helper.dart';
import 'color.dart';
import 'new_feed.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<NewFeed> data = [];
  late BuildContext _buildContext;

  @override
  void initState() {
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => this._startNewsFeedCall());
    super.initState();
  }

  void _startNewsFeedCall() {
    String url = ApiUrl().getNewsFeedUrl().trim();
    final progress = ProgressHUD.of(_buildContext);
    progress?.show();
    ApiService().getData(url).then((value) {
      var articles = value["articles"];
      articles.forEach((item) {
        this.data.add(ParseApiData().parseFeed(item));
      });
      setState(() {});
    }).onError((error, stackTrace) {
      print(error);
      print(stackTrace.toString());
    }).whenComplete(() {
      progress?.dismiss();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex('#F8F8FD'),
      appBar: ViewHelper().appBar("NEWS FEED"),
      body: ProgressHUD(
          child: Builder(
        builder: (buildContext) => _buildMainContentView(buildContext),
      )),
    );
  }

  Widget _buildMainContentView(BuildContext buildContext) {
    this._buildContext = buildContext;
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        var row = data[index];
        if (index == 0) {
          return headerView(row);
        }
        return rowItemView(row);
      },
    );
  }

  Widget rowItemView(NewFeed feed) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 180,
      child: Row(
        children: [
          Expanded(
              child: Container(
            padding: EdgeInsets.only(top: 16, left: 8, right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        feed.source + " ",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        feed.publishedAt + " 🔥 ",
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                            fontWeight: FontWeight.normal),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Expanded(child: Container())
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 16,
                  ),
                  child: Text(
                    feed.title,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(child: Container()),
                Container(
                  margin: EdgeInsets.only(top: 16),
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: Colors.white.withAlpha(100),
                      border: Border.all(
                          color: Colors.white.withAlpha(100), width: 0),
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  child: Text(
                    feed.source,
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                )
              ],
            ),
          )),
          Container(
            width: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      this._goToDetail(feed);
                    },
                    icon: Icon(Icons.more_horiz_outlined)),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: feed.urlToImage.isEmpty
                      ? Container(
                          height: 110,
                          width: 100,
                          color: Colors.grey.withAlpha(100),
                        )
                      : new Image(
                          image: CachedNetworkImageProvider(feed.urlToImage),
                          fit: BoxFit.cover,
                          width: 100,
                          height: 110,
                        ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _goToDetail(NewFeed feed) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => FeedDatailPage(newFeed: feed)));
  }

  Widget headerView(NewFeed feed) {
    return Container(
        padding: EdgeInsets.all(8),
        height: 200,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Stack(
            children: [
              new Image(
                image: CachedNetworkImageProvider(feed.urlToImage),
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: 200,
              ),
              new Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black,
                  ],
                )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: Container()),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: 0,
                          ),
                          child: Text(
                            feed.source + " 🔥 " + feed.publishedAt,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(child: Container()),
                        Container(
                          height: 32,
                          width: 32,
                          child: IconButton(
                              onPressed: () {
                                this._goToDetail(feed);
                              },
                              icon: Icon(
                                Icons.more_horiz_outlined,
                                color: Colors.white,
                              )),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 4, bottom: 4),
                      child: Text(
                        feed.title,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.normal),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: Colors.white.withAlpha(100),
                          border: Border.all(
                              color: Colors.white.withAlpha(100), width: 0),
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      child: Text(
                        feed.source,
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
