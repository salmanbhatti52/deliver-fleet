import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Colors.dart';

Widget detailsButtonDown(context) {
  return Container(
    width: 25.w,
    height: 25.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: white,
      gradient: const LinearGradient(
        colors: [
          Color(0xffFF6302),
          Color(0xffFBC403),
        ],
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
      ),
    ),
    child: const Icon(
      Icons.keyboard_arrow_down_outlined,
      color: white,
      size: 14,
    ),
  );
}

Widget detailsButtonUp(context) {
  return Container(
    width: 25.w,
    height: 25.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: white,
      gradient: const LinearGradient(
        colors: [
          Color(0xffFF6302),
          Color(0xffFBC403),
        ],
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
      ),
    ),
    child: const Icon(
      Icons.keyboard_arrow_up_outlined,
      color: white,
      size: 14,
    ),
  );
}
