import 'package:Deliver_Rider/RiderScreens/AfterLogInScreens/RidesScreens/InProgressEndRideDialog.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Constants/Colors.dart';
import '../../../Constants/PageLoadingKits.dart';
import '../../../models/API models/API response.dart';
import '../../../models/API models/GetAllSystemDataModel.dart';
import '../../../models/API models/InProgressRidesModel.dart';
import '../../../models/API models/ShowBookingsModel.dart';
import '../../../services/API_services.dart';
import '../../../utilities/showToast.dart';
import '../HomeScreens/UserToUserChat/UserToUserChat.dart';

class InProgressDetails extends StatefulWidget {
  final InProgressRidesModel? inProgressRidesList;
  final String userID;
  final List<InProgressRidesModel>? inProgressRidesList2;
  const InProgressDetails({Key? key,
    this.inProgressRidesList,
    this.inProgressRidesList2,
    required this.userID,
  }) : super(key: key);

  @override
  State<InProgressDetails> createState() => _InProgressDetailsState();
}

class _InProgressDetailsState extends State<InProgressDetails> {

  ApiServices get service => GetIt.I<ApiServices>();

  late APIResponse<List<GetAllSystemDataModel>> _getAllSystemDataResponse;
  List<GetAllSystemDataModel>? _getSystemDataList;

