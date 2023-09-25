import 'package:Deliver_Rider/Constants/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SpendingScreenFleet extends StatefulWidget {
  const SpendingScreenFleet({super.key});

  @override
  State<SpendingScreenFleet> createState() => _SpendingScreenFleetState();
}

class _SpendingScreenFleetState extends State<SpendingScreenFleet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.0),
        child: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            Image.asset('assets/images/Group 22720.png'),
            SizedBox(
              height: 30.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Invoice',
                  style: GoogleFonts.syne(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: black,
                  ),
                ),
                Text(
                  'see all',
                  style: GoogleFonts.syne(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: orange,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Image.asset('assets/images/Component 111 – 15.png');
                },
                itemCount: 10,
                shrinkWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
