import 'dart:convert';

import 'package:deliver_partner/ChooseAppScreen.dart';
import 'package:deliver_partner/Constants/Colors.dart';
import 'package:deliver_partner/Constants/PageLoadingKits.dart';
import 'package:deliver_partner/FleetScreens/DrawerSceensFleet/SupportScreen.dart';
import 'package:deliver_partner/FleetScreens/FleetHomeScreens/AddVehicleScreensFleet/AddVehicleFleetFirstScreen.dart';
import 'package:deliver_partner/RiderScreens/DrawerScreens/Banking/AllRecentTransactions.dart';
import 'package:deliver_partner/RiderScreens/DrawerScreens/LegalScreen.dart';
import 'package:deliver_partner/RiderScreens/DrawerScreens/Accepted%20Rides/acceptedRides.dart';
import 'package:deliver_partner/RiderScreens/DrawerScreens/Rider%20Support/riderSupportScreen.dart';
import 'package:deliver_partner/RiderScreens/DrawerScreens/schedule%20Clients/scheduleRidesScreen.dart';
import 'package:deliver_partner/RiderScreens/RequestRideFromFleetActive.dart';
import 'package:deliver_partner/models/API_models/LogInModel.dart';
import 'package:deliver_partner/models/API_models/requestBikeValidation.dart';
import 'package:deliver_partner/models/API_models/switchUserModel.dart';
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
import '../RiderScreens/DrawerScreens/AwardScreens/AwardsScreen.dart';
import '../RiderScreens/DrawerScreens/Banking/BankingScreen.dart';
import '../RiderScreens/DrawerScreens/NotificationScreen.dart';
import '../RiderScreens/DrawerScreens/ProfileScreens/ProfileScreen.dart';
import '../RiderScreens/DrawerScreens/ScooterDetails/ScooterDetails.dart';
import '../RiderScreens/DrawerScreens/Settings/SettingsScreen.dart';
import '../RiderScreens/DrawerScreens/UpdateLocation.dart';
import '../RiderScreens/DrawerScreens/schedule Clients/ScheduleClients.dart';
import '../models/API_models/API_response.dart';
import '../services/API_services.dart';
import '../utilities/showToast.dart';
import 'package:http/http.dart' as http;

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
  String? userFirstName;
  String? userLastName;
  String? userProfilePic;
  String? parentId;

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
    requestValidation();
  }

  SwitchUserModel switchUserModel = SwitchUserModel();
  switchUserType() async {
    await sharedPrefs();
    var headersList = {'Accept': '*/*', 'Content-Type': 'application/json'};
    var url = Uri.parse('https://cs.deliverbygfl.com/api/switch_user_type');

    var body = {
      "users_fleet_id": "$userID",
      "user_type": "Rider",
      "switch_to": "Fleet"
    };

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode == 200) {
      switchUserModel = switchUserModelFromJson(resBody);

      print(resBody);
    } else {
      print(res.reasonPhrase);
      switchUserModel = switchUserModelFromJson(resBody);
    }
  }

  ValidationRequestModel validationRequestModel = ValidationRequestModel();
  requestValidation() async {
    await sharedPrefs();
    var headersList = {'Accept': '*/*', 'Content-Type': 'application/json'};
    var url =
        Uri.parse('https://cs.deliverbygfl.com/api/has_rider_fleet_vehicle');

    var body = {"users_fleet_id": "$userID", "user_type": "Rider"};

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode == 200) {
      validationRequestModel = validationRequestModelFromJson(resBody);
      print(validationRequestModel.status);
      print(resBody);
      setState(() {
        isLoading = false;
        // gettingCategory = true;
      });
    } else {
      print(res.reasonPhrase);
      validationRequestModel = validationRequestModelFromJson(resBody);
    }
  }

  sharedPrefs() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userID = (sharedPreferences.getInt('userID') ?? -1);
    userFirstName = (sharedPreferences.getString('userFirstName') ?? '');
    userLastName = (sharedPreferences.getString('userLastName') ?? '');
    userProfilePic = (sharedPreferences.getString('userProfilePic') ?? '');
    parentId = (sharedPreferences.getString('parentId') ?? '');

    print(
        'sharedPref Data: $userID, $userFirstName, $userLastName, $userProfilePic , $parentId');
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? spinKitRotatingCircle
        : Drawer(
            width: 280.w,
            backgroundColor: Colors.white,
            child: SingleChildScrollView(
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
                          'https://cs.deliverbygfl.com/public/${userProfilePic ?? ''}',
                          // 'https://cs.deliverbygfl.com/public/${getUserProfileResponse!.data!.profile_pic ?? ''}',
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
                                value: loadingProgress.expectedTotalBytes !=
                                        null
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
                  SizedBox(
                    height: 40.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 34, top: 10),
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
                          leading:
                              SvgPicture.asset('assets/images/profile.svg'),
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
                              builder: (context) =>
                                  const AllRecentTransactions(),
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
                        ListTile(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ScheduledRideScreen(),
                              ),
                            );
                          },
                          leading:
                              SvgPicture.asset('assets/images/ride-orange.svg'),
                          title: Text(
                            'Schedule Rides',
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
                        ListTile(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const AcceptedRides(),
                              ),
                            );
                          },
                          leading:
                              SvgPicture.asset('assets/images/ride-orange.svg'),
                          title: Text(
                            'Accepted Rides',
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
                        // available jobs list
                        ListTile(
                          onTap: () async {
                            await requestValidation();
                            if (validationRequestModel.status == "success") {
                              print("$parentId");
                              // Check for parentId == "0" moved outside to avoid repetition
                              if (parentId == "0" &&
                                  validationRequestModel.data!.status ==
                                      "Active") {
                                print("This Run in Active: $parentId");
                                showToastSuccess(
                                  'You already have a Vehicle',
                                  FToast().init(context),
                                  seconds: 3,
                                );
                              } else if (parentId != "0") {
                                // This condition is now correctly placed to check other statuses
                                if (validationRequestModel.data!.status ==
                                    "Accepted") {
                                  print("This Run in Accepted: $parentId");
                                  showToastSuccess(
                                    'You already have a Vehicle',
                                    FToast().init(context),
                                    seconds: 3,
                                  );
                                } else if (validationRequestModel
                                        .data!.status ==
                                    "Pending") {
                                  print("This Run in Pending: $parentId");
                                  showToastSuccess(
                                    'Stay Tuned you already Made Request for Vehicle',
                                    FToast().init(context),
                                    seconds: 3,
                                  );
                                }
                              }
                            } else {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      RequestRideFromFleetActive(
                                    parentID: parentId!,
                                    userFleetId: userID.toString(),
                                  ),
                                ),
                              );
                            }
                          },
                          leading:
                              SvgPicture.asset('assets/images/ride-orange.svg'),
                          title: Text(
                            'Request a Vehicle',
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
                        ListTile(
                          onTap: () async {
                            await requestValidation();
                            if (validationRequestModel.status == "success") {
                              if (parentId == "0" &&
                                  validationRequestModel.data!.status ==
                                      "Active") {
                                print("This Run in Active: $parentId");
                                showToastSuccess(
                                  'You already have a Vehicle',
                                  FToast().init(context),
                                  seconds: 3,
                                );
                              } else if (parentId != "0") {
                                // This condition is now correctly placed to check other statuses
                                if (validationRequestModel.data!.status ==
                                    "Accepted") {
                                  print("This Run in Accepted: $parentId");
                                  showToastSuccess(
                                    'You already have a Vehicle',
                                    FToast().init(context),
                                    seconds: 3,
                                  );
                                } else if (validationRequestModel
                                        .data!.status ==
                                    "Pending") {
                                  print("This Run in Pending: $parentId");
                                  showToastSuccess(
                                    'Stay Tuned you already Made Request for Vehicle',
                                    FToast().init(context),
                                    seconds: 3,
                                  );
                                }
                              }
                            } else {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const AddVehicleFleetFirstScreen(
                                    userType: 'Rider',
                                  ),
                                ),
                              );
                            }
                          },
                          leading:
                              SvgPicture.asset('assets/images/ride-orange.svg'),
                          title: Text(
                            'Add a Vehicle',
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
                        // notification list
                        SizedBox(
                          height: 12.h,
                        ),
                        ListTile(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const NotificationScreen(),
                            ),
                          ),
                          leading: SvgPicture.asset(
                              'assets/images/notification.svg'),
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
                          onTap: () async {
                            // Show the alert dialog
                            final result = await showDialog<bool>(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text(
                                    'Switch User Type',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors
                                          .orange, // Customize title color
                                    ),
                                  ),
                                  content: Text(
                                    'If you switch, you will lose the following data:\n\n'
                                    '~ All of your bikes and vehicles that are under some fleet\n'
                                    '~ You will need to add your bike and verify yourself as a rider again\n\n'
                                    'This verification process could take up to 24 hours. Do you wish to proceed?',
                                    style: TextStyle(
                                      color: Colors.grey[
                                          600], // Customize content text color
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => Navigator.of(context)
                                          .pop(false), // User disagrees
                                      child: const Text(
                                        'Cancel',
                                        style: TextStyle(
                                            color: Colors
                                                .red), // Customize button text color
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.of(context)
                                          .pop(true), // User agrees
                                      child: const Text(
                                        'Proceed',
                                        style: TextStyle(
                                            color: Colors
                                                .green), // Customize button text color
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );

                            // Check the dialog result
                            if (result == true) {
                              // User agreed to switch
                              await switchUserType();
                              showToastSuccess(
                                  'Switching to fleet', FToast().init(context),
                                  seconds: 1);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const BottomNavBarFleet(),
                                ),
                              );
                            }
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
                        ListTile(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const RiderSupportScreen(
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
                          height: 40.h,
                        ),
                        // log out tile
                        ListTile(
                          onTap: () {
                            showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                              ),
                              backgroundColor: orange.withOpacity(0.8),
                              context: context,
                              builder: (context) => Container(
                                height: 250.h,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  ),
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
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const ChooseAppScreen(),
                                                ),
                                                (route) => false);
                                        // await sharedPreferences.setString(
                                        //     'isLogin', 'false');
                                        SharedPreferences sharedPref =
                                            await SharedPreferences
                                                .getInstance();
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
            ),
          );
  }
}
