import 'package:Deliver_Rider/Constants/PageLoadingKits.dart';
import 'package:Deliver_Rider/models/API%20models/API%20response.dart';
import 'package:Deliver_Rider/models/API%20models/LogInModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Constants/Colors.dart';
import '../../../Constants/back-arrow-with-container.dart';
import '../../services/API_services.dart';
import '../../utilities/showToast.dart';

class SettingsScreenFleet extends StatefulWidget {
  const SettingsScreenFleet({super.key});

  @override
  State<SettingsScreenFleet> createState() => _SettingsScreenFleetState();
}

class _SettingsScreenFleetState extends State<SettingsScreenFleet> {
  ApiServices get service => GetIt.I<ApiServices>();

  int userID = -1;
  String userEmail = '';

  late SharedPreferences sharedPreferences;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      isLoading = true;
      // gettingCategory = true;
    });
    init();
  }

  bool isToggled = false;
  late APIResponse<LogInModel>? getUserProfileResponse;

  init() async {
    isToggled = false;

    sharedPreferences = await SharedPreferences.getInstance();
    userID = (sharedPreferences.getInt('userID') ?? -1);
    userEmail = (sharedPreferences.getString('userEmail') ?? '');

    Map data = {
      "users_fleet_id": userID.toString(),
    };

    getUserProfileResponse = await service.getUserProfileAPI(data);

    if (getUserProfileResponse!.status!.toLowerCase() == 'success') {
      if (getUserProfileResponse!.data != null) {
        // showToastSuccess('Loading user data', FToast().init(context));
      }
    } else {
      showToastError(getUserProfileResponse!.message, FToast().init(context));
    }

    setState(() {
      isLoading = false;
      // gettingCategory = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
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
        leading: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 20),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: backArrowWithContainer(context),
          ),
        ),
      ),
      body: SafeArea(
        child: isLoading
            ? spinKitRotatingCircle
            : Padding(
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
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: black,
                          ),
                        ),
                        isUpdating
                            ? SizedBox(
                                // width: 10.w,
                                height: 10.h,
                                child: SpinKitThreeInOut(
                                  size: 10,
                                  color: orange,
                                  // size: 50.0,
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isToggled = !isToggled;
                                  });
                                  updateNotification(context);
                                },
                                child: SizedBox(
                                  width: 45.w,
                                  height: 25.h,
                                  child: isToggled
                                      ? SvgPicture.asset(
                                          'assets/images/switch-on.svg',
                                          fit: BoxFit.contain,
                                        )
                                      : SvgPicture.asset(
                                          'assets/images/switch-off.svg',
                                          fit: BoxFit.contain,
                                        ),
                                ),
                              ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  APIResponse<LogInModel>? _updateResponse;
  bool isUpdating = false;
  updateNotification(BuildContext context) async {
    setState(() {
      isUpdating = true;
    });
    Map updateData = {
      "users_fleet_id": userID.toString(),
      "notifications": isToggled ? 'Yes' : 'No',
    };

    _updateResponse = await service.updateNotificationStatusApi(updateData);

    if (_updateResponse!.status!.toLowerCase() == 'success') {
      isToggled
          ? showToastSuccess(
              'Notifications are enabled', FToast().init(context))
          : showToastSuccess(
              'Notifications are disabled', FToast().init(context));
    } else {
      showToastError(_updateResponse!.message!, FToast().init(context));
    }
    setState(() {
      isUpdating = false;
    });
  }
}
