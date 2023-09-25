import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Constants/Colors.dart';
import '../Constants/buttonContainer.dart';
import '../LogInScreen.dart';
import '../RegisterScreen.dart';

class OnboardingFleetScreen extends StatefulWidget {
  final String fleet;
  const OnboardingFleetScreen({super.key, required this.fleet});

  @override
  State<OnboardingFleetScreen> createState() => _OnboardingFleetScreenState();
}

class _OnboardingFleetScreenState extends State<OnboardingFleetScreen> {
  /// Device ID everytime a user registers their account:

  String deviceName = '';
  String deviceVersion = '';
  String identifier = '';

  Future<void> _deviceDetails() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        setState(() {
          deviceName = build.model;
          deviceVersion = build.version.toString();
          identifier = build.androidId;
          print('device id for android while registering:  ' +
              identifier.toString());
        });
        //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        setState(() {
          deviceName = data.name;
          deviceVersion = data.systemVersion;
          identifier = data.identifierForVendor;
        }); //UUID for iOS
      }
    } on PlatformException catch (e) {
      debugPrint() {
        return e.toString();
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _deviceDetails();
  }

  @override
  Widget build(BuildContext context) {
    print('app mode in fleet:  ${widget.fleet}');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: 328.h,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
                gradient: LinearGradient(
                  colors: [
                    Color(0xffFF6302),
                    Color(0xffFBC403),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/images/logo.svg',
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            SvgPicture.asset(
              'assets/images/onboarding-pic.svg',
              fit: BoxFit.scaleDown,
            ),
            SizedBox(
              height: 40.h,
            ),
            AnimatedTextKit(
              animatedTexts: [
                ColorizeAnimatedText(
                  'Welcome to Golden Fleet Logistics. \n Join our fleet community to deliver \n  amazing experience to customers.',
                  textAlign: TextAlign.center,
                  textStyle: GoogleFonts.inter(
                    fontSize: 16,
                    color: black,
                    fontWeight: FontWeight.w400,
                  ),
                  speed: const Duration(milliseconds: 100),
                  colors: [
                    black,
                    orange,
                    red,
                    orange,
                  ],
                )
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => RegisterScreen(
                      userType: widget.fleet,
                      deviceID: identifier.toString(),
                    ),
                  ),
                );
                _deviceDetails();
              },
              child: buttonContainer(
                context,
                'Continue',
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20.0.h),
              child: GestureDetector(
                onTap: () {
                  print('rider to fleet user tyep:  ' + widget.fleet);
                  // _deviceDetails();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => LogInScreen(
                        userType: widget.fleet,
                        deviceID: identifier.toString(),
                      ),
                    ),
                  );
                },
                child: RichText(
                  text: TextSpan(
                    text: 'Have an account already? ',
                    style: GoogleFonts.syne(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: grey,
                    ),
                    children: [
                      TextSpan(
                        text: 'Login',
                        style: GoogleFonts.syne(
                          decoration: TextDecoration.underline,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: orange,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
