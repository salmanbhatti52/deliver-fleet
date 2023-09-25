import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'Colors.dart';

Widget cameraIcon(context) {
  return Container(
    width: 42.w,
    height: 42.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: white,
      border: Border.all(
        color: black,
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
      'assets/images/camera.svg',
      width: 20.w,
      height: 20.h,
      fit: BoxFit.scaleDown,
    ),
  );
}
