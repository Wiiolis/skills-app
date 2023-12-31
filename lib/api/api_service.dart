import 'dart:convert';
import 'dart:developer';

import 'package:demo_app/api/model/instructors.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';
import 'model/clinical_skills.dart';
import 'model/instructor.dart';
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
      } else {
        throw response.statusCode; // Throw your specific error code
      }
    } catch (e) {
      log('Error logging in: $e');
      throw 401; // Throw your specific error code
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
        } else {
          log('error');
        }
      }
    } catch (e) {
      log('Error getting user info: $e');
    }

    return null;
  }

  Future<List<ClinicalSkills>> getClinicalSkills(moduleVersionId) async {
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
          final List<ClinicalSkills> clinicalSkills =
              []; // Specify the correct type

          for (var element in responseData) {
            clinicalSkills.add(ClinicalSkills.fromJson(element));
          }

          return clinicalSkills; // Return a List<ClinicalSkills>
        } else if (response.statusCode == 401) {
          log('Unauthorized access');
        }
      }
    } catch (e) {
      log('Error getting clinical skills: $e');
    }

    return []; // Return an empty List<ClinicalSkills>
  }

  Future<List<Modules>> getModules() async {
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
          final List<Modules> modules =
              []; // Specify the return type explicitly

          for (var element in responseData) {
            modules.add(Modules.fromJson(element));
          }

          return modules; // Return a List<Modules>
        } else if (response.statusCode == 401) {
          log('Unauthorized access');
        }
      }
    } catch (e) {
      log('Error getting modules: $e');
    }
    return <Modules>[]; // Return an empty List<Modules>
  }

  Future<List<Instructors>> getInstructors() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null) {
      try {
        final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.instructors);
        final response = await http.get(
          url,
          headers: <String, String>{'authorization': token},
        );

        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body) as List<dynamic>;
          final instructors = responseData
              .map((element) => Instructors.fromJson(element))
              .toList();
          return instructors;
        } else if (response.statusCode == 401) {
          log('Unauthorized access');
        }
      } catch (e) {
        log('Error getting instructors: $e');
        throw Exception('Failed to fetch instructors');
      }
    }

    // If any error occurred or token is null, return an empty list.
    return [];
  }

  // save clinical skills
  Future<void> saveClinicalSkill(moduleVersionId, skillId, body) async {
    ApiConstants.initializeClinicalSkill(moduleVersionId, skillId);
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.clinicalSkill);

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token != null) {
        final response = await http.post(
          url,
          headers: <String, String>{'authorization': token},
          body: body,
        );

        if (response.statusCode != 200) {
          throw Exception('Unauthorized access');
        }
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<dynamic> getClinicalSkill(moduleVersionId, skillId) async {
    ApiConstants.initializeClinicalSkill(moduleVersionId, skillId);
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.clinicalSkill);

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token != null) {
        final response = await http
            .get(url, headers: <String, String>{'authorization': token});

        if (response.statusCode != 200) {
          log('Unauthorized access');
        }
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  Future<dynamic> saveInstructor(body) async {
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.instructors);

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token != null) {
        final response = await http.post(
          url,
          headers: <String, String>{'authorization': token},
          body: body,
        );

        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          final instructor = Instructor.fromJson(responseData);

          return instructor.instructorId;
        }

        return null;
      }
    } catch (e) {
      log('Error: $e');
    }
  }
}
