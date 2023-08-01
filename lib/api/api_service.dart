import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';
import 'model/clinical_skills.dart';
import 'model/login_model.dart';
import 'model/modules.dart';
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

  // GET USER INFO
  Future<User?> getUser(userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token != null) {
        ApiConstants.initializeUserEndpoint(userId);
        var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.userEndpoint);
        var response = await http.get(
          url,
          headers: <String, String>{'authorization': token},
        );

        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          final user = User.fromJson(responseData);
          return user;
        } else if (response.statusCode == 401) {
          // Unauthorized access, handle as needed
          log('Unauthorized access');
        }
      }
    } catch (e) {
      log('Error getting user info: $e');
    }

    return null;
  }

  Future<List?> getClinicalSkills(moduleVersionId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      if (token != null) {
        ApiConstants.initializeClinicalSkills(moduleVersionId);
        var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.clinicalSkills);
        var response = await http.get(
          url,
          headers: <String, String>{'authorization': token},
        );

        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          final clinicalSkills = [];

          for (var element in responseData) {
            clinicalSkills.add(ClinicalSkills.fromJson(element));
          }

          return clinicalSkills;
        } else if (response.statusCode == 401) {
          // Unauthorized access, handle as needed
          log('Unauthorized access');
        }
      }
    } catch (e) {
      log('Error getting user info: $e');
    }

    return null;
  }

  Future<List?> getModules() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token != null) {
        var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.modules);
        var response = await http.get(
          url,
          headers: <String, String>{'authorization': token},
        );
        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          final modules = [];

          for (var element in responseData) {
            modules.add(Modules.fromJson(element));
          }

          return modules;
        } else if (response.statusCode == 401) {
          // Unauthorized access, handle as needed
          log('Unauthorized access');
        }
      }
    } catch (e) {
      log('Error getting user info: $e');
    }
    return null;
  }
}
