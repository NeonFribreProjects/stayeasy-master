import 'dart:convert';

import 'package:http/http.dart' as http;

import '../utils/show_toast.dart';
import '../utils/token_checker.dart';

class RegistrationApi {
  final String _baseUrl = "https://api.stay2easy.com/user";

  Future signUp(data, apiUrl) async {
    var url = '$_baseUrl$apiUrl';
    try {
      var response = await http.post(Uri.parse(url), body: json.decode(data));
      if (response.statusCode == 200) {
        return [jsonDecode(response.body), response.statusCode];
      } else {
        print(response.statusCode);
        return [jsonDecode(response.body), response.statusCode];
      }
    } catch (e) {
      return [
        {"message": "Unexpected Error"},
        400
      ];
      // return throw Exception(e);
    }
  }

  Future logIn(data, apiUrl) async {
    var url = '$_baseUrl$apiUrl';
    try {
      var response = await http.post(Uri.parse(url), body: json.decode(data));

      if (response.statusCode == 200) {
        return [jsonDecode(response.body), response.statusCode];
      } else {
        print(response.statusCode);
        return [jsonDecode(response.body), response.statusCode];
      }
    } catch (e) {
      return [
        {"message": "Unexpected Error"},
        400
      ];
      // return throw Exception(e);
    }
  }

  updateProfile(data, token) async {
    // print("response");
    var url = '$_baseUrl/';
    var accessTokenCheck = await TokenChecker().isAccessTokenExpired();
    if (accessTokenCheck[0]) {
      showToast("Unexpected Error", "error");
      return;
    }
    if (accessTokenCheck.length > 1 && accessTokenCheck[0] != null) {
      token = accessTokenCheck[1];
    }
    Map<String, String> headers = {'Authorization': token, 'Accept': '*/*'};

    try {
      var response = await http.patch(Uri.parse(url),
          body: json.decode(data), headers: headers);

      if (response.statusCode == 200) {
        return [jsonDecode(response.body), response.statusCode];
      } else {
        // print(response.statusCode);
        print(jsonDecode(response.body));
        return [jsonDecode(response.body), response.statusCode];
      }
    } catch (e) {
      return [
        {"message": "Unexpected Error"},
        400
      ];
      // return throw Exception(e);
    }
  }
}
