import 'dart:convert';
import 'package:http/http.dart' as http;

import '../utils/show_toast.dart';
import '../utils/token_checker.dart';

class PropertyApi {
  final String _baseUrl =
      "https://api.stay2easy.com/user/search?skip=0&limit=30&";

  Future getAllProperty(apiUrl, token) async {
    var url = '{$_baseUrl}propertyType={$apiUrl}';

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
      var response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        return [jsonDecode(response.body), response.statusCode];
      } else {
        return [jsonDecode(response.body), response.statusCode];
      }
    } catch (e) {
      return throw Exception(e);
    }
  }

  Future getAllBookMarks(token) async {
    var url = 'https://api.stay2easy.com/user/property/bookmark';
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
      var response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        return [jsonDecode(response.body), response.statusCode];
      } else {
        return [jsonDecode(response.body), response.statusCode];
      }
    } catch (e) {
      return throw Exception(e);
    }
  }

  Future deleteBookMark(bookMarkId, token) async {
    var url =
        'https://api.stay2easy.com/user/property/bookmark/${json.decode(bookMarkId)}';
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
      var response = await http.delete(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        return [jsonDecode(response.body), response.statusCode];
      } else {
        return [jsonDecode(response.body), response.statusCode];
      }
    } catch (e) {
      return throw Exception(e);
    }
  }

  Future bookMarkProperty(propertyId, propertyType, token) async {
    var url =
        'https://api.stay2easy.com/user/property/${propertyId}/bookmark?propertyType=${propertyType}';
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
      var response = await http.patch(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        return [jsonDecode(response.body), response.statusCode];
      } else {
        return [jsonDecode(response.body), response.statusCode];
      }
    } catch (e) {
      return throw Exception(e);
    }
  }

  Future getSearchedProperty({
    destination,
    startDate,
    endDate,
    rooms,
    guests,
    children,
    minPrice,
    maxPrice,
    bedPreference,
    propertyType,
    token,
  }) async {
    final String _baseUrl = "https://api.stay2easy.com/user/search";
    final queryParams = <String, dynamic>{};

    queryParams['skip'] = "0";

    queryParams['limit'] = "30";
    if (propertyType != null) {
      queryParams['propertyType'] = propertyType.toString();
    }
    if (bedPreference != null) {
      queryParams['bedPreference'] = bedPreference.toString();
    }
    if (destination != null) {
      queryParams['destination'] = destination.toString();
    }
    if (startDate != null) {
      queryParams['startDate'] = startDate.toString();
    }
    if (endDate != null) {
      queryParams['endDate'] = endDate.toString();
    }
    if (rooms != null) {
      queryParams['rooms'] = rooms.toString();
    }
    if (guests != null) {
      queryParams['guests'] = guests.toString();
    }
    if (children != null) {
      queryParams['children'] = children.toString();
    }
    if (minPrice != null) {
      queryParams['minPrice'] = minPrice.toString();
    }
    if (maxPrice != null) {
      queryParams['maxPrice'] = maxPrice.toString();
    }

    final queryString = Uri(queryParameters: queryParams).query;
    final url = '$_baseUrl?$queryString';
    // print(url);

    var accessTokenCheck = await TokenChecker().isAccessTokenExpired();
    if (accessTokenCheck[0]) {
      showToast("Unexpected Error", "error");
      return;
    }
    if (accessTokenCheck.length > 1 && accessTokenCheck[0] != null) {
      token = accessTokenCheck[1];
    }
    Map<String, String> headers = {'Authorization': token, 'Accept': '*/*'};

    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      return [jsonDecode(response.body), response.statusCode];
    } else {
      return [jsonDecode(response.body), response.statusCode];
    }
  }

  Future getStayProperty(
      apiUrl, token, destination, rooms, childrens, adults) async {
    var url =
        '{$_baseUrl}destination={$destination}&rooms={$rooms}&childrens={$childrens}&adults={$adults}';

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
      var response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        return [jsonDecode(response.body), response.statusCode];
      } else {
        print(response.statusCode);
        return [jsonDecode(response.body), response.statusCode];
      }
    } catch (e) {
      return throw Exception(e);
    }
  }
}
