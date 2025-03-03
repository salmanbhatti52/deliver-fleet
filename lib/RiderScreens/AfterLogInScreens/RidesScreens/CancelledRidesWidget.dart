import 'package:deliver_partner/Constants/Colors.dart';
import 'package:deliver_partner/Constants/SeeDetailsOnCompletedRidesButton.dart';
import 'package:deliver_partner/Constants/details-button.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../models/API_models/InProgressRidesModel.dart';

class CancelledRidesWidget extends StatefulWidget {
  final InProgressRidesModel canceledRidesModel;
  const CancelledRidesWidget({super.key, required this.canceledRidesModel});

  @override
  State<CancelledRidesWidget> createState() => _CancelledRidesWidgetState();
}

class _CancelledRidesWidgetState extends State<CancelledRidesWidget> {
  bool details = false;
  bool cancelled = false;

  DateTime? timeAdded;
  var formattedTime = "";
  var formattedDate = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timeAdded = DateTime.parse("${widget.canceledRidesModel.date_modified}");
    formattedDate = DateFormat('d MMM yyyy').format(timeAdded!);
    formattedTime = DateFormat('hh:mm:ss a').format(timeAdded!);
    print("Formatted Date: $formattedDate");
    print("Formatted Time: $formattedTime");
    setState(() {
      cancelled = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20.h,
        ),
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
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              width: double.infinity,
              height: details ? 210.h : 90.h,
              decoration: BoxDecoration(
                color: lightWhite,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Container(
                              width: 70.w,
                              height: 70.h,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  width: 1,
                                  color: lightGrey.withOpacity(0.8),
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: widget.canceledRidesModel.bookings!
                                            .users_customers!.profile_pic !=
                                        null
                                    ? Image.network(
                                        'https://deliverbygfl.com/public/${widget.canceledRidesModel.bookings!.users_customers!.profile_pic}',
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
                                            ImageChunkEvent? loadingProgress) {
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
                                      '${widget.canceledRidesModel.users_fleet_vehicles!.color}  ${widget.canceledRidesModel.users_fleet_vehicles!.model}',
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
                          height: 20.h,
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
                                SizedBox(
                                  height: 5.h,
                                ),
                                Container(
                                  color: Colors.transparent,
                                  width:
                                      MediaQuery.of(context).size.width * 0.74,
                                  child: Text(
                                    '${widget.canceledRidesModel.bookings!.bookings_destinations![0].pickup_address}',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Cancelled Ride Date',
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.syne(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: grey,
                                  ),
                                ),
                                Text(
                                  'Cancelled Ride Time',
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.syne(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: grey,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AutoSizeText(
                                  formattedDate,
                                  maxLines: 3,
                                  minFontSize: 12,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: black,
                                  ),
                                ),
                                AutoSizeText(
                                  formattedTime,
                                  maxLines: 3,
                                  minFontSize: 12,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: black,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: -12,
              child: Visibility(
                visible: details,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      cancelled = true;
                      details = false;
                    });
                  },
                  child: details ? detailsButtonUp(context) : null,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
