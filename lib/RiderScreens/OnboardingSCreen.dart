import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:deliver_partner/Constants/PageLoadingKits.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:deliver_partner/temploginRider.dart';
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
import '../widgets/apiButton.dart';

class OnboardingScreen extends StatefulWidget {
  final String rider;

  const OnboardingScreen({super.key, required this.rider});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool getsDeviceID = false;

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

  Future<String?> fetchSystemSettingsDescription20() async {
    const String apiUrl = 'https://deliver.eigix.net/api/get_all_system_data';
    setState(() {
      systemSettings = true;
    });
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON
        final Map<String, dynamic> data = json.decode(response.body);

        // Find the setting with system_settings_id equal to 20
        final setting20 = data['data'].firstWhere(
            (setting) => setting['system_settings_id'] == 20,
            orElse: () => null);
        setState(() {
          systemSettings = false;
        });
        if (setting20 != null) {
          // Extract and return the description if setting 20 exists
          loginType = setting20['description'];

          return loginType;
        } else {
          throw Exception('System setting with ID 20 not found');
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
    setState(() {
      getsDeviceID = true;
    });
    fetchSystemSettingsDescription20();
    // TODO: implement initState
    super.initState();
    _deviceDetails();
    setState(() {
      getsDeviceID = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('app mode in rider:  ${widget.rider}');
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
            getsDeviceID
                ? spinKitRotatingCircle
                : Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height *
                        0.34, // Adjust as needed for iPad
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
                        height: MediaQuery.of(context).size.height *
                            0.15, // Adjust as needed
                        width: MediaQuery.of(context).size.width *
                            0.7, // Adjust as needed
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
            SizedBox(
              height: MediaQuery.of(context).size.height *
                  0.07, // Adjust as needed for iPad
            ),
            SvgPicture.asset(
              'assets/images/onboarding-pic.svg',
              height:
                  MediaQuery.of(context).size.height * 0.15, // Adjust as needed
              width: MediaQuery.of(context).size.width * 0.7,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height *
                  0.03, // Adjust as needed for iPad
            ),
            AnimatedTextKit(
              animatedTexts: [
                ColorizeAnimatedText(
                  'Welcome to Golden Fleet Logistics.\n Join our fleet of Riders to deliver amazing\n experience to customers.',
                  textAlign: TextAlign.center,
                  textStyle: GoogleFonts.inter(
                    fontSize: MediaQuery.of(context).size.width *
                        0.04, // Adjust as needed for iPad
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                  speed: const Duration(milliseconds: 100),
                  colors: [
                    Colors.black,
                    Colors.orange,
                    Colors.red,
                    Colors.orange,
                  ],
                )
              ],
            ),
            const Spacer(),
            // loginType == null ? apiButton(context):
            GestureDetector(
              onTap: () async {
                loginType == "Email"
                    ? Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TempLoginRider(
                            userType: widget.rider,
                            deviceID: identifier.toString(),
                            phoneNumber: "123",
                          ),
                        ),
                      )
                    : Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => LogInScreen(
                            userType: widget.rider,
                            deviceID: identifier.toString(),
                          ),
                        ),
                      );
              },
              child: buttonContainer1(
                context,
                'Continue',
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height *
                  0.02, // Adjust as needed for iPad
            ),
            // Other commented code
          ],
        ),
      );
    }
  }
}
