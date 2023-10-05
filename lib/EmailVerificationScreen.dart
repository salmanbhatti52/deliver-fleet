import 'dart:async';
import 'dart:convert';

import 'package:Deliver_Rider/LogInScreen.dart';
import 'package:Deliver_Rider/RegisterScreen.dart';
import 'package:Deliver_Rider/services/API_services.dart';
import 'package:Deliver_Rider/utilities/showToast.dart';
import 'package:Deliver_Rider/widgets/apiButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Constants/Colors.dart';
import 'Constants/back-arrow-with-container.dart';
import 'Constants/buttonContainer.dart';
import 'FleetScreens/BottomNavBarFleet.dart';
import 'RiderScreens/BottomNavBar.dart';
import 'RiderScreens/VerifyDrivingLisecnseManually.dart';
import 'models/API models/API response.dart';
import 'models/API models/CheckPhoneNumberModel.dart';
import 'models/APIModelsFleet/GetAllVehiclesFleetModel.dart';

class EmailVerificationScreen extends StatefulWidget {
  final String userType;
  final String? deviceID;
  final String? phoneNumber;
  final String? latitude;
  final String? longitude;
  const EmailVerificationScreen(
      {super.key, required this.phoneNumber, required this.longitude, required this.latitude,  required this.userType, this.deviceID});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  ApiServices get service => GetIt.I<ApiServices>();

  late TextEditingController otpController;
  // late FlutterGifController gifController;

  bool isSubmitted = false;
  String userTypedOtp = '';

  final interval = const Duration(seconds: 1);

  final int timerMaxSeconds = 120;
  bool isTimerCompleted = false;
  int currentSeconds = 0;

  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

  startTimeout([int? milliseconds]) {
    var duration = interval;
    Timer.periodic(duration, (timer) {
      setState(() {
        currentSeconds = timer.tick;
        if (timer.tick >= timerMaxSeconds) {
          timer.cancel();
          setState(() {
            isTimerCompleted = true;
          });
        }
      });
    });
  }


  final FirebaseAuth auth = FirebaseAuth.instance;
  String verifyId = '';

  Future<void> verifyPhoneNumber() async {
    if (widget.phoneNumber != null) {
      print("phoneNumber: ${widget.phoneNumber!}");
    }
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '${widget.phoneNumber}',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) async {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        verifyId = verificationId;
        String smsCode = otpController.text;

        // Create a PhoneAuthCredential with the code
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: smsCode);

