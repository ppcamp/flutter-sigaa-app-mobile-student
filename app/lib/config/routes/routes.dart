import 'package:fluro/fluro.dart';
import 'package:sigaa_student/config/routes/handlers.dart';

class AppRoutes {
  ///
  static final routeNotFoundHandler = handleNotFound;

  ///
  static final rootRoute =
      AppRoute('/', handleDashboard, transitionType: TransitionType.cupertino);

  ///
  static final classFocused = AppRoute('/class/:id', handleSubjectFocused,
      transitionType: TransitionType.cupertino);

  ///
  static final subjectCalendar = AppRoute('/calendar', handleSubjectCalendar,
      transitionType: TransitionType.cupertino);

  ///
  static final gridView =
      AppRoute('/grid', handleGrid, transitionType: TransitionType.cupertino);

  ///
  static final loginScren = AppRoute('/login', handleLoginScreen,
      transitionType: TransitionType.cupertino);

  ///
  static final aboutScren = AppRoute('/about', handleAboutScreen,
      transitionType: TransitionType.cupertino);

  static final List<AppRoute> routes = [
    rootRoute,
    classFocused,
    subjectCalendar,
    gridView,
    loginScren,
    aboutScren
  ];
}
