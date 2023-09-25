import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'Colors.dart';

Widget bankingActionButton(context) {
  return Container(
    width: 42.w,
    height: 42.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: white,
      border: Border.all(
        color: lightGrey,
        width: 1.5,
      ),
      // boxShadow: [
      //   BoxShadow(
      //     blurRadius: 10,
      //     color: grey,
      //   ),
      // ],
    ),
    child: SvgPicture.asset(
      'assets/images/banking-action.svg',
      width: 20.w,
      height: 20.h,
      fit: BoxFit.scaleDown,
    ),
  );
}
