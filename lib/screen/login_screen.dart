import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/screen/login_screen/login_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                height: double.infinity,
                child: Image.asset(
                  "assets/images/image_back.png",
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                height: double.infinity,
                child: const LoginButton(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
