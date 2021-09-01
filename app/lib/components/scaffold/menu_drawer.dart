import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:sigaa_student/config/routes/router.dart';
import 'package:sigaa_student/config/routes/routes.dart';

getAppDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text('Usuário'),
        ),
        ListTile(
          title: const Text('RootRoute'),
          onTap: () =>
              // Update the state of the app.
              // ...
              // Then close the drawer
              AppRouter.router.pop(context),
        ),
        ListTile(
          title: const Text('ClassFocused'),
          onTap: () =>
              // Update the state of the app.
              // ...
              // Then close the drawer
              AppRouter.router.navigateTo(
            context,
            AppRoutes.classFocused.route,
            replace: true,
            transition: TransitionType.inFromTop,
          ),
        ),
      ],
    ),
  );
}
