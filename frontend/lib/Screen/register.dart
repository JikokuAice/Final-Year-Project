import "package:flutter/cupertino.dart";
import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:frontend/Screen/Login.dart";

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(children: [
          const Center(
            child: Image(image: AssetImage("assets/Logo.png"), height: 150),
          ),
          const Spacer(),
          const TextField(
            decoration: InputDecoration(
              label: Text("Name"),
              hintText: "Full Name",
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 194, 194, 194),
                  width: 1,
                ),
              ),
            ),
          ),
          Spacer(),
          const TextField(
            decoration: InputDecoration(
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
          const Spacer(),
          const TextField(
            obscureText: true,
            decoration: InputDecoration(
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
          const Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () => {},
                icon: const Icon(
                  Icons.add_a_photo_outlined,
                  size: 42,
                ),
              ),
              const Text(
                "Upload Profile Image 📸📸😎",
                style: TextStyle(
                    color: Color.fromRGBO(
                      5,
                      73,
                      48,
                      1,
                    ),
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              )
            ],
          ),
          const Spacer(),
          TextButton(
            onPressed: () => {},
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
              "Register",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          const Spacer(),
          RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 18),
              children: [
                const TextSpan(
                  text: "Already have an account? ",
                  style: TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text: "Login",
                  style: const TextStyle(color: Color.fromRGBO(5, 73, 48, 1)),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage())),
                )
              ],
            ),
          ),
          const Spacer()
        ]),
      ),
    );
  }
}
