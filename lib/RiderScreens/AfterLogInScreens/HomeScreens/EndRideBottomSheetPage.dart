// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:deliver_partner/Constants/PageLoadingKits.dart';
import 'package:deliver_partner/RiderScreens/AfterLogInScreens/HomeScreens/EndRideDialog.dart';
import 'package:deliver_partner/RiderScreens/AfterLogInScreens/HomeScreens/endRidePage.dart';
import 'package:deliver_partner/models/API_models/API_response.dart';
import 'package:deliver_partner/models/API_models/ShowBookingsModel.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:deliver_partner/models/API_models/updateBookingTranscations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import '../../../Constants/Colors.dart';
import '../../../models/API_models/GetAllSystemDataModel.dart';
import '../../../models/API_models/getupdateBooking.dart';
import '../../../services/API_services.dart';
import '../../../utilities/showToast.dart';
import 'UserToUserChat/UserToUserChat.dart';

class EndRideBottomSheetPage extends StatefulWidget {
  final int? index;
  final String userID;
  final String? bookingID;
  final String? destinBookingId;

  const EndRideBottomSheetPage({
    super.key,
    this.index,
    required this.userID,
    this.bookingID,
    this.destinBookingId,
  });

  @override
  State<EndRideBottomSheetPage> createState() => _EndRideBottomSheetPageState();
}

class _EndRideBottomSheetPageState extends State<EndRideBottomSheetPage> {
  ApiServices get service => GetIt.I<ApiServices>();

  late APIResponse<List<GetAllSystemDataModel>> _getAllSystemDataResponse;
  List<GetAllSystemDataModel>? _getSystemDataList;

  String currency = '';
  String distance = '';

  bool isLoading = false;

  int currentIndex = 0;
  ScrollController nextPageScrollController = ScrollController();
  String? ride0;
  String? ride1;
  String? ride2;
  String? ride3;
  String? ride4;
  UpdateBookingStatusModel updateBookingStatusModel =
      UpdateBookingStatusModel();
  Map<String, dynamic>? jsonResponse;
  Future<void> updateBookingStatus() async {
    // try {
    String apiUrl = "https://deliverbygfl.com/api/get_updated_status_booking";
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
    final responseString = response.body;
    debugPrint("response: $responseString");
    debugPrint("statusCode: ${response.statusCode}");
    if (response.statusCode == 200) {
      updateBookingStatusModel =
          updateBookingStatusModelFromJson(responseString);
      debugPrint(
          'updateBookingStatusModel status: ${updateBookingStatusModel.status}');
      jsonResponse = jsonDecode(response.body);

      var bookingsFleet = jsonResponse!['data']['bookings_fleet'];

      ride0 = bookingsFleet.length > 0 ? bookingsFleet[0]['status'] ?? "" : "";
      ride1 = bookingsFleet.length > 1 ? bookingsFleet[1]['status'] ?? "" : "";
      ride2 = bookingsFleet.length > 2 ? bookingsFleet[2]['status'] ?? "" : "";
      ride3 = bookingsFleet.length > 3 ? bookingsFleet[3]['status'] ?? "" : "";
      ride4 = bookingsFleet.length > 4 ? bookingsFleet[4]['status'] ?? "" : "";
    }
    print(
        "destinTotalCharges: ${jsonResponse!["data"]['bookings_fleet'][0]['bookings_destinations']['destin_total_charges'].toString()}");
    print("destinBookingId: ${widget.destinBookingId}");
    print(jsonResponse!["data"]['bookings_fleet'][0]['bookings_destinations']
            ['destin_total_charges']
        .toString());
    setState(() {
      isLoading = false;
    });
    // } catch (e) {
    //   debugPrint('Something went wrong = ${e.toString()}');
    //   return;
    // }
  }

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

