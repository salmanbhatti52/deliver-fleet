import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'Colors.dart';

Widget drawerContainer(context) {
  double containerWidth = MediaQuery.of(context).size.width > 600 ? 38 : 30;
  double containerHeight = MediaQuery.of(context).size.width > 600 ? 38 : 30;

  return Container(
    width: containerWidth,
    height: containerHeight,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: mildGrey,
        width: 1.5,
      ),
    ),
    child: SvgPicture.asset(
      'assets/images/menu-icon.svg',
      fit: BoxFit.scaleDown,
    ),
  );
}

Widget addContainer(context) {
  double containerWidth = MediaQuery.of(context).size.width > 600 ? 55 : 45;
  double containerHeight = MediaQuery.of(context).size.width > 600 ? 38 : 30;

  return Container(
    width: containerWidth,
    height: containerHeight,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: mildGrey,
        width: 1.5,
      ),
    ),
    child: Icon(
      Icons.add,
      color: black,
      size: MediaQuery.of(context).size.width > 600 ? 18 : 16,
    ),
  );
}
