import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Screen/register.dart';
import 'package:gap/gap.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 0, left: 20, right: 20),
        child: Column(children: [
          const Center(
            child: Image(image: AssetImage("assets/Logo.png"), height: 250),
          ),
          const Text(
            "Login To Explore 🥾🍃",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (input) {
                    if (input == null) {
                      return "Please Enter Email";
                    } else if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(input)) {
                      return "Enter Valid Email";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    label: Text("Email"),
                    hintText: "aice**@gmail.com",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 194, 194, 194),
                        width: 1,
                      ),
                    ),
                  ),
                ),
                const Gap(10),
                TextFormField(
                  obscureText: true,
                  validator: (input) {
                    if (input == null) {
                      return "Please Enter Password";
                    } else if (input.length < 8) {
                      return "Password must be at least 8 characters";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    label: Text("Password"),
                    hintText: "**********",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 194, 194, 194),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          TextButton(
            onPressed: () => {_formKey.currentState!.validate()},
            style: ButtonStyle(
              backgroundColor: const WidgetStatePropertyAll(
                Color.fromRGBO(5, 73, 48, 1),
              ),
              padding: const WidgetStatePropertyAll(
                EdgeInsets.only(left: 60, right: 60, top: 12, bottom: 12),
              ),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
            ),
            child: const Text(
              "Login",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          const Gap(20),
          RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 18),
              children: [
                const TextSpan(
                  text: "Create Account? ",
                  style: TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text: "Register",
                  style: const TextStyle(color: Color.fromRGBO(5, 73, 48, 1)),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegistrationPage())),
                )
              ],
            ),
          ),
          Spacer()
        ]),
      ),
    );
  }
}
