import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:deliver_partner/Constants/Colors.dart';
import 'package:deliver_partner/widgets/apiButton.dart';
import 'package:deliver_partner/utilities/showToast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:deliver_partner/Constants/buttonContainer.dart';
import 'package:deliver_partner/models/update_rider_status_model.dart';

class DriverStatusScreen extends StatefulWidget {
  const DriverStatusScreen({super.key});

  @override
  State<DriverStatusScreen> createState() => _DriverStatusScreenState();
}

class _DriverStatusScreenState extends State<DriverStatusScreen> {
  int userID = -1;
  bool isLoading = false;
  bool workSwitchStatus = false;
  bool breakSwitchStatus = false;
  bool isFullTimeSelected = false;
  bool isPartTimeSelected = false;

  void saveSelections() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    sharedPref.setBool('workSwitchStatus', workSwitchStatus);
    sharedPref.setBool('breakSwitchStatus', breakSwitchStatus);
    sharedPref.setBool('isFullTimeSelected', isFullTimeSelected);
    sharedPref.setBool('isPartTimeSelected', isPartTimeSelected);
  }

  UpdateRiderStatusModel updateRiderStatusModel = UpdateRiderStatusModel();

  updateRiderStatus() async {
    try {
      setState(() {
        isLoading = true;
      });
      SharedPreferences sharedPref = await SharedPreferences.getInstance();
      userID = sharedPref.getInt('userID')!;
      String apiUrl = "https://deliver.eigix.net/api/update_rider_status";
      debugPrint("apiUrl: $apiUrl");
      debugPrint("userId: $userID");
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Accept': 'application/json',
        },
        body: {
          "users_fleet_id": userID.toString(),
          "availability": isFullTimeSelected ? 'Full-Time' : 'Part-Time',
          "online_status": workSwitchStatus ? 'Work' : 'Break',
        },
      );
      final responseString = response.body;
      debugPrint("response: $responseString");
      debugPrint("statusCode: ${response.statusCode}");
      if (response.statusCode == 200) {
        updateRiderStatusModel = updateRiderStatusModelFromJson(responseString);
        showToastSuccess("Status updated successfully", FToast().init(context));
        debugPrint('updateRiderStatusModel status: ${updateRiderStatusModel.status}');
        setState(() {
          isLoading = false;
        });
        saveSelections();
      }
    } catch (e) {
      showToastError("Status is already updated", FToast().init(context));
      debugPrint('Something went wrong = ${e.toString()}');
      setState(() {
        isLoading = false;
      });
    }
  }

  sharedPrefs() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    setState(() {
      isFullTimeSelected = sharedPref.getBool('isFullTimeSelected') ?? false;
      isPartTimeSelected = sharedPref.getBool('isPartTimeSelected') ?? false;
      workSwitchStatus = sharedPref.getBool('workSwitchStatus') ?? false;
      breakSwitchStatus = sharedPref.getBool('breakSwitchStatus') ?? false;
    });
    debugPrint('workSwitchStatus: ${sharedPref.getBool('workSwitchStatus')}');
    debugPrint('breakSwitchStatus: ${sharedPref.getBool('breakSwitchStatus')}');
    debugPrint('isFullTimeSelected: ${sharedPref.getBool('isFullTimeSelected')}');
    debugPrint('isPartTimeSelected: ${sharedPref.getBool('isPartTimeSelected')}');
  }

  @override
  void initState() {
    super.initState();
    sharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constarints) => ConstrainedBox(
            constraints: BoxConstraints(maxHeight: constarints.maxHeight),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    'Select Driver Status',
                    style: GoogleFonts.syne(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: black,
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  SizedBox(
                    width: 250.w,
                    height: 30.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Full Time',
                              style: GoogleFonts.syne(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: black,
                              ),
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isFullTimeSelected = !isFullTimeSelected;
                                  isPartTimeSelected = false;
                                });
                              },
                              child: isFullTimeSelected
                                  ? SvgPicture.asset(
                                      'assets/images/tick-orange.svg',
                                    )
                                  : SvgPicture.asset(
                                      'assets/images/tick-grey.svg',
                                    ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Part Time',
                              style: GoogleFonts.syne(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: black,
                              ),
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isPartTimeSelected = !isPartTimeSelected;
                                  isFullTimeSelected = false;
                                });
                              },
                              child: isPartTimeSelected
                                  ? SvgPicture.asset(
                                      'assets/images/tick-orange.svg',
                                    )
                                  : SvgPicture.asset(
                                      'assets/images/tick-grey.svg',
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
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    width: 350.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: grey,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Work',
                          style: GoogleFonts.syne(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: black,
                          ),
                        ),
                        FlutterSwitch(
                          width: 35,
                          height: 20,
                          toggleSize: 12,
                          borderRadius: 50,
                          toggleColor: orange,
                          inactiveToggleColor: grey,
                          activeColor: grey.withOpacity(0.3),
                          inactiveColor: grey.withOpacity(0.3),
                          value: workSwitchStatus,
                          onToggle: (val) {
                            setState(() {
                              workSwitchStatus = val;
                              if (val) {
                                breakSwitchStatus = false;
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    width: 350.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: grey,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Break',
                          style: GoogleFonts.syne(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: black,
                          ),
                        ),
                        FlutterSwitch(
                          width: 35,
                          height: 20,
                          toggleSize: 12,
                          borderRadius: 50,
                          toggleColor: orange,
                          inactiveToggleColor: grey,
                          activeColor: grey.withOpacity(0.3),
                          inactiveColor: grey.withOpacity(0.3),
                          value: breakSwitchStatus,
                          onToggle: (val) {
                            setState(() {
                              breakSwitchStatus = val;
                              if (val) {
                                workSwitchStatus = false;
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(bottom: 50.h),
                    child: GestureDetector(
                      onTap: () {
                        if (!isFullTimeSelected && !isPartTimeSelected) {
                          showToastError(
                              "Please select a option", FToast().init(context));
                          return;
                        } else if (!workSwitchStatus && !breakSwitchStatus) {
                          showToastError("Please select online status",
                              FToast().init(context));
                          return;
                        } else {
                          updateRiderStatus();
                        }
                      },
                      child: isLoading
                          ? apiButton(context)
                          : buttonContainer(context, 'DONE'),
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
}

// import 'package:deliver_partner/Constants/Colors.dart';
// import 'package:deliver_partner/Constants/PageLoadingKits.dart';
// import 'package:deliver_partner/Constants/buttonContainer.dart';
// import 'package:deliver_partner/widgets/apiButton.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get_it/get_it.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../models/API_models/API_response.dart';
// import '../../models/API_models/LogInModel.dart';
// import '../../services/API_services.dart';
// import '../../utilities/showToast.dart';
//
// class DriverStatusScreen extends StatefulWidget {
//   const DriverStatusScreen({super.key});
//
//   @override
//   State<DriverStatusScreen> createState() => _DriverStatusScreenState();
// }
//
// class _DriverStatusScreenState extends State<DriverStatusScreen> {
//   final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
//   int selectShift = -1;
//   int switchState = -1;
//
//   ApiServices get service => GetIt.I<ApiServices>();
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
//       loadSwitchState();
//       switchState == -1 ? switchState == 1 : switchState == 2;
//       selectShift == -1 ? selectShift == 1 : selectShift == 2;
//       loadShiftState();
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
//
//     if (mounted) {
//       setState(() {
//         isLoading = false;
//         // gettingCategory = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//         key: _key,
//         backgroundColor: white,
//         body: isLoading
//             ? spinKitRotatingCircle
//             : SafeArea(
//                 child: LayoutBuilder(
//                   builder: (context, constarints) => ConstrainedBox(
//                     constraints:
//                         BoxConstraints(maxHeight: constarints.maxHeight),
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 22.0.w),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           SizedBox(
//                             height: 20.h,
//                           ),
//                           Text(
//                             'Select Driver Status',
//                             style: GoogleFonts.syne(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w700,
//                               color: black,
//                             ),
//                           ),
//                           SizedBox(
//                             height: 30.h,
//                           ),
//                           SizedBox(
//                             width: 250.w,
//                             height: 30.h,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Text(
//                                       'Full Time',
//                                       style: GoogleFonts.syne(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w500,
//                                         color: black,
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 15.w,
//                                     ),
//                                     GestureDetector(
//                                       onTap: () {
//                                         setState(() {
//                                           selectShift = 1;
//                                           saveShiftState(selectShift);
//                                         });
//                                       },
//                                       child: selectShift == 1
//                                           ? SvgPicture.asset(
//                                               'assets/images/tick-orange.svg')
//                                           : SvgPicture.asset(
//                                               'assets/images/tick-grey.svg'),
//                                     ),
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     Text(
//                                       'Part Time',
//                                       style: GoogleFonts.syne(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w500,
//                                         color: black,
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 15.w,
//                                     ),
//                                     GestureDetector(
//                                       onTap: () {
//                                         setState(() {
//                                           selectShift = 2;
//                                           saveShiftState(selectShift);
//                                         });
//                                       },
//                                       child: selectShift == 2
//                                           ? SvgPicture.asset(
//                                               'assets/images/tick-orange.svg')
//                                           : SvgPicture.asset(
//                                               'assets/images/tick-grey.svg'),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             height: 50.h,
//                           ),
//                           Container(
//                             padding: EdgeInsets.symmetric(horizontal: 18.w),
//                             width: 350.w,
//                             height: 50.h,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               border: Border.all(
//                                 color: grey,
//                                 width: 1,
//                               ),
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   'Work',
//                                   style: GoogleFonts.syne(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w700,
//                                     color: black,
//                                   ),
//                                 ),
//                                 GestureDetector(
//                                   onTap: () {
//                                     setState(() {
//                                       switchState = 1;
//                                       saveSwitchState(switchState);
//                                     });
//                                   },
//                                   child: switchState == 1
//                                       ? SvgPicture.asset(
//                                           'assets/images/switch-orange.svg')
//                                       : SvgPicture.asset(
//                                           'assets/images/switch-grey.svg'),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             height: 15.h,
//                           ),
//                           Container(
//                             padding: EdgeInsets.symmetric(horizontal: 18.w),
//                             width: 350.w,
//                             height: 50.h,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               border: Border.all(
//                                 color: grey,
//                                 width: 1,
//                               ),
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   'Break',
//                                   style: GoogleFonts.syne(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w700,
//                                     color: black,
//                                   ),
//                                 ),
//                                 GestureDetector(
//                                   onTap: () {
//                                     setState(() {
//                                       switchState = 2;
//                                       saveSwitchState(switchState);
//                                     });
//                                   },
//                                   child: switchState == 2
//                                       ? SvgPicture.asset(
//                                           'assets/images/switch-orange.svg')
//                                       : SvgPicture.asset(
//                                           'assets/images/switch-grey.svg'),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           // SizedBox(
//                           //   height: 15.h,
//                           // ),
//                           // Container(
//                           //   padding: EdgeInsets.symmetric(horizontal: 18.w),
//                           //   width: 350.w,
//                           //   height: 50.h,
//                           //   decoration: BoxDecoration(
//                           //     borderRadius: BorderRadius.circular(10),
//                           //     border: Border.all(
//                           //       color: grey,
//                           //       width: 1,
//                           //     ),
//                           //   ),
//                           //   child: Row(
//                           //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           //     children: [
//                           //       Text(
//                           //         'Offline',
//                           //         style: GoogleFonts.syne(
//                           //           fontSize: 14,
//                           //           fontWeight: FontWeight.w700,
//                           //           color: black,
//                           //         ),
//                           //       ),
//                           //       GestureDetector(
//                           //         onTap: () {
//                           //           setState(() {
//                           //             switchState = 3;
//                           //           });
//                           //         },
//                           //         child: switchState == 3
//                           //             ? SvgPicture.asset(
//                           //                 'assets/images/switch-orange.svg')
//                           //             : SvgPicture.asset(
//                           //                 'assets/images/switch-grey.svg'),
//                           //       ),
//                           //     ],
//                           //   ),
//                           // ),
//                           const Spacer(),
//                           Padding(
//                             padding: EdgeInsets.only(bottom: 50.0.h),
//                             child: isUpdating
//                                 ? apiButton(context)
//                                 : GestureDetector(
//                                     onTap: () {
//                                       updateStatus(context);
//                                     },
//                                     child: buttonContainer(context, 'DONE'),
//                                   ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//       );
//   }
//
//   bool isUpdating = false;
//   APIResponse<LogInModel>? _updateResponse;
//
//   updateStatus(BuildContext context) async {
//     setState(() {
//       isUpdating = true;
//     });
//     Map updateData = {
//       "users_fleet_id": userID.toString(),
//       "availability": selectShift == 1 ? 'Full-Time' : 'Part-Time',
//       "online_status": switchState == 1 ? 'Work' : 'Break',
//     };
//
//     _updateResponse = await service.updateRiderStatusApi(updateData);
//     if (_updateResponse!.status!.toLowerCase() == 'success') {
//       if (_updateResponse!.data != null) {
//         showToastSuccess('Status updated successfully', FToast().init(context));
//       }
//     } else {
//       showToastError(_updateResponse!.message!, FToast().init(context));
//     }
//     setState(() {
//       isUpdating = false;
//     });
//   }
//
//   void loadSwitchState() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       switchState = prefs.getInt('switchState') ?? -1;
//     });
//   }
//
//   void saveSwitchState(int state) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setInt('switchState', state);
//   }
//
//   void loadShiftState() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       selectShift = prefs.getInt('switchShift') ?? -1;
//     });
//   }
//
//   void saveShiftState(int state) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setInt('switchShift', state);
//   }
// }