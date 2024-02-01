import 'package:deliver_partner/ChooseAppScreen.dart';
import 'package:deliver_partner/Constants/Colors.dart';
import 'package:deliver_partner/Constants/PageLoadingKits.dart';
import 'package:deliver_partner/Constants/buttonConatinerWithBorder.dart';
import 'package:deliver_partner/Constants/buttonContainer.dart';
import 'package:deliver_partner/FleetScreens/DrawerSceensFleet/SettingsScreenFleet.dart';
import 'package:deliver_partner/FleetScreens/DrawerSceensFleet/SupportScreen.dart';
import 'package:deliver_partner/RiderScreens/DrawerScreens/ContactSupport.dart';
import 'package:deliver_partner/RiderScreens/VerifyDrivingLisecnseManually.dart';
import 'package:deliver_partner/models/API%20models/LogInModel.dart';
import 'package:deliver_partner/models/APIModelsFleet/GetAllSupportAdmin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../FleetScreens/DrawerSceensFleet/InviteRiders.dart';
import '../FleetScreens/DrawerSceensFleet/LegalScreen.dart';
import '../RiderScreens/BottomNavBar.dart';
import '../RiderScreens/DrawerScreens/NotificationScreen.dart';
import '../models/API models/API response.dart';
import '../services/API_services.dart';
import '../utilities/showToast.dart';

class DrawerWidgetFleet extends StatefulWidget {
  const DrawerWidgetFleet({
    super.key,
  });

  @override
  State<DrawerWidgetFleet> createState() => _DrawerWidgetFleetState();
}

class _DrawerWidgetFleetState extends State<DrawerWidgetFleet> {
  ApiServices get service => GetIt.I<ApiServices>();

  int userID = -1;
  String userEmail = '';
  String? userFirstName;
  String? userLastName;
  String? userProfilePic;

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

