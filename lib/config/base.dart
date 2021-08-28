
import 'package:flutter/material.dart';
import 'package:sigaa_student/views/Dashboard/dashboard.screen.dart';

MaterialApp buildApp ({
  required String appName,
  required ThemeData theme,
  required Map<String, Widget Function(BuildContext)> routes,
  }) {
  return MaterialApp(
    title: appName,
    theme: theme,
    routes: routes,
    home: DashboardScreen(),
  );
}