import 'package:deliver_partner/models/API_models/getbookingDestinationStatus.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:deliver_partner/Constants/Colors.dart';
import 'package:deliver_partner/utilities/showToast.dart';
import 'package:deliver_partner/services/API_services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:deliver_partner/Constants/PageLoadingKits.dart';
import 'package:deliver_partner/Constants/buttonContainer.dart';
import 'package:deliver_partner/RiderScreens/BottomNavBar.dart';
import 'package:deliver_partner/models/API_models/API_response.dart';
import 'package:deliver_partner/models/API_models/ShowBookingsModel.dart';
import 'package:deliver_partner/models/API_models/GetBookingDestinationsStatus.dart';
import 'package:http/http.dart' as http;

import '../../../models/API_models/InProgressRidesModel.dart';

List<String> endRideIds = [];

class InProgressEndRidePage extends StatefulWidget {
  final InProgressRidesModel? inProgressRidesList;
  final List<InProgressRidesModel>? inProgressRidesList2;

  const InProgressEndRidePage(
      {super.key, this.inProgressRidesList, this.inProgressRidesList2});

  @override
  State<InProgressEndRidePage> createState() => _InProgressEndRidePageState();
}

class _InProgressEndRidePageState extends State<InProgressEndRidePage> {
  String cancelled = '';
  String delivered = '';
  String lost = '';
  String returned = '';
  String damaged = '';

  int cancelledID = -1;
  int deliveredID = -1;
  int lostID = -1;
  int damagedID = -1;
  int returnedID = -1;

  int radioButton = -1;

  ApiServices get service => GetIt.I<ApiServices>();

  late APIResponse<List<GetBookingDestinationsStatus>>
      getBookingDestinationsStatusResponse;
  List<GetBookingDestinationsStatus>? getBookingDestinationsStatusList;

