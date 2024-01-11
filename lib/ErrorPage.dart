import 'package:deliver_partner/Constants/Colors.dart';
import 'package:deliver_partner/Constants/buttonContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Constants/back-arrow-with-container.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({super.key});

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenHeight * 0.02;
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        elevation: 0.0,
        leadingWidth: 65,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 4, left: 20),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: backArrowWithContainer(context),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Request not fulfilled',
          style: GoogleFonts.syne(
            fontWeight: FontWeight.w700,
            color: black,
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // SizedBox(
          //   height: screenHeight * 0.08,
          // ),
          Text(
            'Something must have gone wrong',
            textAlign: TextAlign.center,
            style: GoogleFonts.syne(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: orange,
            ),
          ),
          // SizedBox(
          //   height: screenHeight * 0.08,
          // ),
          SvgPicture.asset(
            'assets/images/error-icon.svg',
            width: screenWidth * 0.9,
            fit: BoxFit.scaleDown,
          ),
          // SizedBox(
          //   height: screenHeight * 0.08,
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              'Please confirm that you have performed the correct action and try again',
              textAlign: TextAlign.center,
              style: GoogleFonts.syne(
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
                color: orange,
              ),
            ),
          ),
          // SizedBox(
          //   height: screenHeight * 0.08,
          // ),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: buttonContainer(context, 'GO BACK'),
          ),
        ],
      ),
    );
  }
}
