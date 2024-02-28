import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Colors.dart';

Widget SeeDetailsOnCompletedRidesButton(context) {
  return Container(
    width: 110.w,
    height: 40.h,
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [
          Color(0xffFF6302),
          Color(0xffFBC403),
        ],
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Center(
      child: Text(
        'See detail',
        style: GoogleFonts.syne(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: white,
        ),
      ),
    ),
  );
}
