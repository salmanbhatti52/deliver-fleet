import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Constants/Colors.dart';

Widget warningOfNameMatching(context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 7.h),
    width: 295.w,
    height: 55.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: red.withOpacity(0.35),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset('assets/images/info.svg'),
        Text(
          'Make sure names match what is on \n your driving liscense',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: red,
          ),
        ),
      ],
    ),
  );
}
