import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:deliver_partner/RiderScreens/DrivingLicensePictureVerification.dart';
import 'package:deliver_partner/RiderScreens/one.dart';
import 'package:deliver_partner/models/API_models/API_response.dart';
import 'package:deliver_partner/models/API_models/LogInModel.dart';
import 'package:deliver_partner/services/API_services.dart';
import 'package:deliver_partner/temploginReider.dart';
import 'package:deliver_partner/widgets/DrawerWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Constants/drawer_container.dart';
import '../utilities/showToast.dart';
import 'AfterLogInScreens/DriverStatusScreen.dart';
import 'AfterLogInScreens/HomeScreens/HomeScreens.dart';
import 'AfterLogInScreens/RankingScreen.dart';
import 'AfterLogInScreens/RidesScreens/RidesScreen.dart';
import 'DashBoardScreens/DashBoard.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  ApiServices get service => GetIt.I<ApiServices>();
  final List _pages = [
    const HomeScreen(),
    const RidesScreen(),
    const RankingScreen(),
    const DriverStatusScreen(),
  ];

  int _currentIndex = 0;

  void onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isLargeScreen =
        screenSize.width > 600; // Adjust the threshold as needed

    return WillPopScope(
      onWillPop: () async {
        if (_currentIndex == 0) {
          SystemNavigator.pop();
          return true;
        } else {
          setState(() {
            _currentIndex = 0;
          });
        }
        return false;
      },
      child: Scaffold(
        // backgroundColor: Colors.white,
        // drawer: const DrawerWidget(),
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   elevation: 0,
        //   leadingWidth: 70,
        //   leading: Builder(builder: (context) {
        //     return Padding(
        //       padding: const EdgeInsets.only(top: 8.0, left: 20),
        //       child: GestureDetector(
        //           onTap: () => Scaffold.of(context).openDrawer(),
        //           child: const Icon(
        //             Icons.menu,
        //             color: Colors.black,
        //           )),
        //     );
        //   }),
        //   centerTitle: true,
        //   title: _currentIndex == 0
        //       ? GestureDetector(
        //           onTap: () async {
        //             sharedPreferences = await SharedPreferences.getInstance();
        //             userID = (sharedPreferences.getInt('userID') ?? -1);
        //             // var status = await OneSignal.shared.getDeviceState();
        //             // // print("OneSignal Device ID: ${status!.deviceId}");
        //             // String? tokenId = status!.userId;
        //             // print("OneSignal User ID: $tokenId");
        //             var ID4 = OneSignal.User.pushSubscription.id;
        //             print("$ID4");
        //             final response = await sendNotification(
        //                 [ID4!],
        //                 "You got notification From Deliver Partner",
        //                 "Deliver Partner");
        //             print(response.body);
        //             print(response.persistentConnection);

        //             // var ID2 = OneSignal.User.pushSubscription.optedIn;
        //             // var ID3 = OneSignal.User.pushSubscription.token;
        //             // var externalId = await OneSignal.User.getExternalId();
        //             // var tags = await OneSignal.User.getTags();
        //             // print("tags: $tags");
        //             // print("Setting external user ID $userID");
        //             // if (userID == null) return;
        //             // OneSignal.loginWithJWT(userID.toString(), "$ID3");
        //             // OneSignal.User.addAlias("PartnerID", "$userID");
        //             // void observePushSubscription() {
        //             //   OneSignal.User.pushSubscription
        //             //       .addObserver((stateChanges) {
        //             //     print(
        //             //         'Subscription Status: ${stateChanges.current.optedIn}');
        //             //     print(OneSignal.User.pushSubscription.id);
        //             //     print(OneSignal.User.pushSubscription.token);
        //             //     print(stateChanges.current.jsonRepresentation());
        //             //   });
        //             // }

        //             // var url =
        //             //     Uri.parse('https://onesignal.com/api/v1/notifications');
        //             // var response = await http.post(
        //             //   url,
        //             //   headers: {
        //             //     'Content-Type': 'application/json; charset=utf-8',
        //             //     'Authorization':
        //             //         'Basic OGMxMWE2ZDgtNmRiNi00Y2VjLTk5MTMtZmE3Y2Q3YTQ3MDE2',
        //             //   },
        //             //   body: jsonEncode({
        //             //     'app_id': appID,
        //             //     'contents': {'en': 'English Message'},
        //             //     'headings': {'en': 'English Title'},
        //             //     'include_player_ids': [
        //             //       '96079b55-52c0-4797-bb43-86b8c413af5e'
        //             //     ], // Add the user's OneSignal ID here
        //             //   }),
        //             // );

        //             // if (response.statusCode == 200) {
        //             //   print("Notification sent successfully");
        //             //   print("Notification Body ${response.body}");
        //             // } else {
        //             //   print("Failed to send notification: ${response.body}");
        //             // }
        //             // print("ID: $ID");
        //             // print("ID2: $ID2");
        //             // print("ID3: $ID3");
        //             // observePushSubscription();
        //             // print('External ID: $externalId');
        //             // print("Tapping");
        //             // OneSignal.User.pushSubscription.addObserver((state) {
        //             //   print('Subscription Status: ${state.current.optedIn}');
        //             //   print(OneSignal.User.pushSubscription.id);
        //             //   print(OneSignal.User.pushSubscription.token);
        //             //   print(state.current.jsonRepresentation());
        //             // });

        //             // Navigator.push(
        //             //   context,
        //             //   MaterialPageRoute(builder: (context) => ONE()),
        //             // );
        //           },
        //           child: Text(
        //             'Home',
        //             style: GoogleFonts.syne(
        //               fontSize: isLargeScreen ? 32 : 22,
        //               fontWeight: FontWeight.w700,
        //               color: Colors.black,
        //             ),
        //           ),
        //         )
        //       : _currentIndex == 1
        //           ? Text(
        //               'Rides',
        //               style: GoogleFonts.syne(
        //                 fontSize: isLargeScreen ? 32 : 22,
        //                 fontWeight: FontWeight.w700,
        //                 color: Colors.black,
        //               ),
        //             )
        //           : _currentIndex == 2
        //               ? Text(
        //                   'My Reviews',
        //                   style: GoogleFonts.syne(
        //                     fontSize: isLargeScreen ? 32 : 22,
        //                     fontWeight: FontWeight.w700,
        //                     color: Colors.black,
        //                   ),
        //                 )
        //               : Text(
        //                   'Rider Status',
        //                   style: GoogleFonts.syne(
        //                     fontSize: isLargeScreen ? 32 : 22,
        //                     fontWeight: FontWeight.w700,
        //                     color: Colors.black,
        //                   ),
        //                 ),
        // ),
        body: _pages[_currentIndex],
        bottomNavigationBar: Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          children: [
            BottomNavigationBar(
              landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
              mouseCursor: MouseCursor.defer,
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset('assets/images/home-grey.svg'),
                  activeIcon: SvgPicture.asset('assets/images/home-orange.svg'),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset('assets/images/ride-grey.svg'),
                  activeIcon: SvgPicture.asset('assets/images/ride-orange.svg'),
                  label: 'Rides History',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset('assets/images/rank-grey.svg'),
                  activeIcon: SvgPicture.asset('assets/images/rank-orange.svg'),
                  label: 'My Reviews',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset('assets/images/rider-grey.svg'),
                  activeIcon:
                      SvgPicture.asset('assets/images/rider-orange.svg'),
                  label: 'Driver Status',
                ),
              ],
              currentIndex: _currentIndex,
              onTap: onTap,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              showUnselectedLabels: true,
              showSelectedLabels: true,
              iconSize: 20,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.grey,
              selectedLabelStyle: GoogleFonts.syne(
                fontWeight: FontWeight.w500,
                fontSize: isLargeScreen ? 16 : 12,
              ),
              unselectedLabelStyle: GoogleFonts.syne(
                fontWeight: FontWeight.w400,
                fontSize: isLargeScreen ? 16 : 12,
              ),
            ),
            Positioned(
              // top: -40,
              bottom: 30,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const DashBoard(),
                    ),
                  );
                },
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    'assets/images/nav-button.svg',
                    fit: BoxFit.scaleDown,
                    width: 25,
                    height: 25,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<http.Response> sendNotification(
      List<String> tokenIdList, String contents, String heading) async {
    print("tokenId $tokenIdList");
    print("appID $appID");
    print("Hello world");
    return await post(
      Uri.parse('https://onesignal.com/api/v1/notifications'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "app_id": appID,
        //kAppId is the App Id that one get from the OneSignal When the application is registered.

        "include_player_ids": tokenIdList,
        //tokenIdList Is the List of All the Token Id to to Whom notification must be sent.

        // android_accent_color reprsent the color of the heading text in the notifiction
        "android_accent_color": "FF9976D2",

        "small_icon": "ic_launcher",

        "large_icon":
            "https://deliverbygfl.com/public/uploads/system_image/logo2.png",

        "headings": {"en": heading},

        "contents": {"en": contents},
      }),
    );
  }
}
