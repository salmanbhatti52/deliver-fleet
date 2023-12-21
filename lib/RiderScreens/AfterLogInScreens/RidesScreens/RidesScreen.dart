import 'package:deliver_partner/Constants/Colors.dart';
import 'package:deliver_partner/Constants/drawer_container.dart';
import 'package:deliver_partner/widgets/DrawerWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../services/API_services.dart';
import 'CencelledRidesScreen.dart';
import 'CompletedRidesScreen.dart';
import 'InProgresssScreen.dart';

class RidesScreen extends StatefulWidget {
  const RidesScreen({super.key});

  @override
  State<RidesScreen> createState() => _RidesScreenState();
}

class _RidesScreenState extends State<RidesScreen>
    with SingleTickerProviderStateMixin {
  ApiServices get service => GetIt.I<ApiServices>();

  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  width: double.infinity,
                  height: 60.h,
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
                        'In Progress',
                        style: GoogleFonts.syne(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'Completed',
                        style: GoogleFonts.syne(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,

                        ),
                      ),
                      Text(
                        'Cancelled',
                        style: GoogleFonts.syne(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,

                        ),
                      ),
                    ],
                  ),
                ),
                // SizedBox(
                //   height: 30,
                // ),
                // Row(
                //   children: [
                //     Expanded(
                //       child: GestureDetector(
                //         onTap: () {
                //           setState(() {
                //             statusOfRide = 1;
                //             cancelled = false;
                //             completed = false;
                //             inProgress = true;
                //           });
                //         },
                //         child: Container(
                //           width: 120.w,
                //           height: 45,
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(19),
                //             color: statusOfRide != 1 ? lightGrey : null,
                //             gradient: statusOfRide == 1
                //                 ? LinearGradient(
                //                     colors: [
                //                       Color(0xffFF6302),
                //                       Color(0xffFBC403),
                //                     ],
                //                     begin: Alignment.centerRight,
                //                     end: Alignment.centerLeft,
                //                   )
                //                 : null,
                //           ),
                //           child: Center(
                //             child: Text(
                //               'In Progress',
                //               style: GoogleFonts.syne(
                //                 fontWeight: FontWeight.w500,
                //                 color: statusOfRide == 1 ? white : black,
                //                 fontSize: 14,
                //               ),
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //     SizedBox(
                //       width: 7.w,
                //     ),
                //     Expanded(
                //       child: GestureDetector(
                //         onTap: () {
                //           setState(() {
                //             statusOfRide = 2;
                //             inProgress = false;
                //             cancelled = false;
                //             completed = true;
                //           });
                //         },
                //         child: Container(
                //           width: 120.w,
                //           height: 45,
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(19),
                //             color: statusOfRide != 2 ? lightGrey : null,
                //             gradient: statusOfRide == 2
                //                 ? LinearGradient(
                //                     colors: [
                //                       Color(0xffFF6302),
                //                       Color(0xffFBC403),
                //                     ],
                //                     begin: Alignment.centerRight,
                //                     end: Alignment.centerLeft,
                //                   )
                //                 : null,
                //           ),
                //           child: Center(
                //             child: Text(
                //               'Completed',
                //               style: GoogleFonts.syne(
                //                 fontWeight: FontWeight.w500,
                //                 color: statusOfRide == 2 ? white : black,
                //                 fontSize: 14,
                //               ),
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //     SizedBox(
                //       width: 7.w,
                //     ),
                //     Expanded(
                //       child: GestureDetector(
                //         onTap: () {
                //           setState(() {
                //             statusOfRide = 3;
                //             inProgress = false;
                //             completed = false;
                //             cancelled = true;
                //           });
                //         },
                //         child: Container(
                //           width: 120.w,
                //           height: 45,
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(19),
                //             color: statusOfRide != 3 ? lightGrey : null,
                //             gradient: statusOfRide == 3
                //                 ? LinearGradient(
                //                     colors: [
                //                       Color(0xffFF6302),
                //                       Color(0xffFBC403),
                //                     ],
                //                     begin: Alignment.centerRight,
                //                     end: Alignment.centerLeft,
                //                   )
                //                 : null,
                //           ),
                //           child: Center(
                //             child: Text(
                //               'Cancelled',
                //               style: GoogleFonts.syne(
                //                 fontWeight: FontWeight.w500,
                //                 color: statusOfRide == 3 ? white : black,
                //                 fontSize: 14,
                //               ),
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                // // SizedBox(
                // //   height: 30.h,
                // // ),
                // Visibility(
                //   visible: inProgress,
                //   child: InProgressScreen(),
                // ),
                // Visibility(
                //   visible: completed,
                //   child: CompletedRidesScreen(),
                // ),
                // Visibility(
                //   visible: cancelled,
                //   child: CencelledRidesScreen(),
                // ),
                Expanded(
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: tabController,
                    children: const [
                      InProgressScreen(),
                      CompletedRidesScreen(),
                      CencelledRidesScreen(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
