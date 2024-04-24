import 'package:deliver_partner/Constants/PageLoadingKits.dart';
import 'package:deliver_partner/models/API_models/API_response.dart';
import 'package:deliver_partner/models/API_models/GetBookingDestinationsStatus.dart';
import 'package:deliver_partner/models/API_models/ShowBookingsModel.dart';
import 'package:deliver_partner/utilities/showToast.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Constants/Colors.dart';
import '../../../models/API_models/GetAllSystemDataModel.dart';
import '../../../services/API_services.dart';
import 'UserToUserChat/UserToUserChat.dart';
import 'modalBottomSheetEndRide.dart';

class ModalBottomSheetStartRide extends StatefulWidget {
  final String userID;
  final BookingModel bookingModel;
  final List<BookingDestinations> bookingDestinations;

  const ModalBottomSheetStartRide({
    super.key,
    required this.userID,
    required this.bookingModel,
    required this.bookingDestinations,
  });

  @override
  State<ModalBottomSheetStartRide> createState() =>
      _ModalBottomSheetStartRideState();
}

class _ModalBottomSheetStartRideState extends State<ModalBottomSheetStartRide> {
  bool packageStatus = false;

  late APIResponse<List<GetBookingDestinationsStatus>>
      getBookingDestinationsStatusResponse;
  List<GetBookingDestinationsStatus>? getBookingDestinationsStatusList;

  late APIResponse<List<GetAllSystemDataModel>> _getAllSystemDataResponse;
  List<GetAllSystemDataModel>? _getSystemDataList;

  String currency = '';

  int? statusID;
  int? startRideID;
  String? distance;
  bool isLoading = false;
  int currentIndex = 0;
  String? bookingsDestinationsId;

