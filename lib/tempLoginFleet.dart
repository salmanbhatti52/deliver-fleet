import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:deliver_partner/Constants/FacebookButton.dart';
import 'package:deliver_partner/Constants/GoogleButton.dart';
import 'package:deliver_partner/PrivacyPolicy.dart';
import 'package:deliver_partner/TermsAndConditions.dart';
import 'package:deliver_partner/VerifyYourself.dart';
import 'package:deliver_partner/models/tempLoginModel.dart';
import 'package:deliver_partner/services/API_services.dart';
import 'package:deliver_partner/tempRegisterFleet.dart';
import 'package:deliver_partner/utilities/showToast.dart';
import 'package:deliver_partner/widgets/TextFormField_Widget.dart';
import 'package:deliver_partner/widgets/apiButton.dart';
import 'package:device_info/device_info.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Constants/Colors.dart';
import 'Constants/buttonContainer.dart';
import 'FleetScreens/BottomNavBarFleet.dart';
import 'LogInScreen.dart';
import 'RiderScreens/VerifyDrivingLisecnseManually.dart';
import 'models/API models/API response.dart';

class TempLoginFleet extends StatefulWidget {
  final String userType;
  final String deviceID;
  final String phoneNumber;

  const TempLoginFleet(
      {super.key,
      required this.userType,
      required this.phoneNumber,
      required this.deviceID});

  @override
  State<TempLoginFleet> createState() => _TempLoginFleetState();
}

class _TempLoginFleetState extends State<TempLoginFleet> {
  final GlobalKey<FormState> _key = GlobalKey();

  // late TextEditingController firstNameController;
  // late TextEditingController lastNameController;
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  // late TextEditingController confirmPasswordController;
  // late TextEditingController phoneNumberController;
  // late TextEditingController fleetCodeController;
  // late TextEditingController nINController;
  late SharedPreferences sharedPreferences;
  bool passwordHidden = false;
  bool newPasswordHidden = false;
  bool isChecked = false;

  final countryPicker = const FlCountryCodePicker(
    showDialCode: true,
  );
  CountryCode? countryCode;

  bool checkmark = false;

