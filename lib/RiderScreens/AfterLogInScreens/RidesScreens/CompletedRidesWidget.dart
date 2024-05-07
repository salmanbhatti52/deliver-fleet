import 'package:auto_size_text/auto_size_text.dart';
import 'package:deliver_partner/RiderScreens/AfterLogInScreens/RidesScreens/CompletedRideBottomSheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Constants/Colors.dart';
import '../../../Constants/SeeDetailsOnCompletedRidesButton.dart';
import '../../../Constants/details-button.dart';
import '../../../Constants/ratingContainerOnCompletedRides.dart';
import '../../../models/API_models/InProgressRidesModel.dart';
import 'CompletedRidesDestinationsWidget.dart';

class CompletedRidesWidget extends StatefulWidget {
  final InProgressRidesModel completedRidesModel;
  const CompletedRidesWidget({super.key, required this.completedRidesModel});

  @override
  State<CompletedRidesWidget> createState() => _CompletedRidesWidgetState();
}

class _CompletedRidesWidgetState extends State<CompletedRidesWidget> {
  DateTime? timeAdded;
  bool opened = false;
  bool closed = false;

  String formatTimeDifference(DateTime dateTime) {
    Duration difference = DateTime.now().difference(dateTime);

    if (difference.inDays >= 365) {
      int years = (difference.inDays / 365).floor();
      return "${years == 1 ? '1 year' : '$years years'} ago";
    } else if (difference.inDays >= 30) {
      int months = (difference.inDays / 30).floor();
      return "${months == 1 ? '1 month' : '$months months'} ago";
    } else if (difference.inDays >= 7) {
      int weeks = (difference.inDays / 7).floor();
      return "${weeks == 1 ? '1 week' : '$weeks weeks'} ago";
    } else if (difference.inDays > 0) {
      return "${difference.inDays == 1 ? '1 day' : '${difference.inDays} days'} ago";
    } else if (difference.inHours > 0) {
      return "${difference.inHours == 1 ? '1 hour' : '${difference.inHours} hours'} ago";
    } else if (difference.inMinutes > 0) {
      return "${difference.inMinutes == 1 ? '1 minute' : '${difference.inMinutes} mins'} ago";
    } else {
      return "Just now";
    }
  }

  @override
  void initState() {
    super.initState();
    closed = true;
  }

  @override
  Widget build(BuildContext context) {
    timeAdded = DateTime.parse("${widget.completedRidesModel.date_modified}");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20.h,
        ),
        Text(
          '${widget.completedRidesModel.status}',
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
              height: opened ? 315.h : 140.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: lightWhite,
              ),
              child: Column(
                children: [
                  Row(
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
                          child: widget.completedRidesModel.bookings!
                                      .users_customers!.profile_pic !=
                                  null
                              ? Image.network(
                                  'https://cs.deliverbygfl.com/public/${widget.completedRidesModel.bookings!.users_customers!.profile_pic}',
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
                        width: 10.w,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.59,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 160.w,
                                    child: AutoSizeText(
                                      '${widget.completedRidesModel.bookings!.users_customers!.first_name} '
                                      '${widget.completedRidesModel.bookings!.users_customers!.last_name}',
                                      maxLines: 2,
                                      minFontSize: 12,
                                      style: GoogleFonts.inter(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                        color: black,
                                      ),
                                    ),
                                  ),
                                  RatingContainerOnCompletedRides(
                                      ratings: widget
                                                  .completedRidesModel
                                                  .users_fleet!
                                                  .bookings_ratings ==
                                              null
                                          ? '0.0'
                                          : '${widget.completedRidesModel.users_fleet!.bookings_ratings}'),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            SizedBox(
                              width: 200.w,
                              child: AutoSizeText(
                                '${widget.completedRidesModel.users_fleet_vehicles!.color} ${widget.completedRidesModel.users_fleet_vehicles!.model}',
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
                                '(${widget.completedRidesModel.users_fleet_vehicles!.vehicle_registration_no})',
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
                  Visibility(
                    visible: closed,
                    child: Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AutoSizeText(
                            'You Completed a ride \n${formatTimeDifference(timeAdded!)} with this client',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w400,
                              color: black,
                              fontSize: 14,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CompletedRideBottomSheet(
                                            bookingID: widget
                                                .completedRidesModel.bookings_id
                                                .toString(),
                                          )));
                            },
                            child: SeeDetailsOnCompletedRidesButton(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: opened,
                    child: SizedBox(
                      height: 220.h,
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
                                    width: 290.w,
                                    child: Text(
                                      '${widget.completedRidesModel.bookings!.bookings_destinations![0].pickup_address}',
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
                            height: 20.h,
                          ),
                          // widget.completedRidesModel.bookings!.delivery_type ==
                          //         'Multiple'
                          //     ? Container(
                          //         height: MediaQuery.sizeOf(context).height *
                          //             0.172,
                          //         color: lightGrey,
                          //         child: ListView(
                          //           shrinkWrap: true,
                          //           padding: EdgeInsets.zero,
                          //           physics: const BouncingScrollPhysics(),
                          //           scrollDirection: Axis.horizontal,
                          //           children: [
                          //             CompletedRidesDestinationsWidget(
                          //               destination: widget
                          //                   .completedRidesModel
                          //                   .destin1_address!,
                          //               distance: widget.completedRidesModel
                          //                   .destin1_distance!,
                          //               time: widget.completedRidesModel
                          //                   .destin1_time!,
                          //               fare: widget.completedRidesModel
                          //                   .total_charges!,
                          //             ),
                          //             CompletedRidesDestinationsWidget(
                          //               destination: widget
                          //                   .completedRidesModel
                          //                   .destin1_address!,
                          //               distance: widget.completedRidesModel
                          //                   .destin1_distance!,
                          //               time: widget.completedRidesModel
                          //                   .destin1_time!,
                          //               fare: widget.completedRidesModel
                          //                   .total_charges!,
                          //             ),
                          //             CompletedRidesDestinationsWidget(
                          //               destination: widget
                          //                   .completedRidesModel
                          //                   .destin1_address!,
                          //               distance: widget.completedRidesModel
                          //                   .destin1_distance!,
                          //               time: widget.completedRidesModel
                          //                   .destin1_time!,
                          //               fare: widget.completedRidesModel
                          //                   .total_charges!,
                          //             ),
                          //           ],
                          //         ),
                          //       )
                          //
                          //     :
                          Expanded(
                            child: CompletedRidesDestinationsWidget(
                              destination: widget.completedRidesModel.bookings!
                                  .bookings_destinations![0].destin_address!,
                              distance: widget.completedRidesModel.bookings!
                                  .bookings_destinations![0].destin_distance!,
                              time: widget.completedRidesModel.bookings!
                                  .bookings_destinations![0].destin_time!,
                              fare: widget
                                  .completedRidesModel.bookings!.total_charges
                                  .toString(),
                              // fare: widget.completedRidesModel.bookings!.bookings_destinations![0]!.destin_discounted_charges!,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: opened,
              child: Positioned(
                bottom: -15,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      opened = false;
                      closed = true;
                    });
                  },
                  child: detailsButtonUp(context),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
