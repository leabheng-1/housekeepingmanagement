import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/model/Login_Page.dart';
import 'package:housekeepingmanagement/model/home_screen.dart';
import 'package:housekeepingmanagement/widget/testing_table.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  runApp(MyApp(initialToken: token));
}

class MyApp extends StatelessWidget {
  final String? initialToken;

  const MyApp({super.key, this.initialToken});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: initialToken != null ? const HomeScreen() : const LoginPage(),
    );
  }
}
