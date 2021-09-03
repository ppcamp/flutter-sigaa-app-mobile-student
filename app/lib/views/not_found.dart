import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sigaa_student/config/routes/router.dart';
import 'package:sigaa_student/config/routes/routes.dart';

class RouteNotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Route not found"),
            TextButton(
              onPressed: () => AppRouter.router
                  .navigateTo(context, AppRoutes.rootRoute.route),
              child: const Text("Go Home"),
            )
          ],
        ),
      ),
    );
  }
}
