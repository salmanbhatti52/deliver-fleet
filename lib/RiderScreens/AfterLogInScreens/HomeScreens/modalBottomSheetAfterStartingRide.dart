import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Constants/Colors.dart';

class ModalBottomSheetAfterStartingRide extends StatefulWidget {
  final String name;
  final String pickUpPlace;
  final String dropOffPlace;
  final String estimatedTime;
  final String totalDistance;
  final String totalFare;

  final String receiverName;
  final String receiverNumber;
  const ModalBottomSheetAfterStartingRide(
      {super.key,
      required this.name,
      required this.pickUpPlace,
      required this.dropOffPlace,
      required this.estimatedTime,
      required this.totalDistance,
      required this.totalFare,
      required this.receiverName,
      required this.receiverNumber});

  @override
  State<ModalBottomSheetAfterStartingRide> createState() =>
      _ModalBottomSheetAfterStartingRideState();
}

class _ModalBottomSheetAfterStartingRideState
    extends State<ModalBottomSheetAfterStartingRide> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 15.h),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      height: 350.h,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: const CircleAvatar(
                      backgroundImage: AssetImage('assets/images/sample.jpg'),
                    ),
                  ),
                  SizedBox(
                    width: 6.w,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 100.w,
                        child: AutoSizeText(
                          widget.name,
                          minFontSize: 13,
                          maxLines: 3,
                          style: GoogleFonts.syne(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: black),
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Text(
                        'Standard Level',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: 34.w,
                        height: 34.h,
                        child: SvgPicture.asset(
                          'assets/images/msg-map-icon.svg',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        'Chat',
                        style: GoogleFonts.syne(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: grey,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                    children: [
                      Container(
                        width: 34.w,
                        height: 34.h,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: orange,
                        ),
                        child: SvgPicture.asset(
                          'assets/images/call.svg',
                          width: 30,
                          height: 30,
                          colorFilter:
                              const ColorFilter.mode(white, BlendMode.srcIn),
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                      Text(
                        'Call',
                        style: GoogleFonts.syne(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: grey,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          SizedBox(
            width: double.infinity,
            height: 35.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Receiver Name',
                      style: GoogleFonts.syne(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: grey,
                      ),
                    ),
                    Text(
                      widget.receiverName,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: black,
                      ),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Receiver Contact',
                      style: GoogleFonts.syne(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: grey,
                      ),
                    ),
                    Text(
                      widget.receiverNumber,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: black,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              SvgPicture.asset('assets/images/location.svg'),
              SizedBox(
                width: 15.w,
              ),
              Text(
                'Pickup From',
                style: GoogleFonts.syne(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: grey,
                ),
              )
            ],
          ),
          // SizedBox(
          //   height: 4.h,
          // ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8.0.w),
                child: SvgPicture.asset(
                  'assets/images/dotted-line.svg',
                  fit: BoxFit.scaleDown,
                ),
              ),
              SizedBox(
                width: 25.w,
              ),
              SizedBox(
                width: 250.w,
                child: AutoSizeText(
                  widget.pickUpPlace,
                  maxLines: 3,
                  minFontSize: 12,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: black,
                  ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                'assets/images/pointer.svg',
                colorFilter: const ColorFilter.mode(orange, BlendMode.srcIn),
                width: 24.w,
                height: 24.h,
              ),
              SizedBox(
                width: 15.w,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Deliver To',
                    style: GoogleFonts.syne(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: grey,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    width: 250.w,
                    child: AutoSizeText(
                      widget.dropOffPlace,
                      minFontSize: 12,
                      maxLines: 3,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 15.h,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SizedBox(
                    width: 40.w,
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          'assets/images/timer-icon.svg',
                          colorFilter:
                              const ColorFilter.mode(black, BlendMode.srcIn),
                        ),
                        Text(
                          widget.estimatedTime,
                          style: GoogleFonts.inter(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w700,
                            color: black,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Estimate Time',
                            style: GoogleFonts.syne(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: 40.w,
                    child: Column(
                      children: [
                        SvgPicture.asset('assets/images/meter-icon.svg'),
                        Text(
                          widget.totalDistance,
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: black,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Total Distance',
                            style: GoogleFonts.syne(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: 85.w,
                    child: Column(
                      children: [
                        Text(
                          widget.totalFare,
                          style: GoogleFonts.inter(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w700,
                            color: black,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Fare',
                            style: GoogleFonts.syne(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: grey,
                            ),
                          ),
                        ),
                      ],
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
