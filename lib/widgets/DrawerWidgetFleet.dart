import 'package:deliver_partner/ChooseAppScreen.dart';
import 'package:deliver_partner/Constants/Colors.dart';
import 'package:deliver_partner/Constants/PageLoadingKits.dart';
import 'package:deliver_partner/Constants/buttonConatinerWithBorder.dart';
import 'package:deliver_partner/Constants/buttonContainer.dart';
import 'package:deliver_partner/FleetScreens/DrawerSceensFleet/SettingsScreenFleet.dart';
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

  String? getAdminId;
  String? getAdminName;
  String? getAdminImage;
  String? getAdminAddress;

  GetSupportAdminModel getSupportAdminModel = GetSupportAdminModel();

  getSupportAdmin() async {
    try {
      String apiUrl = "https://deliver.eigix.net/api/get_admin_list";
      print("apiUrl: $apiUrl");
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Accept': 'application/json',
        },
      );
      final responseString = response.body;
      print("response: $responseString");
      print("statusCode: ${response.statusCode}");
      if (response.statusCode == 200) {
        getSupportAdminModel = getSupportAdminModelFromJson(responseString);
        setState(() {});
        print('getSupportAdminModel status: ${getSupportAdminModel.status}');
        print(
            'getSupportAdminModel length: ${getSupportAdminModel.data!.length}');
        for (int i = 0; i < getSupportAdminModel.data!.length; i++) {
          getAdminId = "${getSupportAdminModel.data![i].usersSystemId}";
          getAdminName = "${getSupportAdminModel.data![i].firstName}";
          getAdminImage = "${getSupportAdminModel.data![i].userImage}";
          getAdminAddress = "${getSupportAdminModel.data![i].address}";
        }
      }
    } catch (e) {
      print('Something went wrong = ${e.toString()}');
      return null;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      isLoading = true;
      getSupportAdmin();
      // gettingCategory = true;
    });
    init();
  }

  late APIResponse<LogInModel>? getUserProfileResponse;

  init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userID = (sharedPreferences.getInt('userID') ?? -1);
    userFirstName = (sharedPreferences.getString('userFirstName') ?? '');
    userLastName = (sharedPreferences.getString('userLastName') ?? '');
    userProfilePic = (sharedPreferences.getString('userProfilePic') ?? '');
    print('sharedPref Data: $userID, $userFirstName, $userLastName, $userProfilePic');

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
            width: 280.w,
            backgroundColor: white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 80.h,
                ),
                Container(
                  width: 85.w,
                  height: 85.h,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      width: 1,
                      color: lightGrey.withOpacity(0.8),
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
                Container(
                  margin: EdgeInsets.only(
                    left: 32.w,
                  ),
                  color: white,
                  width: 280.w,
                  height: 550.h,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50.h,
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
                          width: 25.w,
                          height: 25.h,
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
                        height: 12.h,
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
                      //   height: 12.h,
                      // ),

                      // loyalty points
                      ListTile(
                        onTap: () {
                          if (getUserProfileResponse!
                                      .data!.driving_license_no ==
                                  '' ||
                              getUserProfileResponse!
                                      .data!.driving_license_no!.isEmpty &&
                                  getUserProfileResponse!
                                      .data!.address!.isEmpty &&
                                  getUserProfileResponse!.data!.user_type ==
                                      'Fleet') {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    VerifyDrivingLicenseManually(
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
                        height: 12.h,
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
                        height: 12.h,
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
                        height: 12.h,
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
                        height: 12.h,
                      ),
                      // settings tile
                      ListTile(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ContactSupport(
                                adminPicture: '$getAdminImage',
                                adminName: '$getAdminName',
                                adminAddress: '$getAdminAddress',
                                adminID: '$getAdminId',
                                userID: '$userID'),
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
                        height: 12.h,
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
