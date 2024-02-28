import 'package:deliver_partner/services/API_services.dart';
import 'package:deliver_partner/utilities/showToast.dart';
import 'package:deliver_partner/widgets/TextFormField_Widget.dart';
import 'package:deliver_partner/widgets/apiButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Constants/Colors.dart';
import 'Constants/back-arrow-with-container.dart';
import 'Constants/buttonContainer.dart';
import 'OTPScreen.dart';
import 'models/API models/API response.dart';

class ForgetPassword extends StatefulWidget {
  final String userType;
  const ForgetPassword({super.key, required this.userType});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  ApiServices get service => GetIt.I<ApiServices>();
  late TextEditingController emailController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
  }

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
      backgroundColor: white,
      body: SafeArea(
        child: GlowingOverscrollIndicator(
          axisDirection: AxisDirection.down,
          color: orange,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 40.h,
                  ),
                  SvgPicture.asset('assets/images/logo.svg'),
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    'Forgot \n Password?',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.syne(
                      fontWeight: FontWeight.w600,
                      color: orange,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    'Enter your account email.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.syne(
                      fontWeight: FontWeight.w400,
                      color: black,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 90.h,
                  ),
                  SizedBox(
                    width: 296.w,
                    child: TextFormFieldWidget(
                      controller: emailController,
                      textInputType: TextInputType.emailAddress,
                      enterTextStyle: enterTextStyle,
                      cursorColor: orange,
                      hintText: 'Email ID',
                      border: border,
                      hintStyle: hintStyle,
                      focusedBorder: focusedBorder,
                      obscureText: null,
                      contentPadding: contentPadding,
                      enableBorder: enableBorder,
                      prefixIcon: null,
                      length: -1,
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.h),
                    child: isForget
                        ? apiButton(context)
                        : GestureDetector(
                            onTap: () => forgetPasswordMethod(context),
                            child: buttonContainer(context, 'NEXT'),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isForget = false;
  late APIResponse<APIResponse> _forgetResponse;
  forgetPasswordMethod(BuildContext context) async {
    if (emailController.text.isNotEmpty) {
      setState(() {
        isForget = true;
      });
      Map forgetData = {
        "email": emailController.text,
      };
      _forgetResponse = await service.forgetPasswordAPI(forgetData);
      if (_forgetResponse.status!.toLowerCase() == 'success') {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => OTPScreen(
              email: emailController.text,
              userType: widget.userType,
            ),
          ),
        );
      } else {
        showToastError(
          _forgetResponse.message,
          FToast().init(context),
        );
      }
    } else {
      showToastError(
        'email is required',
        FToast().init(context),
      );
    }
    setState(() {
      isForget = false;
    });
  }
}