    sharedPrefs();
  }

  sharedPrefs() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userID = (sharedPreferences.getInt('userID') ?? -1);
    userFirstName = (sharedPreferences.getString('userFirstName') ?? '');
    userLastName = (sharedPreferences.getString('userLastName') ?? '');
    userProfilePic = (sharedPreferences.getString('userProfilePic') ?? '');

    print(
        'sharedPref Data: $userID, $userFirstName, $userLastName, $userProfilePic');
    await init();
    setState(() {
      isLoading = false;
    });
  }

  APIResponse<LogInModel>? getUserProfileResponse;

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

    if (mounted) {
      setState(() {
        isLoading = false;
        // gettingCategory = false;
      });
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final screenSize = MediaQuery.of(context).size;
    final isLargeScreen = screenSize.width > 600;
    return Drawer(
      width: isLargeScreen ? 380 : 240,
      backgroundColor: white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 80,
          ),
          Container(
            width: 85.w,
            height: 85.h,
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                width: 1,
                color: white,
              ),
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  'https://deliver.eigix.net/public/${userProfilePic ?? ''}',
                  // 'https://deliver.eigix.net/public/${getUserProfileResponse!.data!.profile_pic ?? ''}',
                  fit: BoxFit.cover,
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return SizedBox(
                        child: Image.asset(
                      'assets/images/place-holder.png',
                      fit: BoxFit.scaleDown,
                    ));
                  },
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        color: orange,
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                )),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            '$userFirstName $userLastName',
            // '${getUserProfileResponse!.data!.first_name!} ${getUserProfileResponse!.data!.last_name!}',
            style: GoogleFonts.syne(
              fontSize: 14,
              color: black,
              fontWeight: FontWeight.w700,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 30,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: isLargeScreen ? 32 : 22,
                ),
                // profile list
                ListTile(
                  style: ListTileStyle.drawer,
                  onTap: () => showDialog(
                      context: context,
                      builder: (context) => InviteRiders(
                            users_fleet_id: getUserProfileResponse!
                                .data!.users_fleet_id!
                                .toString(),
                          )),
                  leading: Image.asset(
                    'assets/images/icons8-invite-48.png',
                    color: orange,
                    width: 22,
                    height: 22,
                    fit: BoxFit.scaleDown,
                  ),
                  title: Text(
                    'Invite Rider',
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
                  height: isLargeScreen ? 12 : 6,
                ),
                // ListTile(
                //   onTap: () => Navigator.of(context).push(
                //     MaterialPageRoute(
                //       builder: (context) => UploadCACScreen(),
                //     ),
                //   ),
                //   style: ListTileStyle.drawer,
                //   leading: SvgPicture.asset(
                //     'assets/images/upload-pic.svg',
                //     height: 25.h,
                //     width: 25.w,
                //     fit: BoxFit.scaleDown,
                //   ),
                //   title: Text(
                //     'Upload CAC Certificate',
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
                // SizedBox(
                //   height: isLargeScreen ? 12 : 6,,
                // ),

                // loyalty points
                ListTile(
                  onTap: () {
                    if (getUserProfileResponse!.data!.driving_license_no ==
                            '' ||
                        getUserProfileResponse!
                                .data!.driving_license_no!.isEmpty &&
                            getUserProfileResponse!.data!.address!.isEmpty &&
                            getUserProfileResponse!.data!.user_type ==
                                'Fleet') {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => VerifyDrivingLicenseManually(
                              email: userEmail, userType: 'Fleet'),
                        ),
                      );
                    } else {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const BottomNavBar(),
                        ),
                      );
                    }
                    showToastSuccess(
                        'Switching to rider', FToast().init(context),
                        seconds: 1);
                    // Navigator.of(context).pushReplacement(
                    //   MaterialPageRoute(
                    //     builder: (context) => getUserProfileResponse!
                    //                 .data!.driving_license_back_image !=
                    //             null
                    //         ? OnboardingScreen(rider: 'Rider')
                    //         : VerifyDrivingLicenseManually(
                    //             email: userEmail, userType: 'Rider'),
                    //   ),
                    // );
                  },
                  leading: const Icon(
                    Icons.switch_access_shortcut_rounded,
                    color: orange,
                  ),
                  title: Text(
                    'Switch To Rider',
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
                  height: isLargeScreen ? 12 : 6,
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
                  leading: SvgPicture.asset(
                    'assets/images/notification.svg',
                    height: 21,
                    width: 21,
                  ),
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
                  height: isLargeScreen ? 12 : 6,
                ),
                // settings tile
                ListTile(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SettingsScreenFleet(),
                    ),
                  ),
                  leading: SvgPicture.asset(
                    'assets/images/settings-fleet-icon.svg',
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
                SizedBox(
                  height: isLargeScreen ? 12 : 6,
                ),
                // legal tile
                ListTile(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LegalScreen(),
                    ),
                  ),
                  leading: SvgPicture.asset(
                    'assets/images/legal-icon.svg',
                    colorFilter:
                        const ColorFilter.mode(orange, BlendMode.srcIn),
                  ),
                  title: Text(
                    'Legal',
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
                  height: isLargeScreen ? 12 : 6,
                ),
                // settings tile
                ListTile(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SupportScreen(
                          // getAdminImage: '$getAdminImage',
                          // getAdminName: '$getAdminName',
                          // getAdminAddress: '$getAdminAddress',
                          // getAdminId: '$getAdminId',
                          ),
                    ),
                  ),
                  leading: SvgPicture.asset(
                    'assets/images/support-icon.svg',
                    colorFilter:
                        const ColorFilter.mode(orange, BlendMode.srcIn),
                  ),
                  title: Text(
                    'Contact Support',
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
                  height: isLargeScreen ? 12 : 6,
                ),
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ChooseAppScreen(),
                                  ),
                                );
                                // sharedPreferences =
                                //     await SharedPreferences.getInstance();
                                // await sharedPreferences.setString(
                                //     'isLogin', 'false');
                                SharedPreferences sharedPref =
                                    await SharedPreferences.getInstance();
                                await sharedPref.clear();
                                setState(() {});
                              },
                              child:
                                  buttonContainer(context, 'YES, LOG ME OUT'),
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
