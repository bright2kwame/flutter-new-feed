import 'package:flutter/material.dart';

import 'color.dart';

class ViewHelper {
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
}
