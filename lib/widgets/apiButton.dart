import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Constants/Colors.dart';

Widget apiButton(context) {
  double fontSize = MediaQuery.of(context).size.height * 0.02;

  return Container(
     width: MediaQuery.of(context).size.width * 0.6, // Adjust width
    height: MediaQuery.of(context).size.height * 0.065, 
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
    child: Container(
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: white,
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Please Wait...',
              textAlign: TextAlign.center,
              style: GoogleFonts.syne(
                fontSize: fontSize,
                fontWeight: FontWeight.w500,
                color: orange,
              ),
            ),
            const CircularProgressIndicator(
              color: orange,
              strokeWidth: 3,
            ),
          ],
        ),
      ),
    ),
  );
}
