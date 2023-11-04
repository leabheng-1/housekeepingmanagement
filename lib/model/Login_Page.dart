import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/model/home_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _showPassword = false;
  String _apiResponse = '';

  Future<void> _loginUser() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    final url = Uri.parse('http://localhost:8000/api/login');
    final response = await http.post(url, body: {
      'name': username,
      'password': password,
    });

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      setState(() {
        _apiResponse = responseData['message'];
      });
      final token = responseData['data']['token']['name'];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('name', username);
      prefs.setString('token', token);
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } else {
      setState(() {
        _apiResponse = 'Login failed';
      });
      // ignore: use_build_context_synchronously
      AwesomeDialog(
        width: 500,
        context: context,
        // ignore: deprecated_member_use
        dialogType: DialogType.ERROR,
        title: 'Login Failed',
        desc: 'Incorrect username or password.',
        btnOkOnPress: () {},
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
  flex: 3,
  child: Align(
    alignment: Alignment.bottomLeft,
    child: Container(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/backgroundlogin.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          margin: EdgeInsets.only(left: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'WELCOME',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'UNIQUE PALM ANGKOR VILLA',
                style: TextStyle(
                  color: Color.fromARGB(243, 208, 208, 208),
                  fontSize: 30,
                ),
              ),
              Text(
                'SORPHOUN VILLA THE PASSED',
                style: TextStyle(
                  color: Color.fromARGB(243, 208, 208, 208),
                  fontSize: 25,
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Copy Right',
                  style: TextStyle(
                    color: Color.fromARGB(243, 208, 208, 208),
                    fontSize: 16,
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

          SizedBox(
            width: 180,
          ),
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                            color: const Color.fromARGB(255, 58, 33, 243),
                            width: 3),
                      ),
                      child: const CircleAvatar(
                        child: CircleAvatar(
                          radius: 130,
                          backgroundColor: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: CircleAvatar(
                              radius: 115,
                              backgroundImage:
                                  AssetImage("assets/images/logo.jpg"),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Text(
                      'Login to get started',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[500],
                      ),
                    ),
                    const SizedBox(height: 25),
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: "Username",
                        prefixIconConstraints:
                            const BoxConstraints(minWidth: 20),
                        prefixIcon: Container(
                          width: 40,
                          height: 40,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: const Color.fromARGB(255, 58, 33, 243),
                                width: 2),
                          ),
                          child: const Icon(
                            Icons.person,
                            size: 30,
                            color: Color.fromARGB(255, 58, 33, 243),
                          ),
                        ),
                        border: myinputborder(),
                        enabledBorder: myinputborder(),
                        focusedBorder: myfocusborder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIconConstraints:
                            const BoxConstraints(minWidth: 20),
                        prefixIcon: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: const Color.fromARGB(255, 58, 33, 243),
                                width: 2),
                          ),
                          padding: const EdgeInsets.all(4),
                          child: const Icon(
                            Icons.key,
                            size: 30,
                            color: Color.fromARGB(255, 58, 33, 243),
                          ),
                        ),
                        border: myinputborder(),
                        enabledBorder: myinputborder(),
                        focusedBorder: myfocusborder(),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _showPassword = !_showPassword;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 25),
                            child: Icon(
                              _showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: const Color.fromARGB(255, 58, 33, 243),
                              size: 25,
                            ),
                          ),
                        ),
                      ),
                      obscureText: !_showPassword,
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                            checkColor: Colors.white,
                            fillColor:
                                MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.error)) {
                                return Colors.red;
                              }
                              return Colors.green;
                            }),
                            value: _rememberMe,
                            shape: const CircleBorder(),
                            onChanged: (bool? value) {
                              setState(() {
                                _rememberMe = value!;
                              });
                            },
                          ),
                          const Text('Remember me'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: 250,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _loginUser,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 58, 33, 243),
                          shape: const StadiumBorder(),
                        ),
                        child: const Text('Login'),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _apiResponse,
                      style: const TextStyle(fontSize: 16, color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  OutlineInputBorder myinputborder() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(70),
      ),
      borderSide: BorderSide(
        color: Color.fromARGB(255, 58, 33, 243),
        width: 3,
      ),
    );
  }

  OutlineInputBorder myfocusborder() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(70),
      ),
      borderSide: BorderSide(
        color: Color.fromARGB(255, 58, 33, 243),
        width: 3,
      ),
    );
  }
}
