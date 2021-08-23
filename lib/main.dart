import 'package:flutter/material.dart';
import 'package:sigaa_student/components/StudentClass/class.screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SIGAA student',
      home: ClassScreen(),
    );
  }
}
