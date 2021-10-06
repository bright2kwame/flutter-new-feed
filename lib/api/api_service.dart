import 'dart:async';
import 'dart:convert';
import 'network_util.dart';

class ApiService {
  NetworkUtil _netUtil = new NetworkUtil();
  static const generalErrorMessage =
      "Something went wrong check and try again later.";
  static const noInternetConnection =
      "It appears you are offline, connect and try again.";

  //MARK: get list of items
  /// @url, url to fetch data
  Future<dynamic> getData(String url) {
    Map<String, String> emptyHeader = new Map();
    return _netUtil.get(url, emptyHeader, utf8).then((dynamic data) {
      var statusCode = data["status"].toString();
      print("STATUS: $statusCode");
      if (statusCode == "ok") {
        return data;
      } else {
        throw Exception(data.toString());
      }
    });
  }

  //MARK: post data
  /// @url, url to fetch data
  Future<dynamic> postDataNoHeader(String url, Map<String, String> data) {
    Map<String, String> emptyHeader = new Map();
    return _netUtil.post(url, emptyHeader, data, utf8).then((dynamic data) {
      var statusCode = data["status"];
      print("STATUS: $statusCode DATA: $data");
      if (statusCode == "ok") {
        return data;
      } else {
        throw Exception(data.toString());
      }
    });
  }

  //MARK: post data
  /// @url, url to fetch data
  Future<dynamic> postData(String url, Map<String, String> data) {
    Map<String, String> basicHeaders = new Map();
    return _netUtil.post(url, basicHeaders, data, utf8).then((dynamic data) {
      var statusCode = data["status"];
      print("STATUS: $statusCode DATA: $data");
      if (statusCode == "ok") {
        return data;
      } else {
        throw Exception(data.toString());
      }
    });
  }
}
