// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:deliver_partner/Constants/FacebookButton.dart';
import 'package:deliver_partner/Constants/GoogleButton.dart';
import 'package:deliver_partner/PrivacyPolicy.dart';
import 'package:deliver_partner/RiderScreens/BottomNavBar.dart';
import 'package:deliver_partner/RiderScreens/RideDetailsAfterLogIn.dart';
import 'package:deliver_partner/TermsAndConditions.dart';
import 'package:deliver_partner/VerifyYourself.dart';
import 'package:deliver_partner/models/APIModelsFleet/GetAllVehiclesFleetModel.dart';
import 'package:deliver_partner/models/tempLoginModel.dart';
import 'package:deliver_partner/services/API_services.dart';
import 'package:deliver_partner/tempRegisterFleet.dart';
import 'package:deliver_partner/tempRegisterRider.dart';
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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'Constants/Colors.dart';
import 'Constants/buttonContainer.dart';
import 'FleetScreens/BottomNavBarFleet.dart';
import 'LogInScreen.dart';
import 'RiderScreens/VerifyDrivingLisecnseManually.dart';
import 'models/API_models/API_response.dart';

late SharedPreferences sharedPreferences;

class TempLoginRider extends StatefulWidget {
  final String userType;
  final String deviceID;
  final String phoneNumber;

  const TempLoginRider(
      {super.key,
      required this.userType,
      required this.phoneNumber,
      required this.deviceID});

  @override
  State<TempLoginRider> createState() => _TempLoginRiderState();
}

void initializeSharedPreferences() async {
  sharedPreferences = await SharedPreferences.getInstance();
  // You can do additional setup here if needed
}

