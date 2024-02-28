import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buttonContainerWithBorder(BuildContext context, String buttonText) {
  double fontSize = MediaQuery.of(context).size.height * 0.02;
  return Container(
    width: MediaQuery.of(context).size.width * 0.6, // Adjust width
    height: MediaQuery.of(context).size.height * 0.065, // Adjust height

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
        color: Colors.white,
      ),
      child: Center(
        child: Text(
          buttonText,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: fontSize, // Adjust font size
            fontWeight: FontWeight.w500,
            color: Colors.orange,
          ),
        ),
      ),
    ),
  );
}
