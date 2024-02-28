import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Constants/Colors.dart';
import '../../../Constants/back-arrow-with-container.dart';
import 'MonthlyAwardScreen.dart';
import 'WeeklyAwards.dart';
import 'YearlyAwardScreen.dart';

class AwardsScreen extends StatefulWidget {
  const AwardsScreen({super.key});

  @override
  State<AwardsScreen> createState() => _AwardsScreenState();
}

class _AwardsScreenState extends State<AwardsScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(
      length: 3,
      vsync: this,
    );
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
          'Awards',
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.0.w),
        child: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
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
                  Text(
                    'Yearly',
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
                children: const [
                  WeeklyAwards(),
                  MonthlyAwardScreen(),
                  YearlyAwardScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
