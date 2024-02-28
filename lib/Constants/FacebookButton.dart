import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Colors.dart';

Widget facebookButton(
  context,
) {
  return Container(
    padding: const EdgeInsets.only(right: 15),
    width: 236.w,
    height: 51.h,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xff395693)),
    child: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset('assets/images/facebook-button.svg'),
          Text(
            'Login with Facebook',
            textAlign: TextAlign.center,
            style: GoogleFonts.syne(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: white,
            ),
          ),
        ],
      ),
    ),
  );
}
