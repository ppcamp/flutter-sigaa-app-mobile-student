import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:sigaa_student/views/class_focused.dart';
import 'package:sigaa_student/views/dashboard.dart';
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
