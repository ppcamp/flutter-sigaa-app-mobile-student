import 'package:flutter/material.dart';
import 'package:sigaa_student/config/routes/router.dart';
import 'package:sigaa_student/config/routes/routes.dart';

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
          child: const Text('Home screen'),
          onPressed: ()=> AppRouter.router.navigateTo(
            context,
            AppRoutes.rootRoute.route,
            replace: true,
          )
        ),
      ),
    );
  }
}