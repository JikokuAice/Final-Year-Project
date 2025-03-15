import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:flutter/material.dart';
import 'package:frontend/Features/Admin/Domain/entity/trail.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

class CreateTrail extends StatefulWidget {
  const CreateTrail({super.key});

  @override
  State<CreateTrail> createState() => _CreateTrailState();
}

class _CreateTrailState extends State<CreateTrail> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lengthController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  final List<String> _images = [];

  final List<String> trailTypes = [
    "Circular Trial",
    "Point-to-Point Trail",
    "Out-and-Back Trail",
    "Lollipop Trail",
    "Figure-Eight Trail"
  ];
  String? selectedTrail;

  final List<String> trailDifficulty = ["Beginner", "Low", "Moderate", "High"];

  String? selectedDifficulty;
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
                  controller: _locationController,
                  validator: (input) {
                    if (input == "") {
                      return "Enter Trail Location!";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    label: Text("Trial Location"),
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
                    if (input == "" || input == '0') {
                      return "Please Enter Length ";
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
                DropdownButtonFormField2(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  hint: const Text(
                    'Select Trail Type',
                    style: TextStyle(fontSize: 14),
                  ),
                  items: trailTypes
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ))
                      .toList(),
                  onChanged: (v) => {
                    selectedTrail = v.toString(),
                  },
                  buttonStyleData: const ButtonStyleData(
                    padding: EdgeInsets.only(right: 8),
                  ),
                  iconStyleData: const IconStyleData(
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black45,
                    ),
                    iconSize: 24,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
                //
                const Gap(20),
                //
                DropdownButtonFormField2(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  hint: const Text(
                    'Select Trail Difficulty',
                    style: TextStyle(fontSize: 14),
                  ),
                  items: trailDifficulty
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ))
                      .toList(),
                  onChanged: (v) => {
                    selectedDifficulty = v.toString(),
                  },
                  buttonStyleData: const ButtonStyleData(
                    padding: EdgeInsets.only(right: 8),
                  ),
                  iconStyleData: const IconStyleData(
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black45,
                    ),
                    iconSize: 24,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
                const Gap(20),
                SizedBox(
                  height: 100,
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    controller: _descriptionController,
                    validator: (input) {
                      if (input == "") {
                        return "Provide Trail Description!";
                      }
                      return null;
                    },
                    minLines: null,
                    maxLines: null,
                    expands: true,
                    decoration: const InputDecoration(
                      label: Text("Description"),
                      hintText: "Enter Trail Description",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 194, 194, 194),
                          width: 1,
                        ),
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
                onPressed: () => {pickImage()},
                padding: EdgeInsets.zero,
                icon: const Icon(
                  Icons.add_a_photo_outlined,
                  size: 50,
                ),
              ),
              const Text(
                "Upload Images 📸🏕️",
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
              if (selectedDifficulty == "" || selectedDifficulty == null)
                {
                  toastification.show(
                    context: context,
                    type: ToastificationType.error,
                    title: const Text('Please select trail difficulty'),
                    style: ToastificationStyle.minimal,
                    autoCloseDuration: const Duration(seconds: 6),
                  )
                }
              else if (selectedTrail == "")
                {
                  toastification.show(
                    context: context,
                    type: ToastificationType.error,
                    title: const Text('Please select trail difficulty'),
                    style: ToastificationStyle.minimal,
                    autoCloseDuration: const Duration(seconds: 6),
                  )
                }
              else if (_images.isEmpty)
                {
                  toastification.show(
                    context: context,
                    type: ToastificationType.error,
                    title: const Text('please select images using camera icon'),
                    style: ToastificationStyle.minimal,
                    autoCloseDuration: const Duration(seconds: 6),
                  )
                }
              else
                {
                  if (_key.currentState!.validate())
                    {
                      sharedPrefTrailStorage(
                        Trail(
                            name: _nameController.text,
                            images: _images,
                            description: _descriptionController.text,
                            trailType: selectedTrail!,
                            location: _locationController.text,
                            length:
                                double.tryParse(_lengthController.text) ?? 0,
                            elevation: 0,
                            difficulty: selectedDifficulty!),
                      ),
                      Navigator.pushNamed(context, "add_map"),
                    }
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
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
            ),
            child: const Text(
              "Proceed",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          const Gap(10),
          const Spacer()
        ]),
      ),
    );
  }

  Future<void> sharedPrefTrailStorage(Trail model) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("trail_json", jsonEncode(model));
  }

  // Future<void> getPrefTrailModel() async {
  //   final SharedPreferences pref = await SharedPreferences.getInstance();
  //   var data = pref.getString("trail_json");
  //   var dataDecoded = jsonDecode(data!);
  //   print(dataDecoded);
  // }

  Future<void> pickImage() async {
    final List<XFile> images = await picker.pickMultiImage();
    if (images.isEmpty) {
      return;
    }
    setState(() {
      _images.addAll(images.map((e) => e.path));
    });
  }
}
