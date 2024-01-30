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
        backgroundColor: Colors.white,
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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 22.w,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Something must have went wrong',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.syne(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: orange,
                  ),
                ),
                SvgPicture.asset(
                  'assets/images/404 Error Page not Found with people connecting a plug-pana.svg',
                  height: 450,
                  width: 450,
                ),
                Text(
                  'Please confirm that you have\n performed the correct action\n and try again',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.syne(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: orange,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 18.0, top: 40),
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: buttonContainer(context, 'GO BACK'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
