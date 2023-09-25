import 'package:Deliver_Rider/Constants/FacebookButton.dart';
import 'package:Deliver_Rider/Constants/GoogleButton.dart';
import 'package:Deliver_Rider/PrivacyPolicy.dart';
import 'package:Deliver_Rider/TermsAndConditions.dart';
import 'package:Deliver_Rider/VerifyYourself.dart';
import 'package:Deliver_Rider/services/API_services.dart';
import 'package:Deliver_Rider/utilities/showToast.dart';
import 'package:Deliver_Rider/widgets/TextFormField_Widget.dart';
import 'package:Deliver_Rider/widgets/apiButton.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Constants/Colors.dart';
import 'Constants/buttonContainer.dart';
import 'LogInScreen.dart';
import 'models/API models/API response.dart';

class RegisterScreen extends StatefulWidget {
  final String userType;
  final String deviceID;
  const RegisterScreen(
      {super.key, required this.userType, required this.deviceID});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _key = GlobalKey();
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController phoneNumberController;
  late TextEditingController fleetCodeController;

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
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    phoneNumberController = TextEditingController();
    fleetCodeController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    lastNameController.dispose();
    firstNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneNumberController.dispose();
    fleetCodeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                    vertical: 30,
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
                              SizedBox(
                                height: 20.h,
                              ),
                              SvgPicture.asset('assets/images/logo.svg'),
                              SizedBox(
                                height: 20.h,
                              ),
                              Text(
                                'REGISTER',
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
                              SizedBox(
                                width: 296.w,
                                // height: 50.h,

                                child: TextFormFieldWidget(
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'name cannot be empty';
                                    }
                                    return null;
                                  },
                                  controller: firstNameController,
                                  textInputType: TextInputType.name,
                                  enterTextStyle: enterTextStyle,
                                  cursorColor: orange,
                                  hintText: 'First Name',
                                  border: border,
                                  hintStyle: hintStyle,
                                  focusedBorder: focusedBorder,
                                  contentPadding: contentPadding,
                                  obscureText: null,
                                  enableBorder: enableBorder,
                                  length: -1,
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              SizedBox(
                                width: 296.w,
                                child: TextFormFieldWidget(
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'name cannot be empty';
                                    }
                                    return null;
                                  },
                                  controller: lastNameController,
                                  textInputType: TextInputType.name,
                                  enterTextStyle: enterTextStyle,
                                  cursorColor: orange,
                                  hintText: 'Last Name',
                                  border: border,
                                  hintStyle: hintStyle,
                                  focusedBorder: focusedBorder,
                                  contentPadding: contentPadding,
                                  obscureText: null,
                                  enableBorder: enableBorder,
                                  length: -1,
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              SizedBox(
                                width: 296.w,
                                child: TextFormFieldWidget(
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'phone number cannot be empty';
                                    }
                                    return null;
                                  },
                                  controller: phoneNumberController,
                                  textInputType: TextInputType.number,
                                  enterTextStyle: enterTextStyle,
                                  cursorColor: orange,
                                  hintText: '123 456 789',
                                  border: border,
                                  hintStyle: hintStyle,
                                  focusedBorder: focusedBorder,
                                  obscureText: null,
                                  contentPadding: contentPadding,
                                  enableBorder: enableBorder,
                                  prefixIcon: GestureDetector(
                                    onTap: () async {
                                      final code = await countryPicker
                                          .showPicker(context: context);
                                      setState(() {
                                        countryCode = code;
                                      });
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
                                                : Image.asset(
                                                    'assets/images/flag-icon.png',
                                                    width: 20,
                                                    height: 20,
                                                    color: orange,
                                                    fit: BoxFit.scaleDown,
                                                  ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            countryCode?.dialCode ?? "+234",
                                            textAlign: TextAlign.center,
                                            style: hintStyle,
                                          ),
                                        ),
                                        SizedBox(width: 10.w),
                                        Text(
                                          '|',
                                          style: hintStyle,
                                        ),
                                        SizedBox(width: 10.w),
                                      ],
                                    ),
                                  ),
                                  length: 15,
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              SizedBox(
                                width: 296.w,
                                child: TextFormFieldWidget(
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'email cannot be empty';
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
                              SizedBox(
                                width: 296.w,
                                child: TextFormFieldWidget(
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'password cannot be empty';
                                    } else if (passwordController.text != val) {
                                      return 'enter correct password';
                                    }
                                    return null;
                                  },
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
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        newPasswordHidden = !newPasswordHidden;
                                      });
                                    },
                                    child: newPasswordHidden
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
                                  enableBorder: enableBorder,
                                  length: -1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      widget.userType == 'Rider'
                          ? SizedBox(
                              width: 296.w,
                              child: TextFormFieldWidget(
                                // validator: (val) {
                                //   if (val!.isEmpty) {
                                //     return 'fleet code cannot be empty';
                                //   }
                                // },
                                controller: fleetCodeController,
                                textInputType: TextInputType.text,
                                enterTextStyle: enterTextStyle,
                                cursorColor: orange,
                                hintText: 'Fleet Code',
                                border: border,
                                hintStyle: hintStyle,
                                focusedBorder: focusedBorder,
                                contentPadding: contentPadding,
                                obscureText: null,
                                enableBorder: enableBorder,
                                length: -1,
                              ),
                            )
                          : const SizedBox(),
                      widget.userType == 'Rider'
                          ? SizedBox(
                              height: 15.h,
                            )
                          : SizedBox(),
                      widget.userType == 'Rider'
                          ? Text(
                              '* Register without fleet code if you have a vehicle',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: orange,
                              ),
                            )
                          : const SizedBox(),
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
                                        'assets/images/check-icon.svg'))
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
                                      ..onTap = () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const TermsAndConditions(),
                                          ),
                                        );
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
                                      ..onTap = () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const PrivacyPolicy(),
                                          ),
                                        );
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
                              onTap: () => checkmark == false
                                  ? ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Please ensure that you agree to terms and conditions to proceed further'),
                                      ),
                                    )
                                  : registerMethod(context),
                              child: buttonContainer(context, 'REGISTER'),
                            ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        'OR',
                        style: GoogleFonts.syne(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: grey,
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      GestureDetector(
                        onTap: null,
                        child: facebookButton(context),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      GestureDetector(
                        onTap: null,
                        child: googleButton(context),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20.0.h, top: 20.h),
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => LogInScreen(
                                userType: widget.userType,
                              ),
                            ),
                          ),
                          child: RichText(
                            text: TextSpan(
                              text: 'Have an account already? ',
                              style: GoogleFonts.syne(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: grey,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Login',
                                  style: GoogleFonts.syne(
                                    decoration: TextDecoration.underline,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: orange,
                                  ),
                                ),
                              ],
                            ),
                          ),
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

  bool isRegistering = false;
  APIResponse<APIResponse>? _signupResponse;
  registerMethod(BuildContext context) async {
    if (_key.currentState!.validate()) {
      setState(() {
        isRegistering = true;
      });
      Map signupData = {
        "user_type": widget.userType,
        "one_signal_id": widget.deviceID,
        "first_name": firstNameController.text,
        "last_name": lastNameController.text,
        "phone": phoneNumberController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "confirm_password": confirmPasswordController.text,
        "parent_id": fleetCodeController.text,
        "account_type": "SignupWithApp"
      };

      print('device ID for android or Ios is:  ' + signupData.toString());

      _signupResponse = await service.signUpAPI(signupData);
      if (_signupResponse!.status!.toLowerCase() == 'success') {
        print('object device id:  ' + widget.deviceID);
        showToastSuccess(
            _signupResponse!.message!.toString(), FToast().init(context),
            seconds: 1);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => VerifyYourself(
              email: emailController.text,
              appMode: widget.userType,
              deviceID: widget.deviceID,
            ),
          ),
        );
      } else {
        print('device id for android while registering:  ' +
            _signupResponse!.message!.toString());

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
