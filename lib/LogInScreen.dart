import 'dart:io';
import 'package:deliver_partner/FleetScreens/BottomNavBarFleet.dart';
import 'package:deliver_partner/RiderScreens/BottomNavBar.dart';
import 'package:deliver_partner/VerifyYourself.dart';
import 'package:deliver_partner/services/API_services.dart';
import 'package:deliver_partner/utilities/showToast.dart';
import 'package:deliver_partner/widgets/TextFormField_Widget.dart';
import 'package:deliver_partner/widgets/apiButton.dart';
import 'package:device_info/device_info.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Constants/Colors.dart';
import 'Constants/FacebookButton.dart';
import 'Constants/GoogleButton.dart';
import 'Constants/PageLoadingKits.dart';
import 'Constants/buttonContainer.dart';
import 'EmailVerificationScreen.dart';
import 'ForgetPassword.dart';
import 'RegisterScreen.dart';
import 'RiderScreens/RideDetailsAfterLogIn.dart';
import 'models/API models/API response.dart';
import 'models/API models/LogInModel.dart';
import 'models/APIModelsFleet/GetAllVehiclesFleetModel.dart';

class LogInScreen extends StatefulWidget {
  final String userType;
  final String? deviceID;
  const LogInScreen({super.key, required this.userType, this.deviceID});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  ApiServices get service => GetIt.I<ApiServices>();

  final GlobalKey<FormState> _key = GlobalKey();
  final countryPicker = const FlCountryCodePicker();
  CountryCode? countryCode =
      const CountryCode(name: 'Nigeria', code: 'NG', dialCode: '+234');
  TextEditingController contactNumberController = TextEditingController();
  // late TextEditingController emailController;
  // late TextEditingController passwordController;

