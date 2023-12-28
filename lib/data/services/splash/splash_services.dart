import 'package:reka/export.dart';
import 'package:get/get.dart';

class SplashServices {
  static void checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? uid = pref.getString('TOKEN');
    Timer(const Duration(milliseconds: 2000), () {
      if (uid == null) {
        Get.toNamed(Routes.signUpScreen);
      } else {
        Get.toNamed(Routes.homePage);
      }
    });
  }
}