  init() async {
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
    await updateBookingStatus();
  }

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
          updateBookingStatusModel.data!.usersCustomersId.toString(),
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
            phone: updateBookingStatusModel.data!.usersCustomers?.phone,
            riderID: widget.userID.toString(),
            image: updateBookingStatusModel.data!.usersCustomers?.profilePic,
            name:
                "${updateBookingStatusModel.data!.usersCustomers?.firstName} ${updateBookingStatusModel.data!.usersCustomers?.lastName}",
            address: updateBookingStatusModel.data!.bookingsFleet?[widget.index!]
                .bookingsDestinations?.pickupAddress,
            clientID: updateBookingStatusModel
                .data!.usersCustomers!.usersCustomersId
                .toString(),
          ),
        ),
      );
    } else {
      print(
          ' error starting chat: ${startUserToUserChatResponse!.message!.toString()}');
      // showToastError('error occurred,try again', FToast().init(context),
      //     seconds: 2);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => UserToUserChat(
            phone: updateBookingStatusModel.data!.usersCustomers?.phone,
            riderID: widget.userID.toString(),
            image: updateBookingStatusModel.data!.usersCustomers?.profilePic,
            name:
                "${updateBookingStatusModel.data!.usersCustomers?.firstName} ${updateBookingStatusModel.data!.usersCustomers?.lastName}",
            address: updateBookingStatusModel
                .data!.bookingsFleet?[0].bookingsDestinations?.pickupAddress,
            clientID: updateBookingStatusModel
                .data!.usersCustomers!.usersCustomersId
                .toString(),
          ),
        ),
      );
    }
    setState(() {
      isChatStarting = false;
    });
  }

  UpdateBookingTransactionModel updateBookingTransactionModel =
      UpdateBookingTransactionModel();
  Future<void> updateBookingTransaction() async {
    try {
      String apiUrl = "https://deliverbygfl.com/maintain_booking_transaction";
      debugPrint("apiUrl: $apiUrl");
      Map data = {
        "bookings_id": widget.bookingID.toString(),
        // "payer_name":
        //     "${updateBookingStatusModel.data!.usersCustomers.firstName} ${updateBookingStatusModel.data!.usersCustomers.lastName}",
        // "payer_email": updateBookingStatusModel.data!.usersCustomers.email,
        "total_amount": updateBookingStatusModel.data!.totalCharges,
        "payment_status": "Paid",
        "bookings_destinations_id": "" // payment_by = 'Receiver'
      };
      print("$data");
      // debugPrint("bookings_id: ${widget.currentBookingId}");
      // debugPrint("payer_name: $firstName $lastName");
      // debugPrint("payer_email: $userEmail");
      // debugPrint(
      //     "total_amount: ${widget.singleData!.isNotEmpty ? widget.singleData!['total_charges'] : widget.multipleData!['total_charges']}");
      debugPrint("payment_status: Paid");
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Accept': 'application/json',
        },
        body: {
          "bookings_id": widget.bookingID.toString(),
          // "payer_name":
          //     "${updateBookingStatusModel.data!.usersCustomers.firstName} ${updateBookingStatusModel.data!.usersCustomers.lastName}",
          // "payer_email": updateBookingStatusModel.data!.usersCustomers.email,
          "total_amount": updateBookingStatusModel.data!.totalCharges,
          "payment_status": "Paid",
          "bookings_destinations_id": "" // payment_by = 'Receiver'
        },
      );
      final responseString = response.body;
      debugPrint("response: $responseString");
      debugPrint("statusCode: ${response.statusCode}");
      if (response.statusCode == 200) {
        updateBookingTransactionModel =
            updateBookingTransactionModelFromJson(responseString);
        debugPrint(
            'updateBookingTransactionModel status: ${updateBookingTransactionModel.status}');
      }
    } catch (e) {
      debugPrint('Something went wrong = ${e.toString()}');
      return;
    }
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
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: isLoading
            ? spinKitRotatingCircle
            : Column(
                children: [
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
                                'https://deliverbygfl.com/public/${updateBookingStatusModel.data!.usersCustomers?.profilePic}',
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
                                  "${updateBookingStatusModel.data!.usersCustomers?.firstName} ${updateBookingStatusModel.data!.usersCustomers?.lastName}",
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
                              updateBookingStatusModel.data!.scheduled == "Yes"
                                  ? Text(
                                      '${updateBookingStatusModel.data!.bookingsTypes?.name} \n(Scheduled Ride)',
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: grey,
                                      ),
                                    )
                                  : Text(
                                      updateBookingStatusModel
                                          .data!.bookingsTypes!.name.toString(),
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
                          Column(
                            children: [
                              SizedBox(
                                width: 36.w,
                                height: 36.h,
                                child: SvgPicture.asset(
                                  'assets/images/dt.svg',
                                  fit: BoxFit.scaleDown,
                                  color: orangeColor,
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                updateBookingStatusModel.data!.deliveryType.toString(),
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
                              _makePhoneCall(updateBookingStatusModel
                                  .data!.usersCustomers!.phone.toString());
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
                  updateBookingStatusModel.data!.deliveryType == 'Single'
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
                                  '${jsonResponse!['data']['bookings_fleet'][0]['bookings_destinations']['receiver_name']}',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: black,
                                  ),
                                ),
                                Text(
                                  '${jsonResponse!['data']['bookings_fleet'][0]['bookings_destinations']['receiver_phone']}',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: black,
                                  ),
                                )
                              ],
                            ),
                            updateBookingStatusModel.data!.scheduled == "Yes"
                                ? SizedBox(
                                    height: 5.h,
                                  )
                                : SizedBox(
                                    height: 20.h,
                                  ),
                            updateBookingStatusModel.data!.scheduled == "Yes"
                                ? Column(
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
                                            '${updateBookingStatusModel.data!.dateAdded}',
                                            style: GoogleFonts.inter(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: black,
                                            ),
                                          ),
                                          Text(
                                            DateFormat('h:mm a').format(
                                                DateTime.parse(
                                                    updateBookingStatusModel
                                                        .data!.dateAdded
                                                        .toString())),
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
                                    jsonResponse!['data']['bookings_fleet'][0]
                                            ['bookings_destinations']
                                        ['pickup_address'],
                                    maxLines: 3,
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
                                        jsonResponse!['data']['bookings_fleet']
                                                [0]['bookings_destinations']
                                            ['destin_address'],
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
                                          jsonResponse!['data']
                                                      ['bookings_fleet'][0]
                                                  ['bookings_destinations']
                                              ['destin_time'],
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
                                          '${jsonResponse!['data']['bookings_fleet'][0]['bookings_destinations']['destin_distance']} $distance',
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
                                          '${jsonResponse!['data']['bookings_fleet'][0]['bookings_destinations']['total_charges'] ?? jsonResponse!['data']['total_charges']}',
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
                              height: 20.h,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EndRidePAge(
                                        deliveryType: updateBookingStatusModel
                                            .data!.deliveryType,
                                        bookingModel: updateBookingStatusModel
                                            .data!.bookingsId
                                            .toString(),
                                        bookingDestinations: jsonResponse!["data"]
                                                    ['bookings_fleet'][0]
                                                ['bookings_destinations_id']
                                            .toString(),
                                        bookingDestinationsList:
                                            jsonResponse!["data"]['status'],
                                        bookingDestinID: updateBookingStatusModel
                                            .data!
                                            .bookingsFleet?[0]
                                            .bookingsDestinationsId
                                            .toString(),
                                        destinTotalCharges:
                                            jsonResponse!["data"]['bookings_fleet'][0]['bookings_destinations']['destin_total_charges'].toString()),
                                  ),
                                );
                                // startRide(context);
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
                                    'End RIDE',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.syne(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: white,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      : Column(
                          children: [
                            Container(
                              color: Colors.transparent,
                              padding: const EdgeInsets.only(right: 10),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.52,
                              child: isLoading
                                  ? spinKitRotatingCircle
                                  : PageView.builder(
                                      onPageChanged: (index) async {
                                        await updateBookingStatus();
                                        setState(() {
                                          currentIndex =
                                              index; // Update currentIndex when page changes
                                        });
                                      },
                                      scrollDirection: Axis.horizontal,
                                      controller: pageController,
                                      itemCount: updateBookingStatusModel
                                          .data!.bookingsFleet?.length,
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
                                              0.325,
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
                                                          '${jsonResponse!["data"]['bookings_fleet'][index]['bookings_destinations']['receiver_name']}',
                                                          style:
                                                              GoogleFonts.inter(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: black,
                                                          ),
                                                        ),
                                                        Text(
                                                          '${jsonResponse!["data"]['bookings_fleet'][index]['bookings_destinations']['receiver_phone']}',
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
                                                    updateBookingStatusModel
                                                                .data!
                                                                .scheduled ==
                                                            "Yes"
                                                        ? SizedBox(
                                                            height: 5.h,
                                                          )
                                                        : SizedBox(
                                                            height: 20.h,
                                                          ),
                                                    updateBookingStatusModel
                                                                .data!
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
                                                                    '${updateBookingStatusModel.data!.dateAdded}',
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
                                                                      DateFormat(
                                                                              'HH:mm:ss')
                                                                          .parse(
                                                                        updateBookingStatusModel
                                                                            .data!
                                                                            .dateAdded
                                                                            .toString()
                                                                            .substring(11,
                                                                                19),
                                                                      ),
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
                                                            jsonResponse!["data"]
                                                                            [
                                                                            'bookings_fleet']
                                                                        [index][
                                                                    'bookings_destinations']
                                                                [
                                                                'pickup_address'],
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
                                                                jsonResponse!["data"]['bookings_fleet']
                                                                            [
                                                                            index]
                                                                        [
                                                                        'bookings_destinations']
                                                                    [
                                                                    'destin_address'],
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
                                                                    jsonResponse!["data"]['bookings_fleet'][index]
                                                                            [
                                                                            'bookings_destinations']
                                                                        [
                                                                        'destin_time']!,
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
                                                                    '${jsonResponse!["data"]['bookings_fleet'][index]['bookings_destinations']['destin_distance']!} $distance',
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
                                                                    updateBookingStatusModel
                                                                        .data!
                                                                        .totalCharges.toString(),
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
                                                    Center(
                                                      child: (currentIndex ==
                                                                      0 &&
                                                                  ride0 ==
                                                                      "Completed") ||
                                                              (currentIndex ==
                                                                      1 &&
                                                                  ride1 ==
                                                                      "Completed") ||
                                                              (currentIndex ==
                                                                      2 &&
                                                                  ride2 ==
                                                                      "Completed") ||
                                                              (currentIndex ==
                                                                      3 &&
                                                                  ride3 ==
                                                                      "Completed") ||
                                                              (currentIndex ==
                                                                      4 &&
                                                                  ride4 ==
                                                                      "Completed")
                                                          ? const SizedBox
                                                              .shrink() // Don't show the button if the condition is true
                                                          : GestureDetector(
                                                              onTap: () async {
                                                                print(
                                                                    "Helllooo");
                                                                await updateBookingStatus();
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            EndRidePAge(
                                                                      bookingDestinID: updateBookingStatusModel
                                                                          .data!
                                                                          .bookingsFleet?[
                                                                              index]
                                                                          .bookingsDestinationsId
                                                                          .toString(),
                                                                      deliveryType: updateBookingStatusModel
                                                                          .data!
                                                                          .deliveryType,
                                                                      bookingModel: updateBookingStatusModel
                                                                          .data!
                                                                          .bookingsId
                                                                          .toString(),
                                                                      bookingDestinations:
                                                                          jsonResponse!["data"]['bookings_fleet'][index]['bookings_destinations_id']
                                                                              .toString(),
                                                                      bookingDestinationsList:
                                                                          jsonResponse!["data"]['bookings_fleet'][0]['bookings_destinations']['bookings_destinations_status_id']
                                                                              .toString(),
                                                                      destinTotalCharges:
                                                                          jsonResponse!["data"]['bookings_fleet'][index]['bookings_destinations']['destin_total_charges']
                                                                              .toString(),
                                                                    ),
                                                                  ),
                                                                );
                                                                // startRide(context);
                                                              },
                                                              child: Container(
                                                                width: 170.w,
                                                                height: 51.h,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  gradient:
                                                                      const LinearGradient(
                                                                    colors: [
                                                                      Color(
                                                                          0xffFF6302),
                                                                      Color(
                                                                          0xffFBC403),
                                                                    ],
                                                                    begin: Alignment
                                                                        .centerRight,
                                                                    end: Alignment
                                                                        .centerLeft,
                                                                  ),
                                                                ),
                                                                child: Center(
                                                                  child: Text(
                                                                    'End RIDE',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style:
                                                                        GoogleFonts
                                                                            .syne(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color:
                                                                          white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                  ],
                                                ),
                                        );
                                      }),
                            ),
                            SizedBox(height: 10.h),
                            updateBookingStatusModel.data!.deliveryType ==
                                    'Single'
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
                                        itemCount: updateBookingStatusModel
                                            .data!.bookingsFleet?.length,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return GestureDetector(
                                            onTap: () {
                                              pageController.animateToPage(
                                                  index,
                                                  duration: const Duration(
                                                      milliseconds: 500),
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
                                                        : grey,
                                                  ),
                                                ),
                                                SizedBox(width: 3.w)
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                  updateBookingStatusModel.data!.deliveryType == 'Single'
                      ? SizedBox(
                          height: 25.h,
                        )
                      : SizedBox(
                          height: 10.h,
                        ),
                  // Padding(
                  //   padding: EdgeInsets.only(top: 22.h),
                  //   child: isRideStarting
                  //       ? Padding(
                  //     padding: EdgeInsets.only(left: 35.0),
                  //     child: SpinKitDoubleBounce(
                  //       color: orange,
                  //       size: 50.0,
                  //     ),
                  //   )
                  //       :
                  // widget.bookingModel.delivery_type == 'Single'
                  //     ?
                  //     : const SizedBox(),
                ],
              ),
      ),
    );
  }

  PageController pageController = PageController();
}
