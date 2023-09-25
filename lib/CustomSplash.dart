import 'package:Deliver_Rider/ChooseAppScreen.dart';
import 'package:Deliver_Rider/FleetScreens/BottomNavBarFleet.dart';
import 'package:Deliver_Rider/RiderScreens/BottomNavBar.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomSplash extends StatefulWidget {
  const CustomSplash({Key? key}) : super(key: key);

  @override
  State<CustomSplash> createState() => _CustomSplashState();
}

class _CustomSplashState extends State<CustomSplash> {
  late SharedPreferences sharedPreferences;
  String isLogin = 'false';
  String userType = '';

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    isLogin = (sharedPreferences.getString('isLogin')) ?? 'false';
    userType = (sharedPreferences.getString('userType')) ?? 'false';

    Future.delayed(
      const Duration(seconds: 6),
      () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            //pushReplacement = replacing the route so that
            //splash screen won't show on back button press
            //navigation to Home page.
            // builder: (context) {
            //   return isLogin == "true"
            //       ? const BottomNavigationBarScreens()
            //       : const OnBoardingScreens();
            // },
            builder: (context) {
              return isLogin == 'true' || userType == 'Rider'
                  ? const BottomNavBar()
                  : isLogin == 'true' || userType == 'Fleet'
                      ? BottomNavBarFleet()
                      : ChooseAppScreen();
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          constraints: const BoxConstraints.expand(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/images/logo.svg'),
              SizedBox(
                height: 30.h,
              ),
              SizedBox(
                width: 295.w,
                height: 85.h,
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'We   Get   It   There',
                      textStyle: GoogleFonts.syne(
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff212A37),
                      ),
                      speed: const Duration(milliseconds: 200),
                    ),
                  ],
                  totalRepeatCount: 4,
                  isRepeatingAnimation: true,

                  // pause: const Duration(milliseconds: 1000),
                  displayFullTextOnTap: true,
                  // stopPauseOnTap: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
