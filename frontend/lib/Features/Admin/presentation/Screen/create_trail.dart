import 'package:bloc/bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:logger/logger.dart';

class CreateTrail extends StatefulWidget {
  const CreateTrail({super.key});

  @override
  State<CreateTrail> createState() => _CreateTrailState();
}

class _CreateTrailState extends State<CreateTrail> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lengthController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _key = GlobalKey<FormState>();
  late Bloc authBloc;
  var log = Logger();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
        child: Column(children: [
          Form(
            key: _key,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  validator: (input) {
                    if (input == "") {
                      return "Enter Trail Name!";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    label: Text("Trial Name"),
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
                  keyboardType: TextInputType.number,
                  controller: _lengthController,
                  validator: (input) {
                    if (input == "") {
                      return "Please Provide Email!";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    label: Text("Length"),
                    hintText: "KM",
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
          const Gap(10),
          RichText(
            text: const TextSpan(
              style: TextStyle(fontSize: 18),
              children: [
                TextSpan(
                  text: "Already have an account? ",
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
          const Spacer()
        ]),
      ),
    );
  }
}
