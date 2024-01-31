import 'package:deliver_partner/FleetScreens/FleetHomeScreens/VehicleScreens/DriverDetailsFleet/DriverInfoWidgetFleet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Constants/Colors.dart';
import '../../../../Constants/back-arrow-with-container.dart';
import '../../../models/APIModelsFleet/GetAllRidersModel.dart';
import 'HistoryOfSelectedDriver.dart';
import 'ReviewsOfSelectedDriver.dart';

class DriverDetailsFleet extends StatefulWidget {
  final GetAllRidersModel allRiders;
  final String userIDOfSelectedDriver;
  const DriverDetailsFleet(
      {super.key,
      required this.allRiders,
      required this.userIDOfSelectedDriver});

  @override
  State<DriverDetailsFleet> createState() => _DriverDetailsFleetState();
}

class _DriverDetailsFleetState extends State<DriverDetailsFleet>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leadingWidth: 70,
        leading: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 20),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: backArrowWithContainer(context),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Driver Profile',
          style: GoogleFonts.syne(
            fontWeight: FontWeight.w700,
            color: black,
            fontSize: 20,
          ),
        ),
      ),
      backgroundColor: white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30.h,
            ),
            Column(
              children: [
                Container(
                  width: 155.w,
                  height: 155.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      width: 4.5,
                      color: lightGrey,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      'https://deliver.eigix.net/public/${widget.allRiders.profile_pic}',
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return SizedBox(
                          child: Image.asset(
                            'assets/images/place-holder.png',
                            fit: BoxFit.scaleDown,
                          ),
                        );
                      },
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            color: orange,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  '${widget.allRiders.first_name} ${widget.allRiders.last_name} ',
                  style: GoogleFonts.syne(
                    fontWeight: FontWeight.w700,
                    color: black,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25.h,
            ),
            DriverInfoWidgetFleet(
              emailAddress: widget.allRiders.email!,
              phoneNumber: widget.allRiders.phone!,
              location: widget.allRiders.address!,
            ),
            SizedBox(
              height: 20.h,
            ),
            // widget.allRiders.status == 'Active'
            //     ? Container(
            //         margin: const EdgeInsets.only(bottom: 20),
            //         padding: const EdgeInsets.symmetric(
            //             horizontal: 12, vertical: 4),
            //         width: double.infinity,
            //         height: 75.h,
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(10),
            //           color: white,
            //         ),
            //         child: Row(
            //           children: [
            //             Container(
            //               width: 65.w,
            //               height: 65.h,
            //               decoration: BoxDecoration(
            //                 border: Border.all(
            //                   color: orange,
            //                 ),
            //                 shape: BoxShape.circle,
            //               ),
            //               child: ClipRRect(
            //                 borderRadius: BorderRadius.circular(65),
            //                 child: Image.network(
            //                   'https://deliver.eigix.net/public/${widget.allRiders.users_fleet_vehicles!.image}',
            //                   fit: BoxFit.cover,
            //                   errorBuilder: (BuildContext context,
            //                       Object exception, StackTrace? stackTrace) {
            //                     return SizedBox(
            //                       child: Image.asset(
            //                         'assets/images/place-holder.png',
            //                         fit: BoxFit.scaleDown,
            //                       ),
            //                     );
            //                   },
            //                   loadingBuilder: (BuildContext context,
            //                       Widget child,
            //                       ImageChunkEvent? loadingProgress) {
            //                     if (loadingProgress == null) {
            //                       return child;
            //                     }
            //                     return Center(
            //                       child: CircularProgressIndicator(
            //                         color: orange,
            //                         value:
            //                             loadingProgress.expectedTotalBytes !=
            //                                     null
            //                                 ? loadingProgress
            //                                         .cumulativeBytesLoaded /
            //                                     loadingProgress
            //                                         .expectedTotalBytes!
            //                                 : null,
            //                       ),
            //                     );
            //                   },
            //                 ),
            //               ),
            //             ),
            //             SizedBox(
            //               width: 15.w,
            //             ),
            //             Column(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Text(
            //                   widget.allRiders.users_fleet_vehicles!.model!,
            //                   overflow: TextOverflow.ellipsis,
            //                   maxLines: 1,
            //                   style: GoogleFonts.syne(
            //                     fontSize: 16,
            //                     fontWeight: FontWeight.w700,
            //                     color: black,
            //                   ).copyWith(
            //                     overflow: TextOverflow.ellipsis,
            //                   ),
            //                 ),
            //                 Text(
            //                   widget.allRiders.users_fleet_vehicles!
            //                       .vehicle_registration_no!,
            //                   style: GoogleFonts.inter(
            //                     fontSize: 14,
            //                     fontWeight: FontWeight.w500,
            //                     color: grey,
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ],
            //         ),
            //       )
            //     : const Text('data'),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
              // padding: EdgeInsets.all(6),
              width: double.infinity,
              height: 50.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: lightGrey,
                  width: 1,
                ),
                color: white,
              ),
              child: TabBar(
                unselectedLabelColor: black,
                labelColor: white,
                controller: tabController,
                indicator: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xffFF6302),
                      Color(0xffFBC403),
                    ],
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                  ),
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                tabs: [
                  Text(
                    'Contact History',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.syne(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'Reviews',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.syne(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                physics: const BouncingScrollPhysics(),
                children: [
                  const HistoryOfSelectedDriver(),
                  ReviewsOfSelectedDriver(
                    userIDOfSelectedDriver: widget.userIDOfSelectedDriver,
                  ),
                  // RidesTabOnFleetDetails(),
                  // ContactHistoryTabOnFleetDetails(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
