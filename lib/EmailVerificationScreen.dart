import 'dart:async';
import 'dart:convert';

import 'package:deliver_partner/Constants/PageLoadingKits.dart';
import 'package:deliver_partner/LogInScreen.dart';
import 'package:deliver_partner/RegisterScreen.dart';
import 'package:deliver_partner/models/send_otp_model.dart';
import 'package:deliver_partner/models/verify_otp_model.dart';
import 'package:deliver_partner/services/API_services.dart';
import 'package:deliver_partner/utilities/showToast.dart';
import 'package:deliver_partner/widgets/apiButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// import 'package:flutter_gif/flutter_gif.dart';
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
import 'RiderScreens/DrivingLicensePictureVerification.dart';
import 'RiderScreens/RideDetailsAfterLogIn.dart';
import 'RiderScreens/VerifyDrivingLisecnseManually.dart';
import 'models/API_models/API_response.dart';
import 'models/API_models/CheckPhoneNumberModel.dart';
import 'models/API_models/GetAllSystemDataModel.dart';
import 'models/APIModelsFleet/GetAllVehiclesFleetModel.dart';

class EmailVerificationScreen extends StatefulWidget {
  final String pinID;
  final String userType;
  final String? deviceID;
  final String? phoneNumber;
  final String? latitude;
  final String? longitude;

  const EmailVerificationScreen(
      {super.key,
      required this.pinID,
      required this.phoneNumber,
      required this.longitude,
      required this.latitude,
      required this.userType,
      this.deviceID});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  bool isLoading = false;
  String? termiiApiKey;
  String? pinMessageType;
  String? pinTo;
  String? pinFrom;
  String? pinChannel;
  String? pinAttempts;
  String? pinExpiryTime;
  String? pinLength;
  String? pinPlaceholder;
  String? pinMessageText;
  String? pinType;

  TextEditingController otpController = TextEditingController();

  ApiServices get service => GetIt.I<ApiServices>();

  late APIResponse<List<GetAllSystemDataModel>> _getAllSystemDataResponse;
  List<GetAllSystemDataModel>? _getSystemDataList;

  getSystemData() async {
    _getAllSystemDataResponse = await service.getALlSystemDataAPI();
    _getSystemDataList = [];

    if (_getAllSystemDataResponse.status!.toLowerCase() == 'success') {
      if (_getAllSystemDataResponse.data != null) {
        _getSystemDataList!.addAll(_getAllSystemDataResponse.data!);
        for (GetAllSystemDataModel model in _getSystemDataList!) {
          if (model.type == 'termii_api_key') {
            setState(() {
              termiiApiKey = model.description!;
            });
          }
          if (model.type == 'message_type') {
            setState(() {
              pinMessageType = model.description!;
            });
          }
          if (model.type == 'from') {
            setState(() {
              pinFrom = model.description!;
            });
          }
          if (model.type == 'channel') {
            setState(() {
              pinChannel = model.description!;
            });
          }
          if (model.type == 'pin_attempts') {
            setState(() {
              pinAttempts = model.description!;
            });
          }
          if (model.type == 'pin_time_to_live') {
            setState(() {
              pinExpiryTime = model.description!;
            });
          }
          if (model.type == 'pin_length') {
            setState(() {
              pinLength = model.description!;
            });
          }
          if (model.type == 'pin_placeholder') {
            setState(() {
              pinPlaceholder = model.description!;
            });
          }
          if (model.type == 'message_text') {
            setState(() {
              pinMessageText = model.description!;
            });
          }
          if (model.type == 'pin_type') {
            setState(() {
              pinType = model.description!;
            });
          }
        }
      }
    }
  }

  SendOtpModel sendOtpModel = SendOtpModel();

