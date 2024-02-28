import 'package:deliver_partner/Constants/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Constants/back-arrow-with-container.dart';
import 'LinecChartWidget.dart';
import 'MonthlyEarnings.dart';
import 'WeeklyEarnings.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard>
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
      backgroundColor: white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leadingWidth: 70,
        centerTitle: true,
        title: Text(
          'Dashboard',
          style: GoogleFonts.syne(
            fontWeight: FontWeight.w700,
            color: black,
            fontSize: 20,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 20),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: backArrowWithContainer(context),
          ),
        ),
      ),
      body: GlowingOverscrollIndicator(
        axisDirection: AxisDirection.down,
        color: orange,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w),
          child: Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              Container(
                padding: EdgeInsets.only(top: 10.h),
                width: double.infinity,
                height: 270.h,
                decoration: BoxDecoration(
                  color: orange,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10.0.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Earning',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: black,
                            ),
                          ),
                          Row(
                            children: [
                              SvgPicture.asset('assets/images/currency.svg'),
                              Text(
                                '567.09',
                                style: GoogleFonts.inter(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                  color: white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: 20.0.w),
                        child: const LinecChartWidget(),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        height: 50.h,
                        color: lightWhite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                    'assets/images/totalRides-icon.svg'),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  '${5678} Rides',
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: black,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                    'assets/images/timer-icon.svg'),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  '6790 h 5678 mint',
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                // padding: EdgeInsets.all(6),
                width: 250,
                height: 50.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: lightGrey,
                    width: 1,
                  ),
                  color: lightWhite,
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
                      'Weekly',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.syne(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'Monthly',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.syne(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Expanded(
                  child: TabBarView(
                controller: tabController,
                physics: const BouncingScrollPhysics(),
                children: const [
                  WeeklyEarnings(
                    dayOfWeek: 'dayOfWeek',
                    amount: 'amount',
                    date: 'date',
                  ),
                  MonthlyEarnings(),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
