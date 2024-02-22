import 'package:deliver_partner/Constants/PageLoadingKits.dart';
import 'package:deliver_partner/DeleteAccountScreen.dart';
import 'package:deliver_partner/models/API%20models/API%20response.dart';
import 'package:deliver_partner/models/API%20models/LogInModel.dart';
import 'package:deliver_partner/models/NotificationSettingModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../Constants/Colors.dart';
import '../../../Constants/back-arrow-with-container.dart';
import '../../services/API_services.dart';
import '../../utilities/showToast.dart';

String? notificationStatus = "Yes";

class SettingsScreenFleet extends StatefulWidget {
  const SettingsScreenFleet({super.key});

  @override
  State<SettingsScreenFleet> createState() => _SettingsScreenFleetState();
}

class _SettingsScreenFleetState extends State<SettingsScreenFleet> {
  int userID = -1;
  bool switchStatus = true;

  checkSwitch() async {
    if (switchStatus == true) {
      notificationStatus = "Yes";
    } else {
      notificationStatus = "No";
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
          "https://deliver.eigix.net/api/update_notification_switch_fleet";
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

//   APIResponse<LogInModel>? _updateResponse;
//   bool isUpdating = false;
//   updateNotification(BuildContext context) async {
//     setState(() {
//       isUpdating = true;
//     });
//     Map updateData = {
//       "users_fleet_id": userID.toString(),
//       "notifications": isToggled ? 'Yes' : 'No',
//     };
//
//     _updateResponse = await service.updateNotificationStatusApi(updateData);
//
//     if (_updateResponse!.status!.toLowerCase() == 'success') {
//       isToggled
//           ? showToastSuccess(
//               'Notifications are enabled', FToast().init(context))
//           : showToastSuccess(
//               'Notifications are disabled', FToast().init(context));
//     } else {
//       showToastError(_updateResponse!.message!, FToast().init(context));
//     }
//     setState(() {
//       isUpdating = false;
//     });
//   }
}
