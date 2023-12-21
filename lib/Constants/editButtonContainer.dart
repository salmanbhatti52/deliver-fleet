import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'Colors.dart';

Widget editButtonContainer(context) {
  return Container(
    width: 55.w,
    height: 38.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: mildGrey,
        width: 1.5,
      ),
    ),
    child: SvgPicture.asset(
      'assets/images/edit-icon.svg',
      fit: BoxFit.scaleDown,
    ),
  );
}
