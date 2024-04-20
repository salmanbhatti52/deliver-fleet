// import 'package:get_it/get_it.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:deliver_partner/Constants/Colors.dart';
// import 'package:deliver_partner/utilities/showToast.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:deliver_partner/services/API_services.dart';
// import 'package:deliver_partner/Constants/PageLoadingKits.dart';
// import 'package:deliver_partner/Constants/buttonContainer.dart';
// import 'package:deliver_partner/RiderScreens/BottomNavBar.dart';
// import 'package:deliver_partner/models/API_models/API_response.dart';
// import 'package:deliver_partner/models/API_models/ShowBookingsModel.dart';
// import 'package:deliver_partner/models/API_models/InProgressRidesModel.dart';
// import 'package:deliver_partner/models/API_models/GetBookingDestinationsStatus.dart';

// class INProgressEndRideDialog extends StatefulWidget {
//   final InProgressRidesModel? inProgressRidesList;
//   final List<InProgressRidesModel>? inProgressRidesList2;

//   const INProgressEndRideDialog(
//       {super.key, this.inProgressRidesList, this.inProgressRidesList2});

//   @override
//   State<INProgressEndRideDialog> createState() =>
//       _INProgressEndRideDialogState();
// }

// class _INProgressEndRideDialogState extends State<INProgressEndRideDialog> {
//   String cancelled = '';
//   String delivered = '';
//   String lost = '';
//   String returned = '';
//   String damaged = '';

//   int cancelledID = -1;
//   int deliveredID = -1;
//   int lostID = -1;
//   int damagedID = -1;
//   int returnedID = -1;

//   int radioButton = -1;

//   ApiServices get service => GetIt.I<ApiServices>();

//   late APIResponse<List<GetBookingDestinationsStatus>>
//       getBookingDestinationsStatusResponse;
//   List<GetBookingDestinationsStatus>? getBookingDestinationsStatusList;

//   bool isLoading = false;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     print("Zainnnnnnnnnnnnnnnnnnn");
//     init();
//     setState(() {
//       isLoading = true;
//     });
//   }

//   init() async {
//     radioButton = -1;

//     getBookingDestinationsStatusResponse =
//         await service.getBookingDestinationsStatusAPI();
//     getBookingDestinationsStatusList = [];

//     if (getBookingDestinationsStatusResponse.status!.toLowerCase() ==
//         'success') {
//       if (getBookingDestinationsStatusResponse.data != null) {
//         getBookingDestinationsStatusList!
//             .addAll(getBookingDestinationsStatusResponse.data!);
//         for (GetBookingDestinationsStatus model
//             in getBookingDestinationsStatusList!) {
//           if (model.name == 'Parcel Delivered') {
//             setState(() {
//               delivered = model.name!;
//               deliveredID = model.bookings_destinations_status_id!;
//             });
//           } else if (model.name == "Parcel Lost") {
//             setState(() {
//               lost = model.name!;
//               lostID = model.bookings_destinations_status_id!;
//             });
//           } else if (model.name == "Parcel Damaged") {
//             setState(() {
//               damaged = model.name!;
//               damagedID = model.bookings_destinations_status_id!;
//             });
//           } else if (model.name == "Parcel Returned") {
//             setState(() {
//               returned = model.name!;
//               returnedID = model.bookings_destinations_status_id!;
//             });
//           } else if (model.name == "Delivery Cancelled") {
//             cancelled = model.name!;
//             cancelledID = model.bookings_destinations_status_id!;
//           }
//         }
//       }
//     }

