import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'api/api_service.dart';
import 'dashboard.dart';
import 'components/my_textfield.dart';
import 'package:url_launcher/url_launcher.dart';

import 'globals.dart';

class Login extends StatefulWidget {
  final String apiBaseUrl;

  const Login({Key? key, required this.apiBaseUrl}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkLoggedIn();
  }

  Future<void> _validateLogin() async {
    final prefs = await SharedPreferences.getInstance();

    var body = jsonEncode({
      "email": usernameController.text,
      "password": passwordController.text,
    });

    await ApiService().login(body).then((value) => {
          if (prefs.getString('token') != null) {context.go("/")}
        });
  }

  Future<String?> _getUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    final userToken = prefs.getString('token');
    return userToken;
  }

  void _checkLoggedIn() async {
    var userToken = await _getUserToken();

    if (userToken != null) {
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Image(
                  image: const AssetImage('assets/images/loginBg.png'),
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover),
              SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 50),
                  child: Center(
                    child: SizedBox(
                      width: 300,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hello.',
                                style: TextStyle(
                                    fontSize: 46,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                'Welcome to EDU',
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                              Text(
                                'Clinical Skill App',
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: 80,
                              )
                            ],
                          ),
                          const Text(
                              'To begin mastering your critical skills, login with your platform credentials below.',
                              textAlign: TextAlign.center),
                          const SizedBox(
                            height: 20,
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                MyTextField(
                                  controller: usernameController,
                                  hintText: 'Enter your EDU e-mail adress',
                                  obscureText: false,
                                  label: 'E-mail',
                                ),
                                MyTextField(
                                  controller: passwordController,
                                  hintText: 'Enter your EDU password',
                                  obscureText: true,
                                  label: 'Password',
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState?.validate() ??
                                          false) {
                                        _validateLogin();
                                      }
                                    },
                                    style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                        AppColors.primaryColor,
                                      ),
                                    ),
                                    child: const Text(
                                      'LOGIN',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: TextButton(
                              onPressed: () async {
                                var url = Uri.parse(
                                    'https://study.edu.edu.mt/#/password-reset');
                                if (await canLaunchUrl(url)) {
                                  launchUrl(url);
                                }
                              },
                              child: const Text(
                                'Forgot your password?',
                                style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 12,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
