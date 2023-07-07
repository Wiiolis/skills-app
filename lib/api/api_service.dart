import 'dart:convert';
import 'dart:developer';

import 'package:demo_app/api/model/current_user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';
import 'model/login_model.dart';
import 'model/user_model.dart';

class ApiService {
  // SAVE TOKEN
  Future saveToken(String token) async {
    String ba = "Basic ${base64.encode(utf8.encode('$token:'))}";
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', ba);
  }

  Future saveCurrentUserId(int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('currentUserId', id);
  }

  // LOGIN
  Future<void> login(body) async {
    String url = "https://gamma.staging.candena.de/api/v1/sessions";

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      if (response.statusCode == 201) {
        var basicAuth = response.headers['x-new-auth-token']!;
        await saveToken(basicAuth);

        final responseData = jsonDecode(response.body);
        final loginData = Login.fromJson(responseData);
        saveCurrentUserId(loginData.userId);
      }
    } catch (e) {
      log('Error getting current user: $e');
    }
  }

  // GET CURRENT USER INFO
  Future<CurrentUser?> getCurrentUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final currentUserId = prefs.getInt('currentUserId');

      if (token != null) {
        ApiConstants.initializeUserEndpoint(currentUserId!);
        var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.userEndpoint);
        var response = await http.get(
          url,
          headers: <String, String>{'authorization': token},
        );

        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          final currentUser = CurrentUser.fromJson(responseData);

          return currentUser;
        } else if (response.statusCode == 401) {
          // Unauthorized access, handle as needed
          log('Unauthorized access');
        }
      }
    } catch (e) {
      log('Error getting current user: $e');
    }

    return null;
  }

  // GET USER INFO
  Future<User?> getUser(currentUserId) async {
    try {
      ApiConstants.initializeUserEndpoint(currentUserId);
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.userEndpoint);
      var response = await http.get(url);

      if (response.statusCode == 200) {
        dynamic user = jsonDecode(response.body);
        return userFromJson(user);
      } else {
        log('Error getting user info: ${response.statusCode}');
      }
    } catch (e) {
      log('Error getting user info: $e');
    }

    return null;
  }
}
