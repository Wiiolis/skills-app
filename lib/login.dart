import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'components/my_textfield.dart';
import 'components/skill_card_list.dart';
import 'globals.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 50),
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomCenter,
                    colors: [
                  AppColors.primaryColor,
                  AppColors.backgroundColor,
                ])),
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
                        onPressed: () {},
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
      ),
    );
  }
}
