import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Colors.dart';

Widget googleButton(context) {
  return Container(
    padding: const EdgeInsets.only(right: 45),
    width: 236.w,
    height: 51.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: const Color(0xffF14336),
    ),
    child: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset('assets/images/google'
                  '.svg'),
              SvgPicture.asset('assets/images/google-button.svg'),
            ],
          ),
          Text(
            'Sign Up with Google',
            textAlign: TextAlign.center,
            style: GoogleFonts.syne(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: white,
            ),
          ),
        ],
      ),
    ),
  );
}
