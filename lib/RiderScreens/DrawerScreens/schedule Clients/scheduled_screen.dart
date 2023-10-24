import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Constants/Colors.dart';
import '../../../Constants/PageLoadingKits.dart';
import '../../../Constants/SeeDetailsOnCompletedRidesButton.dart';
import '../../../Constants/details-button.dart';
import '../../../Constants/ratingContainerOnCompletedRides.dart';
import '../../../models/API models/ScheduledRiderModel.dart';
import '../../AfterLogInScreens/RidesScreens/CompletedRidesDestinationsWidget.dart';

class ScheduledScreen extends StatefulWidget {
  final ScheduledRiderModel scheduledRiderModel;
  const ScheduledScreen({super.key, required this.scheduledRiderModel});

  @override
  State<ScheduledScreen> createState() => _ScheduledScreenState();
}

class _ScheduledScreenState extends State<ScheduledScreen> {

  bool opened = false;
  bool closed = false;

  @override
  void initState() {
    super.initState();
    closed = true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.h,
          ),
          Text(
            '${widget.scheduledRiderModel.status}',
            // "Status",
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: grey,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20.h),
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                  width: double.infinity,
                  height: opened ? 350.h : 160.h,
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
                              borderRadius: BorderRadius.circular(15),
                              color: red,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: widget.scheduledRiderModel.bookings!
                                  .users_customers!.profile_pic !=
                                  null
                                  ? Image.network(
                                'https://deliver.eigix.net/public/${widget.scheduledRiderModel.bookings!.users_customers!.profile_pic}',
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
                                          // "name",
                                          '${widget.scheduledRiderModel.bookings!.users_customers!.first_name} '
                                              '${widget.scheduledRiderModel.bookings!.users_customers!.last_name}',
                                          maxLines: 2,
                                          minFontSize: 12,
                                          style: GoogleFonts.inter(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w400,
                                            color: black,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          child: RatingContainerOnCompletedRides(
                                              ratings: widget.scheduledRiderModel.users_fleet!.bookings_ratings == null
                                                  ? '0.0'
                                                  : '${widget.scheduledRiderModel.users_fleet!.bookings_ratings}')),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                SizedBox(
                                  width: 200.w,
                                  child: AutoSizeText(
                                    // "model",
                                    '${widget.scheduledRiderModel.users_fleet_vehicles!.model}',
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
                                    // "vehicle_registration_no",
                                    '(${widget.scheduledRiderModel.users_fleet_vehicles!.vehicle_registration_no})',
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
                                // "color",
                                'Ride Color ${widget.scheduledRiderModel.users_fleet_vehicles!.color}',
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400,
                                  color: black,
                                  fontSize: 14,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    closed = false;
                                    opened = true;
                                  });
                                },
                                child: SeeDetailsOnCompletedRidesButton(context),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Visibility(
                          visible: opened,
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(
                                height: 20.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Scheduled Date',
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: grey,
                                        ),
                                      ),
                                      Text(
                                        // "pickup_address",
                                        '${widget.scheduledRiderModel.bookings!.delivery_date}',
                                        style: GoogleFonts.inter(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Scheduled Time',
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: grey,
                                        ),
                                      ),
                                      Text(
                                        // "pickup_address",
                                        '${widget.scheduledRiderModel.bookings!.delivery_time}',
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
                                      Text(
                                        // "pickup_address",
                                        '${widget.scheduledRiderModel.bookings!.pickup_address}',
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
                                  // destination: "destination",
                                  // distance: "distance",
                                  // time: "time",
                                  // fare: "fare",
                                  destination: widget.scheduledRiderModel.bookings!.bookings_destinations![0]!.destin_address!,
                                  distance: widget.scheduledRiderModel.bookings!.bookings_destinations![0]!.destin_distance!,
                                  time: widget.scheduledRiderModel.bookings!.bookings_destinations![0]!.destin_time!,
                                  fare: widget.scheduledRiderModel.bookings!.total_charges.toString(),
                                  // fare: widget.scheduledRiderModel.bookings!.bookings_destinations![0]!.destin_discounted_charges!,
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
                    bottom: -10,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          opened = false;
                          closed = true;
                        });
                      },
                      child: detailsButtonOpen(context),
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
