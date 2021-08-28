import 'package:flutter/material.dart';
import 'package:sigaa_student/views/class_focused.dart';
import 'package:sigaa_student/views/dashboard.dart';

Map<String, Widget Function(BuildContext)> getRoutes() => {
      DashboardScreen.id: (context) => DashboardScreen(),
      ClassFocused.id: (context) => ClassFocused()
    };