  final hintStyle = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w300,
    color: black,
  );

  final enterTextStyle = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w300,
    color: black,
  );

  final focusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      color: orange,
    ),
  );
  final border = const OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10),
    ),
    borderSide: BorderSide.none,
  );
  final enableBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10),
    ),
    borderSide: BorderSide.none,
  );

  final contentPadding =
      const EdgeInsets.symmetric(horizontal: 14, vertical: 16);

  ApiServices get service => GetIt.I<ApiServices>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _deviceDetails();
    // SharedPreferences.getInstance().then((SharedPreferences sp) {
    //   sharedPreferences = sp;
    //   // You can now use sharedPreferences throughout your widget
    // });

    ///for location
    _getCurrentPosition();

    // firstNameController = TextEditingController();
    // lastNameController = TextEditingController();
    emailController = TextEditingController();
    // nINController = TextEditingController();
    // passwordController = TextEditingController();
    // confirmPasswordController = TextEditingController();
    // phoneNumberController = TextEditingController();
    // fleetCodeController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // lastNameController.dispose();
    // firstNameController.dispose();
    emailController.dispose();
    // passwordController.dispose();
    // confirmPasswordController.dispose();
    // phoneNumberController.dispose();
    // nINController.dispose();
    // fleetCodeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
        backgroundColor: white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: white,
      body: LayoutBuilder(
        builder: (context, constraints) => SafeArea(
          child: GlowingOverscrollIndicator(
            axisDirection: AxisDirection.down,
            color: orange,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 40.w,
                ),
                child: Column(
                  children: [
                    Form(
                      key: _key,
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints(minHeight: constraints.minHeight),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/images/logo.svg'),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              'Fleet Login',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontSize: 30,
                                color: orange,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            // SizedBox(
                            //   width: 296.w,
                            //   // height: 50.h,

                            //   child: TextFormFieldWidget(
                            //     validator: (val) {
                            //       if (val!.isEmpty) {
                            //         return 'name cannot be empty';
                            //       }
                            //       return null;
                            //     },
                            //     controller: firstNameController,
                            //     textInputType: TextInputType.name,
                            //     enterTextStyle: enterTextStyle,
                            //     cursorColor: orange,
                            //     hintText: 'First Name',
                            //     border: border,
                            //     hintStyle: hintStyle,
                            //     focusedBorder: focusedBorder,
                            //     contentPadding: contentPadding,
                            //     obscureText: null,
                            //     enableBorder: enableBorder,
                            //     length: -1,
                            //   ),
                            // ),

                            // SizedBox(
                            //   height: 20.h,
                            // ),
                            // SizedBox(
                            //   width: 296.w,
                            //   child: TextFormFieldWidget(
                            //     validator: (val) {
                            //       if (val!.isEmpty) {
                            //         return 'name cannot be empty';
                            //       }
                            //       return null;
                            //     },
                            //     controller: lastNameController,
                            //     textInputType: TextInputType.name,
                            //     enterTextStyle: enterTextStyle,
                            //     cursorColor: orange,
                            //     hintText: 'Last Name',
                            //     border: border,
                            //     hintStyle: hintStyle,
                            //     focusedBorder: focusedBorder,
                            //     contentPadding: contentPadding,
                            //     obscureText: null,
                            //     enableBorder: enableBorder,
                            //     length: -1,
                            //   ),
                            // ),

                            // SizedBox(
                            //   height: 20.h,
                            // ),
                            // SizedBox(
                            //   width: 296.w,
                            //   child: TextFormFieldWidget(
                            //     validator: (val) {
                            //       if (val!.isEmpty) {
                            //         return 'phone number cannot be empty';
                            //       }
                            //       return null;
                            //     },
                            //     controller: phoneNumberController,
                            //     textInputType: TextInputType.number,
                            //     enterTextStyle: enterTextStyle,
                            //     cursorColor: orange,
                            //     hintText: '123 456 789',
                            //     border: border,
                            //     hintStyle: hintStyle,
                            //     focusedBorder: focusedBorder,
                            //     obscureText: null,
                            //     contentPadding: contentPadding,
                            //     enableBorder: enableBorder,
                            //     prefixIcon: GestureDetector(
                            //       onTap: () async {
                            //         final code = await countryPicker
                            //             .showPicker(context: context);
                            //         setState(() {
                            //           countryCode = code;
                            //         });
                            //       },
                            //       child: Row(
                            //         mainAxisSize: MainAxisSize.min,
                            //         children: [
                            //           Padding(
                            //             padding:
                            //                 const EdgeInsets.only(left: 20),
                            //             child: Container(
                            //               child: countryCode != null
                            //                   ? Image.asset(
                            //                       countryCode!.flagUri,
                            //                       package: countryCode!
                            //                           .flagImagePackage,
                            //                       width: 25,
                            //                       height: 20,
                            //                     )
                            //                   : Image.asset(
                            //                       'assets/images/flag-icon.png',
                            //                       width: 20,
                            //                       height: 20,
                            //                       color: orange,
                            //                       fit: BoxFit.scaleDown,
                            //                     ),
                            //             ),
                            //           ),
                            //           Padding(
                            //             padding:
                            //                 const EdgeInsets.only(left: 10),
                            //             child: Text(
                            //               countryCode?.dialCode ?? "+234",
                            //               textAlign: TextAlign.center,
                            //               style: hintStyle,
                            //             ),
                            //           ),
                            //           SizedBox(width: 10.w),
                            //           Text(
                            //             '|',
                            //             style: hintStyle,
                            //           ),
                            //           SizedBox(width: 10.w),
                            //         ],
                            //       ),
                            //     ),
                            //     length: 15,
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 20.h,
                            // ),
                            SizedBox(
                              width: 296.w,
                              child: TextFormFieldWidget(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  } else if (!isValidEmail(value)) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
                                controller: emailController,
                                textInputType: TextInputType.emailAddress,
                                enterTextStyle: enterTextStyle,
                                cursorColor: orange,
                                hintText: 'Email ID',
                                border: border,
                                hintStyle: hintStyle,
                                focusedBorder: focusedBorder,
                                contentPadding: contentPadding,
                                obscureText: null,
                                enableBorder: enableBorder,
                                length: -1,
                              ),
                            ),

                            // SizedBox(
                            //   width: 296.w,
                            //   child: TextFormFieldWidget(
                            //     validator: (val) {
                            //       if (val!.isEmpty) {
                            //         return 'NIN cannot be empty';
                            //       }
                            //       return null;
                            //     },
                            //     controller: nINController,
                            //     textInputType: TextInputType.text,
                            //     enterTextStyle: enterTextStyle,
                            //     cursorColor: orange,
                            //     hintText: 'National Identification Number',
                            //     border: border,
                            //     hintStyle: hintStyle,
                            //     focusedBorder: focusedBorder,
                            //     contentPadding: contentPadding,
                            //     obscureText: null,
                            //     enableBorder: enableBorder,
                            //     length: -1,
                            //   ),
                            // ),

                            SizedBox(
                              height: 20.h,
                            ),
                            SizedBox(
                              width: 296.w,
                              child: TextFormFieldWidget(
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'password cannot be empty';
                                  }
                                  return null;
                                },
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      passwordHidden = !passwordHidden;
                                    });
                                  },
                                  child: passwordHidden
                                      ? SvgPicture.asset(
                                          'assets/images/pass-hide-icon.svg',
                                          fit: BoxFit.scaleDown,
                                        )
                                      : SvgPicture.asset(
                                          'assets/images/pass-icon.svg',
                                          // colorFilter:
                                          // ColorFilter.mode(orange, BlendMode.srcIn),
                                          fit: BoxFit.scaleDown,
                                        ),
                                ),
                                controller: passwordController,
                                textInputType: TextInputType.visiblePassword,
                                enterTextStyle: enterTextStyle,
                                cursorColor: orange,
                                hintText: 'Password',
                                border: border,
                                hintStyle: hintStyle,
                                focusedBorder: focusedBorder,
                                obscureText: passwordHidden,
                                contentPadding: contentPadding,
                                enableBorder: enableBorder,
                                length: -1,
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            // SizedBox(
                            //   width: 296.w,
                            //   child: TextFormFieldWidget(
                            //     validator: (val) {
                            //       if (val!.isEmpty) {
                            //         return 'password cannot be empty';
                            //       } else if (passwordController.text != val) {
                            //         return 'enter correct password';
                            //       }
                            //       return null;
                            //     },
                            //     controller: confirmPasswordController,
                            //     textInputType: TextInputType.visiblePassword,
                            //     enterTextStyle: enterTextStyle,
                            //     cursorColor: orange,
                            //     hintText: 'Confirm Password',
                            //     border: border,
                            //     hintStyle: hintStyle,
                            //     focusedBorder: focusedBorder,
                            //     obscureText: newPasswordHidden,
                            //     contentPadding: contentPadding,
                            //     suffixIcon: GestureDetector(
                            //       onTap: () {
                            //         setState(() {
                            //           newPasswordHidden = !newPasswordHidden;
                            //         });
                            //       },
                            //       child: newPasswordHidden
                            //           ? SvgPicture.asset(
                            //               'assets/images/pass-hide-icon.svg',
                            //               fit: BoxFit.scaleDown,
                            //             )
                            //           : SvgPicture.asset(
                            //               'assets/images/pass-icon.svg',
                            //               // colorFilter:
                            //               // ColorFilter.mode(orange, BlendMode.srcIn),
                            //               fit: BoxFit.scaleDown,
                            //             ),
                            //     ),
                            //     enableBorder: enableBorder,
                            //     length: -1,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    // widget.userType == 'Rider'
                    //     ? SizedBox(
                    //         width: 296.w,
                    //         child: TextFormFieldWidget(
                    //           // validator: (val) {
                    //           //   if (val!.isEmpty) {
                    //           //     return 'fleet code cannot be empty';
                    //           //   }
                    //           // },
                    //           controller: fleetCodeController,
                    //           textInputType: TextInputType.text,
                    //           enterTextStyle: enterTextStyle,
                    //           cursorColor: orange,
                    //           hintText: 'Fleet Code',
                    //           border: border,
                    //           hintStyle: hintStyle,
                    //           focusedBorder: focusedBorder,
                    //           contentPadding: contentPadding,
                    //           obscureText: null,
                    //           enableBorder: enableBorder,
                    //           length: -1,
                    //         ),
                    //       )
                    //     : const SizedBox(),
                    // widget.userType == 'Rider'
                    //     ? SizedBox(
                    //         height: 15.h,
                    //       )
                    //     : const SizedBox(),
                    // widget.userType == 'Rider'
                    //     ? Text(
                    //         '* Register without fleet code if you have a vehicle',
                    //         textAlign: TextAlign.center,
                    //         style: GoogleFonts.inter(
                    //           fontSize: 16,
                    //           fontWeight: FontWeight.w400,
                    //           color: orange,
                    //         ),
                    //       )
                    //     : const SizedBox(),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              checkmark = true;
                            });
                          },
                          child: checkmark == true
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      checkmark = false;
                                    });
                                  },
                                  child: SvgPicture.asset(
                                      'assets/images/check-icon.svg'),
                                )
                              : SvgPicture.asset(
                                  'assets/images/uncheck-icon.svg'),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              text: 'I agree to the ',
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: black,
                              ),
                              children: [
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const TermsConditionsPage(),
                                        ),
                                      );
                                      // const url =
                                      //     'https://deliver.eigix.net/users/terms_and_conditions';
                                      // if (await canLaunch(url)) {
                                      //   await launch(url);
                                      // } else {
                                      //   throw 'Could not launch $url';
                                      // }
                                    },
                                  text: 'Terms and Conditions ',
                                  style: GoogleFonts.inter(
                                    decoration: TextDecoration.underline,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: black,
                                  ),
                                ),
                                TextSpan(
                                  text: 'and ',
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: black,
                                  ),
                                ),
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const TermsConditionsPage(),
                                        ),
                                      );
                                      // const url =
                                      //     'https://deliver.eigix.net/users/privacy_policy';
                                      // if (await canLaunch(url)) {
                                      //   await launch(url);
                                      // } else {
                                      //   throw 'Could not launch $url';
                                      // }
                                    },
                                  text: 'Privacy Policy ',
                                  style: GoogleFonts.inter(
                                    decoration: TextDecoration.underline,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    isRegistering
                        ? apiButton(context)
                        : GestureDetector(
                            onTap: () async {
                              if (_key.currentState!.validate()) {
                                setState(() {
                                  isRegistering = true;
                                });
                                await _getCurrentPosition();
                                if (_currentPosition == null ||
                                    _currentPosition?.latitude == null ||
                                    _currentPosition?.longitude == null) {
                                  setState(() {
                                    isRegistering = false;
                                  });
                                  // showDialog(
                                  //   context: context,
                                  //   builder: (BuildContext context) {
                                  //     return AlertDialog(
                                  //       title: const Text('Location Error'),
                                  //       content: const Text(
                                  //           'Please turn on your location'),
                                  //       actions: <Widget>[
                                  //         TextButton(
                                  //           child: const Text('OK'),
                                  //           onPressed: () {
                                  //             Navigator.of(context).pop();
                                  //           },
                                  //         ),
                                  //       ],
                                  //     );
                                  //   },
                                  // );
                                } else if (!checkmark) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Please ensure that you agree to terms and conditions to proceed further'),
                                    ),
                                  );
                                } else {
                                  fleeTempLogin(context);
                                }
                              }
                            },
                            child: buttonContainer(context, 'Login'),
                          ),
                    SizedBox(
                      height: 15.h,
                    ),
                    RichText(
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: const TextStyle(
                          color: orange,
                          fontSize: 12,
                          fontFamily: 'Syne-Regular',
                        ),
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Handle the tap event, e.g., navigate to a new screen
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TempRegisterFleet(
                                        userType: widget.userType,
                                        deviceID: widget.deviceID,
                                        phoneNumber: "1234"),
                                  ),
                                );
                              },
                            text: 'Register',
                            style: const TextStyle(
                              color: orange,
                              fontSize: 14,
                              fontFamily: 'Syne-Bold',
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isValidEmail(String email) {
    final RegExp regex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)*\w+[\w-]$',
    );
    return regex.hasMatch(email);
  }

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
          print(
              'device id for android while registering: ${identifier.toString()}');
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

  /// Location permission methods for longitude and latitude:

  locationPermission() async {
    PermissionStatus status = await Permission.location.request();

    if (status.isGranted) {
      // Permission granted, navigate to the next screen
    } else if (status.isDenied || status.isPermanentlyDenied) {
      // Permission denied, show a message and provide information
      showLocationPermissionSnackBar();
    }
  }

  void showLocationPermissionSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        width: MediaQuery.of(context).size.width,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        duration: const Duration(seconds: 5),
        content: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              stops: [0.1, 1.5],
              colors: [
                orange,
                lightOrange,
              ],
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 2,
                spreadRadius: 2,
                offset: const Offset(0, 3),
                color: black.withOpacity(0.2),
              ),
            ],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 2,
              color: const Color(0xFF707070).withOpacity(0.5),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Location permission is required\nto continue.',
                style: TextStyle(
                  color: white,
                  fontSize: 12,
                  fontFamily: 'Syne-Regular',
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              GestureDetector(
                onTap: () {
                  openAppSettings();
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.04,
                  width: MediaQuery.of(context).size.width * 0.33,
                  decoration: BoxDecoration(
                    color: const Color(0xFF36454F),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      'Grant Permission',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: white,
                        fontSize: 12,
                        fontFamily: 'Syne-Medium',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future<bool> _handleLocationPermission() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //     //     content: Text(
  //     //         )));
  //     showToastError(
  //         'Location services are disabled. Please enable the services',
  //         FToast().init(context),
  //         seconds: 4);
  //     return false;
  //   }
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       // ScaffoldMessenger.of(context).showSnackBar(
  //       //     const SnackBar(content: Text('Location permissions are denied')));
  //       showToastError(
  //           'Location permissions are denied', FToast().init(context),
  //           seconds: 4);
  //       return false;
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //     //     content: Text(
  //     //
  //     showToastError(
  //         'Location permissions are permanently denied, Enable it from app permission',
  //         FToast().init(context),
  //         seconds: 4);
  //     return false;
  //   }
  //   return true;
  // }

  var hasPermission = false;
  Position? _currentPosition;

  Future<void> _getCurrentPosition() async {
    hasPermission = await locationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }

  TempLoginModel tempLoginModel = TempLoginModel();
  bool isRegistering = false;
  APIResponse<TempLoginModel>? loginResponse;

  Future<void> fleeTempLogin(BuildContext context) async {
    String apiUrl = "https://deliver.eigix.net/api/email_login_fleet";
    setState(() {
      isRegistering = true;
    });
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Accept": "application/json"},
      body: {
        "user_type": widget.userType,
        "one_signal_id": widget.deviceID,
        "phone": widget.phoneNumber,
        "email": emailController.text,
        "password": passwordController.text,
        "latitude": _currentPosition!.latitude.toString(),
        "longitude": _currentPosition!.longitude.toString(),
      },
    );
    final responseString = response.body;
    print("responseSignInApi: $responseString");
    print("status Code SignIn: ${response.statusCode}");

    if (response.statusCode == 200) {
      print("in 200 SignIn");
      tempLoginModel = tempLoginModelFromJson(responseString);

      if (tempLoginModel.status == "success") {
        sharedPreferences = await SharedPreferences.getInstance();
        print('object device id: ${widget.deviceID}');
        await sharedPreferences.setInt(
            'userID', tempLoginModel.data!.usersFleetId);
        await sharedPreferences.setString(
            'userEmail', tempLoginModel.data!.email);
        await sharedPreferences.setString(
            'userFirstName', tempLoginModel.data!.firstName);
        await sharedPreferences.setString(
            'userLastName', tempLoginModel.data!.lastName);
        // await sharedPreferences.setString(
        //     'userProfilePic', checkPhoneNumberModel.data!.profilePic!);
        await sharedPreferences.setString(
            'userLatitude', tempLoginModel.data!.latitude);
        await sharedPreferences.setString(
            'userLongitude', tempLoginModel.data!.longitude);
        await sharedPreferences.setString(
            'deviceIDInfo', tempLoginModel.data!.oneSignalId);
        await sharedPreferences.setString(
            'userType', tempLoginModel.data!.userType);
        await sharedPreferences.setString('isLogIn', 'true');
        showToastSuccess(
            tempLoginModel.status!.toString(), FToast().init(context),
            seconds: 1);
        if (widget.userType == "Fleet") {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const BottomNavBarFleet(),
            ),
            (Route<dynamic> route) =>
                false, // This condition determines which routes to remove
          );
        } else {
          showToastSuccess(
              tempLoginModel.message!.toString(), FToast().init(context),
              seconds: 2);
        }
      } else {
        showToastSuccess(
            tempLoginModel.message!.toString(), FToast().init(context),
            seconds: 2);
      }
    } else {
      showToastSuccess(
          tempLoginModel.message!.toString(), FToast().init(context),
          seconds: 2);
      print(
          'device id for android while registering: ${tempLoginModel.message!.toString()}');

      showToastError(
        tempLoginModel.message!.toString(),
        FToast().init(context),
        seconds: 2,
      );
    }
    setState(() {
      isRegistering = false;
    });
  }

  loginMethod(BuildContext context) async {
    if (_key.currentState!.validate()) {
      setState(() {
        isRegistering = true;
      });
      Map LoginData = {
        "user_type": widget.userType,
        "one_signal_id": widget.deviceID,
        "phone": widget.phoneNumber,
        "email": emailController.text,
        "password": passwordController.text,
        "latitude": _currentPosition!.latitude.toString(),
        "longitude": _currentPosition!.longitude.toString(),
      };

      print('device ID for android or Ios is: ${LoginData.toString()}');

      loginResponse = await service.tempLoginAPI(LoginData);
      if (loginResponse!.status!.toLowerCase() == 'success') {
        print('object device id: ${widget.deviceID}');
        await sharedPreferences.setInt(
            'userID', loginResponse!.data!.data!.usersFleetId);
        await sharedPreferences.setString(
            'userEmail', loginResponse!.data!.data!.email);
        await sharedPreferences.setString(
            'userFirstName', loginResponse!.data!.data!.firstName);
        await sharedPreferences.setString(
            'userLastName', loginResponse!.data!.data!.lastName);
        // await sharedPreferences.setString(
        //     'userProfilePic', checkPhoneNumberModel.data!.profilePic!);
        await sharedPreferences.setString(
            'userLatitude', loginResponse!.data!.data!.latitude);
        await sharedPreferences.setString(
            'userLongitude', loginResponse!.data!.data!.longitude);
        await sharedPreferences.setString(
            'deviceIDInfo', loginResponse!.data!.data!.oneSignalId);
        await sharedPreferences.setString(
            'userType', loginResponse!.data!.data!.userType);
        await sharedPreferences.setString('isLogIn', 'true');
        showToastSuccess(
            loginResponse!.message!.toString(), FToast().init(context),
            seconds: 1);
        if (widget.userType == "Fleet") {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const BottomNavBarFleet(),
            ),
          );
        } else {
          showToastSuccess(
              loginResponse!.message!.toString(), FToast().init(context),
              seconds: 2);
        }
      } else {
        print(
            'device id for android while registering: ${loginResponse!.message!.toString()}');

        showToastError(
          loginResponse!.message!.toString(),
          FToast().init(context),
          seconds: 2,
        );
      }
      setState(() {
        isRegistering = false;
      });
    }
  }
}
