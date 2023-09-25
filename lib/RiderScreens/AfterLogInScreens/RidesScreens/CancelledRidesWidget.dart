import 'package:Deliver_Rider/Constants/Colors.dart';
import 'package:Deliver_Rider/Constants/SeeDetailsOnCompletedRidesButton.dart';
import 'package:Deliver_Rider/Constants/details-button.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/API models/InProgressRidesModel.dart';

class CancelledRidesWidget extends StatefulWidget {
  final InProgressRidesModel canceledRidesModel;
  const CancelledRidesWidget({super.key, required this.canceledRidesModel});

  @override
  State<CancelledRidesWidget> createState() => _CancelledRidesWidgetState();
}

class _CancelledRidesWidgetState extends State<CancelledRidesWidget> {
  bool details = false;
  bool cancelled = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      cancelled = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${widget.canceledRidesModel.status}',
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: grey,
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 20.0.h),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                width: double.infinity,
                height: details ? 175.h : 105.h,
                decoration: BoxDecoration(
                  color: lightWhite,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                width: 70.w,
                                height: 70.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: red,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: widget.canceledRidesModel.bookings!
                                              .users_customers!.profile_pic !=
                                          null
                                      ? Image.network(
                                          'https://deliver.eigix.net/public/${widget.canceledRidesModel.bookings!.users_customers!.profile_pic}',
                                          fit: BoxFit.cover,
                                          errorBuilder: (BuildContext context,
                                              Object exception,
                                              StackTrace? stackTrace) {
                                            return SizedBox(
                                              child: SvgPicture.asset(
                                                'assets/images/bike.svg',
                                                fit: BoxFit.scaleDown,
                                              ),
                                            );
                                          },
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent?
                                                  loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return Center(
                                              child: CircularProgressIndicator(
                                                color: orange,
                                                value: loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        loadingProgress
                                                            .expectedTotalBytes!
                                                    : null,
                                              ),
                                            );
                                          },
                                        )
                                      : SvgPicture.asset(
                                          'assets/images/bike.svg',
                                          fit: BoxFit.scaleDown,
                                        ),
                                ),
                              ),
                              SizedBox(
                                width: 15.w,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 250.w,
                                      child: AutoSizeText(
                                        '${widget.canceledRidesModel.bookings!.users_customers!.first_name} ${widget.canceledRidesModel.bookings!.users_customers!.last_name}',
                                        maxLines: 2,
                                        minFontSize: 12,
                                        style: GoogleFonts.inter(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                          color: black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    SizedBox(
                                      width: 200.w,
                                      child: AutoSizeText(
                                        '${widget.canceledRidesModel.users_fleet_vehicles!.model}',
                                        minFontSize: 13,
                                        maxLines: 2,
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: grey,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 200.w,
                                      child: AutoSizeText(
                                        '(${widget.canceledRidesModel.users_fleet_vehicles!.vehicle_registration_no})',
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: cancelled,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                details = true;
                                cancelled = false;
                              });
                            },
                            child: SeeDetailsOnCompletedRidesButton(context),
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: details,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset('assets/images/location.svg'),
                              SizedBox(
                                width: 7.h,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Pickup',
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: grey,
                                    ),
                                  ),
                                  Text(
                                    '${widget.canceledRidesModel.bookings!.pickup_address}',
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: -10,
                child: Visibility(
                  visible: details,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        cancelled = true;
                        details = false;
                      });
                    },
                    child: details ? detailsButtonDown(context) : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
