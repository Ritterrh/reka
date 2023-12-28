import 'package:reka/export.dart';
import 'package:get/get.dart';

class AppRoutes {
  static List<GetPage> routes() {
    return [
      GetPage(name: Routes.splashScreen, page: () => const SplashScreen()),
      GetPage(name: Routes.signUpScreen, page: () => const SignUp()),
      GetPage(name: Routes.signInScreen, page: () => const SignIn()),
      //  GetPage(name: Routes.homePage, page: () => HomePage()),
    ];
  }
}
