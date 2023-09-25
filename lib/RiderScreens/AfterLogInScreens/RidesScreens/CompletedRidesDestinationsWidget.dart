import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Constants/Colors.dart';

class CompletedRidesDestinationsWidget extends StatefulWidget {
  final String destination;
  final String distance;
  final String time;
  final String fare;
  const CompletedRidesDestinationsWidget(
      {super.key,
      required this.destination,
      required this.distance,
      required this.time,
      required this.fare});

  @override
  State<CompletedRidesDestinationsWidget> createState() =>
      _CompletedRidesDestinationsWidgetState();
}

class _CompletedRidesDestinationsWidgetState
    extends State<CompletedRidesDestinationsWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.85,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 17.w,
                height: 17.h,
                decoration: const BoxDecoration(
                  color: orange,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  'assets/images/pointer.svg',
                  fit: BoxFit.scaleDown,
                ),
              ),
              SizedBox(
                width: 7.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dropoff Location ${'1'}',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: grey,
                    ),
                  ),
                  Text(
                    widget.destination,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: black,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 25.h,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    SvgPicture.asset(
                      'assets/images/location.svg',
                      colorFilter:
                          const ColorFilter.mode(grey, BlendMode.srcIn),
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Expanded(
                      child: Text(
                        widget.distance,
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: grey,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SvgPicture.asset(
                      'assets/images/timer-icon.svg',
                      colorFilter:
                          const ColorFilter.mode(grey, BlendMode.srcIn),
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Text(
                      widget.time,
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: grey,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SvgPicture.asset(
                      'assets/images/dollar-circle.svg',
                      colorFilter:
                          const ColorFilter.mode(grey, BlendMode.srcIn),
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Expanded(
                      child: Text(
                        '\$${widget.fare}',
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
