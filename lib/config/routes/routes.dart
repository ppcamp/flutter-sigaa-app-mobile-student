import 'package:flutter/material.dart';
import 'package:sigaa_student/views/ClassFocused/class_focused.dart';
import 'package:sigaa_student/views/Dashboard/dashboard.screen.dart';

Map<String, Widget Function(BuildContext)> getRoutes() => {
      DashboardScreen.id: (context) => DashboardScreen(),
      ClassFocused.id: (context) => ClassFocused()
    };