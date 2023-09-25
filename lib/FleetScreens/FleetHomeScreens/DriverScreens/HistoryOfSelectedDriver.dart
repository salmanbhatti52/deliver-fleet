import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Constants/Colors.dart';

class HistoryOfSelectedDriver extends StatefulWidget {
  const HistoryOfSelectedDriver({super.key});

  @override
  State<HistoryOfSelectedDriver> createState() =>
      _HistoryOfSelectedDriverState();
}

class _HistoryOfSelectedDriverState extends State<HistoryOfSelectedDriver> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Container(
              // margin: EdgeInsets.only(bottom: 10.h),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              width: double.infinity,
              height: 70.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: lightWhite,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 250.w,
                    child: AutoSizeText(
                      'Car Accident',
                      maxLines: 2,
                      minFontSize: 12,
                      style: GoogleFonts.syne(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    'May 20th, 2022 - WW 4527E ',
                    style: GoogleFonts.syne(
                      fontSize: 14,
                      color: grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
      itemCount: 10,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
    );
  }
}
