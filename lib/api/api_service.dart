import 'dart:convert';
import 'dart:developer';

import 'package:demo_app/api/model/current_user_model.dart';
import 'package:http/http.dart' as http;

import 'constants.dart';
import 'model/user_model.dart';

class ApiService {
  // GET CURRENT USER INFO
  Future<List<CurrentUser>> getCurrentUser() async {
    try {
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.currentUsersEndpoint);
      String basicAuth =
          'Basic OHBFVVppY2RXTW9ub0MzSnhPWmMrb1ZPYk1YcFErdVhUM1dtdlUwTjJYZk1wNFpLdnozL0dvYUlFQjdPem1hbDRVaUd2NVZPVUpWODMvU1RrOURKczRXMFdWRVE4Zndld01JM3BZODdDRHlYTUk1bzF1bC9lWVE9Og==';
      var response = await http.get(
        url,
        headers: <String, String>{'authorization': basicAuth},
      );

      if (response.statusCode == 200) {
        dynamic currentUser = response.body;
        List<CurrentUser> _model = [];
        _model.add(currentUserFromJson(currentUser));
        return _model;
      } else {
        log('Error getting current user: ${response.statusCode}');
      }
    } catch (e) {
      log('Error getting current user: $e');
    }

    return [];
  }

  // GET USER INFO
  Future<List<User>> getUser(currentUserId) async {
    try {
      ApiConstants.initializeUserEndpoint(currentUserId);
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.userEndpoint);
      String basicAuth =
          'Basic OHBFVVppY2RXTW9ub0MzSnhPWmMrb1ZPYk1YcFErdVhUM1dtdlUwTjJYZk1wNFpLdnozL0dvYUlFQjdPem1hbDRVaUd2NVZPVUpWODMvU1RrOURKczRXMFdWRVE4Zndld01JM3BZODdDRHlYTUk1bzF1bC9lWVE9Og==';
      var response = await http.get(
        url,
        headers: <String, String>{'authorization': basicAuth},
      );

      if (response.statusCode == 200) {
        dynamic user = response.body;
        List<User> _model = [];
        _model.add(userFromJson(user));
        return _model;
      } else {
        log('Error getting current user: ${response.statusCode}');
      }
    } catch (e) {
      log('Error getting current user: $e');
    }

    return [];
  }
}
