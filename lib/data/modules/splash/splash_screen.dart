import 'package:reka/export.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SplashServices.checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackgroundColor,
      body: Center(
        child: Container(
          alignment: Alignment.center,
          height: 150,
          width: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: primaryColor,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(.2), offset: Offset(1, 1)),
                BoxShadow(
                    color: Colors.grey.withOpacity(.2), offset: Offset(-1, -1))
              ]),
          child: Icon(
            FontAwesomeIcons.candyCane,
            color: Colors.pinkAccent,
            size: 50,
          ),
        ),
      ),
    );
  }
}