//     setState(() {
//       isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Dialog(
//       backgroundColor: white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(40),
//       ),
//       insetPadding: const EdgeInsets.only(left: 20, right: 20),
//       child: SizedBox(
//         height: size.height * 0.5,
//         child: Column(
//           children: [
//             Align(
//               alignment: Alignment.topRight,
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 5, right: 15),
//                 child: GestureDetector(
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                   child: SvgPicture.asset(
//                     "assets/images/close-circle.svg",
//                   ),
//                 ),
//               ),
//             ),
//             Text(
//               'Ending Ride',
//               style: GoogleFonts.syne(
//                 fontSize: 20,
//                 color: orange,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//             SizedBox(
//               height: 10.h,
//             ),
//             Text(
//               'Select the reason why are \nyou ending this ride',
//               textAlign: TextAlign.center,
//               style: GoogleFonts.syne(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w400,
//                 color: grey,
//               ),
//             ),
//             SizedBox(
//               height: 10.h,
//             ),
//             isLoading
//                 ? SizedBox(height: 200.h, child: spinKitRotatingCircle)
//                 : SizedBox(
//                     height: 200.h,
//                     width: 270.w,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               radioButton = 1;
//                               deliveredID;
//                               debugPrint(
//                                   'object delivered: ${deliveredID.toString()}');
//                             });
//                           },
//                           child: Row(
//                             children: [
//                               radioButton == 1
//                                   ? SvgPicture.asset(
//                                       'assets/images/select-radio.svg')
//                                   : SvgPicture.asset(
//                                       'assets/images/unselect-radio.svg'),
//                               SizedBox(
//                                 width: 12.w,
//                               ),
//                               Text(
//                                 'Parcel has been delivered',
//                                 style: GoogleFonts.syne(
//                                   fontSize: 16,
//                                   color: black,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               radioButton = 2;
//                               cancelledID;
//                               debugPrint(
//                                   'object cancelled: ${cancelledID.toString()}');
//                             });
//                           },
//                           child: Row(
//                             children: [
//                               radioButton == 2
//                                   ? SvgPicture.asset(
//                                       'assets/images/select-radio.svg')
//                                   : SvgPicture.asset(
//                                       'assets/images/unselect-radio.svg'),
//                               SizedBox(
//                                 width: 12.w,
//                               ),
//                               Text(
//                                 'Delivery is cancelled by rider',
//                                 style: GoogleFonts.syne(
//                                   fontSize: 16,
//                                   color: black,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               radioButton = 3;
//                               lostID;
//                               debugPrint('object lost: ${lostID.toString()}');
//                             });
//                           },
//                           child: Row(
//                             children: [
//                               radioButton == 3
//                                   ? SvgPicture.asset(
//                                       'assets/images/select-radio.svg')
//                                   : SvgPicture.asset(
//                                       'assets/images/unselect-radio.svg'),
//                               SizedBox(
//                                 width: 12.w,
//                               ),
//                               Text(
//                                 'Parcel is lost by rider',
//                                 style: GoogleFonts.syne(
//                                   fontSize: 16,
//                                   color: black,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               radioButton = 4;
//                               returnedID;
//                               debugPrint(
//                                   'object returned: ${returnedID.toString()}');
//                             });
//                           },
//                           child: Row(
//                             children: [
//                               radioButton == 4
//                                   ? SvgPicture.asset(
//                                       'assets/images/select-radio.svg')
//                                   : SvgPicture.asset(
//                                       'assets/images/unselect-radio.svg'),
//                               SizedBox(
//                                 width: 12.w,
//                               ),
//                               Text(
//                                 'Parcel is returned by the rider',
//                                 style: GoogleFonts.syne(
//                                   fontSize: 16,
//                                   color: black,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               radioButton = 5;
//                               damagedID;
//                               debugPrint(
//                                   'object damaged: ${damagedID.toString()}');
//                             });
//                           },
//                           child: Row(
//                             children: [
//                               radioButton == 5
//                                   ? SvgPicture.asset(
//                                       'assets/images/select-radio.svg')
//                                   : SvgPicture.asset(
//                                       'assets/images/unselect-radio.svg'),
//                               SizedBox(
//                                 width: 12.w,
//                               ),
//                               Text(
//                                 'Parcel is damaged',
//                                 style: GoogleFonts.syne(
//                                   fontSize: 16,
//                                   color: black,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//             SizedBox(
//               height: 10.h,
//             ),
//             isRideEnding
//                 ? const Center(
//                     child: SpinKitDoubleBounce(
//                       color: orange,
//                       size: 50.0,
//                     ),
//                   )
//                 : GestureDetector(
//                     onTap: () {
//                       // Navigator.of(context).pop();
//                       endRideMethod(context);
//                     },
//                     child: buttonContainer(context, 'End Ride'),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }

//   bool isRideEnding = false;
//   APIResponse<ShowBookingsModel>? endRideResponse;

//   endRideMethod(BuildContext context) async {
//     setState(() {
//       isRideEnding = true;
//     });
//     Map endRideData = {
//       "bookings_id": widget.inProgressRidesList!.bookings_id.toString(),
//       "bookings_destinations_id":
//           widget.inProgressRidesList2![0].bookings_destinations_id.toString(),
//       "bookings_destinations_status_id": radioButton == 1
//           ? deliveredID.toString()
//           : radioButton == 2
//               ? cancelledID.toString()
//               : radioButton == 3
//                   ? lostID.toString()
//                   : radioButton == 4
//                       ? returnedID.toString()
//                       : radioButton == 5
//                           ? damagedID.toString()
//                           : null,
//     };
//     debugPrint("end ride data: ${endRideData.toString()}");

//     endRideResponse = await service.endRideRequest(endRideData);

//     if (endRideResponse!.status!.toLowerCase() == "success") {
//       if (endRideResponse!.data != null) {
//         showToastSuccess('Ride has been ended', FToast().init(context));
//         Navigator.of(context).pop();
//         Navigator.of(context).push(
//           MaterialPageRoute(
//             builder: (context) => const BottomNavBar(),
//           ),
//         );
//       }
//     } else {
//       showToastError(endRideResponse!.message, FToast().init(context));
//       debugPrint(
//           'object error ending ride: ${endRideResponse!.status!.toString()}');
//     }
//     setState(() {
//       isRideEnding = false;
//     });
//   }
// }
