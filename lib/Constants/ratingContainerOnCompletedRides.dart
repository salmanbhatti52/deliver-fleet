import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Colors.dart';

class RatingContainerOnCompletedRides extends StatelessWidget {
  final String ratings;
  const RatingContainerOnCompletedRides({super.key, required this.ratings});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      width: 40.w,
      height: 25.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11),
        color: lightOrange,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            'assets/images/rating-star.svg',
            width: 10.w,
            height: 10.h,
            fit: BoxFit.scaleDown,
          ),
          Text(
            ratings,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: black,
            ),
          ),
        ],
      ),
    );
  }
}
