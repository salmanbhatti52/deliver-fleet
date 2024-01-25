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
import 'LogInScreen.dart';
import 'models/API models/API response.dart';

class NewPasswordAfterOTP extends StatefulWidget {
  final String otpData;
  final String emailData;
  final String userType;
  const NewPasswordAfterOTP(
      {super.key,
      required this.otpData,
      required this.emailData,
      required this.userType});

  @override
  State<NewPasswordAfterOTP> createState() => _NewPasswordAfterOTPState();
}

class _NewPasswordAfterOTPState extends State<NewPasswordAfterOTP> {
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  final GlobalKey<FormState> _key = GlobalKey();
  ApiServices get service => GetIt.I<ApiServices>();

  bool passwordHidden = false;
  bool newPasswordHidden = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    passwordController.dispose();
    confirmPasswordController.dispose();
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
        backgroundColor: white,
        body: SafeArea(
          child: GlowingOverscrollIndicator(
            axisDirection: AxisDirection.down,
            color: orange,
            child: LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: constraints.maxHeight,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    child: Form(
                      key: _key,
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
                            'New \n Password',
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
                            'Enter new password',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.syne(
                              fontWeight: FontWeight.w400,
                              color: black,
                              fontSize: 16,
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: 296.w,
                            child: TextFormFieldWidget(
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
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Password cannot be empty';
                                }
                                return null;
                              },
                              length: -1,
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          SizedBox(
                              width: 296.w,
                              child: TextFormFieldWidget(
                                controller: confirmPasswordController,
                                textInputType: TextInputType.visiblePassword,
                                enterTextStyle: enterTextStyle,
                                cursorColor: orange,
                                hintText: 'Confirm Password',
                                border: border,
                                hintStyle: hintStyle,
                                focusedBorder: focusedBorder,
                                obscureText: newPasswordHidden,
                                contentPadding: contentPadding,
                                enableBorder: enableBorder,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'Confirm password cannot be empty';
                                  } else if (passwordController.text != val) {
                                    return 'Enter correct password';
                                  }
                                  return null;
                                },
                                length: -1,
                              )),
                          const Spacer(),
                          Padding(
                            padding: EdgeInsets.only(bottom: 20.0.h),
                            child: isLoading
                                ? apiButton(context)
                                : GestureDetector(
                                    onTap: () {
                                      resetPasswordMethod(context);
                                    },
                                    child: buttonContainer(context, 'RESET'),
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
        ),
      ),
    );
  }

  /// reset password API method:
  bool isLoading = false;
  APIResponse<APIResponse>? resetResponse;
  resetPasswordMethod(BuildContext context) async {
    if (_key.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      Map updateData = {
        "email": widget.emailData,
        "otp": widget.otpData,
        "password": passwordController.text,
        "confirm_password": confirmPasswordController.text,
      };
      resetResponse = await service.resetPasswordAPI(updateData);
      if (resetResponse!.status!.toLowerCase() == 'success') {
        showToastSuccess(resetResponse!.message, FToast().init(context));
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => LogInScreen(
              userType: widget.userType,
            ),
          ),
        );
      } else {
        print('reset password:  ${resetResponse!.message!}    ${resetResponse!.status!}');
        showToastError(resetResponse!.status, FToast().init(context));
      }
      setState(() {
        isLoading = false;
      });
    }
  }
}
