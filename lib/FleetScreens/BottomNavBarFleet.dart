import 'package:deliver_partner/FleetScreens/ProfileScreensFleet/EditProfileFleet.dart';
import 'package:deliver_partner/FleetScreens/ProfileScreensFleet/ProfileScreenFleet.dart';
import 'package:deliver_partner/widgets/DrawerWidgetFleet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Constants/Colors.dart';
import '../Constants/drawer_container.dart';
import '../Constants/editButtonContainer.dart';
import 'CalenderScreens/CalenderScreenFleet.dart';
import 'FleetHomeScreens/AddVehicleScreensFleet/AddVehicleFleetFirstScreen.dart';
import 'FleetHomeScreens/FleetScreen.dart';
import 'SpendingScreenFleet.dart';

class BottomNavBarFleet extends StatefulWidget {
  const BottomNavBarFleet({super.key});

  @override
  State<BottomNavBarFleet> createState() => _BottomNavBarFleetState();
}

class _BottomNavBarFleetState extends State<BottomNavBarFleet> {
  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  final List _pages = [
    const FleetScreen(
      userType: 'Fleet',
    ),
    const CalenderScreenFleet(),
    const SpendingScreenFleet(),
    const ProfileScreenFleet(),
  ];

  int _currentIndex = 0;

  void onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // bool get isIos =>
  //     foundation.defaultTargetPlatform == foundation.TargetPlatform.iOS;

  @override
  Widget build(BuildContext context) {
    // if (isIos) {
    //   return CupertinoTabScaffold(
    //       tabBar: CupertinoTabBar(
    //         currentIndex: _currentIndex,
    //         height: 70.h,
    //         iconSize: 20.sp,
    //         inactiveColor: grey,
    //         activeColor: orange,
    //         backgroundColor: lightWhite,
    //         items: [
    //           BottomNavigationBarItem(
    //             icon: SvgPicture.asset('assets/images/home-grey.svg'),
    //             activeIcon: SvgPicture.asset('assets/images/home-orange.svg'),
    //             label: 'Fleet',
    //           ),
    //           BottomNavigationBarItem(
    //             icon: SvgPicture.asset('assets/images/ride-grey.svg'),
    //             activeIcon: SvgPicture.asset('assets/images/ride-orange.svg'),
    //             label: 'Calender',
    //           ),
    //           BottomNavigationBarItem(
    //             icon: SvgPicture.asset('assets/images/rank-grey.svg'),
    //             activeIcon: SvgPicture.asset('assets/images/rank-orange.svg'),
    //             label: 'Spending',
    //           ),
    //           BottomNavigationBarItem(
    //             icon: SvgPicture.asset('assets/images/rider-grey.svg'),
    //             activeIcon: SvgPicture.asset('assets/images/rider-orange.svg'),
    //             label: 'Profile',
    //           ),
    //         ],
    //         onTap: onTap,
    //       ),
    //       tabBuilder: (context, index) {
    //         return CupertinoTabView(
    //           builder: (context) {
    //             return _pages[_currentIndex];
    //           },
    //         );
    //       });
    // } else {
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
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          key: key,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            leadingWidth: 70,
            actions: [
              Builder(builder: (context) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0, right: 20),
                  child: _currentIndex == 0
                      ? GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  const AddVehicleFleetFirstScreen(
                                userType: 'Fleet',
                              ),
                            ),
                          ),
                          child: addContainer(context),
                        )
                      : _currentIndex == 1
                          ? GestureDetector(
                              child: addContainer(context),
                            )
                          : null,
                );
              }),
              _currentIndex == 3
                  ? Padding(
                      padding: const EdgeInsets.only(top: 8, right: 20),
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const EditProfileFleet(),
                          ),
                        ),
                        child: editButtonContainer(context),
                      ),
                    )
                  : const SizedBox()
            ],
            leading: Builder(builder: (context) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 20),
                child: GestureDetector(
                  onTap: () => Scaffold.of(context).openDrawer(),
                  child: drawerContainer(context),
                ),
              );
            }),
            centerTitle: true,
            title: _currentIndex == 0
                ? Text(
                    'Fleet',
                    style: GoogleFonts.syne(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: black,
                    ),
                  )
                : _currentIndex == 1
                    ? Text(
                        'Calender',
                        style: GoogleFonts.syne(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: black,
                        ),
                      )
                    : _currentIndex == 2
                        ? Text(
                            'Spending',
                            style: GoogleFonts.syne(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: black,
                            ),
                          )
                        : Text(
                            'Profile',
                            style: GoogleFonts.syne(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: black,
                            ),
                          ),
          ),
          drawer: const DrawerWidgetFleet(),
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
                    icon: SvgPicture.asset(
                      'assets/images/fleet-icon.svg',
                      colorFilter:
                          const ColorFilter.mode(grey, BlendMode.srcIn),
                    ),
                    activeIcon:
                        SvgPicture.asset('assets/images/fleet-icon.svg'),
                    label: 'Fleet',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset('assets/images/fleet-calender.svg'),
                    activeIcon: SvgPicture.asset(
                      'assets/images/fleet-calender.svg',
                      colorFilter:
                          const ColorFilter.mode(orange, BlendMode.srcIn),
                    ),
                    label: 'Calender',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset('assets/images/fleet-spending.svg'),
                    activeIcon: SvgPicture.asset(
                      'assets/images/fleet-spending.svg',
                      colorFilter:
                          const ColorFilter.mode(orange, BlendMode.srcIn),
                    ),
                    label: 'Spending',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset('assets/images/fleet-profile.svg'),
                    activeIcon: SvgPicture.asset(
                      'assets/images/fleet-profile.svg',
                      colorFilter:
                          const ColorFilter.mode(orange, BlendMode.srcIn),
                    ),
                    label: 'Profile',
                  ),
                ],
                currentIndex: _currentIndex,
                onTap: onTap,
                type: BottomNavigationBarType.fixed,
                backgroundColor: lightWhite,
                showUnselectedLabels: true,
                showSelectedLabels: true,
                iconSize: 20.sp,
                selectedItemColor: black,
                unselectedItemColor: grey,
                selectedLabelStyle: GoogleFonts.syne(
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                ),
                unselectedLabelStyle: GoogleFonts.syne(
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                ),
              ),
              Positioned(
                top: -40,
                child: GestureDetector(
                  // onTap: () {
                  //   Navigator.of(
                  //     context,
                  //   ).push(
                  //     MaterialPageRoute(
                  //       builder: (context) => DashBoard(),
                  //     ),
                  //   );
                  // },
                  child: Container(
                    width: 60.w,
                    height: 60.h,
                    decoration: const BoxDecoration(
                      color: grey,
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
      ),
    );
    // }
  }
}
