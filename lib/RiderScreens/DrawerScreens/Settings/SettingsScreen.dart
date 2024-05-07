import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:deliver_partner/Constants/Colors.dart';
import 'package:deliver_partner/DeleteAccountScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:deliver_partner/models/NotificationSettingModel.dart';

String? notificationStatus = "Yes";

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // ApiServices get service => GetIt.I<ApiServices>();

  int userID = -1;
  bool switchStatus = true;

  checkSwitch() async {
    if (switchStatus == false) {
      notificationStatus = "No";
    } else {
      notificationStatus = "Yes";
    }

    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setString('notificationStatus', "$notificationStatus");
    notificationSwitch();
  }

  NotificationSettingModel notificationSettingModel =
      NotificationSettingModel();

  notificationSwitch() async {
    try {
      SharedPreferences sharedPref = await SharedPreferences.getInstance();
      userID = sharedPref.getInt('userID')!;
      String apiUrl =
          "https://cs.deliverbygfl.com/api/update_notification_switch_fleet";
      print("apiUrl: $apiUrl");
      print("userId: $userID");
      print("notifications: $notificationStatus");
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Accept': 'application/json',
        },
        body: {
          "users_fleet_id": userID.toString(),
          "notifications": notificationStatus,
        },
      );
      final responseString = response.body;
      print("response: $responseString");
      print("statusCode: ${response.statusCode}");
      if (response.statusCode == 200) {
        notificationSettingModel =
            notificationSettingModelFromJson(responseString);
        setState(() {});
        print(
            'notificationSettingModel status: ${notificationSettingModel.status}');
      }
    } catch (e) {
      print('Something went wrong = ${e.toString()}');
      return null;
    }
  }

  sharedPrefs() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    notificationStatus = sharedPref.getString('notificationStatus');
    print("notificationStatus in sharedPrefs is: $notificationStatus");
  }

  @override
  void initState() {
    super.initState();
    sharedPrefs();
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   setState(() {
  //     isLoading = true;
  //     // gettingCategory = true;
  //   });
  //   init();
  // }
  //
  // bool isToggled = false;
  // late APIResponse<LogInModel>? getUserProfileResponse;
  //
  // init() async {
  //   isToggled = false;
  //
  //   sharedPreferences = await SharedPreferences.getInstance();
  //   userID = (sharedPreferences.getInt('userID') ?? -1);
  //   userEmail = (sharedPreferences.getString('userEmail') ?? '');
  //
  //   Map data = {
  //     "users_fleet_id": userID.toString(),
  //   };
  //
  //   getUserProfileResponse = await service.getUserProfileAPI(data);
  //
  //   if (getUserProfileResponse!.status!.toLowerCase() == 'success') {
  //     if (getUserProfileResponse!.data != null) {
  //       // showToastSuccess('Loading user data', FToast().init(context));
  //     }
  //   } else {
  //     showToastError(getUserProfileResponse!.message, FToast().init(context));
  //   }
  //
  //   setState(() {
  //     isLoading = false;
  //     // gettingCategory = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leadingWidth: 70,
        centerTitle: true,
        title: Text(
          'Settings',
          style: GoogleFonts.syne(
            fontWeight: FontWeight.w700,
            color: black,
            fontSize: 20,
          ),
        ),
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: Column(
          children: [
            SizedBox(
              height: 40.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Enable Notifications',
                  style: GoogleFonts.syne(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: black,
                  ),
                ),
                FlutterSwitch(
                  width: 35,
                  height: 20,
                  activeColor: black,
                  inactiveColor: white,
                  activeToggleBorder: Border.all(color: black, width: 2),
                  inactiveToggleBorder: Border.all(color: black, width: 2),
                  inactiveSwitchBorder: Border.all(color: black, width: 2),
                  toggleSize: 12,
                  value: notificationStatus == "Yes"
                      ? switchStatus = true
                      : switchStatus = false,
                  borderRadius: 50,
                  onToggle: (val) {
                    setState(() {
                      switchStatus = val;
                      checkSwitch();
                      print("switchStatus onToggle: $switchStatus");
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 30.h,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DeleteAccountScreen(),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Delete Your Account',
                    style: GoogleFonts.syne(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: black,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: black,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // APIResponse<LogInModel>? _updateResponse;
  // bool isUpdating = false;
  // updateNotification(BuildContext context) async {
  //   setState(() {
  //     isUpdating = true;
  //   });
  //   Map updateData = {
  //     "users_fleet_id": userID.toString(),
  //     "notifications": isToggled ? 'Yes' : 'No',
  //   };
  //
  //   _updateResponse = await service.updateNotificationStatusApi(updateData);
  //
  //   if (_updateResponse!.status!.toLowerCase() == 'success') {
  //     isToggled
  //         ? showToastSuccess(
  //         'Notifications are enabled', FToast().init(context))
  //         : showToastSuccess(
  //         'Notifications are disabled', FToast().init(context));
  //   } else {
  //     showToastError(_updateResponse!.message!, FToast().init(context));
  //   }
  //   setState(() {
  //     isUpdating = false;
  //   });
  // }
}


// import 'package:deliver_partner/Constants/PageLoadingKits.dart';
// import 'package:deliver_partner/Constants/buttonContainer.dart';
// import 'package:deliver_partner/models/API_models/LogInModel.dart';
// import 'package:deliver_partner/widgets/apiButton.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get_it/get_it.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../../Constants/Colors.dart';
// import '../../../Constants/back-arrow-with-container.dart';
// import '../../../models/API_models/API_response.dart';
// import '../../../services/API_services.dart';
// import '../../../utilities/showToast.dart';
// import '../../../widgets/TextFormField_Widget.dart';

// import 'EmailVerificationThroughSettings.dart';
//
// class SettingsScreen extends StatefulWidget {
//   const SettingsScreen({super.key});
//
//   @override
//   State<SettingsScreen> createState() => _SettingsScreenState();
// }
//
// class _SettingsScreenState extends State<SettingsScreen> {
//   late TextEditingController passwordController;
//   late TextEditingController newPasswordController;
//   late TextEditingController confirmPasswordController;
//   late TextEditingController emailController;
//   late TextEditingController newEmailController;
//
//   final GlobalKey<FormState> _key = GlobalKey();
//
//   int userID = -1;
//
//   late SharedPreferences sharedPreferences;
//   bool isLoading = false;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     setState(() {
//       isLoading = true;
//       // gettingCategory = true;
//     });
//     init();
//   }
//
//   late APIResponse<LogInModel>? getUserProfileResponse;
//
//   init() async {
//     sharedPreferences = await SharedPreferences.getInstance();
//     userID = (sharedPreferences.getInt('userID') ?? -1);
//
//     Map data = {
//       "users_fleet_id": userID.toString(),
//     };
//
//     getUserProfileResponse = await service.getUserProfileAPI(data);
//
//     if (getUserProfileResponse!.status!.toLowerCase() == 'success') {
//       if (getUserProfileResponse!.data != null) {
//         // showToastSuccess('Loading user data', FToast().init(context));
//       }
//     } else {
//       showToastError(getUserProfileResponse!.message, FToast().init(context));
//     }
//     passwordController = TextEditingController();
//     newPasswordController = TextEditingController();
//     confirmPasswordController = TextEditingController();
//     emailController = TextEditingController();
//     newEmailController = TextEditingController();
//     setState(() {
//       isLoading = false;
//       // gettingCategory = false;
//     });
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//     confirmPasswordController.dispose();
//     newPasswordController.dispose();
//     newEmailController.dispose();
//   }
//
//   final hintStyle = GoogleFonts.inter(
//     fontSize: 13,
//     fontWeight: FontWeight.w300,
//     color: black,
//   );
//
//   final enterTextStyle = GoogleFonts.inter(
//     fontSize: 13,
//     fontWeight: FontWeight.w300,
//     color: black,
//   );
//
//   final focusedBorder = OutlineInputBorder(
//     borderRadius: BorderRadius.circular(10),
//     borderSide: const BorderSide(
//       color: orange,
//     ),
//   );
//   final border = const OutlineInputBorder(
//     borderRadius: BorderRadius.all(
//       Radius.circular(10),
//     ),
//     borderSide: BorderSide.none,
//   );
//   final enableBorder = const OutlineInputBorder(
//     borderRadius: BorderRadius.all(
//       Radius.circular(10),
//     ),
//     borderSide: BorderSide.none,
//   );
//
//   final contentPadding =
//       const EdgeInsets.symmetric(horizontal: 14, vertical: 16);
//
//   ApiServices get service => GetIt.I<ApiServices>();
//
//   bool isHiddenOld = false;
//   bool isHiddenNew = false;
//   bool isHiddenConfirm = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           elevation: 0.0,
//           backgroundColor: Colors.white,
//           leadingWidth: 70,
//           leading: Padding(
//             padding: const EdgeInsets.only(top: 8.0, left: 20),
//             child: GestureDetector(
//               onTap: () => Navigator.of(context).pop(),
//               child: backArrowWithContainer(context),
//             ),
//           ),
//           centerTitle: true,
//           title: Text(
//             'Settings',
//             style: GoogleFonts.syne(
//               fontWeight: FontWeight.w700,
//               color: black,
//               fontSize: 20,
//             ),
//           ),
//         ),
//         backgroundColor: white,
//         body: isLoading
//             ? spinKitRotatingCircle
//             : GlowingOverscrollIndicator(
//                 axisDirection: AxisDirection.down,
//                 color: orange,
//                 child: SingleChildScrollView(
//                   physics: const BouncingScrollPhysics(),
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 40.w),
//                     child: Column(
//                       children: [
//                         Form(
//                           key: _key,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               SizedBox(
//                                 height: 30.h,
//                               ),
//                               Container(
//                                 width: 150.w,
//                                 height: 150.h,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   border: Border.all(
//                                     color: lightGrey,
//                                     width: 4.5,
//                                   ),
//                                 ),
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(10),
//                                   child: Image.network(
//                                     'https://cs.deliverbygfl.com/public/${getUserProfileResponse!.data!.profile_pic}',
//                                     fit: BoxFit.cover,
//                                     errorBuilder: (BuildContext context,
//                                         Object exception,
//                                         StackTrace? stackTrace) {
//                                       return SizedBox(
//                                           child: Image.asset(
//                                         'assets/images/place-holder.png',
//                                         fit: BoxFit.scaleDown,
//                                       ));
//                                     },
//                                     loadingBuilder: (BuildContext context,
//                                         Widget child,
//                                         ImageChunkEvent? loadingProgress) {
//                                       if (loadingProgress == null) {
//                                         return child;
//                                       }
//                                       return Center(
//                                         child: CircularProgressIndicator(
//                                           color: orange,
//                                           value: loadingProgress
//                                                       .expectedTotalBytes !=
//                                                   null
//                                               ? loadingProgress
//                                                       .cumulativeBytesLoaded /
//                                                   loadingProgress
//                                                       .expectedTotalBytes!
//                                               : null,
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 20.h,
//                               ),
//                               Text(
//                                 '${getUserProfileResponse!.data!.first_name!} ${getUserProfileResponse!.data!.last_name!}',
//                                 style: GoogleFonts.syne(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.w700,
//                                   color: black,
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 30.h,
//                               ),
//                               Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Text(
//                                   'Change Password',
//                                   style: GoogleFonts.syne(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w700,
//                                     color: black,
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 20.h,
//                               ),
//                               SizedBox(
//                                 width: 296.w,
//                                 child: TextFormFieldWidget(
//                                   validator: (val) {
//                                     if (val!.isEmpty) {
//                                       return 'password cannot be empty';
//                                     }
//                                     return null;
//                                   },
//                                   controller: passwordController,
//                                   textInputType: TextInputType.visiblePassword,
//                                   enterTextStyle: enterTextStyle,
//                                   cursorColor: orange,
//                                   hintText: 'Old Password',
//                                   border: border,
//                                   hintStyle: hintStyle,
//                                   focusedBorder: focusedBorder,
//                                   obscureText: isHiddenOld,
//                                   contentPadding: contentPadding,
//                                   suffixIcon: GestureDetector(
//                                     onTap: () {
//                                       setState(() {
//                                         isHiddenOld = !isHiddenOld;
//                                       });
//                                     },
//                                     child: isHiddenOld
//                                         ? SvgPicture.asset(
//                                             'assets/images/pass-hide-icon.svg',
//                                             fit: BoxFit.scaleDown,
//                                           )
//                                         : SvgPicture.asset(
//                                             'assets/images/pass-icon.svg',
//                                             // colorFilter:
//                                             // ColorFilter.mode(orange, BlendMode.srcIn),
//                                             fit: BoxFit.scaleDown,
//                                           ),
//                                   ),
//                                   enableBorder: enableBorder,
//                                   length: -1,
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 15.h,
//                               ),
//                               SizedBox(
//                                 width: 296.w,
//                                 child: TextFormFieldWidget(
//                                   validator: (val) {
//                                     if (val!.isEmpty) {
//                                       return 'password cannot be empty';
//                                     }
//                                     return null;
//                                   },
//                                   controller: newPasswordController,
//                                   textInputType: TextInputType.visiblePassword,
//                                   enterTextStyle: enterTextStyle,
//                                   cursorColor: orange,
//                                   hintText: 'New Password',
//                                   border: border,
//                                   hintStyle: hintStyle,
//                                   focusedBorder: focusedBorder,
//                                   obscureText: isHiddenNew,
//                                   contentPadding: contentPadding,
//                                   suffixIcon: GestureDetector(
//                                     onTap: () {
//                                       setState(() {
//                                         isHiddenNew = !isHiddenNew;
//                                       });
//                                     },
//                                     child: isHiddenNew
//                                         ? SvgPicture.asset(
//                                             'assets/images/pass-hide-icon.svg',
//                                             fit: BoxFit.scaleDown,
//                                           )
//                                         : SvgPicture.asset(
//                                             'assets/images/pass-icon.svg',
//                                             // colorFilter:
//                                             // ColorFilter.mode(orange, BlendMode.srcIn),
//                                             fit: BoxFit.scaleDown,
//                                           ),
//                                   ),
//                                   enableBorder: enableBorder,
//                                   length: -1,
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 15.h,
//                               ),
//                               SizedBox(
//                                 width: 296.w,
//                                 child: TextFormFieldWidget(
//                                   validator: (val) {
//                                     if (val!.isEmpty) {
//                                       return 'password cannot be empty';
//                                     } else if (confirmPasswordController.text !=
//                                         val) {
//                                       return 'enter correct password';
//                                     }
//                                     return null;
//                                   },
//                                   controller: confirmPasswordController,
//                                   textInputType: TextInputType.visiblePassword,
//                                   enterTextStyle: enterTextStyle,
//                                   cursorColor: orange,
//                                   hintText: 'Confirm Password',
//                                   border: border,
//                                   hintStyle: hintStyle,
//                                   focusedBorder: focusedBorder,
//                                   obscureText: isHiddenConfirm,
//                                   contentPadding: contentPadding,
//                                   suffixIcon: GestureDetector(
//                                     onTap: () {
//                                       setState(() {
//                                         isHiddenConfirm = !isHiddenConfirm;
//                                       });
//                                     },
//                                     child: isHiddenConfirm
//                                         ? SvgPicture.asset(
//                                             'assets/images/pass-hide-icon.svg',
//                                             fit: BoxFit.scaleDown,
//                                           )
//                                         : SvgPicture.asset(
//                                             'assets/images/pass-icon.svg',
//                                             // colorFilter:
//                                             // ColorFilter.mode(orange, BlendMode.srcIn),
//                                             fit: BoxFit.scaleDown,
//                                           ),
//                                   ),
//                                   enableBorder: enableBorder,
//                                   length: -1,
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 30.h,
//                               ),
//                               updatingPassword
//                                   ? apiButton(context)
//                                   : GestureDetector(
//                                       onTap: () => updatePassword(context),
//                                       child: buttonContainer(context, 'UPDATE'),
//                                     ),
//                             ],
//                           ),
//                         ),
//                         Column(
//                           children: [
//                             SizedBox(
//                               height: 30.h,
//                             ),
//                             Align(
//                               alignment: Alignment.centerLeft,
//                               child: Text(
//                                 'Change Email',
//                                 style: GoogleFonts.syne(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w700,
//                                   color: black,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 20.h,
//                             ),
//                             Container(
//                               width: 296.w,
//                               // height: 50.h,
//                               decoration: BoxDecoration(
//                                 color: mildGrey,
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               child: TextFormField(
//                                 controller: emailController,
//                                 keyboardType: TextInputType.emailAddress,
//                                 style: GoogleFonts.inter(
//                                   fontSize: 13,
//                                   fontWeight: FontWeight.w300,
//                                   color: black,
//                                 ),
//                                 cursorColor: orange,
//                                 decoration: InputDecoration(
//                                   border: InputBorder.none,
//                                   hintText: 'Enter Current Email',
//                                   contentPadding: const EdgeInsets.symmetric(
//                                       horizontal: 14, vertical: 16),
//                                   hintStyle: GoogleFonts.inter(
//                                     fontSize: 13,
//                                     fontWeight: FontWeight.w300,
//                                     color: black,
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                     borderSide: const BorderSide(
//                                       color: orange,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 15.h,
//                             ),
//                             Container(
//                               width: 296.w,
//                               // height: 50.h,
//                               decoration: BoxDecoration(
//                                 color: mildGrey,
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               child: TextFormField(
//                                 controller: newEmailController,
//                                 keyboardType: TextInputType.emailAddress,
//                                 style: GoogleFonts.inter(
//                                   fontSize: 13,
//                                   fontWeight: FontWeight.w300,
//                                   color: black,
//                                 ),
//                                 cursorColor: orange,
//                                 decoration: InputDecoration(
//                                   border: InputBorder.none,
//                                   hintText: 'Enter New Email',
//                                   contentPadding: const EdgeInsets.symmetric(
//                                       horizontal: 14, vertical: 16),
//                                   hintStyle: GoogleFonts.inter(
//                                     fontSize: 13,
//                                     fontWeight: FontWeight.w300,
//                                     color: black,
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                     borderSide: const BorderSide(
//                                       color: orange,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 30.h,
//                             ),
//                             Padding(
//                               padding: EdgeInsets.only(bottom: 20.0.h),
//                               child: updatingEmail
//                                   ? apiButton(context)
//                                   : GestureDetector(
//                                       onTap: () => updateEmail(context),
//                                       child: buttonContainer(context, 'UPDATE'),
//                                     ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//       ),
//     );
//   }
//
//   bool updatingPassword = false;
//   APIResponse<LogInModel>? updatePasswordResponse;
//   updatePassword(BuildContext context) async {
//     if (_key.currentState!.validate()) {
//       setState(() {
//         updatingPassword = true;
//       });
//       Map updatePasswordData = {
//         "users_fleet_id": userID.toString(),
//         "current_password": passwordController.text,
//         "password": newPasswordController.text,
//         "confirm_password": confirmPasswordController.text,
//       };
//       updatePasswordResponse =
//           await service.updatePasswordApi(updatePasswordData);
//       if (updatePasswordResponse!.status!.toLowerCase() == 'success') {
//         showToastSuccess(
//             'Password updated successfully', FToast().init(context));
//       } else {
//         showToastError(
//             updatePasswordResponse!.message!, FToast().init(context));
//       }
//     }
//     setState(() {
//       updatingPassword = false;
//     });
//   }
//
//   bool updatingEmail = false;
//   APIResponse<LogInModel>? updateEmailResponse;
//   updateEmail(BuildContext context) async {
//     setState(() {
//       updatingEmail = true;
//     });
//     Map updateEmailData = {
//       "users_fleet_id": userID.toString(),
//       "current_email": emailController.text,
//       "new_email": newEmailController.text,
//     };
//     print('update email data :' + updateEmailData.toString());
//     updateEmailResponse = await service.updateEmailApi(updateEmailData);
//     if (updateEmailResponse!.status!.toLowerCase() == 'success') {
//       showToastSuccess(updateEmailResponse!.message!, FToast().init(context));
//       Navigator.of(context).push(
//         MaterialPageRoute(
//           builder: (context) => EmailVerificationThroughSettings(
//             email: newEmailController.text,
//           ),
//         ),
//       );
//     } else {
//       showToastError(updateEmailResponse!.message!, FToast().init(context));
//     }
//     setState(() {
//       updatingEmail = false;
//     });
//   }
// }
