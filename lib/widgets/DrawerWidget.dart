import 'package:Deliver_Rider/ChooseAppScreen.dart';
import 'package:Deliver_Rider/Constants/Colors.dart';
import 'package:Deliver_Rider/Constants/PageLoadingKits.dart';
import 'package:Deliver_Rider/models/API%20models/LogInModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/buttonConatinerWithBorder.dart';
import '../Constants/buttonContainer.dart';
import '../FleetScreens/BottomNavBarFleet.dart';
import '../FleetScreens/OnboardingFleetScreen.dart';
import '../RiderScreens/BottomNavBar.dart';
import '../RiderScreens/DrawerScreens/AwardScreens/AwardsScreen.dart';
import '../RiderScreens/DrawerScreens/Banking/BankingScreen.dart';
import '../RiderScreens/DrawerScreens/NotificationScreen.dart';
import '../RiderScreens/DrawerScreens/ProfileScreens/ProfileScreen.dart';
import '../RiderScreens/DrawerScreens/ScooterDetails/ScooterDetails.dart';
import '../RiderScreens/DrawerScreens/Settings/SettingsScreen.dart';
import '../RiderScreens/DrawerScreens/UpdateLocation.dart';
import '../models/API models/API response.dart';
import '../services/API_services.dart';
import '../utilities/showToast.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  ApiServices get service => GetIt.I<ApiServices>();

  int userID = -1;

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

  late APIResponse<LogInModel>? getUserProfileResponse;

  init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userID = (sharedPreferences.getInt('userID') ?? -1);

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
  Widget build(
    BuildContext context,
  ) {
    return isLoading
        ? spinKitRotatingCircle
        : Drawer(
            backgroundColor: white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 250.h,
                  width: double.infinity,
                  child: DrawerHeader(
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.zero,
                    decoration: const BoxDecoration(
                      color: white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 90.h),
                          width: 85.w,
                          height: 85.h,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: lightWhite,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            // color: red,
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                'https://deliver.eigix.net/public/${getUserProfileResponse!.data!.profile_pic ?? ''}',
                                fit: BoxFit.cover,
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return SizedBox(
                                      child: Image.asset(
                                    'assets/images/place-holder.png',
                                    fit: BoxFit.scaleDown,
                                  ));
                                },
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: orange,
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  );
                                },
                              )),
                        ),
                        Text(
                          '${getUserProfileResponse!.data!.first_name!} ${getUserProfileResponse!.data!.last_name!}',
                          style: GoogleFonts.syne(
                            fontSize: 14,
                            color: black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 32.w,
                  ),
                  color: white,
                  width: double.infinity,
                  height: 550.h,
                  child: Column(
                    children: [
                      // profile list
                      ListTile(
                        style: ListTileStyle.drawer,
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ProfileScreen(),
                          ),
                        ),
                        leading: SvgPicture.asset('assets/images/profile.svg'),
                        title: Text(
                          'Profile',
                          style: GoogleFonts.syne(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: black,
                          ),
                        ),
                        visualDensity: VisualDensity.compact,
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                      ),
                      SizedBox(
                        height: 12.h,
                      ),

                      // banking list
                      ListTile(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const BankingScreen(),
                          ),
                        ),
                        leading: SvgPicture.asset('assets/images/wallet.svg'),
                        title: Text(
                          'Banking',
                          style: GoogleFonts.syne(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: black,
                          ),
                        ),
                        visualDensity: VisualDensity.compact,
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      // scooter list
                      ListTile(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const ScooterDetails(),
                            ),
                          );
                        },
                        leading:
                            SvgPicture.asset('assets/images/ride-orange.svg'),
                        title: Text(
                          'Vehicle Details',
                          style: GoogleFonts.syne(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: black,
                          ),
                        ),
                        visualDensity: VisualDensity.compact,
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      // update location list
                      ListTile(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const UpdateLocation(),
                          ),
                        ),
                        leading: SvgPicture.asset(
                          'assets/images/update-icon.svg',
                          width: 30.w,
                          fit: BoxFit.scaleDown,
                          colorFilter: ColorFilter.mode(
                            orange,
                            BlendMode.srcIn,
                          ),
                        ),
                        title: Text(
                          'Update Location',
                          style: GoogleFonts.syne(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: black,
                          ),
                        ),
                        visualDensity: VisualDensity.compact,
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      // awards list
                      ListTile(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const AwardsScreen(),
                          ),
                        ),
                        leading: SvgPicture.asset('assets/images/medal.svg'),
                        title: Text(
                          'Awards',
                          style: GoogleFonts.syne(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: black,
                          ),
                        ),
                        visualDensity: VisualDensity.compact,
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      // loyalty points
                      ListTile(
                        onTap: () {
                          showToastSuccess(
                              'switching to fleet', FToast().init(context),
                              seconds: 1);
                          Navigator.of(context).push(
                            // MaterialPageRoute(
                            //   builder: (context) => const OnboardingFleetScreen(
                            //     fleet: 'Fleet',
                            //   ),
                            // ),
                            MaterialPageRoute(
                              builder: (context) => const BottomNavBarFleet(),
                            ),
                          );
                        },
                        leading: const Icon(
                          Icons.switch_access_shortcut_rounded,
                          color: orange,
                        ),
                        title: Text(
                          'Switch To Fleet',
                          style: GoogleFonts.syne(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: black,
                          ),
                        ),
                        visualDensity: VisualDensity.compact,
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                      ),
                      // available jobs list
                      // ListTile(
                      //   onTap: () => Navigator.of(context).push(
                      //     MaterialPageRoute(
                      //       builder: (context) => AvailableJobs(),
                      //     ),
                      //   ),
                      //   leading: SvgPicture.asset('assets/images/jobs.svg'),
                      //   title: Text(
                      //     'Available Jobs',
                      //     style: GoogleFonts.syne(
                      //       fontSize: 16,
                      //       fontWeight: FontWeight.w500,
                      //       color: black,
                      //     ),
                      //   ),
                      //   visualDensity: VisualDensity.compact,
                      //   contentPadding: EdgeInsets.zero,
                      //   dense: true,
                      // ),
                      // notification list
                      ListTile(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const NotificationScreen(),
                          ),
                        ),
                        leading:
                            SvgPicture.asset('assets/images/notification.svg'),
                        title: Text(
                          'Notifications',
                          style: GoogleFonts.syne(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: black,
                          ),
                        ),
                        visualDensity: VisualDensity.compact,
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      // settings tile
                      ListTile(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const SettingsScreen(),
                          ),
                        ),
                        leading: SvgPicture.asset(
                          'assets/images/settings-icon.svg',
                          colorFilter:
                              const ColorFilter.mode(orange, BlendMode.srcIn),
                        ),
                        title: Text(
                          'Settings',
                          style: GoogleFonts.syne(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: black,
                          ),
                        ),
                        visualDensity: VisualDensity.compact,
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                      ),
                      const Spacer(),
                      // log out tile
                      ListTile(
                        onTap: () {
                          showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: const BorderSide(
                                color: orange,
                                width: 2,
                              ),
                            ),
                            backgroundColor: orange.withOpacity(0.8),
                            context: context,
                            builder: (context) => Container(
                              height: 250.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 22, vertical: 22),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'Are you sure you want to logout?',
                                    style: GoogleFonts.syne(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50.h,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ChooseAppScreen(),
                                          ),
                                          (route) => false);
                                      // await sharedPreferences.setString(
                                      //     'isLogin', 'false');
                                        SharedPreferences sharedPref = await SharedPreferences.getInstance();
                                        await sharedPref.clear();
                                        setState(() {});
                                    },
                                    child: buttonContainer(
                                        context, 'YES, LOG ME OUT'),
                                  ),
                                  GestureDetector(
                                    onTap: () => Navigator.of(context).pop(),
                                    child: buttonContainerWithBorder(
                                        context, 'KEEP ME LOGGED IN'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        leading: SvgPicture.asset('assets/images/logout.svg'),
                        title: Text(
                          'Logout',
                          style: GoogleFonts.syne(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: black,
                          ),
                        ),
                        visualDensity: VisualDensity.compact,
                        contentPadding: const EdgeInsets.only(bottom: 20),
                        dense: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