  bool isLoading = false;
  GetBookingDestinationStatus getBookingDestinationStatus =
      GetBookingDestinationStatus();
  getDestinationStatus() async {
    var headersList = {
      'Accept': '*/*',
    };
    var url = Uri.parse(
        'https://cs.deliverbygfl.com/api/get_bookings_destinations_status');

    var req = http.Request('GET', url);
    req.headers.addAll(headersList);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode == 200) {
      getBookingDestinationStatus =
          getBookingDestinationStatusFromJson(resBody);
      print("getBookingDestinationStatus: ${getBookingDestinationStatus.data}");
      print(resBody);
      setState(() {});
    } else {
      print(res.reasonPhrase);
    }
  }

  String? endId;
  List<String> reasonType = [];
  TextEditingController passCodeController = TextEditingController();

  // init() async {
  //   radioButton = -1;

  //   getBookingDestinationsStatusResponse =
  //       await service.getBookingDestinationsStatusAPI();
  //   getBookingDestinationsStatusList = [];

  //   if (getBookingDestinationsStatusResponse.status!.toLowerCase() ==
  //       'success') {
  //     if (getBookingDestinationsStatusResponse.data != null) {
  //       getBookingDestinationsStatusList!
  //           .addAll(getBookingDestinationsStatusResponse.data!);
  //       for (GetBookingDestinationsStatus model
  //           in getBookingDestinationsStatusList!) {
  //         if (model.name == 'Parcel Delivered') {
  //           setState(() {
  //             delivered = model.name!;
  //             deliveredID = model.bookings_destinations_status_id!;
  //           });
  //         } else if (model.name == "Parcel Lost") {
  //           setState(() {
  //             lost = model.name!;
  //             lostID = model.bookings_destinations_status_id!;
  //           });
  //         } else if (model.name == "Parcel Damaged") {
  //           setState(() {
  //             damaged = model.name!;
  //             damagedID = model.bookings_destinations_status_id!;
  //           });
  //         } else if (model.name == "Parcel Returned") {
  //           setState(() {
  //             returned = model.name!;
  //             returnedID = model.bookings_destinations_status_id!;
  //           });
  //         } else if (model.name == "Delivery Cancelled") {
  //           cancelled = model.name!;
  //           cancelledID = model.bookings_destinations_status_id!;
  //         }
  //       }
  //     }
  //   }

  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // init();
    getDestinationStatus();
    // setState(() {
    //   isLoading = true;
    // });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        // title: Text(
        //   'End Ride',
        //   style: TextStyle(
        //     color: blackColor,
        //     fontSize: 20,
        //     fontFamily: 'Inter-Regular',
        //   ),
        // ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            "assets/images/close-circle.svg",
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          Text(
            'Ending Ride',
            style: GoogleFonts.syne(
              fontSize: 20,
              color: orange,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            'Select the reason why are \nyou ending this ride',
            textAlign: TextAlign.center,
            style: GoogleFonts.syne(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: grey,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              children: [
                Expanded(
                  child: getBookingDestinationStatus.data == null
                      ? const Center(
                          child: CircularProgressIndicator(
                          color: Colors.orange,
                          strokeWidth: 2,
                        )) // Show progress indicator if data is not fetched
                      : DropdownButtonFormField<String>(
                          value: endId,
                          onChanged: (newValue) {
                            setState(() {
                              endId = newValue;
                              print("endId: $endId");
                            });
                          },
                          items:
                              getBookingDestinationStatus.data!.map((status) {
                                    return DropdownMenuItem<String>(
                                      value: status.bookingsDestinationsStatusId
                                          .toString(),
                                      child: Text(status.name ?? ''),
                                    );
                                  }).toList() ??
                                  [],
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: filledColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: redColor, width: 1),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            hintText: 'Please Select Answers',
                            hintStyle: TextStyle(
                                color: hintColor,
                                fontSize: 12,
                                fontFamily: 'Inter-Light'),
                            errorStyle: TextStyle(
                                color: redColor,
                                fontSize: 10,
                                fontFamily: 'Inter-Bold'),
                          ),
                        ),
                ),
                const SizedBox(width: 5),
              ],
            ),
          ),

          // Padding(
          //   padding: const EdgeInsets.only(left: 15, right: 15),
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: ButtonTheme(
          //           alignedDropdown: true,
          //           child: DropdownButtonHideUnderline(
          //             child: DropdownButtonFormField<String>(
          //               value: endId,
          //               onChanged: (newValue) {
          //                 setState(() {
          //                   endId = newValue;
          //                   print("endId: $endId");
          //                 });
          //               },
          //               items: getBookingDestinationStatus.data?.map((bookid) {
          //                     return DropdownMenuItem<String>(
          //                       value: bookid.bookingsDestinationsStatusId
          //                           .toString(),
          //                       child: Text(bookid.name ?? ''),
          //                     );
          //                   }).toList() ??
          //                   [],
          //               style: TextStyle(
          //                 color: blackColor,
          //                 fontSize: 14,
          //                 fontFamily: 'Inter-Regular',
          //                 // fontWeight: FontWeight.w900,
          //               ),
          //               borderRadius: BorderRadius.circular(10),
          //               decoration: InputDecoration(
          //                 filled: true,
          //                 fillColor: filledColor,
          //                 border: const OutlineInputBorder(
          //                   borderRadius: BorderRadius.all(
          //                     Radius.circular(10),
          //                   ),
          //                   borderSide: BorderSide.none,
          //                 ),
          //                 enabledBorder: const OutlineInputBorder(
          //                   borderRadius: BorderRadius.all(
          //                     Radius.circular(10),
          //                   ),
          //                   borderSide: BorderSide.none,
          //                 ),
          //                 focusedBorder: const OutlineInputBorder(
          //                   borderRadius: BorderRadius.all(
          //                     Radius.circular(10),
          //                   ),
          //                   borderSide: BorderSide.none,
          //                 ),
          //                 errorBorder: OutlineInputBorder(
          //                   borderRadius: const BorderRadius.all(
          //                     Radius.circular(10),
          //                   ),
          //                   borderSide: BorderSide(
          //                     color: redColor,
          //                     width: 1,
          //                   ),
          //                 ),
          //                 contentPadding: const EdgeInsets.symmetric(
          //                     horizontal: 20, vertical: 10),
          //                 hintText: 'Select Reason',
          //                 hintStyle: TextStyle(
          //                   color: hintColor,
          //                   fontSize: 12,
          //                   fontFamily: 'Inter-Light',
          //                 ),
          //                 errorStyle: TextStyle(
          //                   color: redColor,
          //                   fontSize: 10,
          //                   fontFamily: 'Inter-Bold',
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //       const SizedBox(
          //         width: 5,
          //       ),
          //     ],
          //   ),
          // ),

          // Expanded(
          //   child: ButtonTheme(
          //     alignedDropdown: true,
          //     child: DropdownButtonHideUnderline(
          //       child: DropdownButtonFormField(
          //         // icon: Padding(
          //         //   padding: const EdgeInsets.only(top: 3),
          //         //   child: SvgPicture.asset(
          //         //     'assets/images/dropdown-icon.svg',
          //         //     width: 5,
          //         //     height: 5,
          //         //     fit: BoxFit.scaleDown,
          //         //   ),
          //         // ),
          //         decoration: InputDecoration(
          //           filled: true,
          //           fillColor: filledColor,
          //           border: const OutlineInputBorder(
          //             borderRadius: BorderRadius.all(
          //               Radius.circular(10),
          //             ),
          //             borderSide: BorderSide.none,
          //           ),
          //           enabledBorder: const OutlineInputBorder(
          //             borderRadius: BorderRadius.all(
          //               Radius.circular(10),
          //             ),
          //             borderSide: BorderSide.none,
          //           ),
          //           focusedBorder: const OutlineInputBorder(
          //             borderRadius: BorderRadius.all(
          //               Radius.circular(10),
          //             ),
          //             borderSide: BorderSide.none,
          //           ),
          //           errorBorder: OutlineInputBorder(
          //             borderRadius: const BorderRadius.all(
          //               Radius.circular(10),
          //             ),
          //             borderSide: BorderSide(
          //               color: redColor,
          //               width: 1,
          //             ),
          //           ),
          //           contentPadding: const EdgeInsets.symmetric(
          //               horizontal: 20, vertical: 10),
          //           hintText: 'Select Reason',
          //           hintStyle: TextStyle(
          //             color: hintColor,
          //             fontSize: 12,
          //             fontFamily: 'Inter-Light',
          //           ),
          //           errorStyle: TextStyle(
          //             color: redColor,
          //             fontSize: 10,
          //             fontFamily: 'Inter-Bold',
          //           ),
          //         ),
          //         padding: const EdgeInsets.only(right: 5),
          //         borderRadius: BorderRadius.circular(10),
          //         items: reasonType
          //             .map(
          //               (item) => DropdownMenuItem<String>(
          //                 value: item,
          //                 child: Text(
          //                   item,
          //                   style: TextStyle(
          // color: blackColor,
          // fontSize: 14,
          // fontFamily: 'Inter-Regular',
          //                   ),
          //                 ),
          //               ),
          //             )
          //             .toList(),
          //         value: endId,
          //         onChanged: (value) {
          //           setState(() {
          //             endId = value;
          //             debugPrint("endId: $value");
          //             if (getBookingDestinationStatus.data != null) {
          //               for (int i = 0;
          //                   i < getBookingDestinationStatus.data!.length;
          //                   i++) {
          //                 if (getBookingDestinationStatus.data?[i].name ==
          //                     value) {
          //                   endId = getBookingDestinationStatus
          //                       .data?[i].bookingsDestinationsStatusId
          //                       .toString();
          //                   debugPrint(
          //                       'endId: ${getBookingDestinationStatus.data?[i].bookingsDestinationsStatusId.toString()}');
          //                 }
          //               }
          //             }
          //           });
          //         },
          //       ),
          //     ),
          //   ),
          // ),
          // isLoading
          //     ? SizedBox(height: 200.h, child: spinKitRotatingCircle)
          //     : SizedBox(
          //         height: 200.h,
          //         width: 270.w,
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           mainAxisAlignment: MainAxisAlignment.spaceAround,
          //           children: [
          //             GestureDetector(
          //               onTap: () {
          //                 setState(() {
          //                   radioButton = 1;
          //                   deliveredID;
          //                   debugPrint(
          //                       'object delivered: ${deliveredID.toString()}');
          //                 });
          //               },
          //               child: Row(
          //                 children: [
          //                   radioButton == 1
          //                       ? SvgPicture.asset(
          //                           'assets/images/select-radio.svg')
          //                       : SvgPicture.asset(
          //                           'assets/images/unselect-radio.svg'),
          //                   SizedBox(
          //                     width: 12.w,
          //                   ),
          //                   Text(
          //                     'Parcel has been delivered',
          //                     style: GoogleFonts.syne(
          //                       fontSize: 16,
          //                       color: black,
          //                       fontWeight: FontWeight.w400,
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //             GestureDetector(
          //               onTap: () {
          //                 setState(() {
          //                   radioButton = 2;
          //                   cancelledID;
          //                   debugPrint(
          //                       'object cancelled: ${cancelledID.toString()}');
          //                 });
          //               },
          //               child: Row(
          //                 children: [
          //                   radioButton == 2
          //                       ? SvgPicture.asset(
          //                           'assets/images/select-radio.svg')
          //                       : SvgPicture.asset(
          //                           'assets/images/unselect-radio.svg'),
          //                   SizedBox(
          //                     width: 12.w,
          //                   ),
          //                   Text(
          //                     'Delivery is cancelled by rider',
          //                     style: GoogleFonts.syne(
          //                       fontSize: 16,
          //                       color: black,
          //                       fontWeight: FontWeight.w400,
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //             GestureDetector(
          //               onTap: () {
          //                 setState(() {
          //                   radioButton = 3;
          //                   lostID;
          //                   debugPrint('object lost: ${lostID.toString()}');
          //                 });
          //               },
          //               child: Row(
          //                 children: [
          //                   radioButton == 3
          //                       ? SvgPicture.asset(
          //                           'assets/images/select-radio.svg')
          //                       : SvgPicture.asset(
          //                           'assets/images/unselect-radio.svg'),
          //                   SizedBox(
          //                     width: 12.w,
          //                   ),
          //                   Text(
          //                     'Parcel is lost by rider',
          //                     style: GoogleFonts.syne(
          //                       fontSize: 16,
          //                       color: black,
          //                       fontWeight: FontWeight.w400,
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //             GestureDetector(
          //               onTap: () {
          //                 setState(() {
          //                   radioButton = 4;
          //                   returnedID;
          //                   debugPrint(
          //                       'object returned: ${returnedID.toString()}');
          //                 });
          //               },
          //               child: Row(
          //                 children: [
          //                   radioButton == 4
          //                       ? SvgPicture.asset(
          //                           'assets/images/select-radio.svg')
          //                       : SvgPicture.asset(
          //                           'assets/images/unselect-radio.svg'),
          //                   SizedBox(
          //                     width: 12.w,
          //                   ),
          //                   Text(
          //                     'Parcel is returned by the rider',
          //                     style: GoogleFonts.syne(
          //                       fontSize: 16,
          //                       color: black,
          //                       fontWeight: FontWeight.w400,
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //             GestureDetector(
          //               onTap: () {
          //                 setState(() {
          //                   radioButton = 5;
          //                   damagedID;
          //                   debugPrint(
          //                       'object damaged: ${damagedID.toString()}');
          //                 });
          //               },
          //               child: Row(
          //                 children: [
          //                   radioButton == 5
          //                       ? SvgPicture.asset(
          //                           'assets/images/select-radio.svg')
          //                       : SvgPicture.asset(
          //                           'assets/images/unselect-radio.svg'),
          //                   SizedBox(
          //                     width: 12.w,
          //                   ),
          //                   Text(
          //                     'Parcel is damaged',
          //                     style: GoogleFonts.syne(
          //                       fontSize: 16,
          //                       color: black,
          //                       fontWeight: FontWeight.w400,
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          SizedBox(
            height: 20.h,
          ),
          endId == "4"
              ? Container(
                  color: transparentColor,
                  width: size.width * 0.80,
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    controller: passCodeController,
                    cursorColor: orangeColor,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'PassCode is required!';
                      }
                      return null;
                    },
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 14,
                      fontFamily: 'Inter-Regular',
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: filledColor,
                      errorStyle: TextStyle(
                        color: redColor,
                        fontSize: 10,
                        fontFamily: 'Inter-Bold',
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide.none,
                      ),
                      focusedErrorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide.none,
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide(
                          color: redColor,
                          width: 1,
                        ),
                      ),
                      // contentPadding: EdgeInsets.symmetric(
                      //   horizontal: screenWidth * 0.04,
                      //   vertical: screenHeight * 0.02,
                      // ),
                      hintText: "Pass Code",
                      hintStyle: TextStyle(
                        color: hintColor,
                        fontSize: 12,
                        fontFamily: 'Inter-Light',
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          SizedBox(
            height: 20.h,
          ),
          endId == null
              ? const SizedBox.shrink()
              : (isRideEnding
                  ? const Center(
                      child: SpinKitDoubleBounce(
                        color: orange,
                        size: 50.0,
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        endRideMethod(
                          context,
                        );
                      },
                      child: buttonContainer(context, 'End Ride'),
                    )),
        ],
      ),
    );
  }

  bool isRideEnding = false;
  APIResponse<ShowBookingsModel>? endRideResponse;

  endRideMethod(BuildContext context) async {
    setState(() {
      isRideEnding = true;
    });
    Map endRideData = {
      "bookings_id": widget.inProgressRidesList!.bookings_id.toString(),
      "bookings_destinations_id":
          widget.inProgressRidesList2![0].bookings_destinations_id.toString(),
      "bookings_destinations_status_id": endId.toString(),
      "passcode": passCodeController.text
    };
    debugPrint("end ride data: ${endRideData.toString()}");

    endRideResponse = await service.endRideRequest(endRideData);

    if (endRideResponse!.status!.toLowerCase() == "success") {
      if (endRideResponse!.data != null) {
        showToastSuccess('Parcel delivered successfully ', FToast().init(context));
        Navigator.of(context).pop();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const BottomNavBar(),
          ),
        );
      }
    } else {
      showToastError(endRideResponse!.message, FToast().init(context));
      debugPrint(
          'object error ending ride: ${endRideResponse!.status!.toString()}');
    }
    setState(() {
      isRideEnding = false;
    });
  }
}
