import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Constants/Colors.dart';

class DriverInfoWidgetFleet extends StatelessWidget {
  final String emailAddress;
  final String phoneNumber;
  final String location;
  const DriverInfoWidgetFleet(
      {super.key,
      required this.emailAddress,
      required this.phoneNumber,
      required this.location});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      width: double.infinity,
      height: 50.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: lightWhite,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset('assets/images/location.svg'),
                SizedBox(
                  width: 4.w,
                ),
                Expanded(
                  child: Tooltip(
                    message: location,
                    child: AutoSizeText(
                      location,
                      maxLines: 3,
                      minFontSize: 10,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset('assets/images/call.svg'),
                SizedBox(
                  width: 4.w,
                ),
                Expanded(
                  child: AutoSizeText(
                    phoneNumber,
                    maxLines: 3,
                    minFontSize: 10,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset('assets/images/email-icon.svg'),
                SizedBox(
                  width: 4.w,
                ),
                Expanded(
                  child: AutoSizeText(
                    emailAddress,
                    maxLines: 3,
                    minFontSize: 10,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
