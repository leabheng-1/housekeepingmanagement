import 'package:flutter/material.dart';

class LoginButton extends StatefulWidget {
  const LoginButton({super.key});

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(25),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                      color: const Color.fromARGB(255, 58, 33, 243), width: 3),
                ),
                child: const CircleAvatar(
                  radius: 135,
                  child: CircleAvatar(
                    radius: 130,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 115,
                      backgroundImage: AssetImage("assets/images/logo.jpg"),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              const Text(
                "Login below to get started",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 400,
                child: Column(
                  children: [
                    TextField(
                      controller: username,
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
                    const SizedBox(height: 30),
                    TextField(
                      controller: password,
                      decoration: InputDecoration(
                        labelText: "Password",
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
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 40,
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 58, 33, 243),
                          shape: const StadiumBorder(),
                        ),
                        child: const Text('Login'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
