import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class TokenChecker {
  setToken(token) async {
    SharedPreferences sharedStorage = await SharedPreferences.getInstance();

    int hours = 1;
    int minutes = 60;
    int seconds = 60;
    int milliseconds = 1000;

    sharedStorage.setString('_token', token);
    sharedStorage.setInt(
      'token_time',
      DateTime.now().millisecondsSinceEpoch +
          (hours * minutes * seconds * milliseconds),
    );
  }

  getToken() async {
    SharedPreferences sharedStorage = await SharedPreferences.getInstance();
    return sharedStorage.getString('_token');
  }

  removeToken() async {
    SharedPreferences sharedStorage = await SharedPreferences.getInstance();
    sharedStorage.remove('token_time');
    sharedStorage.remove("_token");
    sharedStorage.remove("_user-info");
    return;
  }

  Future<List> isAccessTokenExpired() async {
    SharedPreferences sharedStorage = await SharedPreferences.getInstance();

    final accessTokenExpiryTime = sharedStorage.getInt('token_time');

    if (accessTokenExpiryTime == null) {
      // Access token expiry time not set, so assume it is expired
      return [true];
    }

    final currentTime = DateTime.now().millisecondsSinceEpoch;

    if (accessTokenExpiryTime < currentTime) {
      // Access token has expired

      SharedPreferences sharedStorage = await SharedPreferences.getInstance();
      String? tokenValue = sharedStorage.getString('_token');
      var checkTokenValue = await GetNewToken(tokenValue);

      try {
        if (checkTokenValue == "Error Occured") {
          return [true, checkTokenValue];
        } else {
          setToken(checkTokenValue);
          return [false, checkTokenValue];
        }
      } catch (e) {
        // print(e);
      }
    }

    // Access token is still valid
    return [false];
  }

  Future<String> GetNewToken(token) async {
    final String url = "https://api.stay2easy.com/user/refresh-token";
    Map<String, String>? headers = {'Authorization': token, 'Accept': '*/*'};
    try {
      var response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        return jsonDecode(response.body)["token"];
      } else {
        // print(response.statusCode);
        return "Error Occured";
      }
    } catch (e) {
      return throw Exception(e);
    }
  }
}