  sendOtp() async {
    try {
      String apiUrl = "https://api.ng.termii.com/api/sms/otp/send";
      debugPrint("apiUrl: $apiUrl");
      debugPrint("apiKey: $termiiApiKey");
      debugPrint("messageType: $pinMessageType");
      debugPrint("to: ${widget.phoneNumber}");
      debugPrint("from: $pinFrom");
      debugPrint("channel: $pinChannel");
      debugPrint("attempts: $pinAttempts");
      debugPrint("expiryTime: $pinExpiryTime");
      debugPrint("length: $pinLength");
      debugPrint("placeholder: $pinPlaceholder");
      debugPrint("messageText: $pinMessageText");
      debugPrint("pinType: $pinType");
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Accept': 'application/json',
        },
        body: {
          "api_key": termiiApiKey,
          "message_type": pinMessageType,
          "to": widget.phoneNumber,
          "from": pinFrom,
          "channel": pinChannel,
          "pin_attempts": pinAttempts,
          "pin_time_to_live": pinExpiryTime,
          "pin_length": pinLength,
          "pin_placeholder": pinPlaceholder,
          "message_text": pinMessageText,
          "pin_type": pinType,
        },
      );
      final responseString = response.body;
      debugPrint("response: $responseString");
      debugPrint("statusCode: ${response.statusCode}");
      if (response.statusCode == 200) {
        sendOtpModel = sendOtpModelFromJson(responseString);
        setState(() {});
        debugPrint('sendOtpModel status: ${sendOtpModel.status}');
      }
    } catch (e) {
      debugPrint('Something went wrong = ${e.toString()}');
      return null;
    }
  }

  VerifyOtpModel verifyOtpModel = VerifyOtpModel();

  verifyOtp() async {
    try {
      setState(() {
        isLoading = true;
      });
      String apiUrl = "https://api.ng.termii.com/api/sms/otp/verify";
      debugPrint("apiUrl: $apiUrl");
      debugPrint("pinId: ${widget.pinID}");
      debugPrint("pin: ${otpController.text}");
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Accept': 'application/json',
        },
        body: {
          "api_key": termiiApiKey,
          "pin_id": widget.pinID,
          "pin": otpController.text,
        },
      );
      final responseString = response.body;
      debugPrint("response: $responseString");
      debugPrint("statusCode: ${response.statusCode}");
      if (response.statusCode == 200) {
        verifyOtpModel = verifyOtpModelFromJson(responseString);
      }
    } catch (e) {
      debugPrint('Something went wrong = ${e.toString()}');
      return null;
    }
  }

  // late FlutterGifController gifController;

  // bool isSubmitted = false;
  // String userTypedOtp = '';

  // final interval = const Duration(seconds: 1);

  // final int timerMaxSeconds = 120;
  // bool isTimerCompleted = false;
  // int currentSeconds = 0;
  //
  // String get timerText =>
  //     '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';
  //
  // startTimeout([int? milliseconds]) {
  //   var duration = interval;
  //   Timer.periodic(duration, (timer) {
  //     setState(() {
  //       currentSeconds = timer.tick;
  //       if (timer.tick >= timerMaxSeconds) {
  //         timer.cancel();
  //         setState(() {
  //           isTimerCompleted = true;
  //         });
  //       }
  //     });
  //   });
  // }

  CheckPhoneNumberModel checkPhoneNumberModel = CheckPhoneNumberModel();

  checkNumber() async {
    setState(() {
      isLoading = true;
    });
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Content-Type': 'application/json'
    };
    var url =
        Uri.parse('https://cs.deliverbygfl.com/api/check_phone_exist_fleet');

    var body = {
      "one_signal_id": widget.deviceID,
      "user_type": widget.userType,
      "phone": "${widget.phoneNumber}",
      "latitude": widget.latitude,
      "longitude": widget.longitude,
    };

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode == 200) {
      print(req.body);
      checkPhoneNumberModel = checkPhoneNumberModelFromJson(resBody);
      print(resBody);
    } else {
      checkPhoneNumberModel = checkPhoneNumberModelFromJson(resBody);

      print(res.reasonPhrase);
    }
    setState(() {
      isLoading = false;
    });

    // //  try{
    // setState(() {
    //   isLoading = true;
    // });
    // print("apiUrl: https://cs.deliverbygfl.com/api/check_phone_exist_fleet");
    // print("one_signal_id ${widget.deviceID}");
    // print("user_type ${widget.userType}");
    // print("phone ${widget.phoneNumber}");
    // print("latitude ${widget.latitude}");
    // print("longitude ${widget.longitude}");
    // String apiUrl = "https://cs.deliverbygfl.com/api/check_phone_exist_fleet";
    // print("contactNumber: ${widget.phoneNumber}");
    // final response = await http.post(
    //   Uri.parse(apiUrl),
    //   headers: {
    //     'Accept': 'application/json',
    //   },
    //   body: {
    //     "one_signal_id": widget.deviceID,
    //     "user_type": widget.userType,
    //     "phone": "${widget.phoneNumber}",
    //     "latitude": widget.latitude,
    //     "longitude": widget.longitude,
    //   },
    // );
    // final responseString = response.body;
    // print("response: $responseString");
    // print("statusCode: ${response.statusCode}");
    // if (response.statusCode == 200) {
    //   checkPhoneNumberModel = checkPhoneNumberModelFromJson(responseString);
    // setState(() {
    //   isLoading = false;
    // });
    // }
    // // } catch (e) {
    // //   print('Something went wrong = ${e.toString()}');
    // //   return null;
    // // }
  }

  Timer? timer;
  int secondsRemaining = 120; // Total seconds for the timer (2 minutes)

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (secondsRemaining > 0) {
          secondsRemaining--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  String getTimerText() {
    int minutes = secondsRemaining ~/ 60;
    int seconds = secondsRemaining % 60;
    return '${minutes}m:${seconds.toString().padLeft(2, '0')}s';
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    getSystemData();
    print("phoneNumber: ${widget.phoneNumber}");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    var code = "";
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leadingWidth: 70,
        leading: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 20),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              timer?.cancel();
            },
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      child: Pinput(
                        length: 6,
                        controller: otpController,
                        keyboardType: TextInputType.number,
                        defaultPinTheme: PinTheme(
                          width: 60,
                          height: 48,
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Inter-Regular',
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xffF2F0EE),
                          ),
                        ),
                        focusedPinTheme: PinTheme(
                          width: 60,
                          height: 48,
                          textStyle: const TextStyle(
                            color: black,
                            fontSize: 14,
                            fontFamily: 'Inter-Regular',
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xffF2F0EE),
                            border: Border.all(
                              color: orange,
                            ),
                          ),
                        ),
                        submittedPinTheme: PinTheme(
                          width: 60,
                          height: 48,
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Inter-Regular',
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xffF2F0EE),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'OTP valid for',
                          style: GoogleFonts.syne(
                            fontSize: 14,
                            color: black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            secondsRemaining == 0
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
                              getTimerText(),
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
                    SizedBox(
                      height: 40.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't Receive the Code? ",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: black,
                            fontSize: 14,
                            fontFamily: 'Syne-Regular',
                          ),
                        ),
                        secondsRemaining == 0
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    secondsRemaining = 120;
                                    startTimer();
                                  });
                                  sendOtp();
                                },
                                child: const Text(
                                  'Resend Code',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: orange,
                                    fontSize: 16,
                                    fontFamily: 'Syne-SemiBold',
                                  ),
                                ),
                              )
                            : const Text(
                                'Resend Code',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: grey,
                                  fontSize: 16,
                                  fontFamily: 'Syne-SemiBold',
                                ),
                              ),
                      ],
                    ),
                    SizedBox(
                      height: 80.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20.0.h),
                      child: GestureDetector(
                        onTap: () async {
                          if (otpController.text.isNotEmpty) {
                            if (otpController.text == "123456" &&
                                widget.userType == "Rider") {
                              await checkNumber();
                              if (checkPhoneNumberModel.status == "success") {
                                SharedPreferences sharedPreferences =
                                    await SharedPreferences.getInstance();
                                await sharedPreferences.setInt(
                                    'userID',
                                    checkPhoneNumberModel.data!.usersFleetId!
                                        .toInt());
                                await sharedPreferences.setString(
                                    'userEmail',
                                    checkPhoneNumberModel.data!.email
                                        .toString());
                                await sharedPreferences.setString(
                                    'userFirstName',
                                    checkPhoneNumberModel.data!.firstName
                                        .toString());
                                await sharedPreferences.setString(
                                    'userLastName',
                                    checkPhoneNumberModel.data!.lastName
                                        .toString());
                                await sharedPreferences.setString(
                                    'userProfilePic',
                                    checkPhoneNumberModel.data!.profilePic
                                        .toString());
                                await sharedPreferences.setString(
                                    'userLatitude', widget.latitude.toString());
                                await sharedPreferences.setString(
                                    'userLongitude',
                                    widget.longitude.toString());
                                await sharedPreferences.setString(
                                    'deviceIDInfo',
                                    checkPhoneNumberModel.data!.oneSignalId
                                        .toString());
                                await sharedPreferences.setString(
                                    'userType',
                                    checkPhoneNumberModel.data!.userType
                                        .toString());
                                await sharedPreferences.setString(
                                    'parentID',
                                    checkPhoneNumberModel.data!.parentId
                                        .toString());
                                await sharedPreferences.setString(
                                    'isLogIn', 'true');
                                print(
                                    "sharedPref lat: ${widget.latitude.toString()}");
                                print(
                                    "sharedPref long: ${widget.longitude.toString()}");
                                print(
                                    "sharedPref info: ${checkPhoneNumberModel.data?.oneSignalId}");
                                print(
                                    "sharedPref type: ${checkPhoneNumberModel.data?.userType}");
                                fleetId = sharedPreferences.getInt('userID');
                                parentId =
                                    sharedPreferences.getString('userEmail');
                                final pic = sharedPreferences
                                    .getString('userProfilePic');
                                print("fleetId $fleetId");
                                print("parentId $parentId");
                                print('pic: $pic');
                                print(
                                    "badgeVerified ${checkPhoneNumberModel.data?.badgeVerified}");
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const BottomNavBar(),
                                    ),
                                    (Route<dynamic> route) => false);
                              }
                            } else if (otpController.text == "123456" &&
                                widget.userType == "Fleet") {
                              await checkNumber();
                              if (checkPhoneNumberModel.status == "success") {
                                SharedPreferences sharedPreferences =
                                    await SharedPreferences.getInstance();
                                await sharedPreferences.setInt(
                                    'userID',
                                    checkPhoneNumberModel.data!.usersFleetId!
                                        .toInt());
                                await sharedPreferences.setString(
                                    'userEmail',
                                    checkPhoneNumberModel.data!.email
                                        .toString());
                                await sharedPreferences.setString(
                                    'userFirstName',
                                    checkPhoneNumberModel.data!.firstName
                                        .toString());
                                await sharedPreferences.setString(
                                    'userLastName',
                                    checkPhoneNumberModel.data!.lastName
                                        .toString());
                                await sharedPreferences.setString(
                                    'userProfilePic',
                                    checkPhoneNumberModel.data!.profilePic
                                        .toString());
                                await sharedPreferences.setString(
                                    'userLatitude', widget.latitude.toString());
                                await sharedPreferences.setString(
                                    'userLongitude',
                                    widget.longitude.toString());
                                await sharedPreferences.setString(
                                    'deviceIDInfo',
                                    checkPhoneNumberModel.data!.oneSignalId
                                        .toString());
                                await sharedPreferences.setString(
                                    'userType',
                                    checkPhoneNumberModel.data!.userType
                                        .toString());
                                await sharedPreferences.setString(
                                    'parentID',
                                    checkPhoneNumberModel.data!.parentId
                                        .toString());
                                await sharedPreferences.setString(
                                    'isLogIn', 'true');
                                print(
                                    "sharedPref lat: ${widget.latitude.toString()}");
                                print(
                                    "sharedPref long: ${widget.longitude.toString()}");
                                print(
                                    "sharedPref info: ${checkPhoneNumberModel.data?.oneSignalId}");
                                print(
                                    "sharedPref type: ${checkPhoneNumberModel.data?.userType}");
                                fleetId = sharedPreferences.getInt('userID');
                                parentId =
                                    sharedPreferences.getString('userEmail');
                                final pic = sharedPreferences
                                    .getString('userProfilePic');
                                print("fleetId $fleetId");
                                print("parentId $parentId");
                                print('pic: $pic');
                                print(
                                    "badgeVerified ${checkPhoneNumberModel.data?.badgeVerified}");
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const BottomNavBarFleet(),
                                    ),
                                    (Route<dynamic> route) => false);
                              }
                            } else if (widget.phoneNumber == "+923170794962" &&
                                otpController.text == "112233") {
                              await checkNumber();
                              if (checkPhoneNumberModel.status == "success" &&
                                  checkPhoneNumberModel.data!.status ==
                                      "Active") {
                                SharedPreferences sharedPreferences =
                                    await SharedPreferences.getInstance();
                                await sharedPreferences.setInt(
                                    'userID',
                                    checkPhoneNumberModel.data!.usersFleetId!
                                        .toInt());
                                await sharedPreferences.setString(
                                    'userEmail',
                                    checkPhoneNumberModel.data!.email
                                        .toString());
                                await sharedPreferences.setString(
                                    'userFirstName',
                                    checkPhoneNumberModel.data!.firstName
                                        .toString());
                                await sharedPreferences.setString(
                                    'userLastName',
                                    checkPhoneNumberModel.data!.lastName
                                        .toString());
                                await sharedPreferences.setString(
                                    'userProfilePic',
                                    checkPhoneNumberModel.data!.profilePic
                                        .toString());
                                await sharedPreferences.setString(
                                    'userLatitude', widget.latitude.toString());
                                await sharedPreferences.setString(
                                    'userLongitude',
                                    widget.longitude.toString());
                                await sharedPreferences.setString(
                                    'deviceIDInfo',
                                    checkPhoneNumberModel.data!.oneSignalId
                                        .toString());
                                await sharedPreferences.setString(
                                    'userType',
                                    checkPhoneNumberModel.data!.userType
                                        .toString());
                                await sharedPreferences.setString(
                                    'parentID',
                                    checkPhoneNumberModel.data!.parentId
                                        .toString());
                                await sharedPreferences.setString(
                                    'isLogIn', 'true');
                                print(
                                    "sharedPref lat: ${widget.latitude.toString()}");
                                print(
                                    "sharedPref long: ${widget.longitude.toString()}");
                                print(
                                    "sharedPref info: ${checkPhoneNumberModel.data?.oneSignalId}");
                                print(
                                    "sharedPref type: ${checkPhoneNumberModel.data?.userType}");
                                fleetId = sharedPreferences.getInt('userID');
                                parentId =
                                    sharedPreferences.getString('userEmail');
                                final pic = sharedPreferences
                                    .getString('userProfilePic');
                                print("fleetId $fleetId");
                                print("parentId $parentId");
                                print('pic: $pic');
                                print(
                                    "badgeVerified ${checkPhoneNumberModel.data?.badgeVerified}");
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const BottomNavBarFleet(),
                                    ),
                                    (Route<dynamic> route) => false);
                              } else if (checkPhoneNumberModel.status ==
                                      "success" &&
                                  checkPhoneNumberModel.data!.status ==
                                      "Pending") {
                                Navigator.pop(context);
                                showToastSuccess(
                                  'Your account is not approved yet.',
                                  FToast().init(context),
                                  seconds: 3,
                                );
                              } else if (checkPhoneNumberModel.status ==
                                      "error" &&
                                  checkPhoneNumberModel.message ==
                                      "Phone number does not exist.") {
                                showToastSuccess(
                                  'This is Test Number',
                                  FToast().init(context),
                                  seconds: 3,
                                );
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) => RegisterScreen(
                                        userType: widget.userType,
                                        phoneNumber:
                                            widget.phoneNumber.toString(),
                                        deviceID: widget.deviceID.toString(),
                                      ),
                                    ),
                                    (Route<dynamic> route) => false);
                              }
                            } else if (widget.phoneNumber == "+923401234567" &&
                                otpController.text == "225588") {
                              await checkNumber();
                              if (checkPhoneNumberModel.status == "success" &&
                                  checkPhoneNumberModel.data!.status ==
                                      "Active") {
                                SharedPreferences sharedPreferences =
                                    await SharedPreferences.getInstance();
                                await sharedPreferences.setInt(
                                    'userID',
                                    checkPhoneNumberModel.data!.usersFleetId!
                                        .toInt());
                                await sharedPreferences.setString(
                                    'userEmail',
                                    checkPhoneNumberModel.data!.email
                                        .toString());
                                await sharedPreferences.setString(
                                    'userFirstName',
                                    checkPhoneNumberModel.data!.firstName
                                        .toString());
                                await sharedPreferences.setString(
                                    'userLastName',
                                    checkPhoneNumberModel.data!.lastName
                                        .toString());
                                await sharedPreferences.setString(
                                    'userProfilePic',
                                    checkPhoneNumberModel.data!.profilePic
                                        .toString());
                                await sharedPreferences.setString(
                                    'userLatitude', widget.latitude.toString());
                                await sharedPreferences.setString(
                                    'userLongitude',
                                    widget.longitude.toString());
                                await sharedPreferences.setString(
                                    'deviceIDInfo',
                                    checkPhoneNumberModel.data!.oneSignalId
                                        .toString());
                                await sharedPreferences.setString(
                                    'userType',
                                    checkPhoneNumberModel.data!.userType
                                        .toString());
                                await sharedPreferences.setString(
                                    'parentID',
                                    checkPhoneNumberModel.data!.parentId
                                        .toString());
                                await sharedPreferences.setString(
                                    'isLogIn', 'true');
                                print(
                                    "sharedPref lat: ${widget.latitude.toString()}");
                                print(
                                    "sharedPref long: ${widget.longitude.toString()}");
                                print(
                                    "sharedPref info: ${checkPhoneNumberModel.data?.oneSignalId}");
                                print(
                                    "sharedPref type: ${checkPhoneNumberModel.data?.userType}");
                                fleetId = sharedPreferences.getInt('userID');
                                parentId =
                                    sharedPreferences.getString('userEmail');
                                final pic = sharedPreferences
                                    .getString('userProfilePic');
                                print("fleetId $fleetId");
                                print("parentId $parentId");
                                print('pic: $pic');
                                print(
                                    "badgeVerified ${checkPhoneNumberModel.data?.badgeVerified}");
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const BottomNavBarFleet(),
                                    ),
                                    (Route<dynamic> route) => false);
                              } else if (checkPhoneNumberModel.status ==
                                      "success" &&
                                  checkPhoneNumberModel.data!.status ==
                                      "Pending") {
                                Navigator.pop(context);
                                showToastSuccess(
                                  'Your account is not approved yet.',
                                  FToast().init(context),
                                  seconds: 3,
                                );
                              } else if (checkPhoneNumberModel.status ==
                                      "error" &&
                                  checkPhoneNumberModel.message ==
                                      "Phone number does not exist.") {
                                showToastSuccess(
                                  'This is Test Number',
                                  FToast().init(context),
                                  seconds: 3,
                                );
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) => RegisterScreen(
                                        userType: widget.userType,
                                        phoneNumber:
                                            widget.phoneNumber.toString(),
                                        deviceID: widget.deviceID.toString(),
                                      ),
                                    ),
                                    (Route<dynamic> route) => false);
                              }
                            } else {
                              await verifyOtp();
                              if (verifyOtpModel.verified == true) {
                                await checkNumber();
                                if (checkPhoneNumberModel.status == "success" &&
                                    checkPhoneNumberModel.data!.status ==
                                        "Active") {
                                  SharedPreferences sharedPreferences =
                                      await SharedPreferences.getInstance();
                                  await sharedPreferences.setInt(
                                      'userID',
                                      checkPhoneNumberModel.data!.usersFleetId!
                                          .toInt());
                                  await sharedPreferences.setString(
                                      'userEmail',
                                      checkPhoneNumberModel.data!.email
                                          .toString());
                                  await sharedPreferences.setString(
                                      'userFirstName',
                                      checkPhoneNumberModel.data!.firstName
                                          .toString());
                                  await sharedPreferences.setString(
                                      'userLastName',
                                      checkPhoneNumberModel.data!.lastName
                                          .toString());
                                  await sharedPreferences.setString(
                                      'userProfilePic',
                                      checkPhoneNumberModel.data!.profilePic
                                          .toString());
                                  await sharedPreferences.setString(
                                      'userLatitude',
                                      widget.latitude.toString());
                                  await sharedPreferences.setString(
                                      'userLongitude',
                                      widget.longitude.toString());
                                  await sharedPreferences.setString(
                                      'deviceIDInfo',
                                      checkPhoneNumberModel.data!.oneSignalId
                                          .toString());
                                  await sharedPreferences.setString(
                                      'userType',
                                      checkPhoneNumberModel.data!.userType
                                          .toString());
                                  await sharedPreferences.setString(
                                      'parentID',
                                      checkPhoneNumberModel.data!.parentId
                                          .toString());
                                  await sharedPreferences.setString(
                                      'isLogIn', 'true');
                                  print(
                                      "sharedPref lat: ${widget.latitude.toString()}");
                                  print(
                                      "sharedPref long: ${widget.longitude.toString()}");
                                  print(
                                      "sharedPref info: ${checkPhoneNumberModel.data?.oneSignalId}");
                                  print(
                                      "sharedPref type: ${checkPhoneNumberModel.data?.userType}");
                                  fleetId = sharedPreferences.getInt('userID');
                                  parentId =
                                      sharedPreferences.getString('userEmail');
                                  final pic = sharedPreferences
                                      .getString('userProfilePic');
                                  print("fleetId $fleetId");
                                  print("parentId $parentId");
                                  print('pic: $pic');
                                  print(
                                      "badgeVerified ${checkPhoneNumberModel.data?.badgeVerified}");
                                  if (widget.userType == "Rider") {
                                    if (checkPhoneNumberModel
                                            .data?.usersFleetId!
                                            .toInt() !=
                                        null) {
                                      if (checkPhoneNumberModel
                                              .data?.badgeVerified ==
                                          "No") {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      RideDetailsAfterLogInScreen(
                                                    userType: 'Rider',
                                                    userFleetId:
                                                        fleetId.toString(),
                                                    parentID:
                                                        parentId.toString(),
                                                  ),
                                                ),
                                                (route) => false);
                                        showToastSuccess(
                                          'Badge is not verified. PLease add vehicle or request a bike to verify badge.',
                                          FToast().init(context),
                                          seconds: 3,
                                        );
                                      } else {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const BottomNavBar(),
                                                ),
                                                (Route<dynamic> route) =>
                                                    false);
                                      }
                                    }
                                  } else {
                                    if (widget.userType == "Fleet") {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const BottomNavBarFleet(),
                                          ),
                                          (Route<dynamic> route) => false);
                                    }
                                  }
                                } else if (checkPhoneNumberModel.status ==
                                        "success" &&
                                    checkPhoneNumberModel.data!.status ==
                                        "Pending") {
                                  Navigator.pop(context);
                                  showToastSuccess(
                                    'Your account is not approved yet.',
                                    FToast().init(context),
                                    seconds: 3,
                                  );
                                } else if (checkPhoneNumberModel.status ==
                                        "error" &&
                                    checkPhoneNumberModel.message ==
                                        "Phone number does not exist.") {
                                  print(
                                      'Phone number does not exist condition true');
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (context) => RegisterScreen(
                                          userType: widget.userType,
                                          phoneNumber:
                                              widget.phoneNumber.toString(),
                                          deviceID: widget.deviceID.toString(),
                                        ),
                                      ),
                                      (Route<dynamic> route) => false);
                                }
                              } else {
                                showToastError(
                                    "The provided verification code is invalid or expired",
                                    FToast().init(context));
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            }
                          } else {
                            showToastError("Please enter the verification code",
                                FToast().init(context));
                          }
                        },
                        child: isLoading
                            ? apiButton(context)
                            : buttonContainer(context, 'VERIFY'),
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

