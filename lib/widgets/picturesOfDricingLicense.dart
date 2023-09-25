import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Constants/Colors.dart';

Widget picturesOfDricingLicense(context, File frontImage, File backImage) {
  return SizedBox(
    height: 150.h,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 170.w,
              height: 110.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: FileImage(frontImage),
                ),
              ),
            ),
            Text(
              'Front',
              textAlign: TextAlign.center,
              style: GoogleFonts.syne(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: orange,
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 170.w,
              height: 110.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: FileImage(backImage),
                ),
              ),
            ),
            Text(
              'Back',
              textAlign: TextAlign.center,
              style: GoogleFonts.syne(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: orange,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