class _TempLoginRiderState extends State<TempLoginRider> {
  final GlobalKey<FormState> _key = GlobalKey();
  // late TextEditingController firstNameController;
  // late TextEditingController lastNameController;
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  // late TextEditingController confirmPasswordController;
  // late TextEditingController phoneNumberController;
  // late TextEditingController fleetCodeController;
  // late TextEditingController nINController;

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
    _getCurrentPosition();
    // firstNameController = TextEditingController();
    // lastNameController = TextEditingController();
    // emailController = TextEditingController();
    // nINController = TextEditingController();
    // passwordController = TextEditingController();
    // confirmPasswordController = TextEditingController();
    // phoneNumberController = TextEditingController();
    // fleetCodeController = TextEditingController();
    initializeSharedPreferences();
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
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
            color: Colors.black), // This will change the color of the icons
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
                              'Rider Login',
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
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Row(
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
                                      'assets/images/check-icon.svg',
                                      width: 20,
                                      height: 20,
                                    ),
                                  )
                                : SvgPicture.asset(
                                    'assets/images/uncheck-icon.svg',
                                    width: 20,
                                    height: 20,
                                  ),
                          ),
                          const SizedBox(
                            width: 10,
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
                                        // try {
                                        //   String url =
                                        //       'https://deliverbygfl.com/users/terms_and_conditions';
                                        //   if (await canLaunch(url)) {
                                        //     await launch(url);
                                        //   } else {
                                        //     throw 'Could not launch $url';
                                        //   }
                                        // } catch (e) {
                                        //   print('Error launching URL: $e');
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
                                        // try {
                                        //   const url =
                                        //       'https://deliverbygfl.com/users/privacy_policy';
                                        //   if (await canLaunch(url)) {
                                        //     await launch(url);
                                        //   } else {
                                        //     throw 'Could not launch $url';
                                        //   }
                                        // } catch (e) {
                                        //   print('Error launching URL: $e');
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
                                  setState(() {
                                    isRegistering = false;
                                  });
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
                                    builder: (context) => TempRegisterRider(
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

  bool isRegistering = false;
  APIResponse<APIResponse>? _signupResponse;
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

  bool isValidEmail(String email) {
    final RegExp regex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)*\w+[\w-]$',
    );
    return regex.hasMatch(email);
  }

  /// Location permission methods for longitude and latitude:
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //     content: Text(
      //         )));
      showToastError(
          'Location services are disabled. Please enable the services',
          FToast().init(context),
          seconds: 4);
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(content: Text('Location permissions are denied')));
        showToastError(
            'Location permissions are denied', FToast().init(context),
            seconds: 4);
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //     content: Text(
      //
      showToastError(
          'Location permissions are permanently denied, Enable it from app permission',
          FToast().init(context),
          seconds: 4);
      return false;
    }
    return true;
  }

  bool hasPermission = false;
  Position? _currentPosition;

  Future<void> _getCurrentPosition() async {
    hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }

  TempLoginModel tempLoginModel = TempLoginModel();
  late APIResponse<List<GetAllVehiclesFleetModel>> _getAllVehicleFleetResponse;
  APIResponse<TempLoginModel>? loginResponse;
  Future<void> fleeTempLogin(BuildContext context) async {
    String apiUrl = "https://deliverbygfl.com/api/email_login_fleet";
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

    tempLoginModel = tempLoginModelFromJson(responseString);
    if (tempLoginModel.status == "success") {
      print("Helllooooo Zainnnnnnnnnnnnnnnnnnnnnnnn");
      print("in 200 SignIn");
      Map userData = {
        "users_fleet_id": tempLoginModel.data!.usersFleetId.toString(),
      };

      _getAllVehicleFleetResponse =
          await service.getAllVehiclesFleetApi(userData);
      sharedPreferences = await SharedPreferences.getInstance();
      if (_getAllVehicleFleetResponse.status!.toLowerCase() == 'success') {}
      print('object device id: ${widget.deviceID}');

      await sharedPreferences.setInt(
          'userID', tempLoginModel.data!.usersFleetId);
      await sharedPreferences.setString(
          'parentID', tempLoginModel.data!.parentId.toString());
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
      if (widget.userType == 'Rider') {
        if (_getAllVehicleFleetResponse.status!.toLowerCase() == 'success') {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const BottomNavBar(),
            ),
          );
        } else {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => RideDetailsAfterLogInScreen(
                userType: widget.userType,
                userFleetId: tempLoginModel.data!.usersFleetId.toString(),
                parentID: tempLoginModel.data!.parentId.toString(),
              ),
            ),
          );
        }
      } else if (widget.userType == 'Fleet') {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const BottomNavBarFleet(),
          ),
        );
      }
    } else if (tempLoginModel.status == "error") {
      print("Hellooooooooooooooooooooooooooooooooooo");

      showToastError(
        tempLoginModel.message!.toString(),
        FToast().init(context),
        seconds: 2,
      );
      print(
          'device id for android while registering: ${tempLoginModel.message!.toString()}');
    }
    setState(() {
      isRegistering = false;
    });
  }

  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  registerMethod(BuildContext context) async {
    if (_key.currentState!.validate()) {
      setState(() {
        isRegistering = true;
      });
      Map signupData = {
        "user_type": widget.userType,
        "one_signal_id": widget.deviceID,
        // "first_name": firstNameController.text,
        // "last_name": lastNameController.text,
        "phone": widget.phoneNumber,
        "email": emailController.text,
        // "national_identification_no": nINController.text,
        // "password": passwordController.text,
        // "confirm_password": confirmPasswordController.text,
        // "parent_id": fleetCodeController.text,
        "account_type": "SignupWithApp"
      };

      print('device ID for android or Ios is: ${signupData.toString()}');

      _signupResponse = await service.signUpAPI(signupData);
      if (_signupResponse!.status!.toLowerCase() == 'success') {
        print('object device id: ${widget.deviceID}');
        showToastSuccess(
            _signupResponse!.message!.toString(), FToast().init(context),
            seconds: 1);
        if (widget.userType == "Rider") {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => VerifyDrivingLicenseManually(
                email: emailController.text,
                userType: widget.userType,
                deviceID: widget.deviceID,
              ),
            ),
          );
        } else {
          showToastSuccess(
              "You have registered successfully admin approve your account soon...",
              FToast().init(context),
              seconds: 1);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => LogInScreen(
                    userType: widget.userType, deviceID: widget.deviceID),
              ),
              (Route<dynamic> route) => false);
        }
      } else {
        print(
            'device id for android while registering: ${_signupResponse!.message!.toString()}');

        showToastError(
          _signupResponse!.message!.toString(),
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
