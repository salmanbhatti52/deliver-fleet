import 'package:Deliver_Rider/Constants/Colors.dart';
import 'package:Deliver_Rider/FleetScreens/FleetHomeScreens/DriverScreens/AllDriversOfFleet.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      // backgroundColor: white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20.h,
          ),
          Container(
            padding: const EdgeInsets.all(3),
            // margin: EdgeInsets.symmetric(horizontal: 22),
            width: 235.w,
            height: 45.h,
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TabBar(
              unselectedLabelColor: black,
              // physics: NeverScrollableScrollPhysics(),

              labelColor: white,

              controller: tabController,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // color: statusOfRide != 1 ? lightGrey : null,
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
                    fontSize: 14,
                  ),
                ),
                Text(
                  'Driver\'s',
                  style: GoogleFonts.syne(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
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
