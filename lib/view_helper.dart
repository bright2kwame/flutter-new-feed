import 'package:flutter/material.dart';
import 'color.dart';

class ViewHelper {
//MARK: for all bars in the app
  AppBar appBar(String title) {
    return AppBar(
      elevation: 2.0,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.black, fontSize: 14),
      ),
      centerTitle: true,
      backgroundColor: HexColor.fromHex('#F8F8FD'),
    );
  }

//MARK: placeholder for images
  Widget placeholderImage({double width = 100, double height = 100}) {
    return new Image(
      image: AssetImage("images/app_logo.png"),
      height: height,
      width: width,
      fit: BoxFit.cover,
    );
  }
}
