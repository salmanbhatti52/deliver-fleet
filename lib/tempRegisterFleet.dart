import 'package:deliver_partner/Constants/FacebookButton.dart';
import 'package:deliver_partner/Constants/GoogleButton.dart';
import 'package:deliver_partner/PrivacyPolicy.dart';
import 'package:deliver_partner/TermsAndConditions.dart';
import 'package:deliver_partner/VerifyYourself.dart';
import 'package:deliver_partner/services/API_services.dart';
import 'package:deliver_partner/tempLoginFleet.dart';
import 'package:deliver_partner/utilities/showToast.dart';
import 'package:deliver_partner/widgets/TextFormField_Widget.dart';
import 'package:deliver_partner/widgets/apiButton.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Constants/Colors.dart';
import 'Constants/buttonContainer.dart';
import 'FleetScreens/BottomNavBarFleet.dart';
import 'LogInScreen.dart';
import 'RiderScreens/VerifyDrivingLisecnseManually.dart';
import 'models/API models/API response.dart';

class TempRegisterFleet extends StatefulWidget {
  final String userType;
  final String deviceID;
  final String phoneNumber;

  const TempRegisterFleet(
      {super.key,
      required this.userType,
      required this.phoneNumber,
      required this.deviceID});

  @override
  State<TempRegisterFleet> createState() => _TempRegisterFleetState();
}

class _TempRegisterFleetState extends State<TempRegisterFleet> {
  final GlobalKey<FormState> _key = GlobalKey();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // late TextEditingController confirmPasswordController;
  // late TextEditingController fleetCodeController;
  // late TextEditingController nINController;

  bool passwordHidden = true;
  bool newPasswordHidden = true;
  bool isChecked = false;

  final countryPicker = const FlCountryCodePicker(
    showDialCode: true,
  );
  CountryCode? countryCode =
      const CountryCode(name: 'Nigeria', code: 'NG', dialCode: '+234');

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
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    lastNameController.dispose();
    firstNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    // confirmPasswordController.dispose();
    // phoneNumberController.dispose();
    // nINController.dispose();
    // fleetCodeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
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
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Create Fleet Profile',
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
                                height: 10.h,
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
                                height: 10.h,
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
                                height: 10.h,
                              ),
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
                                height: 10.h,
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
                              // SizedBox(
                              //   height: 20.h,
                              // ),
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
                      // SizedBox(
                      //   height: 20.h,
                      // ),
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
                        height: 40.h,
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
                              onTap: () {
                                print('object user type: ${widget.userType}');
                                checkmark == false
                                    ? ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Please make ensure that you have agreed to our terms and conditions to proceed further.'),
                                        ),
                                      )
                                    : registerMethod(context);
                              },
                              child: buttonContainer(context, 'Sign Up'),
                            ),
                      SizedBox(
                        height: 15.h,
                      ),
                      RichText(
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "Already have an account? ",
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
                                      builder: (context) => TempLoginFleet(
                                          userType: widget.userType,
                                          deviceID: widget.deviceID,
                                          phoneNumber: widget.phoneNumber),
                                    ),
                                  );
                                },
                              text: 'Login',
                              style: const TextStyle(
                                color: orange,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
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

  bool isValidEmail(String email) {
    final RegExp regex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)*\w+[\w-]$',
    );
    return regex.hasMatch(email);
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
        "phone": countryCode!.dialCode + phoneNumberController.text,
        "email": emailController.text,
        // "national_identification_no": nINController.text,
        "password": passwordController.text,
        // "confirm_password": confirmPasswordController.text,
        // "parent_id": fleetCodeController.text,
      };

      print('data: $signupData');

      print('device ID for android or Ios is: ${signupData.toString()}');

      _signupResponse = await service.signUpNewAPI(signupData);
      if (_signupResponse!.status!.toLowerCase() == 'success') {
        print('object device id: ${widget.deviceID}');

        showToastSuccess(
            _signupResponse!.message!.toString(), FToast().init(context),
            seconds: 1);
        if (widget.userType == "Fleet") {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TempLoginFleet(
                  userType: widget.userType,
                  deviceID: widget.deviceID,
                  phoneNumber: widget.phoneNumber),
            ),
          );
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
