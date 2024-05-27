import 'package:deliver_partner/Constants/Colors.dart';
import 'package:deliver_partner/RiderScreens/DrawerScreens/schedule%20Clients/scheduledAccepted.dart';
import 'package:deliver_partner/RiderScreens/DrawerScreens/schedule%20Clients/scheduledNewRides.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ScheduledRideScreen extends StatefulWidget {
  const ScheduledRideScreen({super.key});

  @override
  State<ScheduledRideScreen> createState() => _ScheduledRideScreenState();
}

class _ScheduledRideScreenState extends State<ScheduledRideScreen>
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
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leadingWidth: 70,
        centerTitle: true,
        title: Text(
          'Schedule Rides',
          style: GoogleFonts.syne(
            fontWeight: FontWeight.w700,
            color: black,
            fontSize: 20,
          ),
        ),
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.black),
        // leading: Padding(
        //   padding: const EdgeInsets.only(top: 8.0, left: 20),
        //   child: GestureDetector(
        //     onTap: () => Navigator.of(context).pop(),
        //     child: backArrowWithContainer(context),
        //   ),
        // ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w),
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(3, 5, 3, 5),
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
                      'New Rides',
                      style: GoogleFonts.syne(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      'Accepted Rides',
                      style: GoogleFonts.syne(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: tabController,
                  children: const [
                    ScheduledNewRides(),
                    ScheduledAccepted(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }




}
