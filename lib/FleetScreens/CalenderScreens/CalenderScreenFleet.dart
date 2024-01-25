import 'package:deliver_partner/Constants/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'CalenderWidget.dart';
import 'UpcomingDeadlinesWidget.dart';

class CalenderScreenFleet extends StatefulWidget {
  const CalenderScreenFleet({super.key});

  @override
  State<CalenderScreenFleet> createState() => _CalenderScreenFleetState();
}

class _CalenderScreenFleetState extends State<CalenderScreenFleet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
            ),
            CalenderWidget(),
            SizedBox(
              height: 20.h,
            ),
            Text(
              'Upcoming Deadlines',
              textAlign: TextAlign.start,
              style: GoogleFonts.syne(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: black,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return UpcomingDeadlinesWidget();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
