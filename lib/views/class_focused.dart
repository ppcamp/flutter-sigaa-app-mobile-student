import 'package:flutter/material.dart';

class ClassFocused extends StatelessWidget {
  static const id = "Screen_to_show_specific_class_info";

  const ClassFocused({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the second screen when tapped.
          },
          child: const Text('Launch screen'),
        ),
      ),
    );
  }
}