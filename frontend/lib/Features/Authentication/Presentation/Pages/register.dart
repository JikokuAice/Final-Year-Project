import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:frontend/Features/Authentication/Domain/Entities/Register.dart";
import "package:frontend/Features/Authentication/Presentation/Bloc/auth_bloc.dart";
import "package:frontend/Features/Authentication/Presentation/Pages/Login.dart";
import "package:gap/gap.dart";
import "package:logger/logger.dart";
import "package:toastification/toastification.dart";

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _key = GlobalKey<FormState>();
  late Bloc authBloc;
  var log = Logger();

  @override
  void initState() {
    super.initState();
    authBloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is RegistrationSucess) {
            Navigator.pushReplacementNamed(context, "login");
          } else if (state is RegistrationFailure) {
            toastification.show(
              context: context,
              type: ToastificationType.error,
              title: const Text('please register again!'),
              style: ToastificationStyle.minimal,
              autoCloseDuration: const Duration(seconds: 5),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(children: [
            const Center(
              child: Image(image: AssetImage("assets/Logo.png"), height: 150),
            ),
            Form(
              key: _key,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    validator: (input) {
                      if (input == "") {
                        return "Please Provide Your Name!";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
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
                  const Gap(20),
                  TextFormField(
                    controller: _emailController,
                    validator: (input) {
                      if (input == "") {
                        return "Please Provide Email!";
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
                  const Gap(20),
                  TextFormField(
                    controller: _passwordController,
                    validator: (input) {
                      if (input == "") {
                        return "Please Provide Password!";
                      }
                      return null;
                    },
                    obscureText: true,
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
            const Gap(10),
            TextButton(
              onPressed: () => {
                if (_key.currentState!.validate())
                  {
                    authBloc.add(
                      RegisterEvent(
                        register: Register(
                            name: _nameController.text,
                            email: _emailController.text,
                            password: _passwordController.text,
                            image: "empty pp"),
                      ),
                    )
                  }
              },
              style: ButtonStyle(
                backgroundColor: const WidgetStatePropertyAll(
                  Color.fromRGBO(5, 73, 48, 1),
                ),
                padding: const WidgetStatePropertyAll(
                  EdgeInsets.only(left: 60, right: 60, top: 12, bottom: 12),
                ),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
              child: const Text(
                "Register",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            const Gap(10),
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
      ),
    );
  }
}
