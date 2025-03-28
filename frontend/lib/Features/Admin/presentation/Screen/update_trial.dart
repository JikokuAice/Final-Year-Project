import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/Features/Admin/Domain/entity/trail.dart';
import 'package:frontend/Features/Admin/Domain/entity/update_trail_with_map_entity.dart';
import 'package:frontend/Features/Admin/presentation/Bloc/admin_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

class UpdateTrial extends StatefulWidget {
  const UpdateTrial({super.key, required this.id});
  final int id;
  @override
  State<UpdateTrial> createState() => _UpdateTrialState();
}

class _UpdateTrialState extends State<UpdateTrial> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  List<String?> _images = [];
  int? id;

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
  void initState() {
    _nameController.text = widget.id.toString();
    authBloc = BlocProvider.of<AdminBloc>(context);
    insertValueInFields(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminBloc, AdminState>(
      builder: (context, state) {
        if (state is GetSepecificTrailFailure) {
          return Scaffold(
            body: Column(
              children: [
                const Text("Error"),
                ElevatedButton(onPressed: () {}, child: const Text("GO Back"))
              ],
            ),
          );
        }

        if (state is GetSepecificTrailSuccess) {
          var enitty = state.entity;
          id = widget.id;
          _nameController.text = enitty?.name ?? "name?";
          _locationController.text = enitty?.location ?? " ";
          _descriptionController.text = enitty?.description ?? "";
          _images = enitty?.images ?? <String>[];
          selectedDifficulty = enitty?.difficulty ?? "";
          selectedTrail = enitty?.trailType ?? "";
          return Scaffold(
            appBar: AppBar(
              title: const Text("Update Trial"),
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
                      DropdownButtonFormField2(
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 16),
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

                      DropdownButtonFormField2(
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 16),
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
                        onChanged: (v) => setState(() {
                          selectedDifficulty = v.toString();
                        }),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () => {
                        authBloc.add(
                          UpdateTrailWithMapEvent(
                            entity: UpdateTrailWithMapEntity(
                                id: id,
                                name: _nameController.text,
                                images: List<String>.from(_images),
                                description: _descriptionController.text,
                                trailType: selectedTrail,
                                rating: enitty?.rating ?? 0,
                                diffculty: selectedDifficulty,
                                location: _locationController.text,
                                mapId: enitty?.mapId,
                                mapName: enitty?.mapName,
                                mapDestinationLatlang:
                                    enitty?.destinationLatlang,
                                mapStartLatLang: enitty?.startLatlang,
                                mapAltitude: enitty?.altitude,
                                mapDistance: enitty?.distance,
                                mapAverageTime: enitty?.averageTime,
                                mapPolypoints: enitty?.polypoints),
                          ),
                        ),
                        toastification.show(
                          context: context,
                          type: ToastificationType.error,
                          title: const Text('Update Sucessfull'),
                          style: ToastificationStyle.minimal,
                          autoCloseDuration: const Duration(seconds: 5),
                        ),
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          "",
                          (Route<dynamic> route) => false,
                        )
                      },
                      style: ButtonStyle(
                        backgroundColor: const WidgetStatePropertyAll(
                          Color.fromRGBO(5, 73, 48, 1),
                        ),
                        padding: const WidgetStatePropertyAll(
                          EdgeInsets.only(
                              left: 30, right: 30, top: 12, bottom: 12),
                        ),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                      ),
                      child: const Text(
                        "Confirm",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: const WidgetStatePropertyAll(
                          Color.fromRGBO(209, 68, 101, 1),
                        ),
                        padding: const WidgetStatePropertyAll(
                          EdgeInsets.only(
                              left: 30, right: 30, top: 12, bottom: 12),
                        ),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                      ),
                      child: const Text(
                        "Update Map",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    )
                  ],
                ),
                const Gap(10),
                const Spacer()
              ]),
            ),
          );
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
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
      _images.addAll(images.map((e) => e.path).toList());
    });
  }

  void insertValueInFields(int id) {
    setState(() {
      _nameController.clear();
      _locationController.clear();
      _descriptionController.clear();
      selectedDifficulty = " ";
      selectedTrail = "";
      authBloc.add(GetSepecificTrailEvent(id: id));
    });
  }
}
