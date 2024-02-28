import 'package:deliver_partner/Constants/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget profileDetails(context, String propertyText, String profileDataText) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        propertyText,
        style: GoogleFonts.syne(
            fontSize: 14, fontWeight: FontWeight.w700, color: black),
      ),
      SizedBox(
        height: 7.h,
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        width: double.infinity,
        height: 50.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: lightWhite,
        ),
        child: Text(
          profileDataText,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: grey,
          ),
        ),
      ),
    ],
  );
}
