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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
        key: key,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          leadingWidth: 70.w,
          actions: [
            Builder(builder: (context) {
              return Padding(
                padding: const EdgeInsets.only(right: 15),
                child: _currentIndex == 0
                    ? GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  const AddVehicleFleetFirstScreen(
                                userType: 'Fleet',
                              ),
                            ),
                          );
                        },
                        child: const Icon(Icons.add, color: Colors.black))
                    : _currentIndex == 1
                        ? GestureDetector(
                            child: addContainer(context),
                          )
                        : null,
              );
            }),
            _currentIndex == 3
                ? Padding(
                    padding: EdgeInsets.only(right: 20.w),
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
              padding: const EdgeInsets.only(left: 15),
              child: GestureDetector(
                onTap: () => Scaffold.of(context).openDrawer(),
                child: const Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
              ),
            );
          }),
          centerTitle: true,
          title: _currentIndex == 0
              ? Text(
                  'Fleet',
                  style: GoogleFonts.syne(
                    fontSize: screenWidth > 600 ? 32 : 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                )
              : _currentIndex == 1
                  ? Text(
                      'Calender',
                      style: GoogleFonts.syne(
                        fontSize: screenWidth > 600 ? 32 : 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    )
                  : _currentIndex == 2
                      ? Text(
                          'Spending',
                          style: GoogleFonts.syne(
                            fontSize: screenWidth > 600 ? 32 : 22,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        )
                      : Text(
                          'Profile',
                          style: GoogleFonts.syne(
                            fontSize: screenWidth > 600 ? 32 : 22,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
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
                    colorFilter: const ColorFilter.mode(grey, BlendMode.srcIn),
                  ),
                  activeIcon: SvgPicture.asset('assets/images/fleet-icon.svg'),
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
              selectedItemColor: Colors.black,
              unselectedItemColor: grey,
              selectedLabelStyle: GoogleFonts.syne(
                fontWeight: FontWeight.w500,
                fontSize: screenWidth > 600 ? 22 : 12,
              ),
              unselectedLabelStyle: GoogleFonts.syne(
                fontWeight: FontWeight.w400,
                fontSize: screenWidth > 600 ? 22 : 12,
              ),
            ),
            // Positioned(
            //   top: -40.h,
            //   child: GestureDetector(
            //     // onTap: () {
            //     //   Navigator.of(
            //     //     context,
            //     //   ).push(
            //     //     MaterialPageRoute(
            //     //       builder: (context) => DashBoard(),
            //     //     ),
            //     //   );
            //     // },
            //     child: Container(
            //       width: 60.w,
            //       height: 60.h,
            //       decoration: const BoxDecoration(
            //         color: grey,
            //         shape: BoxShape.circle,
            //       ),
            //       child: SvgPicture.asset(
            //         'assets/images/nav-button.svg',
            //         fit: BoxFit.scaleDown,
            //         width: 25.w,
            //         height: 25.h,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
