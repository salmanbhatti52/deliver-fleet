import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Colors.dart';

Widget buttonContainer(context, String buttonText) {
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
    child: Center(
      child: Text(
        buttonText,
        textAlign: TextAlign.center,
        style: GoogleFonts.syne(
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
          color: white,
        ),
      ),
    ),
  );
}

Widget buttonContainer1(BuildContext context, String buttonText) {
  final double screenHeight = MediaQuery.of(context).size.height;
  final double screenWidth = MediaQuery.of(context).size.width;

  // Calculate the font size based on the screen height and width
  double fontSize = screenHeight * 0.02;

  // Define minimum and maximum font sizes for better control
  const double minFontSize = 12.0;
  const double maxFontSize = 30.0;

  // Apply minimum and maximum limits to the font size
  fontSize = fontSize.clamp(minFontSize, maxFontSize);

  return Container(
    height: screenHeight * 0.065,
    width: screenWidth * 0.6,
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
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    ),
  );
}