  ScrollController nextPageScrollController = ScrollController();
  List<String>? pickedParcelIds = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
    setState(() {
      isLoading = true;
    });
    nextPageScrollController.addListener(() {
      setState(() {
        // Update the current index based on the scroll position
        currentIndex = (nextPageScrollController.offset /
                MediaQuery.of(context).size.width)
            .round();
      });
    });
  }

  String? name;
  String? startRide;

  init() async {
    getBookingDestinationsStatusResponse =
        await service.getBookingDestinationsStatusAPI();
    getBookingDestinationsStatusList = [];

    if (getBookingDestinationsStatusResponse.status!.toLowerCase() ==
        'success') {
      if (getBookingDestinationsStatusResponse.data != null) {
        getBookingDestinationsStatusList!
            .addAll(getBookingDestinationsStatusResponse.data!);
        for (GetBookingDestinationsStatus model
            in getBookingDestinationsStatusList!) {
          if (model.name == 'Parcel Picked') {
            setState(() {
              name = model.name!;
              statusID = model.bookings_destinations_status_id!;
              print("statusID: $statusID");
            });
          } else if (model.name == "Start Ride") {
            setState(() {
              startRide = model.name!;
              startRideID = model.bookings_destinations_status_id!;
            });
          }
        }
      }
    }

    _getAllSystemDataResponse = await service.getALlSystemDataAPI();
    _getSystemDataList = [];

    if (_getAllSystemDataResponse.status!.toLowerCase() == 'success') {
      if (_getAllSystemDataResponse.data != null) {
        _getSystemDataList!.addAll(_getAllSystemDataResponse.data!);
        for (GetAllSystemDataModel model in _getSystemDataList!) {
          if (model.type == 'system_currency') {
            setState(() {
              currency = model.description!;
            });
          } else if (model.type == 'distance_unit') {
            setState(() {
              distance = model.description!;
            });
          }
        }
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < widget.bookingDestinations.length; i++) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 10.h),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        height: widget.bookingModel.scheduled == "Yes"
            ? MediaQuery.sizeOf(context).height * 0.685
            : MediaQuery.sizeOf(context).height * 0.645,
        child: isLoading
            ? spinKitRotatingCircle
            : Column(
                children: [
                  SizedBox(
                    height: 13.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 60.w,
                            height: 60.h,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: Image.network(
                                'https://deliver.eigix.net/public/${widget.bookingModel.users_customers!.profile_pic}',
                                fit: BoxFit.cover,
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return SizedBox(
                                      child: Image.asset(
                                    'assets/images/place-holder.png',
                                    fit: BoxFit.scaleDown,
                                  ));
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
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  );
                                },
                              ),
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
                                  '${widget.bookingModel.users_customers!.first_name!} ${widget.bookingModel.users_customers!.last_name!}',
                                  minFontSize: 12,
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
                              widget.bookingModel.scheduled == "Yes"
                                  ? Text(
                                      '${widget.bookingModel.bookings_types!.name!} (Scheduled Ride)',
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: grey,
                                      ),
                                    )
                                  : Text(
                                      widget.bookingModel.bookings_types!.name!,
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: grey,
                                      ),
                                    ),
                              SizedBox(
                                height: 4.h,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => startUserToUserChatMethod(context),
                            child: Column(
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
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          GestureDetector(
                            onTap: () {
                              _makePhoneCall(
                                  widget.bookingModel.users_customers!.phone!);
                            },
                            child: Column(
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
                                    colorFilter: const ColorFilter.mode(
                                        white, BlendMode.srcIn),
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
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  widget.bookingModel.delivery_type == 'Single'
                      ? Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Receiver Name',
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.syne(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: grey,
                                  ),
                                ),
                                Text(
                                  'Receiver Contact',
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
                                Text(
                                  '${widget.bookingDestinations[i].receiver_name}',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: black,
                                  ),
                                ),
                                Text(
                                  '${widget.bookingDestinations[i].receiver_phone}',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: black,
                                  ),
                                )
                              ],
                            ),
                            widget.bookingModel.scheduled == "Yes"
                                ? SizedBox(
                                    height: 5.h,
                                  )
                                : SizedBox(
                                    height: 20.h,
                                  ),
                            widget.bookingModel.scheduled == "Yes"
                                ? Column(
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Schedule Delivery Date',
                                            textAlign: TextAlign.start,
                                            style: GoogleFonts.syne(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: grey,
                                            ),
                                          ),
                                          Text(
                                            'Schedule Delivery Time',
                                            style: GoogleFonts.syne(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${widget.bookingModel.delivery_date}',
                                            style: GoogleFonts.inter(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: black,
                                            ),
                                          ),
                                          Text(
                                            DateFormat('h:mm a').format(
                                              DateFormat('HH:mm:ss').parse(
                                                  widget.bookingModel
                                                      .delivery_time!),
                                            ),
                                            style: GoogleFonts.inter(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: black,
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
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
                            SizedBox(
                              height: 4.h,
                            ),
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
                                  width: 290.w,
                                  child: AutoSizeText(
                                    widget
                                        .bookingModel
                                        .bookings_destinations![0]
                                        .pickup_address!,
                                    maxLines: 2,
                                    minFontSize: 12,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/pointer.svg',
                                  colorFilter: const ColorFilter.mode(
                                      orange, BlendMode.srcIn),
                                  width: 24.w,
                                  height: 24.h,
                                ),
                                SizedBox(
                                  width: 10.w,
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
                                      width: 290.w,
                                      child: AutoSizeText(
                                        widget.bookingDestinations[i]
                                            .destin_address!,
                                        minFontSize: 12,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
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
                              height: 20.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    width: 40.w,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/timer-icon.svg',
                                          colorFilter: const ColorFilter.mode(
                                              black, BlendMode.srcIn),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.004),
                                        Text(
                                          widget.bookingDestinations[i]
                                              .destin_time!,
                                          style: GoogleFonts.inter(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700,
                                            color: black,
                                          ),
                                        ),
                                        Text(
                                          'Estimate Time',
                                          style: GoogleFonts.syne(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: grey,
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
                                        SvgPicture.asset(
                                            'assets/images/meter-icon.svg'),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.007),
                                        Text(
                                          '${widget.bookingDestinations[i].destin_distance!} $distance',
                                          style: GoogleFonts.inter(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700,
                                            color: black,
                                          ),
                                        ),
                                        Text(
                                          'Total Distance',
                                          style: GoogleFonts.syne(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: grey,
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
                                          currency,
                                          style: GoogleFonts.inter(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: black,
                                          ),
                                        ),
                                        Text(
                                          '${widget.bookingModel.total_charges}',
                                          // '$currency ${widget.bookingDestinationsList![i].destin_discounted_charges!}',
                                          style: GoogleFonts.inter(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700,
                                            color: black,
                                          ),
                                        ),
                                        Text(
                                          'Fare',
                                          style: GoogleFonts.syne(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Container(
                              color: Colors.transparent,
                              padding: const EdgeInsets.only(right: 10),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.38,
                              child: isLoading
                                  ? spinKitRotatingCircle
                                  : PageView.builder(
                                      onPageChanged: (index) async {
                                        setState(() {
                                          currentIndex =
                                              index; // Update currentIndex when page changes
                                        });
                                      },
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          widget.bookingDestinations.length,
                                      controller: pageController,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          color: Colors.transparent,
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.86,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.38,
                                          child: isLoading
                                              ? spinKitRotatingCircle
                                              : Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Receiver Name',
                                                          textAlign:
                                                              TextAlign.start,
                                                          style:
                                                              GoogleFonts.syne(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: grey,
                                                          ),
                                                        ),
                                                        Text(
                                                          'Receiver Contact',
                                                          style:
                                                              GoogleFonts.syne(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: grey,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 3.h,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          '${widget.bookingDestinations[index].receiver_name}',
                                                          style:
                                                              GoogleFonts.inter(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: black,
                                                          ),
                                                        ),
                                                        Text(
                                                          '${widget.bookingDestinations[index].receiver_phone}',
                                                          style:
                                                              GoogleFonts.inter(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: black,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    widget.bookingModel
                                                                .scheduled ==
                                                            "Yes"
                                                        ? SizedBox(
                                                            height: 5.h,
                                                          )
                                                        : SizedBox(
                                                            height: 20.h,
                                                          ),
                                                    widget.bookingModel
                                                                .scheduled ==
                                                            "Yes"
                                                        ? Column(
                                                            // crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                height: 10.h,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    'Schedule Delivery Date',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    style:
                                                                        GoogleFonts
                                                                            .syne(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color:
                                                                          grey,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    'Schedule Delivery Time',
                                                                    style:
                                                                        GoogleFonts
                                                                            .syne(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color:
                                                                          grey,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 5.h,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    '${widget.bookingModel.delivery_date}',
                                                                    style: GoogleFonts
                                                                        .inter(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color:
                                                                          black,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    DateFormat(
                                                                            'h:mm a')
                                                                        .format(
                                                                      DateFormat('HH:mm:ss').parse(widget
                                                                          .bookingModel
                                                                          .delivery_time!),
                                                                    ),
                                                                    style: GoogleFonts
                                                                        .inter(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color:
                                                                          black,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 15.h,
                                                              ),
                                                            ],
                                                          )
                                                        : const SizedBox(),
                                                    Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                            'assets/images/location.svg'),
                                                        SizedBox(
                                                          width: 15.w,
                                                        ),
                                                        Text(
                                                          'Pickup From',
                                                          style:
                                                              GoogleFonts.syne(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: grey,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 8.0.w),
                                                          child:
                                                              SvgPicture.asset(
                                                            'assets/images/dotted-line.svg',
                                                            fit: BoxFit
                                                                .scaleDown,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 25.w,
                                                        ),
                                                        SizedBox(
                                                          width: 250.w,
                                                          child: AutoSizeText(
                                                            widget
                                                                .bookingDestinations[
                                                                    index]
                                                                .pickup_address!,
                                                            maxLines: 3,
                                                            minFontSize: 12,
                                                            style: GoogleFonts
                                                                .inter(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: black,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SvgPicture.asset(
                                                          'assets/images/pointer.svg',
                                                          colorFilter:
                                                              const ColorFilter
                                                                  .mode(
                                                                  orange,
                                                                  BlendMode
                                                                      .srcIn),
                                                          width: 24.w,
                                                          height: 24.h,
                                                        ),
                                                        SizedBox(
                                                          width: 10.w,
                                                        ),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Deliver To',
                                                              style: GoogleFonts
                                                                  .syne(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: grey,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 10.h,
                                                            ),
                                                            SizedBox(
                                                              width: 270.w,
                                                              child:
                                                                  AutoSizeText(
                                                                widget
                                                                    .bookingDestinations[
                                                                        index]
                                                                    .destin_address!,
                                                                minFontSize: 12,
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
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
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            child: SizedBox(
                                                              width: 40.w,
                                                              child: Column(
                                                                children: [
                                                                  SvgPicture
                                                                      .asset(
                                                                    'assets/images/timer-icon.svg',
                                                                    colorFilter: const ColorFilter
                                                                        .mode(
                                                                        black,
                                                                        BlendMode
                                                                            .srcIn),
                                                                  ),
                                                                  SizedBox(
                                                                      height: MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                          0.004),
                                                                  Text(
                                                                    widget
                                                                        .bookingDestinations[
                                                                            index]
                                                                        .destin_time!,
                                                                    style: GoogleFonts
                                                                        .inter(
                                                                      fontSize:
                                                                          10,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      color:
                                                                          black,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    'Estimate Time',
                                                                    style:
                                                                        GoogleFonts
                                                                            .syne(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color:
                                                                          grey,
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
                                                                  SvgPicture.asset(
                                                                      'assets/images/meter-icon.svg'),
                                                                  SizedBox(
                                                                      height: MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                          0.007),
                                                                  Text(
                                                                    '${widget.bookingDestinations[index].destin_distance!} $distance',
                                                                    style: GoogleFonts
                                                                        .inter(
                                                                      fontSize:
                                                                          10,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      color:
                                                                          black,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    'Total Distance',
                                                                    style:
                                                                        GoogleFonts
                                                                            .syne(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color:
                                                                          grey,
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
                                                                    currency,
                                                                    style: GoogleFonts
                                                                        .inter(
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      color:
                                                                          black,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    '${widget.bookingModel.total_charges}',
                                                                    // '$currency ${widget.bookingDestinationsList![i].destin_discounted_charges!}',
                                                                    style: GoogleFonts
                                                                        .inter(
                                                                      fontSize:
                                                                          10,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      color:
                                                                          black,
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child: Text(
                                                                      'Fare',
                                                                      style: GoogleFonts
                                                                          .syne(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        color:
                                                                            grey,
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
                                                    isParcelPicked
                                                        ? SizedBox(
                                                            // width: 10.w,
                                                            height: 10.h,
                                                            child:
                                                                const SpinKitThreeInOut(
                                                              size: 10,
                                                              color: orange,
                                                            ),
                                                          )
                                                        : Row(
                                                            children: [
                                                              GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    // packageStatus =
                                                                    //     !packageStatus;
                                                                    statusID;
                                                                  });
                                                                  bookingsDestinationsId = widget
                                                                      .bookingDestinations[
                                                                          index]
                                                                      .bookings_destinations_id
                                                                      .toString();
                                                                  print(
                                                                      'object id of picked parcel: $bookingsDestinationsId');
                                                                  parcelPickedMethod(
                                                                      context,
                                                                      bookingsDestinationsId!);

                                                                  print(
                                                                      'object id of picked parcel: ${statusID.toString()}');
                                                                },
                                                                child: pickedParcelIds!.contains(widget
                                                                        .bookingDestinations[
                                                                            index]
                                                                        .bookings_destinations_id
                                                                        .toString())
                                                                    ? SvgPicture
                                                                        .asset(
                                                                            'assets/images/tick-orange.svg')
                                                                    : SvgPicture
                                                                        .asset(
                                                                            'assets/images/tick-grey.svg'),
                                                              ),
                                                              SizedBox(
                                                                width: 15.w,
                                                              ),
                                                              pickedParcelIds!.contains(widget
                                                                      .bookingDestinations[
                                                                          index]
                                                                      .bookings_destinations_id
                                                                      .toString())
                                                                  ? Text(
                                                                      name!,
                                                                      style: GoogleFonts
                                                                          .syne(
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        color:
                                                                            black,
                                                                      ),
                                                                    )
                                                                  : Text(
                                                                      'Pick Parcel',
                                                                      style: GoogleFonts
                                                                          .syne(
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        color:
                                                                            black,
                                                                      ),
                                                                    ),
                                                            ],
                                                          ),
                                                  ],
                                                ),
                                        );
                                      }),
                            ),
                          ],
                        ),
                  widget.bookingModel.delivery_type == 'Single'
                      ? SizedBox(height: 5.h)
                      : SizedBox(height: 15.h),
                  widget.bookingModel.delivery_type == 'Single'
                      ? isParcelPicked
                          ? SizedBox(
                              height: 10.h,
                              child: const SpinKitThreeInOut(
                                size: 10,
                                color: orange,
                              ),
                            )
                          : Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      packageStatus = !packageStatus;
                                      statusID;
                                    });
                                    parcelPickedMethod(
                                        context,
                                        widget.bookingDestinations[0]
                                            .bookings_destinations_id
                                            .toString());
                                    print(
                                        'object id of picked parcel: ${statusID.toString()}');
                                  },
                                  child: packageStatus
                                      ? SvgPicture.asset(
                                          'assets/images/tick-orange.svg')
                                      : SvgPicture.asset(
                                          'assets/images/tick-grey.svg'),
                                ),
                                SizedBox(
                                  width: 15.w,
                                ),
                                Text(
                                  name!,
                                  style: GoogleFonts.syne(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: black,
                                  ),
                                ),
                              ],
                            )
                      : const SizedBox(),
                  widget.bookingModel.delivery_type == 'Single'
                      ? SizedBox(
                          height: 15.h,
                        )
                      : const SizedBox(),
                  widget.bookingModel.delivery_type == 'Single'
                      ? const SizedBox()
                      : Container(
                          color: Colors.transparent,
                          height: 12.h,
                          width: 100.w,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 7),
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                controller: nextPageScrollController,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: widget.bookingDestinations.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      pageController.animateToPage(index,
                                          duration:
                                              const Duration(milliseconds: 500),
                                          curve: Curves.ease);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(width: 3.w),
                                        Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: currentIndex == index
                                                ? orange
                                                : grey, // Adjust indicator color based on current index
                                          ),
                                        ),
                                        SizedBox(width: 3.w)
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        ),
                  SizedBox(
                    height: 15.h,
                  ),
                  isRideStarting
                      ? const SpinKitDoubleBounce(
                          color: orange,
                          size: 50.0,
                        )
                      : GestureDetector(
                          onTap: () {
                            startRideMethod(context);
                          },
                          child: Container(
                            width: 170.w,
                            height: 51.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xffFF6302),
                                  Color(0xffFBC403),
                                ],
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'START RIDE',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.syne(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: white,
                                ),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
      );
    }
    return const SizedBox();
  }

  PageController pageController = PageController();
  bool isChatStarting = false;
  APIResponse<APIResponse>? startUserToUserChatResponse;

  startUserToUserChatMethod(BuildContext context) async {
    setState(() {
      isChatStarting = true;
    });
    Map startChatData = {
      "request_type": " startChat",
      "users_type": "Rider",
      "other_users_type": "Customers",
      "users_id": widget.userID,
      "other_users_id":
          widget.bookingModel.users_customers!.users_customers_id.toString(),
    };
    print('object start suer to uer chat data: ${startChatData.toString()}');
    startUserToUserChatResponse =
        await service.startUserToUserChatAPI(startChatData);
    if (startUserToUserChatResponse!.status!.toLowerCase() == 'success') {
      showToastSuccess('Chat has been started!', FToast().init(context),
          seconds: 1);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => UserToUserChat(
            phone: widget.bookingModel.users_customers!.phone!,
            riderID: widget.userID.toString(),
            image: widget.bookingModel.users_customers!.profile_pic!,
            name:
                "${widget.bookingModel.users_customers!.first_name!} ${widget.bookingModel.users_customers!.last_name!}",
            address:
                widget.bookingModel.bookings_destinations![0].pickup_address,
            clientID: widget.bookingModel.users_customers!.users_customers_id
                .toString(),
          ),
        ),
      );
    } else {
      print(
          'error starting chat:  ${startUserToUserChatResponse!.message!.toString()}');
      // showToastError('error occurred,try again', FToast().init(context),
      //     seconds: 2);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => UserToUserChat(
            phone: widget.bookingModel.users_customers!.phone!,
            riderID: widget.userID.toString(),
            image: widget.bookingModel.users_customers!.profile_pic!,
            name:
                "${widget.bookingModel.users_customers!.first_name!} ${widget.bookingModel.users_customers!.last_name!}",
            address:
                widget.bookingModel.bookings_destinations![0].pickup_address,
            clientID: widget.bookingModel.users_customers!.users_customers_id
                .toString(),
          ),
        ),
      );
    }
    setState(() {
      isChatStarting = false;
    });
  }

  ApiServices get service => GetIt.I<ApiServices>();

  APIResponse<ShowBookingsModel>? startRideResponse;

  bool isRideStarting = false;

  startRideMethod(BuildContext context) async {
    if (widget.bookingModel.scheduled == "Yes") {
      showToastError(
          'Your scheduled ride is not started yet', FToast().init(context),
          seconds: 2);
    } else if (pickedParcelIds!.length != widget.bookingDestinations.length) {
      showToastError(
          'You\'ve to pick all the parcel from pickup location first.',
          FToast().init(context),
          seconds: 2);
    } else {
      setState(() {
        isRideStarting = true;
      });

      Map startRideData = {
        "bookings_id": widget.bookingModel.bookings_id.toString(),
        "bookings_destinations_id":
            widget.bookingDestinations[0].bookings_destinations_id.toString(),
        "bookings_destinations_status_id": startRideID.toString()
      };
      print('object start ride data: ${startRideData.toString()}');
      startRideResponse = await service.startRideRequest(startRideData);

      if (startRideResponse!.status!.toLowerCase() == "success") {
        if (startRideResponse!.data != null) {
          showToastSuccess('Ride has been started', FToast().init(context));
          Navigator.of(context).pop();
          showModalBottomSheet(
            backgroundColor: white,
            isDismissible: false,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            context: context,
            builder: (context) => ModalBottomSheetEndRide(
              bookingModel: widget.bookingModel,
              userID: widget.userID,
              bookingDestinations: widget.bookingDestinations,
            ),
          );
        }
      } else {
        showToastError(startRideResponse!.message, FToast().init(context));
        print(
            'object status starting ride: ${startRideResponse!.status!.toString()}');
        print(
            'object message starting ride: ${startRideResponse!.message!.toString()}');
      }
      setState(() {
        isRideStarting = false;
      });
    }
  }

  bool isParcelPicked = false;
  APIResponse<ShowBookingsModel>? pickedResponse;

  parcelPickedMethod(BuildContext context, String index) async {
    setState(() {
      isParcelPicked = true;
    });
    Map startRideData = {
      "bookings_id": widget.bookingModel.bookings_id.toString(),
      "bookings_destinations_id": index,
      "bookings_destinations_status_id": statusID.toString()
    };
    print('object picked parcel data: ${startRideData.toString()}');
    pickedResponse = await service.startRideRequest(startRideData);

    if (pickedResponse!.status!.toLowerCase() == "success") {
      if (pickedResponse!.data != null) {
        showToastSuccess('Parcel has been picked', FToast().init(context));
      }
      pickedParcelIds!.add(index);
      print('picked parcels id: ${pickedParcelIds!.toString()}');
    } else {
      showToastError(pickedResponse!.message, FToast().init(context));
      print(
          'object status picked parcel: ${pickedResponse!.status!.toString()}');
      print(
          'object message picked parcel: ${pickedResponse!.message!.toString()}');
    }
    setState(() {
      isParcelPicked = false;
    });
  }
}
