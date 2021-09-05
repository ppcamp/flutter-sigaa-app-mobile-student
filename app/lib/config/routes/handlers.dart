import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:sigaa_student/views/about.dart';
import 'package:sigaa_student/views/calendar.dart';
import 'package:sigaa_student/views/class_focused.dart';
import 'package:sigaa_student/views/dashboard.dart';
import 'package:sigaa_student/views/grid.dart';
import 'package:sigaa_student/views/login.dart';
import 'package:sigaa_student/views/not_found.dart';

final handleNotFound = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  debugPrint("Route not found.");
  return RouteNotFoundPage();
});

final handleDashboard = Handler(
  handlerFunc: (context, parameters) => DashboardScreen(),
);

final handleSubjectFocused = Handler(
  handlerFunc: (context, parameters) => ClassFocused(),
);

final handleSubjectCalendar = Handler(
  handlerFunc: (context, parameters) => Calendar(),
);

final handleGrid = Handler(
  handlerFunc: (context, parameters) => Grid(),
);

final handleLoginScreen = Handler(
  handlerFunc: (context, parameters) => LoginScreen(),
);

final handleAboutScreen = Handler(
  handlerFunc: (context, parameters) => AboutScreen(),
);
