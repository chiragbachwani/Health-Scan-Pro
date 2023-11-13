import 'package:firebase_auth/firebase_auth.dart';

import '../../auth_screen/login_screen.dart';
import '../../const/const.dart';
import '../../widgets_common/app_logo.dart';
import '../home_screen/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  gotoNextScreen() {
    Future.delayed(const Duration(seconds: 4), () {
      // Get.to(() => const LoginScren());

      auth.authStateChanges().listen((User? user) {
        if (user == null && mounted) {
          Get.to(const LoginScren());
        } else {
          Get.to(() => const Home());
        }
      });
    });
  }

  @override
  void initState() {
    gotoNextScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          // Image.asset("assets/images/qb.gif"),

          Align(
            alignment: Alignment.topLeft,
            child: Image.asset(
              icSplashBg,
              width: 300,
            ),
          ),
          applogoWidget(),

          const Spacer(),
          credits.text.fontFamily(semibold).color(Vx.gray600).make(),
          const HeightBox(30),
        ],
      ),
    );
  }
}
