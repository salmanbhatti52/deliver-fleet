import 'package:deliver_partner/RiderScreens/DrivingLicensePictureVerification.dart';
import 'package:deliver_partner/models/API%20models/API%20response.dart';
import 'package:deliver_partner/models/API%20models/LogInModel.dart';
import 'package:deliver_partner/services/API_services.dart';
import 'package:deliver_partner/widgets/DrawerWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
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
        backgroundColor: Colors.white,
        drawer: const DrawerWidget(),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leadingWidth: 70,
          leading: Builder(builder: (context) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 20),
              child: GestureDetector(
                  onTap: () => Scaffold.of(context).openDrawer(),
                  child: const Icon(
                    Icons.menu,
                    color: Colors.black,
                  )),
            );
          }),
          centerTitle: true,
          title: _currentIndex == 0
              ? Text(
                  'Home',
                  style: GoogleFonts.syne(
                    fontSize: isLargeScreen ? 32 : 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                )
              : _currentIndex == 1
                  ? Text(
                      'Rides',
                      style: GoogleFonts.syne(
                        fontSize: isLargeScreen ? 32 : 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    )
                  : _currentIndex == 2
                      ? Text(
                          'My Reviews',
                          style: GoogleFonts.syne(
                            fontSize: isLargeScreen ? 32 : 22,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        )
                      : Text(
                          'Rider Status',
                          style: GoogleFonts.syne(
                            fontSize: isLargeScreen ? 32 : 22,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
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
                  activeIcon: SvgPicture.asset('assets/images/home-orange.svg'),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset('assets/images/ride-grey.svg'),
                  activeIcon: SvgPicture.asset('assets/images/ride-orange.svg'),
                  label: 'Rides',
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
              top: -40,
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
}
