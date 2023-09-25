import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Colors.dart';

Widget buttonContainer(context, String buttonText) {
  return Container(
    width: 236.w,
    height: 51.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      gradient: const LinearGradient(
        colors: [
          Color(0xffFF6302),
          Color(0xffFBC403),
        ],
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
      ),
    ),
    child: Center(
      child: Text(
        buttonText,
        textAlign: TextAlign.center,
        style: GoogleFonts.syne(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: white,
        ),
      ),
    ),
  );
}
