import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/Features/Authentication/Domain/Entities/login.dart';
import 'package:frontend/Features/Authentication/Presentation/Bloc/auth_bloc.dart';
import 'package:frontend/Features/Authentication/Presentation/Pages/register.dart';
import 'package:gap/gap.dart';
import 'package:logger/logger.dart';
import 'package:toastification/toastification.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late Bloc authBloc;
  var log = Logger();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
          if (state is LoginSucess) {
            Navigator.pushReplacementNamed(context, "");
          } else if (state is LoginFailure) {
            toastification.show(
              context: context,
              type: ToastificationType.error,
              title: const Text('OOPS! Login Again Using Correct Credential.'),
              style: ToastificationStyle.minimal,
              autoCloseDuration: const Duration(seconds: 5),
            );
          }
        },
        child: Padding(
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
                    controller: _emailController,
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
                    controller: _passwordController,
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
            const Spacer(),
            TextButton(
              onPressed: () => {
                if (_formKey.currentState!.validate())
                  {
                    authBloc.add(
                      LoginEvent(
                        login: Login(
                            email: _emailController.text,
                            password: _passwordController.text),
                      ),
                    )
                  }
                else
                  {log.e("okay dham")}
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
            const Spacer()
          ]),
        ),
      ),
    );
  }
}
