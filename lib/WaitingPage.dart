import 'package:deliver_partner/Constants/Colors.dart';
import 'package:deliver_partner/Constants/buttonContainer.dart';
import 'package:deliver_partner/RiderScreens/BottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class WaitingPage extends StatefulWidget {
  final String userType;

  const WaitingPage({super.key, required this.userType});

  @override
  State<WaitingPage> createState() => _WaitingPageState();
}

class _WaitingPageState extends State<WaitingPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            'Wait for process to complete',
            style: GoogleFonts.syne(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: black,
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'STAY TIGHT!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 21,
                    fontWeight: FontWeight.w600,
                    color: orange,
                  ),
                ),
                SvgPicture.asset('assets/images/Waiting-rafiki.svg'),
                Text(
                  'We are considering your request.\n Kindly wait till your request\n gets accepted',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: orange,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const BottomNavBar()),
                          (Route<dynamic> route) => false);
                    },
                    child: buttonContainer(context, 'CONTINUE'),
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
