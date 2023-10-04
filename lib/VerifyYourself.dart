import 'package:Deliver_Rider/Constants/Colors.dart';
import 'package:Deliver_Rider/Constants/buttonConatinerWithBorder.dart';
import 'package:Deliver_Rider/Constants/buttonContainer.dart';
import 'package:Deliver_Rider/PhoneNumberVerificationScreen.dart';
import 'package:Deliver_Rider/services/API_services.dart';
import 'package:Deliver_Rider/utilities/showToast.dart';
import 'package:Deliver_Rider/widgets/apiButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Constants/back-arrow-with-container.dart';
import 'EmailVerificationScreen.dart';
import 'models/API models/API response.dart';

class VerifyYourself extends StatefulWidget {
  final String appMode;
  final String email;
  final String? deviceID;
  const VerifyYourself(
      {super.key, required this.email, required this.appMode, this.deviceID});

  @override
  State<VerifyYourself> createState() => _VerifyYourselfState();
}

class _VerifyYourselfState extends State<VerifyYourself> {
  ApiServices get service => GetIt.I<ApiServices>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Center(
                child: SvgPicture.asset(
                  'assets/images/verify-yourself.svg',
                  fit: BoxFit.scaleDown,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'Verify Yourself',
                style: GoogleFonts.syne(
                  fontWeight: FontWeight.w700,
                  color: black,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              Text(
                'Verify your identity using email or phone \n number.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w400,
                  color: black,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              isEmailVerifying
                  ? apiButton(context)
                  : GestureDetector(
                      onTap: () => emailVerifyMethod(context),
                      child: buttonContainer(context, 'VERIFY EMAIL'),
                    ),
              SizedBox(
                height: 30.h,
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const PhoneNumberVerificationScreen(),
                  ),
                ),
                child:
                    buttonContainerWithBorder(context, 'VERIFY PHONE NUMBER'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isEmailVerifying = false;
  APIResponse<APIResponse>? emailResponse;
  emailVerifyMethod(BuildContext context) async {
    setState(() {
      isEmailVerifying = true;
    });
    Map emailData = {
      "email": widget.email.toString(),
    };

    emailResponse = await service.verifyEmailAPI(emailData);

    if (emailResponse!.status!.toLowerCase() == 'success') {
      showToastSuccess(
          emailResponse!.message!.toString(), FToast().init(context));
      // Navigator.of(context).push(
      //   MaterialPageRoute(
      //     builder: (context) => EmailVerificationScreen(
      //       email: widget.email,
      //       userType: widget.appMode,
      //       deviceID: widget.deviceID ?? '',
      //     ),
      //   ),
      // );
    } else {
      showToastError(emailResponse!.status, FToast().init(context));
    }
    setState(() {
      isEmailVerifying = false;
    });
  }
}