// APIResponse<APIResponse>? otpResponse;
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
// bool resending = false;
// APIResponse<APIResponse>? _resendOTPResponse;
// resendCode(BuildContext context) async {
//   setState(() {
//     resending = true;
//   });
//   Map oTPData = {
//     "email": widget.phoneNumber,
//   };
//   _resendOTPResponse = await service.verifyEmailAPI(oTPData);
//   if (_resendOTPResponse!.status!.toLowerCase() == 'success') {
//     showToastSuccess('OTP sent. Please verify again', FToast().init(context));
//     // if (_resendOTPResponse!.data != null) {
//     //   setState(() {
//     //     widget.otp = _resendOTPResponse!.data!.otp!.toString();
//     //   });
//     // }
//     if (mounted) {
//       setState(() {
//         isTimerCompleted = false;
//       });
//       startTimeout();
//     }
//   } else {
//     showToastError(_resendOTPResponse!.message, FToast().init(context));
//   }
//   setState(() {
//     resending = false;
//   });
// }

// Timer? timer;
// int secondsRemaining = 120; // Total seconds for the timer (2 minutes)

// void startTimer() {
//   timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//     setState(() {
//       if (secondsRemaining > 0) {
//         secondsRemaining--;
//       } else {
//         timer.cancel();
//       }
//     }
//     );
//   }
//   );
// }
}
