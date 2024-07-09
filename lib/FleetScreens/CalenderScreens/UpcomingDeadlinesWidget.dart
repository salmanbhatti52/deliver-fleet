import 'package:deliver_partner/Constants/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class UpcomingDeadlinesWidget extends StatefulWidget {
  const UpcomingDeadlinesWidget({super.key});

  @override
  State<UpcomingDeadlinesWidget> createState() =>
      _UpcomingDeadlinesWidgetState();
}

class _UpcomingDeadlinesWidgetState extends State<UpcomingDeadlinesWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 12.h),
            padding: EdgeInsets.symmetric(vertical: 9.h, horizontal: 11.w),
            height: 72.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: grey,
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset('assets/images/oil-change.svg'),
                    SizedBox(
                      width: 7.w,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Oil Change',
                          style: GoogleFonts.syne(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: black,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          'May 20th, 2022 - WW 4527E ',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: grey,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: grey,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
