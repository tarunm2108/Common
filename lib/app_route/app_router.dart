import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:my_code/src/ui/splash/splash_view.dart';

///Routes Name
///Add new screen here with there path neme
const String splashView = "/";//initial view
const String loginView = "/login";

class AppPages {
  static const initial = splashView;

  static List<GetPage> routes = [
    GetPage(
      name: splashView,
      page: () => const SplashView(),
    ),

  ];
}
