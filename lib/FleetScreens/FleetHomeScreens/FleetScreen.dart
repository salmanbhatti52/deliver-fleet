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

    return Scaffold(
      // backgroundColor: white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20.h,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.55,
            height: MediaQuery.of(context).size.height * 0.06,
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TabBar(
              unselectedLabelColor: black,
              // physics: NeverScrollableScrollPhysics(),
              // labelPadding: const EdgeInsets.symmetric(horizontal: 12),
              indicatorSize: TabBarIndicatorSize.label,
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

      // Padding(
      //         padding: const EdgeInsets.symmetric(horizontal: 10),
      //         child: Container(
      //             width: size.width * 0.55,
      //             height: size.height * 0.06,
      //             decoration: BoxDecoration(
      //               color: whiteColor,
      //               borderRadius: BorderRadius.circular(10),
      //               border: Border.all(
      //                 color: borderColor,
      //                 width: 1,
      //               ),
      //             ),
      //             child: Padding(
      //               padding:
      //                   const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
      //               child: DefaultTabController(
      //                 length: 2,
      //                 child: TabBar(
      //                   controller: tabController,
      //                   indicator: BoxDecoration(
      //                     gradient: LinearGradient(
      //                       begin: Alignment.centerRight,
      //                       end: Alignment.centerLeft,
      //                       stops: const [0.1, 1.5],
      //                       colors: [
      //                         orangeColor,
      //                         yellowColor,
      //                       ],
      //                     ),
      //                     borderRadius: BorderRadius.circular(10),
      //                   ),
      //                   labelColor: whiteColor,
      //                   labelStyle: TextStyle(
      //                     color: whiteColor,
      //                     fontSize: 14,
      //                     fontFamily: 'Syne-Medium',
      //                   ),
      //                   unselectedLabelColor: const Color(0xFF4D4D4D),
      //                   unselectedLabelStyle: const TextStyle(
      //                     color: Color(0xFF4D4D4D),
      //                     fontSize: 14,
      //                     fontFamily: 'Syne-Regular',
      //                   ),
      //                   tabs: const [
      //                     Tab(text: "Scooter"),
      //                     Tab(text: "Driver's"),
      //                   ],
      //                 ),
      //               ),
      //             )),
      //       ),
      //       Container(
      //         color: transparentColor,
      //         width: size.width,
      //         height: size.height * 0.72,
      //         child: TabBarView(
      //           controller: tabController,
      //           children: const [
      //             ScooterScreen(),
      //             DriversScreen(),
      //           ],
      //         ),
      //       ),