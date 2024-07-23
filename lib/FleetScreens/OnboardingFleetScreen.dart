import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:deliver_partner/tempLoginFleet.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:deliver_partner/Constants/back-arrow-with-container.dart';
import '../Constants/Colors.dart';
import '../Constants/buttonContainer.dart';
import '../LogInScreen.dart';
import '../RegisterScreen.dart';
import '../tempRegisterFleet.dart';
import '../widgets/apiButton.dart';

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
          print('device id for android while registering:  $identifier');
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

  bool systemSettings = false;
  String? loginType;

  Future<String?> fetchSystemSettingsDescription28() async {
    const String apiUrl = 'https://deliverbygfl.com/api/get_all_system_data';
    setState(() {
      systemSettings = true;
    });
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON
        final Map<String, dynamic> data = json.decode(response.body);

        // Find the setting with system_settings_id equal to 26
        final setting40 = data['data'].firstWhere(
            (setting) => setting['system_settings_id'] == 20,
            orElse: () => null);
        setState(() {
          systemSettings = false;
        });
        if (setting40 != null) {
          // Extract and return the description if setting 28 exists
          loginType = setting40['description'];

          return loginType;
        } else {
          throw Exception('System setting with ID 40 not found');
        }
      } else {
        // If the server did not return a 200 OK response,
        // throw an exception.
        throw Exception('Failed to fetch system settings');
      }
    } catch (e) {
      // Catch any exception that might occur during the process
      print('Error fetching system settings: $e');
      return null;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchSystemSettingsDescription28();
    _deviceDetails();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenHeight * 0.02;
    print('app mode in fleet:  ${widget.fleet}');
    if (systemSettings == true) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: orange,
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: const Color(0xffFBC403),
          leadingWidth: 70,
          leading: Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 20),
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: backArrowWithContainer(context),
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.21,
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
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.7,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            SvgPicture.asset(
              'assets/images/onboarding-pic.svg',
              fit: BoxFit.scaleDown,
            ),
            const SizedBox(
              height: 40,
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
              onTap: () async {
                // await fetchSystemSettingsDescription28();
                loginType == "Email"
                    ? Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TempLoginFleet(
                              userType: widget.fleet,
                              deviceID: identifier.toString(),
                              phoneNumber: "1234"),
                        ),
                      )
                    : Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => LogInScreen(
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
            const SizedBox(
              height: 30,
            ),
            // Padding(
            //   padding: EdgeInsets.only(bottom: 20.0.h),
            //   child: GestureDetector(
            //     onTap: () {
            //       print('rider to fleet user tyep:  ' + widget.fleet);
            //       // _deviceDetails();
            //       Navigator.of(context).push(
            //         MaterialPageRoute(
            //           builder: (context) => LogInScreen(
            //             userType: widget.fleet,
            //             deviceID: identifier.toString(),
            //           ),
            //         ),
            //       );
            //     },
            //     child: RichText(
            //       text: TextSpan(
            //         text: 'Have an account already? ',
            //         style: GoogleFonts.syne(
            //           fontSize: 13,
            //           fontWeight: FontWeight.w400,
            //           color: grey,
            //         ),
            //         children: [
            //           TextSpan(
            //             text: 'Login',
            //             style: GoogleFonts.syne(
            //               decoration: TextDecoration.underline,
            //               fontSize: 14,
            //               fontWeight: FontWeight.w500,
            //               color: orange,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      );
    }
  }
}
