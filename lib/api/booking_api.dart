import 'dart:convert';

import 'package:http/http.dart' as http;

import '../utils/show_toast.dart';
import '../utils/token_checker.dart';

class BookingApi {
  final String _baseUrl = "https://api.stay2easy.com/booking/";

  static bookProperty(data, token) async {
    final String url = "https://api.stay2easy.com/booking/";
    var accessTokenCheck = await TokenChecker().isAccessTokenExpired();
    if (accessTokenCheck[0]) {
      showToast("Unexpected Error", "error");
      return;
    }

    if (accessTokenCheck.length > 1 && accessTokenCheck[0] != null) {
      token = accessTokenCheck[1];
    }

    try {
      Map<String, String> headers = {'Authorization': token, 'Accept': '*/*'};
      var response = await http.post(Uri.parse(url),
          body: json.decode(data), headers: headers);
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

  Future getBookedProperty(data, token) async {
    var url = '$_baseUrl';
    var accessTokenCheck = await TokenChecker().isAccessTokenExpired();
    if (accessTokenCheck[0]) {
      showToast("Unexpected Error", "error");
      return;
    }
    if (accessTokenCheck.length > 1 && accessTokenCheck[0] != null) {
      token = accessTokenCheck[1];
    }

    try {
      Map<String, String> headers = {'Authorization': token, 'Accept': '*/*'};
      final response = await http.get(Uri.parse(url), headers: headers);
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

  Future reBookedProperty(data, token, id) async {
    var _baseUrl = 'https://api.stay2easy.com/booking?';
    final queryParams = <String, dynamic>{};
    if (id != null) {
      queryParams['id'] = id.toString();
    }
    final queryString = Uri(queryParameters: queryParams).query;
    final url = '$_baseUrl?$queryString';
    var accessTokenCheck = await TokenChecker().isAccessTokenExpired();
    if (accessTokenCheck[0]) {
      showToast("Unexpected Error", "error");
      return;
    }
    if (accessTokenCheck.length > 1 && accessTokenCheck[0] != null) {
      token = accessTokenCheck[1];
    }
    try {
      Map<String, String> headers = {'Authorization': token, 'Accept': '*/*'};
      final response = await http.put(Uri.parse(url), headers: headers);
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

  Future confirmBookingPayment(data, token) async {
    var url = _baseUrl + 'confirm-payment';
    /* 
  {
    "sessionId": "string"
  }
     */
    var accessTokenCheck = await TokenChecker().isAccessTokenExpired();
    if (accessTokenCheck[0]) {
      showToast("Unexpected Error", "error");
      return;
    }
    if (accessTokenCheck.length > 1 && accessTokenCheck[0] != null) {
      token = accessTokenCheck[1];
    }
    try {
      Map<String, String> headers = {'Authorization': token, 'Accept': '*/*'};
      var response = await http.post(Uri.parse(url),
          body: json.decode(data), headers: headers);
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
}
