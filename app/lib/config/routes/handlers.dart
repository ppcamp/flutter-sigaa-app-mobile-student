import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:sigaa_student/views/Calendar.dart';
import 'package:sigaa_student/views/ClassFocused.dart';
import 'package:sigaa_student/views/Dashboard.dart';
import 'package:sigaa_student/views/Grid.dart';
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
