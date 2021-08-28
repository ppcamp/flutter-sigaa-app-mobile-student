import 'package:fluro/fluro.dart';
import 'package:sigaa_student/config/routes/handlers.dart';

class AppRoutes {
  static final routeNotFoundHandler = handleNotFound;
  // rootRoute is the main (dashboard) route
  static final rootRoute = AppRoute('/', handleDashboard, transitionType: TransitionType.cupertino);
  // rootRoute is the main (dashboard) route
  static final classFocused = AppRoute('/class/:id', handleSubjectFocused, transitionType: TransitionType.cupertino);

  static final List<AppRoute> routes = [rootRoute, classFocused];
}
