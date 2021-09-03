import 'package:flutter/material.dart';
import 'package:sigaa_student/config/routes/router.dart';
import 'package:sigaa_student/config/routes/routes.dart';

getAppDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                "https://i.imgur.com/BoN9kdC.png")))),
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "RA: ",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: "2016000000",
                            style:
                                TextStyle(color: Theme.of(context).hintColor))
                      ]),
                    )),
                TextButton(
                    onPressed: () => print("exited"),
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
        ListTile(
          title: Text('Grades curriculares'),
          onTap: () =>
              // Update the state of the app.
              // ...
              // Then close the drawer
              AppRouter.router.navigateTo(context, AppRoutes.gridView.route,
                  transition: AppRoutes.gridView.transitionType),
        ),
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
        ListTile(
          title: Text('Matérias'),
          onTap: () =>
              // Update the state of the app.
              // ...
              // Then close the drawer
              AppRouter.router.navigateTo(context, AppRoutes.classFocused.route,
                  transition: AppRoutes.classFocused.transitionType),
        ),
      ],
    ),
  );
}
