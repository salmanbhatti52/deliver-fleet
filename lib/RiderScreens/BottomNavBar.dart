import 'package:deliver_partner/widgets/DrawerWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Constants/Colors.dart';
import '../Constants/drawer_container.dart';
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
    //             label: 'Home',
    //           ),
    //           BottomNavigationBarItem(
    //             icon: SvgPicture.asset('assets/images/ride-grey.svg'),
    //             activeIcon: SvgPicture.asset('assets/images/ride-orange.svg'),
    //             label: 'Rides',
    //           ),
    //           BottomNavigationBarItem(
    //             icon: SvgPicture.asset('assets/images/rank-grey.svg'),
    //             activeIcon: SvgPicture.asset('assets/images/rank-orange.svg'),
    //             label: 'My Reviews',
    //           ),
    //           BottomNavigationBarItem(
    //             icon: SvgPicture.asset('assets/images/rider-grey.svg'),
    //             activeIcon: SvgPicture.asset('assets/images/rider-orange.svg'),
    //             label: 'Driver Status',
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
          backgroundColor: white,
          drawer: const DrawerWidget(),
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            leadingWidth: 70,
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
                    'Home',
                    style: GoogleFonts.syne(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: black,
                    ),
                  )
                : _currentIndex == 1
                    ? Text(
                        'Rides',
                        style: GoogleFonts.syne(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: black,
                        ),
                      )
                    : _currentIndex == 2
                        ? Text(
                            'My Reviews',
                            style: GoogleFonts.syne(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: black,
                            ),
                          )
                        : Text(
                            'Rider Status',
                            style: GoogleFonts.syne(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: black,
                            ),
                          ),
          ),
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
                    activeIcon:
                        SvgPicture.asset('assets/images/home-orange.svg'),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset('assets/images/ride-grey.svg'),
                    activeIcon:
                        SvgPicture.asset('assets/images/ride-orange.svg'),
                    label: 'Rides',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset('assets/images/rank-grey.svg'),
                    activeIcon:
                        SvgPicture.asset('assets/images/rank-orange.svg'),
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
                  onTap: () {
                    Navigator.of(
                      context,
                    ).push(
                      MaterialPageRoute(
                        builder: (context) => const DashBoard(),
                      ),
                    );
                  },
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
