import 'package:flutter/material.dart';

class AddMap extends StatefulWidget {
  const AddMap({super.key});

  @override
  State<AddMap> createState() => _AddMapState();
}

class _AddMapState extends State<AddMap> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Add Map"),
      ),
    );
    ;
  }
}