  String currency = '';
  String distance = '';

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
    setState(() {
      isLoading = true;
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
      "other_users_id": widget.inProgressRidesList2?[0].bookings?.users_customers?.users_customers_id.toString(),
    };
    print('object start suer to uer chat data:  ' + startChatData.toString());
    startUserToUserChatResponse =
    await service.startUserToUserChatAPI(startChatData);
    if (startUserToUserChatResponse!.status!.toLowerCase() == 'success') {
      showToastSuccess('Chat has been started!', FToast().init(context),
          seconds: 1);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => UserToUserChat(
            phone: widget.inProgressRidesList2?[0].bookings?.users_customers?.phone,
            riderID: widget.userID.toString(),
            image: widget.inProgressRidesList2?[0].bookings?.users_customers?.profile_pic,
            name:"${widget.inProgressRidesList2?[0].bookings?.users_customers?.first_name} ${widget.inProgressRidesList2?[0].bookings?.users_customers?.last_name}",
            address: widget.inProgressRidesList?.bookings?.bookings_destinations?[0].pickup_address,
            clientID: widget.inProgressRidesList!.bookings!.users_customers!.users_customers_id.toString(),
          ),
        ),
      );
    } else {
      print(' error starting chat:  ' +
          startUserToUserChatResponse!.message!.toString());
      // showToastError('error occurred,try again', FToast().init(context),
      //     seconds: 2);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => UserToUserChat(
            phone: widget.inProgressRidesList2?[0].bookings?.users_customers?.phone,
            riderID: widget.userID.toString(),
            image: widget.inProgressRidesList2?[0].bookings?.users_customers?.profile_pic,
            name:"${widget.inProgressRidesList2?[0].bookings?.users_customers?.first_name} ${widget.inProgressRidesList2?[0].bookings?.users_customers?.last_name}",
            address: widget.inProgressRidesList?.bookings?.bookings_destinations?[0].pickup_address,
            clientID: widget.inProgressRidesList!.bookings!.users_customers!.users_customers_id.toString(),
          ),
        ),
      );
    }
    setState(() {
      isChatStarting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < widget.inProgressRidesList2!.length; i++) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 20.h),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        height: MediaQuery.sizeOf(context).height * 0.63,
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
                          'https://deliver.eigix.net/public/${widget.inProgressRidesList?.bookings?.users_customers!.profile_pic}',
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
                            '${widget.inProgressRidesList?.bookings?.users_customers!.first_name!} ${widget.inProgressRidesList?.bookings?.users_customers!.last_name!}',
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
                        Text(
                          widget.inProgressRidesList!.bookings!.bookings_types!.name!,
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
                // Row(
                //   children: [
                //     // GestureDetector(
                //     //   onTap: () => startUserToUserChatMethod(context),
                //     //   child: Column(
                //     //     children: [
                //     //       SizedBox(
                //     //         width: 34.w,
                //     //         height: 34.h,
                //     //         child: SvgPicture.asset(
                //     //           'assets/images/msg-map-icon.svg',
                //     //           fit: BoxFit.scaleDown,
                //     //         ),
                //     //       ),
                //     //       SizedBox(
                //     //         height: 5.h,
                //     //       ),
                //     //       Text(
                //     //         'Chat',
                //     //         style: GoogleFonts.syne(
                //     //           fontSize: 12,
                //     //           fontWeight: FontWeight.w400,
                //     //           color: grey,
                //     //         ),
                //     //       )
                //     //     ],
                //     //   ),
                //     // ),
                //     SizedBox(
                //       width: 10.w,
                //     ),
                //     GestureDetector(
                //       onTap: () {
                //         _makePhoneCall(
                //             widget.inProgressRidesList!.bookings!.users_customers!.phone!);
                //       },
                //       child: Column(
                //         children: [
                //           Container(
                //             width: 34.w,
                //             height: 34.h,
                //             decoration: const BoxDecoration(
                //               shape: BoxShape.circle,
                //               color: orange,
                //             ),
                //             child: SvgPicture.asset(
                //               'assets/images/call.svg',
                //               width: 30,
                //               height: 30,
                //               colorFilter: const ColorFilter.mode(
                //                   white, BlendMode.srcIn),
                //               fit: BoxFit.scaleDown,
                //             ),
                //           ),
                //           SizedBox(
                //             width: 12.w,
                //           ),
                //           Text(
                //             'Call',
                //             style: GoogleFonts.syne(
                //               fontSize: 12,
                //               fontWeight: FontWeight.w400,
                //               color: grey,
                //             ),
                //           )
                //         ],
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              width: double.infinity,
              height: 35.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Receiver Name',
                        style: GoogleFonts.syne(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: grey,
                        ),
                      ),
                      Text(
                        "${widget.inProgressRidesList2![i].bookings?.bookings_destinations?[i].receiver_name}",
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: black,
                        ),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Receiver Contact',
                        style: GoogleFonts.syne(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: grey,
                        ),
                      ),
                      Text(
                        widget.inProgressRidesList2![i].bookings!.bookings_destinations![i].receiver_phone!,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: black,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            widget.inProgressRidesList2?[i].bookings?.scheduled == "Yes"
                ? SizedBox(height: 10.h,)
                : SizedBox(height: 30.h,),
            widget.inProgressRidesList2?[i].bookings?.scheduled == "Yes"
                ? Column(
              children: [
                Text(
                  'Schedule Ride',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.syne(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: grey,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  height: 3.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${widget.inProgressRidesList2?[i].bookings?.delivery_date}',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: black,
                      ),
                    ),
                    Text(
                      '${widget.inProgressRidesList2?[i].bookings?.delivery_time}',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: black,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 9.h,
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
                    widget.inProgressRidesList!.bookings!.bookings_destinations![0].pickup_address!,
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  'assets/images/pointer.svg',
                  colorFilter:
                  const ColorFilter.mode(orange, BlendMode.srcIn),
                  width: 24.w,
                  height: 24.h,
                ),
                SizedBox(
                  width: 15.w,
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
                        widget.inProgressRidesList2![i].bookings!.bookings_destinations![i].destin_address!,
                        minFontSize: 12,
                        maxLines: 3,
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
              height: 15.h,
            ),
            SizedBox(
              height: 15.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SizedBox(
                    width: 40.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/timer-icon.svg',
                          colorFilter: const ColorFilter.mode(
                              black, BlendMode.srcIn),
                        ),
                        Text(
                          widget.inProgressRidesList2![i].bookings!.bookings_destinations![i].destin_time!,
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
                        SvgPicture.asset('assets/images/meter-icon.svg'),
                        Text(
                          '${widget.inProgressRidesList2![i].bookings?.bookings_destinations?[i].destin_distance!} $distance',
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
                          '$currency ${widget.inProgressRidesList2![i].bookings?.total_charges}',
                          // '$currency ${widget.inProgressRidesList2![i].bookings?.bookings_destinations?[i].destin_discounted_charges!}',
                          style: GoogleFonts.inter(
                            fontSize: 20,
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
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: GestureDetector(
                onTap: () {
                  showAdaptiveDialog(
                    context: context,
                    builder: (context) => INProgressEndRideDialog(
                      inProgressRidesList: widget.inProgressRidesList, inProgressRidesList2: widget.inProgressRidesList2,
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
              ),
            ),
          ],
        ),
      );
    }
    return SizedBox();
  }
}