  late SharedPreferences sharedPreferences;
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      isLoading = true;
    });
    init();
  }

  String userType = '';
  init() async {
    _deviceDetails();

    ///for location
    _getCurrentPosition();

    /// for email and password
    // getEmailAndPassword();

    sharedPreferences = await SharedPreferences.getInstance();
    userType = (sharedPreferences.getString('userType')) ?? 'false';
    // emailController = TextEditingController();
    // passwordController = TextEditingController();
    contactNumberController = TextEditingController();
    setState(() {
      isLoading = false;
    });
  }

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

  // String? _currentAddress;
  var hasPermission = false;
  Position? _currentPosition;
  Future<void> _getCurrentPosition() async {
    hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  /// Location permission methods for longitude and latitude:

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // emailController.dispose();
    // passwordController.dispose();
    contactNumberController.dispose();
  }

  bool passwordHidden = false;
  bool rememberMe = false;
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

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    var size = MediaQuery.of(context).size;

    print('user type on login screen :  ${widget.userType}');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: white,
        body: SafeArea(
          child: isLoading
              ? spinKitRotatingCircle
              : GlowingOverscrollIndicator(
                  axisDirection: AxisDirection.down,
                  color: orange,
                  child: SingleChildScrollView(
                    child: Form(
                      key: _key,
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                          ),
                          SvgPicture.asset(
                            'assets/images/logo.svg',
                            height: size.height * 0.15,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            'LOGIN',
                            style: GoogleFonts.syne(
                              fontWeight: FontWeight.w700,
                              color: orange,
                              fontSize: size.width * 0.08,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Text(
                            'as ${widget.userType}',
                            style: GoogleFonts.syne(
                              fontWeight: FontWeight.w700,
                              color: orange,
                              fontSize: size.width * 0.04,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.08,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.1),
                            child: TextFormField(
                              controller: contactNumberController,
                              cursorColor: orange,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(15),
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Contact Number is required!';
                                }
                                return null;
                              },
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Inter-Regular',
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color(0xffF2F0EE),
                                errorStyle: const TextStyle(
                                  color: red,
                                  fontSize: 10,
                                  fontFamily: 'Inter-Bold',
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: orange,
                                  ),
                                ),
                                focusedErrorBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  borderSide: BorderSide(
                                    color: red,
                                    width: 1,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.04,
                                  vertical: screenHeight * 0.02,
                                ),
                                hintText: "Contact Number",
                                hintStyle: TextStyle(
                                  color:
                                      const Color(0xFF191919).withOpacity(0.5),
                                  fontSize: 12,
                                  fontFamily: 'Inter-Light',
                                ),
                                prefixIcon: GestureDetector(
                                  onTap: () async {
                                    final code = await countryPicker.showPicker(
                                        context: context);
                                    setState(() {
                                      countryCode = code;
                                    });
                                    print('countryName: ${countryCode!.name}');
                                    print('countryCode: ${countryCode!.code}');
                                    print(
                                        'countryDialCode: ${countryCode!.dialCode}');
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Container(
                                          child: countryCode != null
                                              ? Image.asset(
                                                  countryCode!.flagUri,
                                                  package: countryCode!
                                                      .flagImagePackage,
                                                  width: 25,
                                                  height: 20,
                                                )
                                              : SvgPicture.asset(
                                                  'assets/images/flag-icon.svg',
                                                ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          countryCode?.dialCode ?? "+234",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: const Color(0xFF191919)
                                                .withOpacity(0.5),
                                            fontSize: 12,
                                            fontFamily: 'Inter-Light',
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.02),
                                      Text(
                                        '|',
                                        style: TextStyle(
                                          color: const Color(0xFF191919)
                                              .withOpacity(0.5),
                                          fontSize: 12,
                                          fontFamily: 'Inter-SemiBold',
                                        ),
                                      ),
                                      SizedBox(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.02),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // AutofillGroup(
                          //   child: Column(
                          //     children: [
                          //       SizedBox(
                          //         width: 296.w,
                          //         child: TextFormFieldWidget(
                          //           autofillHints: AutofillHints.email,
                          //           controller: emailController,
                          //           textInputType: TextInputType.emailAddress,
                          //           enterTextStyle: enterTextStyle,
                          //           cursorColor: orange,
                          //           hintText: 'Email ID',
                          //           border: border,
                          //           hintStyle: hintStyle,
                          //           focusedBorder: focusedBorder,
                          //           obscureText: null,
                          //           contentPadding: contentPadding,
                          //           enableBorder: enableBorder,
                          //           prefixIcon: null,
                          //           validator: (val) {
                          //             if (val!.isEmpty) {
                          //               return 'email cannot be empty';
                          //             }
                          //             return null;
                          //           },
                          //           length: -1,
                          //         ),
                          //       ),
                          //       SizedBox(
                          //         height: 25.h,
                          //       ),
                          //       SizedBox(
                          //         width: 296.w,
                          //         child: TextFormFieldWidget(
                          //           autofillHints: AutofillHints.password,
                          //           validator: (val) {
                          //             if (val!.isEmpty) {
                          //               return 'password cannot be empty';
                          //             }
                          //             return null;
                          //           },
                          //           suffixIcon: GestureDetector(
                          //             onTap: () {
                          //               setState(() {
                          //                 passwordHidden = !passwordHidden;
                          //               });
                          //             },
                          //             child: passwordHidden
                          //                 ? SvgPicture.asset(
                          //                     'assets/images/pass-hide-icon.svg',
                          //                     fit: BoxFit.scaleDown,
                          //                   )
                          //                 : SvgPicture.asset(
                          //                     'assets/images/pass-icon.svg',
                          //                     // colorFilter:
                          //                     // ColorFilter.mode(orange, BlendMode.srcIn),
                          //                     fit: BoxFit.scaleDown,
                          //                   ),
                          //           ),
                          //           controller: passwordController,
                          //           textInputType:
                          //               TextInputType.visiblePassword,
                          //           enterTextStyle: enterTextStyle,
                          //           cursorColor: orange,
                          //           hintText: 'Password',
                          //           border: border,
                          //           hintStyle: hintStyle,
                          //           focusedBorder: focusedBorder,
                          //           obscureText: passwordHidden,
                          //           contentPadding: contentPadding,
                          //           enableBorder: enableBorder,
                          //           length: -1,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),

                          const SizedBox(
                            height: 30,
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Row(
                          //       children: [
                          //         GestureDetector(
                          //           onTap: () {
                          //             setState(() {
                          //               rememberMe = !rememberMe;
                          //               TextInput.finishAutofillContext(
                          //                   shouldSave: rememberMe);
                          //               // getEmailAndPassword();
                          //             });
                          //           },
                          //           child: rememberMe
                          //               ? SvgPicture.asset(
                          //                   'assets/images/switch-on.svg')
                          //               : SvgPicture.asset(
                          //                   'assets/images/switch-off.svg'),
                          //         ),
                          //         SizedBox(
                          //           width: 9.w,
                          //         ),
                          //         Text(
                          //           'Remember me',
                          //           style: GoogleFonts.syne(
                          //             fontSize: 12,
                          //             fontWeight: FontWeight.w400,
                          //             color: black,
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //     GestureDetector(
                          //       onTap: () => Navigator.of(context).push(
                          //         MaterialPageRoute(
                          //           builder: (context) => ForgetPassword(
                          //             userType: widget.userType,
                          //           ),
                          //         ),
                          //       ),
                          //       child: Text(
                          //         'Forgot Password?',
                          //         style: GoogleFonts.syne(
                          //           decoration: TextDecoration.underline,
                          //           fontSize: 12,
                          //           fontWeight: FontWeight.w400,
                          //           color: black,
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          const SizedBox(
                            height: 30,
                          ),
                          // GestureDetector(
                          //   onTap: () => Navigator.of(context).push(
                          //     MaterialPageRoute(
                          //       builder: (context) => VerifyYourself(
                          //           email: emailController.text,
                          //           appMode: widget.userType),
                          //     ),
                          //   ),
                          //   child: RichText(
                          //     text: TextSpan(
                          //       text: 'Did\'nt verify email?',
                          //       style: GoogleFonts.syne(
                          //         fontSize: 13,
                          //         fontWeight: FontWeight.w400,
                          //         color: grey,
                          //       ),
                          //       children: [
                          //         TextSpan(
                          //           text: '  Verify Now',
                          //           style: GoogleFonts.syne(
                          //             decoration: TextDecoration.underline,
                          //             fontSize: 14,
                          //             fontWeight: FontWeight.w500,
                          //             color: orange,
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          const SizedBox(
                            height: 40,
                          ),
                          isLoggingIn
                              ? apiButton(context)
                              : GestureDetector(
                                  onTap: () {
                                    print(
                                        "lat ${_currentPosition!.latitude.toString()}");
                                    print(
                                        "long ${_currentPosition!.longitude.toString()}");
                                    if (_key.currentState!.validate()) {
                                      // hasPermission ? loginMethod(context) :
                                      print("object");
                                      _getCurrentPosition();
                                      // MaterialPageRoute(
                                      //   builder: (context) => RegisterScreen(
                                      //     userType: widget.userType,
                                      //     deviceID: widget.deviceID ?? '',
                                      //   ),
                                      // );
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              EmailVerificationScreen(
                                            latitude: _currentPosition!.latitude
                                                .toString(),
                                            longitude: _currentPosition!
                                                .longitude
                                                .toString(),
                                            phoneNumber: countryCode!.dialCode +
                                                contactNumberController.text,
                                            userType: widget.userType,
                                            deviceID: widget.deviceID ?? '',
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  child: buttonContainer1(context, 'LOGIN'),
                                ),
                          // const Spacer(),
                          const SizedBox(
                            height: 30,
                          ),
                          // Text(
                          //   'OR',
                          //   style: GoogleFonts.syne(
                          //     fontSize: 18,
                          //     fontWeight: FontWeight.w600,
                          //     color: grey,
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 15.h,
                          // ),
                          // GestureDetector(
                          //   onTap: null,
                          //   child: facebookButton(context),
                          // ),
                          // SizedBox(
                          //   height: 20.h,
                          // ),
                          // GestureDetector(
                          //   onTap: null,
                          //   child: googleButton(context),
                          // ),
                          // Padding(
                          //   padding: EdgeInsets.only(bottom: 20.0.h, top: 20.h),
                          //   child: GestureDetector(
                          //     onTap: () => Navigator.of(context).push(
                          //       MaterialPageRoute(
                          //         builder: (context) => LogInScreen(
                          //           userType: widget.userType,
                          //         ),
                          //       ),
                          //     ),
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
                          // Padding(
                          //   padding: EdgeInsets.only(bottom: 20.0.h),
                          //   child: GestureDetector(
                          //     onTap: () => Navigator.of(context).push(
                          //       MaterialPageRoute(
                          //         builder: (context) => RegisterScreen(
                          //           userType: widget.userType,
                          //           deviceID: widget.deviceID ?? '',
                          //         ),
                          //       ),
                          //     ),
                          //     child: RichText(
                          //       text: TextSpan(
                          //         text: 'don\'t have an account already? ',
                          //         style: GoogleFonts.syne(
                          //           fontSize: 13,
                          //           fontWeight: FontWeight.w400,
                          //           color: grey,
                          //         ),
                          //         children: [
                          //           TextSpan(
                          //             text: 'Register',
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
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  /// LogIn Button API Method:
  bool isLoggingIn = false;
  APIResponse<LogInModel>? _loginResponse;

  late APIResponse<List<GetAllVehiclesFleetModel>> _getAllVehicleFleetResponse;

  loginMethod(BuildContext context) async {
    if (_key.currentState!.validate()) {
      setState(() {
        isLoggingIn = true;
      });
      Map loginData = {
        "one_signal_id": identifier.toString(),
        "user_type": widget.userType,
        // "email": emailController.text,
        // "password": passwordController.text,
        "latitude": _currentPosition!.latitude.toString(),
        "longitude": _currentPosition!.longitude.toString(),
      };
      print('map log in :  $loginData');
      _loginResponse = await service.logInAPI(loginData);
      if (_loginResponse!.status!.toLowerCase() == 'success') {
        /// call get all vehicals api to chedck:

        Map userData = {
          "users_fleet_id": _loginResponse!.data!.users_fleet_id!.toString(),
        };

        _getAllVehicleFleetResponse =
            await service.getAllVehiclesFleetApi(userData);

        if (_getAllVehicleFleetResponse.status!.toLowerCase() == 'success') {}

        await sharedPreferences.setInt(
            'userID', _loginResponse!.data!.users_fleet_id!);
        await sharedPreferences.setString(
            'userEmail', _loginResponse!.data!.email!);
        await sharedPreferences.setString(
            'userLatitude', _loginResponse!.data!.latitude!);
        await sharedPreferences.setString(
            'userLongitude', _loginResponse!.data!.longitude!);
        await sharedPreferences.setString(
            'deviceIDInfo', _loginResponse!.data!.one_signal_id!);
        await sharedPreferences.setString(
            'userType', _loginResponse!.data!.user_type!);
        await sharedPreferences.setString('isLogIn', 'true');

        if (_loginResponse!.data!.badge_verified!.toLowerCase() == 'no' &&
            _loginResponse!.data!.status!.toLowerCase() == 'active') {
          showToastSuccess(
              'LogIn successful. Your documents will be approved soon',
              FToast().init(context),
              seconds: 1);
        } else {
          showToastSuccess('LogIn successful!', FToast().init(context),
              seconds: 1);
        }

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
                  userFleetId: _loginResponse!.data!.users_fleet_id!.toString(),
                  parentID: _loginResponse!.data!.parent_id!.toString(),
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
      } else {
        print('error  ${_loginResponse!.message!}');
        print('status  ${_loginResponse!.status!}');
        showToastError(_loginResponse!.message!, FToast().init(context),
            seconds: 2);
      }
      setState(() {
        isLoggingIn = false;
      });
    }
  }

  /// Remember Me Method:

  // void _RemeberMeMethod(bool value) {
  //   rememberMe = value;
  //   SharedPreferences.getInstance().then(
  //     (prefs) {
  //       prefs.setString("rememberMe", 'false');
  //       prefs.setString('email', emailController.text);
  //       prefs.setString('password', passwordController.text);
  //     },
  //   );
  //   setState(() {
  //     rememberMe = value;
  //   });
  // }
  //
  // void getEmailAndPassword() async {
  //   try {
  //     SharedPreferences _prefs = await SharedPreferences.getInstance();
  //     var getEmail = _prefs.getString("email") ?? "";
  //     var getPassword = _prefs.getString("password") ?? "";
  //     var getRememberMe = _prefs.getString('rememberMe') ?? "";
  //     print(getRememberMe);
  //     print(getEmail);
  //     print(getPassword);
  //     if (getRememberMe != false) {
  //       setState(() {
  //         // rememberMe = true;
  //       });
  //       emailController.text = getEmail ?? "";
  //       passwordController.text = getPassword ?? "";
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
