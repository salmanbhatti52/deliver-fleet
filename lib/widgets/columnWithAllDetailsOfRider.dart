import 'dart:core';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Constants/Colors.dart';

class ColumnWithAllDetailsOfRiders extends StatelessWidget {
  final String address;
  final String cnic;

  final String licenseNumber;

  const ColumnWithAllDetailsOfRiders({
    super.key,
    required this.address,
    required this.cnic,
    required this.licenseNumber,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * 0.1,
      //margin: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Address',
                style: GoogleFonts.syne(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: black,
                ),
              ),
              SizedBox(
                width: 90.w,
                child: AutoSizeText(
                  'National Identification Number',
                  maxLines: 3,
                  softWrap: true,
                  overflow: TextOverflow.visible,
                  style: GoogleFonts.syne(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: black,
                  ),
                ),
              ),
              Text(
                'License number',
                style: GoogleFonts.syne(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: black,
                ),
              ),
            ],
          ),
          // SizedBox(
          //   width: 40.w,
          // ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 100.w,
                child: AutoSizeText(
                  address,
                  maxLines: 2,
                  minFontSize: 10,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: grey,
                  ),
                ),
              ),
              SizedBox(
                width: 100.w,
                child: AutoSizeText(
                  cnic,
                  maxLines: 2,
                  minFontSize: 10,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: grey,
                  ),
                ),
              ),
              SizedBox(
                width: 100.w,
                child: AutoSizeText(
                  licenseNumber,
                  maxLines: 2,
                  minFontSize: 10,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: grey,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
