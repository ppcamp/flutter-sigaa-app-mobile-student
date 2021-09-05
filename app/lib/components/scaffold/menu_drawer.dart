import 'package:flutter/material.dart';
import 'package:sigaa_student/components/clippers/semi_circle_transformed.dart';
import 'package:sigaa_student/config/routes/router.dart';
import 'package:sigaa_student/config/routes/routes.dart';
import 'package:sigaa_student/config/setup/globals.dart';
import 'package:sigaa_student/services/sync.dart';

void logOut() {}

getAppDrawer(BuildContext context) {
  final studentRA = '2016001942';

  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        ClipPath(
            clipper: SemiCircleTransformedClipper(),
            child: Container(
              color: Theme.of(context).accentColor,
              child: DrawerHeader(
                decoration: BoxDecoration(
                    boxShadow: [], border: Border.all(style: BorderStyle.none)),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      userAvatar,
                      Padding(
                          padding: EdgeInsets.all(5.0),
                          child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: "RA: ",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: studentRA,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor))
                            ]),
                          )),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary:
                                  Theme.of(context).scaffoldBackgroundColor,
                              elevation: 0,
                              padding: EdgeInsets.only(
                                  bottom: 8, top: 8, left: 15, right: 15),
                              minimumSize: Size.zero),
                          onPressed: () {
                            // clean all objects (including images)
                            SyncService.logout();

                            // Then close the drawer and redirect to login scr
                            AppRouter.router.navigateTo(
                                context, AppRoutes.loginScren.route,
                                transition:
                                    AppRoutes.loginScren.transitionType);
                          },
                          child: Text(
                            'SAIR',
                            style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                ),
              ),
            )),

        // Turmas
        ListTile(
          title: Text('Turmas'),
          onTap: () =>
              // Update the state of the app.
              // ...
              // Then close the drawer
              AppRouter.router.navigateTo(context, AppRoutes.rootRoute.route,
                  clearStack: true,
                  transition: AppRoutes.rootRoute.transitionType),
        ),

        // Grades curriculares
        ListTile(
          title: Text('Grades curriculares'),
          onTap: () =>
              // Update the state of the app.
              // ...
              // Then close the drawer
              AppRouter.router.navigateTo(context, AppRoutes.gridView.route,
                  transition: AppRoutes.gridView.transitionType),
        ),

        // Calendário
        ListTile(
          title: Text('Calendário'),
          onTap: () =>
              // Update the state of the app.
              // ...
              // Then close the drawer
              AppRouter.router.navigateTo(
                  context, AppRoutes.subjectCalendar.route,
                  transition: AppRoutes.subjectCalendar.transitionType),
        ),

        // Matérias
        ListTile(
          title: Text('Matérias'),
          onTap: () =>
              // Update the state of the app.
              // ...
              // Then close the drawer
              AppRouter.router.navigateTo(context, AppRoutes.classFocused.route,
                  transition: AppRoutes.classFocused.transitionType),
        ),

        // Sobre
        ListTile(
          title: Text('Sobre'),
          onTap: () =>
              // Update the state of the app.
              // ...
              // Then close the drawer
              AppRouter.router.navigateTo(context, AppRoutes.aboutScren.route,
                  transition: AppRoutes.aboutScren.transitionType),
        ),
      ],
    ),
  );
}
