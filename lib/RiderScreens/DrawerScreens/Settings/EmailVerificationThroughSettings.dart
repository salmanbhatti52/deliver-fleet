import 'dart:async';

import 'package:deliver_partner/LogInScreen.dart';
import 'package:deliver_partner/widgets/apiButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Constants/Colors.dart';
import '../../../Constants/back-arrow-with-container.dart';
import '../../../Constants/buttonContainer.dart';
import '../../../models/API models/API response.dart';
import '../../../services/API_services.dart';
import '../../../utilities/showToast.dart';

class EmailVerificationThroughSettings extends StatefulWidget {
  final String email;

  const EmailVerificationThroughSettings({super.key, required this.email});

  @override
  State<EmailVerificationThroughSettings> createState() =>
      _EmailVerificationThroughSettingsState();
}

class _EmailVerificationThroughSettingsState
    extends State<EmailVerificationThroughSettings>
    with TickerProviderStateMixin {
  late TextEditingController otpController;
  late FlutterGifController gifController;

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

  @override
  void initState() {
    super.initState();
    init();
  }

  init() {
    gifController = FlutterGifController(vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      gifController.repeat(
        min: 0,
        max: 60,
        period: const Duration(seconds: 2),
      );
    });
    if (mounted) startTimeout();
    otpController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    otpController.dispose();
    gifController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
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
                      'Email Verification',
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
                      'We have sent 4 digit code to\n Your Email.',
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
                    OtpTextField(
                      fillColor: mildGrey,
                      filled: true,
                      keyboardType: TextInputType.number,
                      borderWidth: 0.0,
                      borderRadius: BorderRadius.circular(10.0),
                      fieldWidth: 50.h,

                      clearText: true,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      textStyle: GoogleFonts.inter(
                        color: black,
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                      ),
                      decoration: InputDecoration(
                        fillColor: mildGrey,
                        filled: true,
                        counterText: '',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                          // borderSide: BorderSide(
                          //   color: Colors.transparent,
                          // ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                          borderSide: const BorderSide(
                            color: mildGrey,
                          ),
                        ),
                        focusColor: mildGrey,
                        hintText: '0',
                        hintStyle: GoogleFonts.inter(
                          color: black,
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      numberOfFields: 4,
                      borderColor: mildGrey,
                      showCursor: false,
                      showFieldAsBox: true,

                      hasCustomInputDecoration: true,
                      onCodeChanged: (String code) {
                        setState(() {
                          isSubmitted = false;
                          userTypedOtp = '';
                        });
                      },
                      onSubmit: (String verificationCode) {
                        setState(() {
                          isSubmitted = true;
                          userTypedOtp = verificationCode;
                        });
                      }, // end onSubmit
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0.w),
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
                                timerText,
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
                    GestureDetector(
                      child: RichText(
                        text: TextSpan(
                          text: 'Did\'nt received code?    ',
                          style: GoogleFonts.syne(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: grey,
                          ),
                          children: [
                            TextSpan(
                              text: 'RESEND CODE',
                              style: GoogleFonts.syne(
                                decoration: TextDecoration.underline,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: orange,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 80.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20.0.h),
                      child: GestureDetector(
                        onTap: () => showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            backgroundColor: white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            alignment: Alignment.center,
                            insetPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 25.h),
                              width: 350.w,
                              height: 442.h,
                              child: Column(
                                // crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: GestureDetector(
                                      onTap: () => Navigator.of(context).pop(),
                                      child: SvgPicture.asset(
                                          'assets/images/close-circle.svg'),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 186.w,
                                    height: 186.h,
                                    child: GifImage(
                                      controller: gifController,
                                      image: const AssetImage(
                                        "assets/images/email-verify-done.gif",
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Congratulations',
                                    style: GoogleFonts.syne(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: orange,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Text(
                                    'You have successfully verify\n the Email Address',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.syne(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  isVerifying
                                      ? apiButton(context)
                                      : GestureDetector(
                                          onTap: () => verifyOTPmethod(context),
                                          child: buttonContainer(context, 'OK'),
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ),
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
    );
  }

  ApiServices get service => GetIt.I<ApiServices>();

  APIResponse<APIResponse>? otpResponse;
  bool isVerifying = false;
  verifyOTPmethod(BuildContext context) async {
    if (isSubmitted == false && userTypedOtp == '') {
      showToastError('enter OTP to proceed', FToast().init(context));
    } else {
      setState(() {
        isVerifying = true;
      });
      Map otpData = {"email": widget.email, "otp": userTypedOtp.toString()};
      otpResponse = await service.verifyOtpApi(otpData);
      if (otpResponse!.status!.toLowerCase() == 'success') {
        showToastSuccess('email updated successfully', FToast().init(context));
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const LogInScreen(userType: 'Rider'),
          ),
        );
      } else {
        showToastError(otpResponse!.message, FToast().init(context));
      }
      setState(() {
        isVerifying = false;
      });
    }
  }

  /// resend OTP API:
  bool resending = false;
  APIResponse<APIResponse>? _resendOTPResponse;
  resendCode(BuildContext context) async {
    setState(() {
      resending = true;
    });
    Map oTPData = {
      "email": widget.email,
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
