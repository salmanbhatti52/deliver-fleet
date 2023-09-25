import 'package:Deliver_Rider/Constants/PageLoadingKits.dart';
import 'package:Deliver_Rider/models/API%20models/API%20response.dart';
import 'package:Deliver_Rider/models/API%20models/GetBookingDeatinationsStatus.dart';
import 'package:Deliver_Rider/models/API%20models/ShowBookingsModel.dart';
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
import '../../../models/API models/GetAllSystemDataModel.dart';
import '../../../services/API_services.dart';
import 'modalBottomSheetEndRide.dart';

class ModalBottomSheetStartRide extends StatefulWidget {
  final BookingModel bookingModel;
  final List<BookingDestinations> bookingDestinations;

  const ModalBottomSheetStartRide({
    super.key,
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
    setState(() {
      isLoading = true;
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
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 20.h),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        height: MediaQuery.sizeOf(context).height * 0.57,
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
                              Text(
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
                          Column(
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
                              widget.bookingDestinations[i].receiver_name!,
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
                              widget.bookingDestinations[i].receiver_phone!,
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
                  SizedBox(
                    height: 10.h,
                  ),
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
                          widget.bookingModel.pickup_address!,
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
                              widget.bookingDestinations[i].destin_address!,
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
                                widget.bookingDestinations[i].destin_time!,
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
                                '$currency ${widget.bookingDestinations[i].destin_discounted_charges!}',
                                style: GoogleFonts.inter(
                                  fontSize: 28,
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
                  isParcelPicked
                      ? SizedBox(
                          // width: 10.w,
                          height: 10.h,
                          child: SpinKitThreeInOut(
                            size: 10,
                            color: orange,
                            // size: 50.0,
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
                                parcelPickedMethod(context);
                                print('object id of picked parcel:  ' +
                                    statusID.toString());
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
                        ),
                  Padding(
                    padding: EdgeInsets.only(top: 22.h),
                    child: isRideStarting
                        ? Padding(
                            padding: EdgeInsets.only(left: 35.0),
                            child: SpinKitDoubleBounce(
                              color: orange,
                              size: 50.0,
                            ),
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
                  ),
                ],
              ),
      );
    }
    return SizedBox();
  }

  ApiServices get service => GetIt.I<ApiServices>();

  APIResponse<ShowBookingsModel>? startRideResponse;

  bool isRideStarting = false;
  startRideMethod(BuildContext context) async {
    if (packageStatus == false) {
      showToastError('You\'ve to pick the parcel from pickup location first',
          FToast().init(context),
          seconds: 1);
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
      print('object start ride data:    ' + startRideData.toString());
      startRideResponse = await service.startRideRequest(startRideData);

      if (startRideResponse!.status!.toLowerCase() == "success") {
        if (startRideResponse!.data != null) {
          showToastSuccess('Ride has been started', FToast().init(context));
          Navigator.of(context).pop();
          showModalBottomSheet(
            backgroundColor: white,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            context: context,
            builder: (context) => ModalBottomSheetEndRide(
              bookingModel: widget.bookingModel,
              bookingDestinations: widget.bookingDestinations,
            ),
          );
        }
      } else {
        showToastError(startRideResponse!.message, FToast().init(context));
        print('object error starting ride:   ' +
            startRideResponse!.message!.toString() +
            '   ' +
            startRideResponse!.status!.toString());
      }
      setState(() {
        isRideStarting = false;
      });
    }
  }

  bool isParcelPicked = false;
  APIResponse<ShowBookingsModel>? pickedResponse;

  parcelPickedMethod(BuildContext context) async {
    setState(() {
      isParcelPicked = true;
    });
    Map startRideData = {
      "bookings_id": widget.bookingModel.bookings_id.toString(),
      "bookings_destinations_id":
          widget.bookingDestinations[0].bookings_destinations_id.toString(),
      "bookings_destinations_status_id": statusID.toString()
    };
    print('object start ride data:    ' + startRideData.toString());
    pickedResponse = await service.startRideRequest(startRideData);

    if (pickedResponse!.status!.toLowerCase() == "success") {
      if (pickedResponse!.data != null) {
        showToastSuccess('Parcel has been picked', FToast().init(context));
      }
    } else {
      showToastError(pickedResponse!.message, FToast().init(context));
      print('object error starting ride:   ' +
          pickedResponse!.message!.toString() +
          '   ' +
          pickedResponse!.status!.toString());
    }
    setState(() {
      isParcelPicked = false;
    });
  }
}
