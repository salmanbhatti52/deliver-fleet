import 'package:deliver_partner/Constants/Colors.dart';
import 'package:deliver_partner/FleetScreens/FleetHomeScreens/DriverScreens/AllDriversOfFleet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'VehicleScreens/VehicleScreen.dart';

class FleetScreen extends StatefulWidget {
  final String userType;
  const FleetScreen({super.key, required this.userType});

  @override
  State<FleetScreen> createState() => _FleetScreenState();
}

class _FleetScreenState extends State<FleetScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double relativeHeight = height * 1 / 100;
    final screenSize = MediaQuery.of(context).size;
    final isLargeScreen = screenSize.width > 600;
    return Scaffold(
      // backgroundColor: white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: relativeHeight,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(3, 5, 3, 5),
            width: MediaQuery.of(context).size.width * 0.67,
            height: MediaQuery.of(context).size.height * 0.076,
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                width: 1,
                color: lightGrey.withOpacity(0.5),
              ),
            ),
            child: TabBar(
              labelColor: white,
              controller: tabController,
              unselectedLabelColor: black,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(19),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xffFF6302),
                    Color(0xffFBC403),
                  ],
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                ),
              ),
              tabs: [
                Text(
                  'Vehicles',
                  style: GoogleFonts.syne(
                    fontWeight: FontWeight.w500,
                    fontSize: isLargeScreen ? 24 : 14,
                  ),
                ),
                Text(
                  'Driver\'s',
                  style: GoogleFonts.syne(
                    fontWeight: FontWeight.w500,
                    fontSize: isLargeScreen ? 24 : 14,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: const [
                VehicleScreenFleet(),
                AllDriversOfFleet(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