        // Sign the user in (or link) with the credential
        // await _auth.signInWithCredential(credential);
      },
      timeout: const Duration(seconds: 120),
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }


  CheckPhoneNumberModel checkPhoneNumberModel = CheckPhoneNumberModel();

  checkNumber() async {
    try {
      String apiUrl = "https://deliver.eigix.net/api/check_phone_exist_fleet";
      print("contactNumber: ${widget.phoneNumber}");
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Accept': 'application/json',
        },
        body: {
          "one_signal_id": widget.deviceID,
          "user_type": widget.userType,
          "phone": widget.phoneNumber,
          "latitude": widget.latitude,
          "longitude": widget.longitude,
        },
      );
      final responseString = response.body;
      print("response: $responseString");
      print("statusCode: ${response.statusCode}");
      if (response.statusCode == 200) {
        checkPhoneNumberModel = checkPhoneNumberModelFromJson(responseString);
        print("status ${checkPhoneNumberModel.status}");
        print("message ${checkPhoneNumberModel.message}");
        print('checkNumberModel status: ${checkPhoneNumberModel.status}');
        SharedPreferences sharedPref = await SharedPreferences.getInstance();
        await sharedPref.setInt('userID', checkPhoneNumberModel.data!.usersFleetId!.toInt());
        await sharedPref.setString('userEmail', checkPhoneNumberModel.data!.email.toString());
        await sharedPref.setString('userLatitude', widget.latitude.toString());
        await sharedPref.setString('userLongitude', widget.longitude.toString());
        await sharedPref.setString('deviceIDInfo', checkPhoneNumberModel.data!.oneSignalId.toString());
        await sharedPref.setString('userType', checkPhoneNumberModel.data!.userType.toString());
        await sharedPref.setString('parentID', checkPhoneNumberModel.data!.parentId.toString());
        await sharedPref.setString('isLogIn', 'true');
        print("sharedPref userId: ${checkPhoneNumberModel.data!.usersFleetId.toString()}");
        print("sharedPref email: ${checkPhoneNumberModel.data!.email}");
        print("sharedPref lat: ${widget.latitude.toString()}");
        print("sharedPref long: ${widget.longitude.toString()}");
        print("sharedPref info: ${checkPhoneNumberModel.data!.oneSignalId.toString()}");
        print("sharedPref type: ${checkPhoneNumberModel.data!.userType}");
        print("sharedPref parentId: ${checkPhoneNumberModel.data!.parentId}");
        // print("sharedPref isLogin: ${""}");
        setState(() {});
      }
    } catch (e) {
      print('Something went wrong = ${e.toString()}');
      return null;
    }
  }

  Future<void> verifyOTPCode() async {
    print("verificationId: $verifyId");
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verifyId,
      smsCode: otpController.text,
    );
    await auth.signInWithCredential(credential).then((value) async {
      print('User Login In Successful ${value.user}');
      await checkNumber();
      setState(() {
        isVerifying = true;
      });
      if (checkPhoneNumberModel.status == "success") {

        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        await sharedPreferences.setInt(
            'userID', checkPhoneNumberModel.data!.usersFleetId!.toInt());
        await sharedPreferences.setString(
            'userEmail', checkPhoneNumberModel.data!.email.toString());
        await sharedPreferences.setString(
            'userLatitude', widget.latitude.toString());
        await sharedPreferences.setString(
            'userLongitude', widget.longitude.toString());
        await sharedPreferences.setString(
            'deviceIDInfo', checkPhoneNumberModel.data!.oneSignalId.toString());
        await sharedPreferences.setString(
            'userType', checkPhoneNumberModel.data!.userType.toString());
        await sharedPreferences.setString('isLogIn', 'true');


        if(widget.userType == "Rider"){
          print("object");
          if (checkPhoneNumberModel.data!.usersFleetId!.toInt() != null) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => BottomNavBar(),
                ),
                    (Route<dynamic> route) => false);
          } else {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => RegisterScreen(userType: widget.userType, phoneNumber: widget.phoneNumber.toString(), deviceID: widget.deviceID.toString()),
                ),
                    (Route<dynamic> route) => false);
          }
        } else {
          if(widget.userType == "Fleet"){
            if (checkPhoneNumberModel.data!.usersFleetId!.toInt() != null) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => BottomNavBarFleet(),
                  ),
                      (Route<dynamic> route) => false);
            } else {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => RegisterScreen(userType: widget.userType, phoneNumber: widget.phoneNumber.toString(), deviceID: widget.deviceID.toString()),
                  ),
                      (Route<dynamic> route) => false);
            }
          }
        }
      }else if(checkPhoneNumberModel.status == "error" && checkPhoneNumberModel.message == "Your account is not approved yet.") {
        print("2");
        Navigator.pop(context);
        showToastSuccess(
            'Your account is not approved yet.',
            FToast().init(context),
            seconds: 3);
      }  else if(checkPhoneNumberModel.status == "error" && checkPhoneNumberModel.message == "Phone number does not exist.") {
        print("3");
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => RegisterScreen(userType: widget.userType, phoneNumber: widget.phoneNumber.toString(), deviceID: widget.deviceID.toString()),
            ),
                (Route<dynamic> route) => false);
      }
      setState(() {
        isVerifying = false;
      });
    });
  }

  init() {
    // gifController = FlutterGifController(vsync: this);
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    // gifController.repeat(
    //   min: 0,
    //   max: 60,
    //   period: const Duration(seconds: 2),
    // );
    // });
    if (mounted) startTimeout();
    otpController = TextEditingController();
    super.initState();
  }

  @override
  void initState() {
    super.initState();
    init();
    verifyPhoneNumber();
    print("phoneNumber: ${widget.phoneNumber}");
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    otpController.dispose();
    // gifController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var code = "";
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leadingWidth: 70,
          leading: Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 20),
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: backArrowWithContainer(context),
            ),
          ),
        ),
        body: GlowingOverscrollIndicator(
          color: orange,
          axisDirection: AxisDirection.down,
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.minHeight),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.0.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30.h,
                      ),
                      Text(
                        // 'Email Verification',
                        'Phone Verification',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.syne(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: black,
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      SvgPicture.asset('assets/images/email-number-verify.svg'),
                      SizedBox(
                        height: 50.h,
                      ),
                      Text(
                        'VERIFICATION CODE',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.syne(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: orange,
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Text(
                        'We have sent 6 digit code to\n Your Phone.',
                        // 'We have sent 4 digit code to\n Your Email.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.syne(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: grey,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      // OtpTextField(
                      //   fillColor: mildGrey,
                      //
                      //   filled: true,
                      //   keyboardType: TextInputType.number,
                      //   borderWidth: 0.0,
                      //   borderRadius: BorderRadius.circular(10.0),
                      //   fieldWidth: 50.h,
                      //
                      //   clearText: true,
                      //   inputFormatters: [
                      //     LengthLimitingTextInputFormatter(1),
                      //     FilteringTextInputFormatter.digitsOnly,
                      //   ],
                      //   textStyle: GoogleFonts.inter(
                      //     color: black,
                      //     fontSize: 13,
                      //     fontWeight: FontWeight.w300,
                      //   ),
                      //   decoration: InputDecoration(
                      //     fillColor: mildGrey,
                      //     filled: true,
                      //     counterText: '',
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(
                      //         10,
                      //       ),
                      //       // borderSide: BorderSide(
                      //       //   color: Colors.transparent,
                      //       // ),
                      //     ),
                      //     focusedBorder: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(
                      //         10,
                      //       ),
                      //       borderSide: const BorderSide(
                      //         color: mildGrey,
                      //       ),
                      //     ),
                      //     focusColor: mildGrey,
                      //     hintText: '0',
                      //     hintStyle: GoogleFonts.inter(
                      //       color: black,
                      //       fontSize: 13,
                      //       fontWeight: FontWeight.w300,
                      //     ),
                      //   ),
                      //   numberOfFields: 6,
                      //   borderColor: mildGrey,
                      //   showCursor: false,
                      //   showFieldAsBox: true,
                      //
                      //   hasCustomInputDecoration: true,
                      //   onCodeChanged: (String code) {
                      //     setState(() {
                      //       isSubmitted = false;
                      //       userTypedOtp = '';
                      //     });
                      //   },
                      //   onSubmit: (String verificationCode) {
                      //     setState(() {
                      //       isSubmitted = true;
                      //       userTypedOtp = verificationCode;
                      //     });
                      //   }, // end onSubmit
                      // ),
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        child: Pinput(
                          length: 6,
                          controller: otpController,
                          keyboardType: TextInputType.number,
                          defaultPinTheme: PinTheme(
                            width: 60,
                            height: 48,
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Inter-Regular',
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xffF2F0EE),
                            ),
                          ),
                          focusedPinTheme: PinTheme(
                            width: 60,
                            height: 48,
                            textStyle: TextStyle(
                              color: black,
                              fontSize: 14,
                              fontFamily: 'Inter-Regular',
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xffF2F0EE),
                              border: Border.all(
                                color: orange,
                              ),
                            ),
                          ),
                          submittedPinTheme: PinTheme(
                            width: 60,
                            height: 48,
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Inter-Regular',
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xffF2F0EE),
                              border: Border.all(
                                color: orange,
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            code = value;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50.0.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 89.w,
                              height: 20.h,
                              child: Text(
                                'OTP valid for',
                                style: GoogleFonts.syne(
                                  fontSize: 14,
                                  color: black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                isTimerCompleted
                                    ? SvgPicture.asset(
                                        'assets/images/timer-icon.svg',
                                        colorFilter: const ColorFilter.mode(
                                            grey, BlendMode.srcIn),
                                      )
                                    : SvgPicture.asset(
                                        'assets/images/timer-icon.svg',
                                        // colorFilter:
                                        // ColorFilter.mode(grey, BlendMode.srcIn),
                                      ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  isTimerCompleted ? '00:00' : timerText,
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      resending
                          ? const CircularProgressIndicator(
                              color: orange,
                            )
                          : RichText(
                              text: TextSpan(
                                text: 'Did\'nt received code?    ',
                                style: GoogleFonts.syne(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: grey,
                                ),
                                children: [
                                  TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        resendCode(context);
                                      },
                                    text: 'RESEND CODE',
                                    style: GoogleFonts.syne(
                                      decoration: TextDecoration.underline,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: isTimerCompleted ? orange : grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      SizedBox(
                        height: 80.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20.0.h),
                        child: GestureDetector(
                          onTap: (){
                            verifyOTPCode();
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (context) => RegisterScreen(
                            //       email: widget.email,
                                  // userType: widget.userType,
                                  // deviceID: widget.deviceID ?? '',
                                // ),
                              // ),
                            // );
                          },
                          // => isVerifying
                          //     ? apiButton(context)
                          //     : verifyOTPmethod(context),
                          child: buttonContainer(context, 'VERIFY'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  APIResponse<APIResponse>? otpResponse;
  bool isVerifying = false;
  // verifyOTPmethod(BuildContext context) async {
  //   if (isSubmitted == false && userTypedOtp == '') {
  //     showToastError('enter OTP to proceed', FToast().init(context));
  //   } else {
  //     setState(() {
  //       isVerifying = true;
  //     });
  //     Map otpData = {
  //       "email": widget.email,
  //       "otp": userTypedOtp.toString(),
  //     };
  //     otpResponse = await service.verifyOtpApi(otpData);
  //     if (otpResponse!.status!.toLowerCase() == 'success') {
  //       showToastSuccess('OTP successfully entered', FToast().init(context));
  //       showDialog(
  //         context: context,
  //         builder: (context) => Dialog(
  //           backgroundColor: white,
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(20),
  //           ),
  //           alignment: Alignment.center,
  //           insetPadding: const EdgeInsets.symmetric(
  //             horizontal: 20,
  //           ),
  //           child: Container(
  //             padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
  //             width: 350.w,
  //             height: 442.h,
  //             child: Column(
  //               // crossAxisAlignment: CrossAxisAlignment.end,
  //               children: [
  //                 Align(
  //                   alignment: Alignment.topRight,
  //                   child: GestureDetector(
  //                     onTap: () => Navigator.of(context).pop(),
  //                     child: SvgPicture.asset('assets/images/close-circle.svg'),
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   width: 186.w,
  //                   height: 186.h,
  //                   child: GifImage(
  //                     fit: BoxFit.scaleDown,
  //                     controller: gifController,
  //                     image: const AssetImage(
  //                       "assets/images/email-verify-done.gif",
  //                     ),
  //                   ),
  //                 ),
  //                 Text(
  //                   'Congratulations',
  //                   style: GoogleFonts.syne(
  //                     fontSize: 20,
  //                     fontWeight: FontWeight.w700,
  //                     color: orange,
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   height: 20.h,
  //                 ),
  //                 Text(
  //                   'You have successfully verify\n the Email Address',
  //                   textAlign: TextAlign.center,
  //                   style: GoogleFonts.syne(
  //                     fontSize: 18,
  //                     fontWeight: FontWeight.w400,
  //                     color: black,
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   height: 20.h,
  //                 ),
  //                 Expanded(
  //                   child: GestureDetector(
  //                     onTap: () {
  //                       Navigator.of(context).push(
  //                         MaterialPageRoute(
  //                           builder: (context) => widget.userType == 'Rider'
  //                               ? VerifyDrivingLicenseManually(
  //                                   email: widget.email,
  //                                   userType: widget.userType,
  //                                 )
  //                               : LogInScreen(
  //                                   userType: widget.userType,
  //                                   deviceID: widget.deviceID,
  //                                 ),
  //                         ),
  //                       );
  //                     },
  //                     child: buttonContainer(context, 'OK'),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       );
  //     } else {
  //       showToastError(otpResponse!.message, FToast().init(context));
  //     }
  //     setState(() {
  //       isVerifying = false;
  //     });
  //   }
  // }

  /// resend OTP API:
  bool resending = false;
  APIResponse<APIResponse>? _resendOTPResponse;
  resendCode(BuildContext context) async {
    setState(() {
      resending = true;
    });
    Map oTPData = {
      "email": widget.phoneNumber,
    };
    _resendOTPResponse = await service.verifyEmailAPI(oTPData);
    if (_resendOTPResponse!.status!.toLowerCase() == 'success') {
      showToastSuccess('OTP sent. Please verify again', FToast().init(context));
      // if (_resendOTPResponse!.data != null) {
      //   setState(() {
      //     widget.otp = _resendOTPResponse!.data!.otp!.toString();
      //   });
      // }
      if (mounted) {
        setState(() {
          isTimerCompleted = false;
        });
        startTimeout();
      }
    } else {
      showToastError(_resendOTPResponse!.message, FToast().init(context));
    }
    setState(() {
      resending = false;
    });
  }
}
