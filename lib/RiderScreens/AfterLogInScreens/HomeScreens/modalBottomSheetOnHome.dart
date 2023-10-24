import 'package:Deliver_Rider/RiderScreens/AfterLogInScreens/HomeScreens/UserToUserChat/UserToUserChat.dart';
import 'package:Deliver_Rider/models/API%20models/API%20response.dart';
import 'package:Deliver_Rider/utilities/showToast.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Constants/Colors.dart';
import '../../../models/API models/ShowBookingsModel.dart';
import '../../../services/API_services.dart';
import 'ModalSheetRideData.dart';
import 'modalBottomSheetStartRide.dart';

class ModalBottomSheetOnHome extends StatefulWidget {
  final String userID;
  List<BookingDestinations>? bookingDestinationsList;
  final BookingModel customersModel;
  final CustomersModel? customerDetails;
  ModalBottomSheetOnHome(
      {super.key,
      required this.userID,
        this.customerDetails,
      this.bookingDestinationsList,
      required this.customersModel});

  @override
  State<ModalBottomSheetOnHome> createState() => _ModalBottomSheetOnHomeState();
}

class _ModalBottomSheetOnHomeState extends State<ModalBottomSheetOnHome> {
  ApiServices get service => GetIt.I<ApiServices>();

  late PageController scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    scrollController = PageController();
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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 20.h),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      height: MediaQuery.sizeOf(context).height * 0.57,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.network(
                        'https://deliver.eigix.net/public/${widget.customersModel.users_customers!.profile_pic}',
                        fit: BoxFit.cover,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return SizedBox(
                              child: Image.asset(
                            'assets/images/place-holder.png',
                            fit: BoxFit.scaleDown,
                          ));
                        },
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              color: orange,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
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
                          '${widget.customersModel.users_customers!.first_name!} ${widget.customersModel.users_customers!.last_name!}',
                          minFontSize: 13,
                          maxLines: 2,
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
                        '${widget.customersModel.delivery_type}',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  isChatStarting
                      ? SizedBox(
                          // width: 10.w,
                          height: 10.h,
                          child: SpinKitThreeInOut(
                            size: 12,
                            color: orange,
                            // size: 50.0,
                          ),
                        )
                      : GestureDetector(
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
                          widget.customersModel.users_customers!.phone!);
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
                                const ColorFilter.mode(white, BlendMode.srcIn),
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
            height: 10.h,
          ),
          SizedBox(
              height: MediaQuery.sizeOf(context).height / 2.8,
              child: ModalSheetRideData(
                bookingDestinationsList: widget.bookingDestinationsList,
                pickupAddress: widget.customersModel.pickup_address!,
                customersModel: widget.customersModel,
              )),
          Padding(
            padding: EdgeInsets.only(top: 14.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                isAcceptingRide
                    ? Padding(
                        padding: EdgeInsets.only(left: 35.0),
                        child: SpinKitDoubleBounce(
                          color: orange,
                          size: 50.0,
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          acceptRideMethod(context);
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
                              'ACCEPT',
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
                isRejectingRide
                    ? Padding(
                        padding: EdgeInsets.only(right: 35.0),
                        child: SpinKitDoubleBounce(
                          color: orange,
                          size: 50.0,
                        ),
                      )
                    : GestureDetector(
                        onTap: () => rejectRequestMethod(context),
                        child: Container(
                          width: 170.w,
                          height: 51.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: red,
                          ),
                          child: Center(
                            child: Text(
                              'REJECT',
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
          ),
        ],
      ),
    );
  }

  bool isAcceptingRide = false;
  APIResponse<ShowBookingsModel>? acceptRideResponse;
  acceptRideMethod(BuildContext context) async {
    setState(() {
      isAcceptingRide = true;
    });
    Map acceptRideData = {
      "bookings_id": widget.customersModel.bookings_id.toString(),
      "users_customers_id":
          widget.customersModel.users_customers!.users_customers_id.toString(),
      "users_fleet_id": widget.userID.toString(),
    };

    print('object accept ride data:   ' + acceptRideData.toString());

    acceptRideResponse = await service.acceptRideRequest(acceptRideData);
    if (acceptRideResponse!.status!.toLowerCase() == 'success') {
      if (acceptRideResponse!.data != null) {
        showToastSuccess('Request has been accepted', FToast().init(context),
            seconds: 1);
        Navigator.of(context).pop();
        showModalBottomSheet(
          backgroundColor: white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          isScrollControlled: true,
          isDismissible: false,
          context: context,
          builder: (context) => ModalBottomSheetStartRide(
            userID: widget.userID,
            bookingModel: widget.customersModel,
            bookingDestinations: widget.bookingDestinationsList!,
          ),
        );
      }
    } else {
      showToastError(acceptRideResponse!.message!, FToast().init(context),
          seconds: 1);
    }
    setState(() {
      isAcceptingRide = false;
    });
  }

  bool isRejectingRide = false;
  APIResponse<ShowBookingsModel>? rejectRideResponse;
  rejectRequestMethod(BuildContext context) async {
    setState(() {
      isRejectingRide = true;
    });
    Map rejectRideData = {
      "bookings_id": widget.customersModel.bookings_id.toString(),
      "users_customers_id":
          widget.customersModel.users_customers!.users_customers_id.toString(),
      "users_fleet_id": widget.userID.toString(),
    };
    rejectRideResponse = await service.rejectRideRequest(rejectRideData);
    if (rejectRideResponse!.status!.toLowerCase() == 'success') {
      if (rejectRideResponse!.data != null) {
        showToastSuccess('Ride Request is rejected', FToast().init(context),
            seconds: 1);
        Navigator.of(context).pop();
      }
    } else {
      showToastError(rejectRideResponse!.message!, FToast().init(context),
          seconds: 1);
      Navigator.of(context).pop();
    }
    setState(() {
      isRejectingRide = false;
    });
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
      "users_id": widget.userID.toString(),
      "other_users_id":
          widget.customersModel.users_customers!.users_customers_id.toString(),
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
            phone: widget.customersModel.users_customers!.phone!,
            riderID: widget.userID.toString(),
            image: widget.customersModel.users_customers!.profile_pic!,
            name:"${widget.customersModel.users_customers!.first_name!} ${widget.customersModel.users_customers!.last_name!}",
            address: widget.customersModel.pickup_address,
            clientID: widget.customersModel.users_customers!.users_customers_id
                .toString(),
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
            phone: widget.customersModel.users_customers!.phone!,
            riderID: widget.userID.toString(),
            image: widget.customersModel.users_customers!.profile_pic!,
            name:"${widget.customersModel.users_customers!.first_name!} ${widget.customersModel.users_customers!.last_name!}",
            address: widget.customersModel.pickup_address,
            clientID: widget.customersModel.users_customers!.users_customers_id.toString(),
          ),
        ),
      );
    }
    setState(() {
      isChatStarting = false;
    });
  }
}
