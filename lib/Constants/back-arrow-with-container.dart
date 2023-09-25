import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'Colors.dart';

Widget backArrowWithContainer(context) {
  return Container(
    // margin: EdgeInsets.only(
    //   top: 10,
    //   left: 10,
    // ),
    width: 38.w,
    height: 38.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: mildGrey,
        width: 1.5,
      ),
      // boxShadow: [
      //   BoxShadow(
      //     blurRadius: 2,
      //     color: grey,
      //   ),
      // ],
      // boxShadow: [
      //   BoxShadow(
      //     color: Colors.grey.withOpacity(0.1),
      //     spreadRadius: 5,
      //     blurRadius: 7,
      //     offset: Offset(0, 3), // changes position of shadow
      //   ),
      // ],
    ),
    child: SvgPicture.asset(
      'assets/images/arrow-back.svg',
      fit: BoxFit.scaleDown,
    ),
  );
}
