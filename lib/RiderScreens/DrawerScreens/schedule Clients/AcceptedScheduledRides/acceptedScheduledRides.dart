// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:deliver_partner/Constants/Colors.dart';
import 'package:deliver_partner/Constants/PageLoadingKits.dart';
import 'package:deliver_partner/RiderScreens/AfterLogInScreens/HomeScreens/UserToUserChat/UserToUserChat.dart';
import 'package:deliver_partner/models/API_models/API_response.dart';
import 'package:deliver_partner/models/API_models/GetAllSystemDataModel.dart';
import 'package:deliver_partner/models/API_models/GetBookingDestinationsStatus.dart';
import 'package:deliver_partner/models/API_models/ShowBookingsModel.dart';
import 'package:deliver_partner/models/API_models/getupdateBooking.dart';
import 'package:deliver_partner/services/API_services.dart';
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
import 'package:http/http.dart' as http;

class AcceptedScheduledRidesPage extends StatefulWidget {
  final String? userID;
  final String? bookingID;

  const AcceptedScheduledRidesPage({
    super.key,
    this.userID,
    this.bookingID,
  });

  @override
  State<AcceptedScheduledRidesPage> createState() =>
      _AcceptedScheduledRidesPageState();
}

class _AcceptedScheduledRidesPageState
    extends State<AcceptedScheduledRidesPage> {
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

  String? passcode0;
  String? passcode1;
  String? passcode2;
  String? passcode3;
  String? passcode4;

  UpdateBookingStatusModel updateBookingStatusModel =
      UpdateBookingStatusModel();
  String? responseString1;
  updateBookingStatus() async {
    setState(() {
      isLoading = true;
    });
    // print(
    // " Passssssssssss ${updateBookingStatusModel.data!.bookingsFleet![0].bookingsDestinations!.passCode}");
    // try {
    String apiUrl =
        "https://cs.deliverbygfl.com/api/get_updated_status_booking";
    debugPrint("apiUrl: $apiUrl");
    debugPrint("currentBookingId: ${widget.bookingID}");
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Accept': 'application/json',
      },
      body: {
        "bookings_id": widget.bookingID.toString(),
      },
    );
    responseString1 = response.body;

    debugPrint("response zain: $responseString1");
    debugPrint("statusCode: ${response.statusCode}");
    if (response.statusCode == 200) {
      updateBookingStatusModel =
          updateBookingStatusModelFromJson(responseString1!);
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      debugPrint(
          'updateBookingStatusModel status: ${updateBookingStatusModel.status}');
      debugPrint(
          'updateBookingStatusModel paymentStatus: ${updateBookingStatusModel.data!.paymentStatus}');
    }
    // }
    //  catch (e) {
    //   debugPrint('Something went wrong = ${e.toString()}');
    //   return null;
    // }
  }

  String? name;
  String? startRide;

  init() async {
    await updateBookingStatus();
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
    showToastError(
        "Payment Status ${updateBookingStatusModel.data!.paymentStatus}",
        FToast().init(context));
    _getAllSystemDataResponse = await service.getALlSystemDataAPI();
    _getSystemDataList = [];

    if (_getAllSystemDataResponse.status!.toLowerCase() == 'success') {
      if (_getAllSystemDataResponse.data != null) {
        _getSystemDataList!.addAll(_getAllSystemDataResponse.data!);
        for (GetAllSystemDataModel model in _getSystemDataList!) {
          if (model.type == 'system_currency') {
            if (mounted) {
              setState(() {
                currency = model.description!;
              });
            }
          } else if (model.type == 'distance_unit') {
            if (mounted) {
              setState(() {
                distance = model.description!;
              });
            }
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
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
    updateBookingStatus();

    // setState(() {
    //   isLoading = true;
    // });
    nextPageScrollController.addListener(() {
      setState(() {
        // Update the current index based on the scroll position
        currentIndex = (nextPageScrollController.offset /
                MediaQuery.of(context).size.width)
            .round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (updateBookingStatusModel.data == null) {
      // Data is not loaded yet, show a loading spinner
      return Scaffold(
          backgroundColor: white, body: Center(child: spinKitRotatingCircle));
    } else {
      for (int i = 0;
          i < updateBookingStatusModel.data!.bookingsFleet.length;) {
        return Scaffold(
          backgroundColor: white,
          appBar: AppBar(
            backgroundColor: white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              'Ride Details',
              style: GoogleFonts.syne(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: black,
              ),
            ),
            centerTitle: true,
          ),
          body: isLoading
              ? spinKitRotatingCircle
              : Container(
                  height: MediaQuery.of(context).size.height,
                  padding:
                      EdgeInsets.symmetric(horizontal: 22.w, vertical: 10.h),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
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
                                          'https://cs.deliverbygfl.com/public/${updateBookingStatusModel.data!.usersCustomers.profilePic}',
                                          fit: BoxFit.cover,
                                          errorBuilder: (BuildContext context,
                                              Object exception,
                                              StackTrace? stackTrace) {
                                            return SizedBox(
                                                child: Image.asset(
                                              'assets/images/place-holder.png',
                                              fit: BoxFit.scaleDown,
                                            ));
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
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 6.w,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 100.w,
                                          child: AutoSizeText(
                                            '${updateBookingStatusModel.data!.usersCustomers.firstName} ${updateBookingStatusModel.data!.usersCustomers.lastName}',
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
                                        updateBookingStatusModel
                                                    .data!.scheduled ==
                                                "Yes"
                                            ? Text(
                                                '${updateBookingStatusModel.data!.bookingsTypes.name} \n(Scheduled Ride)',
                                                style: GoogleFonts.inter(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: grey,
                                                ),
                                              )
                                            : Text(
                                                updateBookingStatusModel
                                                    .data!.bookingsTypes.name,
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
                                      onTap: () =>
                                          startUserToUserChatMethod(context),
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
                                        _makePhoneCall(updateBookingStatusModel
                                            .data!.usersCustomers.phone);
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
                                              colorFilter:
                                                  const ColorFilter.mode(
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
                            updateBookingStatusModel.data!.deliveryType ==
                                    'Single'
                                ? Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            updateBookingStatusModel
                                                .data!
                                                .bookingsFleet[0]
                                                .bookingsDestinations
                                                .receiverName,
                                            style: GoogleFonts.inter(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: black,
                                            ),
                                          ),
                                          Text(
                                            updateBookingStatusModel
                                                .data!
                                                .bookingsFleet[0]
                                                .bookingsDestinations
                                                .receiverPhone,
                                            style: GoogleFonts.inter(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: black,
                                            ),
                                          )
                                        ],
                                      ),
                                      updateBookingStatusModel
                                                  .data!.scheduled ==
                                              "Yes"
                                          ? SizedBox(
                                              height: 5.h,
                                            )
                                          : SizedBox(
                                              height: 20.h,
                                            ),
                                      updateBookingStatusModel
                                                  .data!.scheduled ==
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
                                                          TextAlign.start,
                                                      style: GoogleFonts.syne(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: grey,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Schedule Delivery Time',
                                                      style: GoogleFonts.syne(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
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
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      '${updateBookingStatusModel.data!.deliveryDate}',
                                                      style: GoogleFonts.inter(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: black,
                                                      ),
                                                    ),
                                                    Text(
                                                      DateFormat('h:mm a')
                                                          .format(
                                                        DateFormat('HH:mm:ss').parse(
                                                            updateBookingStatusModel
                                                                .data!
                                                                .deliveryTime!),
                                                      ),
                                                      style: GoogleFonts.inter(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
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
                                          SvgPicture.asset(
                                              'assets/images/location.svg'),
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
                                            padding:
                                                EdgeInsets.only(left: 8.0.w),
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
                                              updateBookingStatusModel
                                                  .data!
                                                  .bookingsFleet[0]
                                                  .bookingsDestinations
                                                  .pickupAddress,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                  updateBookingStatusModel
                                                      .data!
                                                      .bookingsFleet[0]
                                                      .bookingsDestinations
                                                      .destinAddress,
                                                  minFontSize: 12,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                                    colorFilter:
                                                        const ColorFilter.mode(
                                                            black,
                                                            BlendMode.srcIn),
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.004),
                                                  Text(
                                                    updateBookingStatusModel
                                                        .data!
                                                        .bookingsFleet[0]
                                                        .bookingsDestinations
                                                        .destinTime,
                                                    style: GoogleFonts.inter(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: black,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Estimate Time',
                                                    style: GoogleFonts.syne(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
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
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.007),
                                                  Text(
                                                    '${updateBookingStatusModel.data!.bookingsFleet[0].bookingsDestinations.destinDistance} $distance',
                                                    style: GoogleFonts.inter(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: black,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Total Distance',
                                                    style: GoogleFonts.syne(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
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
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: black,
                                                    ),
                                                  ),
                                                  Text(
                                                    updateBookingStatusModel
                                                        .data!.totalCharges,
                                                    // '$currency ${widget.bookingDestinationsList![i].destin_discounted_charges!}',
                                                    style: GoogleFonts.inter(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: black,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Fare',
                                                    style: GoogleFonts.syne(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
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
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.44,
                                        child: isLoading
                                            ? spinKitRotatingCircle
                                            : PageView.builder(
                                                onPageChanged: (index) async {
                                                  setState(() {
                                                    currentIndex =
                                                        index; // Update currentIndex when page changes
                                                  });
                                                },
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount:
                                                    updateBookingStatusModel
                                                        .data!
                                                        .bookingsFleet
                                                        .length,
                                                controller: pageController,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  final itemList =
                                                      updateBookingStatusModel
                                                          .data!
                                                          .bookingsFleet[index];
                                                  final bookingModels =
                                                      updateBookingStatusModel
                                                          .data;
                                                  return Container(
                                                    color: Colors.transparent,
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.86,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.38,
                                                    child: isLoading
                                                        ? spinKitRotatingCircle
                                                        : Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
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
                                                                    'Receiver Contact',
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
                                                                height: 3.h,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    itemList
                                                                        .bookingsDestinations
                                                                        .receiverName,
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
                                                                    itemList
                                                                        .bookingsDestinations
                                                                        .receiverPhone,
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
                                                              bookingModels!
                                                                          .scheduled ==
                                                                      "Yes"
                                                                  ? SizedBox(
                                                                      height:
                                                                          5.h,
                                                                    )
                                                                  : SizedBox(
                                                                      height:
                                                                          20.h,
                                                                    ),
                                                              bookingModels
                                                                          .scheduled ==
                                                                      "Yes"
                                                                  ? Column(
                                                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        SizedBox(
                                                                          height:
                                                                              10.h,
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
                                                                          height:
                                                                              5.h,
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Text(
                                                                              '${bookingModels.deliveryDate}',
                                                                              style: GoogleFonts.inter(
                                                                                fontSize: 14,
                                                                                fontWeight: FontWeight.w500,
                                                                                color: black,
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              DateFormat('h:mm a').format(DateFormat('HH:mm:ss').parse(bookingModels.deliveryTime)),
                                                                              style: GoogleFonts.inter(
                                                                                fontSize: 14,
                                                                                fontWeight: FontWeight.w500,
                                                                                color: black,
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              15.h,
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
                                                                  )
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left: 8.0
                                                                            .w),
                                                                    child: SvgPicture
                                                                        .asset(
                                                                      'assets/images/dotted-line.svg',
                                                                      fit: BoxFit
                                                                          .scaleDown,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 25.w,
                                                                  ),
                                                                  SizedBox(
                                                                    width:
                                                                        250.w,
                                                                    child:
                                                                        AutoSizeText(
                                                                      itemList
                                                                          .bookingsDestinations
                                                                          .pickupAddress,
                                                                      maxLines:
                                                                          3,
                                                                      minFontSize:
                                                                          12,
                                                                      style: GoogleFonts
                                                                          .inter(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        color:
                                                                            black,
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
                                                                  SvgPicture
                                                                      .asset(
                                                                    'assets/images/pointer.svg',
                                                                    colorFilter: const ColorFilter
                                                                        .mode(
                                                                        orange,
                                                                        BlendMode
                                                                            .srcIn),
                                                                    width: 24.w,
                                                                    height:
                                                                        24.h,
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
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                          color:
                                                                              grey,
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            10.h,
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            270.w,
                                                                        child:
                                                                            AutoSizeText(
                                                                          itemList
                                                                              .bookingsDestinations
                                                                              .destinAddress,
                                                                          minFontSize:
                                                                              12,
                                                                          maxLines:
                                                                              2,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style:
                                                                              GoogleFonts.inter(
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            color:
                                                                                black,
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
                                                              Expanded(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          SizedBox(
                                                                        width:
                                                                            40.w,
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            SvgPicture.asset(
                                                                              'assets/images/timer-icon.svg',
                                                                              colorFilter: const ColorFilter.mode(black, BlendMode.srcIn),
                                                                            ),
                                                                            SizedBox(height: MediaQuery.of(context).size.height * 0.004),
                                                                            Text(
                                                                              itemList.bookingsDestinations.destinTime,
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
                                                                      child:
                                                                          SizedBox(
                                                                        width:
                                                                            40.w,
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            SvgPicture.asset('assets/images/meter-icon.svg'),
                                                                            SizedBox(height: MediaQuery.of(context).size.height * 0.007),
                                                                            Text(
                                                                              '${itemList.bookingsDestinations.destinDistance} $distance',
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
                                                                      child:
                                                                          SizedBox(
                                                                        width:
                                                                            85.w,
                                                                        child:
                                                                            Column(
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
                                                                              bookingModels.totalCharges,
                                                                              // '$currency ${widget.bookingDestinationsList![i].destin_discounted_charges!}',
                                                                              style: GoogleFonts.inter(
                                                                                fontSize: 10,
                                                                                fontWeight: FontWeight.w700,
                                                                                color: black,
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              child: Text(
                                                                                'Fare',
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
                                                                  ],
                                                                ),
                                                              ),
                                                              isParcelPicked
                                                                  ? SizedBox(
                                                                      // width: 10.w,
                                                                      height:
                                                                          14.h,
                                                                      child:
                                                                          const SpinKitThreeInOut(
                                                                        size:
                                                                            10,
                                                                        color:
                                                                            orange,
                                                                      ),
                                                                    )
                                                                  : Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              setState(() {
                                                                                // packageStatus =
                                                                                //     !packageStatus;
                                                                                statusID;
                                                                              });
                                                                              bookingsDestinationsId = itemList.bookingsDestinations.bookingsDestinationsId.toString();
                                                                              print('object id of picked parcel: $bookingsDestinationsId');
                                                                              parcelPickedMethod(context, bookingsDestinationsId!);

                                                                              print('object id of picked parcel: ${statusID.toString()}');
                                                                            },
                                                                            child: pickedParcelIds!.contains(itemList.bookingsDestinations.bookingsDestinationsId.toString())
                                                                                ? SvgPicture.asset('assets/images/tick-orange.svg')
                                                                                : SvgPicture.asset('assets/images/tick-grey.svg'),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                15.w,
                                                                          ),
                                                                          pickedParcelIds!.contains(itemList.bookingsDestinations.bookingsDestinationsId.toString())
                                                                              ? Text(
                                                                                  name!,
                                                                                  style: GoogleFonts.syne(
                                                                                    fontSize: 16,
                                                                                    fontWeight: FontWeight.w500,
                                                                                    color: black,
                                                                                  ),
                                                                                )
                                                                              : Text(
                                                                                  'Pick Parcel',
                                                                                  style: GoogleFonts.syne(
                                                                                    fontSize: 16,
                                                                                    fontWeight: FontWeight.w500,
                                                                                    color: black,
                                                                                  ),
                                                                                ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                            ],
                                                          ),
                                                  );
                                                }),
                                      ),
                                    ],
                                  ),
                            updateBookingStatusModel.data!.deliveryType ==
                                    'Single'
                                ? SizedBox(height: 5.h)
                                : SizedBox(height: 15.h),
                            updateBookingStatusModel.data!.deliveryType ==
                                    'Single'
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
                                                  updateBookingStatusModel
                                                      .data!
                                                      .bookingsFleet[0]
                                                      .bookingsDestinations
                                                      .bookingsDestinationsId
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
                            SizedBox(
                              height: 5.h,
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
                                    child: updateBookingStatusModel
                                                    .data!.paymentStatus ==
                                                "Paid" ||
                                            updateBookingStatusModel
                                                    .data!.paymentBy ==
                                                "Receiver"
                                        ? Container(
                                            width: 170.w,
                                            height: 51.h,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                          )
                                        : GestureDetector(
                                            onTap: () {
                                              init();
                                            },
                                            child: Container(
                                              width: 170.w,
                                              height: 51.h,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
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
                                                  'Refresh',
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.syne(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )),
                            SizedBox(
                              height: 25.h,
                            ),
                            updateBookingStatusModel.data!.deliveryType ==
                                    'Single'
                                ? SizedBox(
                                    height: 15.h,
                                  )
                                : const SizedBox(),
                            updateBookingStatusModel.data!.deliveryType ==
                                    'Single'
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(left: 35),
                                    child: Center(
                                      child: Container(
                                        color: Colors.transparent,
                                        height: 12.h,
                                        width: 100.w,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 7),
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              controller:
                                                  nextPageScrollController,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount:
                                                  updateBookingStatusModel.data!
                                                      .bookingsFleet.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                final itemList =
                                                    updateBookingStatusModel
                                                        .data!
                                                        .bookingsFleet[index];
                                                final bookingModels =
                                                    updateBookingStatusModel
                                                        .data;
                                                return GestureDetector(
                                                  onTap: () {
                                                    pageController.animateToPage(
                                                        index,
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    500),
                                                        curve: Curves.ease);
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(width: 3.w),
                                                      Container(
                                                        width: 10,
                                                        height: 10,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: currentIndex ==
                                                                  index
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
                                    ),
                                  ),
                          ],
                        ),
                ),
        );
      }
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
      "other_users_id": updateBookingStatusModel
          .data!.usersCustomers.usersCustomersId
          .toString(),
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
            phone: updateBookingStatusModel.data!.usersCustomers.phone,
            riderID: widget.userID.toString(),
            image: updateBookingStatusModel.data!.usersCustomers.profilePic,
            name:
                "${updateBookingStatusModel.data!.usersCustomers.firstName} ${updateBookingStatusModel.data!.usersCustomers.lastName}",
            address: updateBookingStatusModel
                .data!.bookingsFleet[0].bookingsDestinations.pickupAddress,
            clientID: updateBookingStatusModel
                .data!.usersCustomers.usersCustomersId
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
            phone: updateBookingStatusModel.data!.usersCustomers.phone,
            riderID: widget.userID.toString(),
            image: updateBookingStatusModel.data!.usersCustomers.profilePic,
            name:
                "${updateBookingStatusModel.data!.usersCustomers.firstName} ${updateBookingStatusModel.data!.usersCustomers.lastName}",
            address: updateBookingStatusModel
                .data!.bookingsFleet[0].bookingsDestinations.pickupAddress,
            clientID: updateBookingStatusModel
                .data!.usersCustomers.usersCustomersId
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
    DateTime deliveryDate =
        DateTime.parse(updateBookingStatusModel.data!.deliveryDate);
    TimeOfDay deliveryTime = TimeOfDay.fromDateTime(DateFormat('HH:mm:ss')
        .parse(updateBookingStatusModel.data!.deliveryTime));

    DateTime deliveryDateTime = DateTime(
      deliveryDate.year,
      deliveryDate.month,
      deliveryDate.day,
      deliveryTime.hour,
      deliveryTime.minute,
    );

    DateTime currentDateTime = DateTime.now();

    print("currentDateTime: $currentDateTime");
    print("deliveryTime: $deliveryTime");

    if (currentDateTime.isBefore(deliveryDateTime)) {
      showToastError(
          'Your scheduled ride is not started yet', FToast().init(context),
          seconds: 2);
    } else if (pickedParcelIds!.length !=
        updateBookingStatusModel.data!.bookingsFleet.length) {
      showToastError(
          'You\'ve to pick all the parcel from pickup location first.',
          FToast().init(context),
          seconds: 2);
    } else {
      setState(() {
        isRideStarting = true;
      });

      Map startRideData = {
        "bookings_id": updateBookingStatusModel.data!.bookingsId.toString(),
        "bookings_destinations_id": updateBookingStatusModel
            .data!.bookingsFleet[0].bookingsDestinations.bookingsDestinationsId
            .toString(),
        "bookings_destinations_status_id": startRideID.toString()
      };
      print('object start ride data: ${startRideData.toString()}');
      startRideResponse = await service.startRideRequest(startRideData);

      if (startRideResponse!.status!.toLowerCase() == "success") {
        if (startRideResponse!.data != null) {
          showToastSuccess('Ride has been started', FToast().init(context));
          Navigator.of(context).pop();
          // showModalBottomSheet(
          //   backgroundColor: white,
          //   isDismissible: false,
          //   isScrollControlled: true,
          //   shape: const RoundedRectangleBorder(
          //     borderRadius: BorderRadius.vertical(
          //       top: Radius.circular(20),
          //     ),
          //   ),
          //   context: context,
          //   builder: (context) => ModalBottomSheetEndRide(
          //     bookingModel: widget.bookingModel,
          //     userID: widget.userID,
          //     bookingDestinations: widget.bookingDestinations,
          //   ),
          // );
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
      "bookings_id": updateBookingStatusModel.data!.bookingsId.toString(),
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
