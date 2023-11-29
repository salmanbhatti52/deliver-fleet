import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../Constants/Colors.dart';
import '../../../Constants/PageLoadingKits.dart';
import '../../../Constants/SeeDetailsOnCompletedRidesButton.dart';
import '../../../Constants/details-button.dart';
import '../../../Constants/ratingContainerOnCompletedRides.dart';
import '../../../models/API models/API response.dart';
import '../../../models/API models/GetAllSystemDataModel.dart';
import '../../../models/API models/GetBookingDeatinationsStatus.dart';
import '../../../models/API models/ScheduledRiderModel.dart';
import '../../../models/API models/ShowBookingsModel.dart';
import '../../../services/API_services.dart';
import '../../../utilities/showToast.dart';
import '../../AfterLogInScreens/HomeScreens/modalBottomSheetEndRide.dart';
import '../../AfterLogInScreens/RidesScreens/CompletedRidesDestinationsWidget.dart';
import '../../BottomNavBar.dart';

class ScheduledScreen extends StatefulWidget {
  final ScheduledRiderModel scheduledRiderModel;
  const ScheduledScreen({super.key, required this.scheduledRiderModel});

  @override
  State<ScheduledScreen> createState() => _ScheduledScreenState();
}

class _ScheduledScreenState extends State<ScheduledScreen> {
  bool opened = false;
  bool closed = false;
  late APIResponse<List<GetBookingDestinationsStatus>>
  getBookingDestinationsStatusResponse;
  List<GetBookingDestinationsStatus>? getBookingDestinationsStatusList;

  late APIResponse<List<GetAllSystemDataModel>> _getAllSystemDataResponse;
  List<GetAllSystemDataModel>? _getSystemDataList;

  String? name;
  int? statusID;
  int? startRideID;
  String? startRide;
  String currency = '';
  String? distance;
  bool isLoading = false;

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

  @override
  void initState() {
    super.initState();
    init();
    closed = true;
    setState(() {
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {

    String deliveryDateStr = widget.scheduledRiderModel.bookings!.delivery_date.toString();
    String deliveryTimeStr = widget.scheduledRiderModel.bookings!.delivery_time.toString();

    DateTime deliveryDateTime = DateTime.parse("$deliveryDateStr $deliveryTimeStr");

    DateTime now = DateTime.now();
    // bool isScheduled = deliveryDateTime.isAfter(now) || (deliveryDateTime.isAtSameMomentAs(now) && deliveryDateTime.isAfter(now));
    bool isScheduled = now.isAfter(deliveryDateTime);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                  width: double.infinity,
                  height: opened ? 500.h : 160.h,
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
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.59,
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
                                              ratings: widget
                                                          .scheduledRiderModel
                                                          .users_fleet!
                                                          .bookings_ratings ==
                                                      null
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
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    closed = false;
                                    opened = true;
                                  });
                                },
                                child:
                                    SeeDetailsOnCompletedRidesButton(context),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                  SvgPicture.asset(
                                      'assets/images/location.svg'),
                                  SizedBox(
                                    width: 7.h,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        width: 290.w,
                                        child: Text(
                                          // "pickup_address",
                                          '${widget.scheduledRiderModel.bookings!.bookings_destinations![0].pickup_address}',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.inter(
                                            fontSize: 16,
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
                                  destination: widget
                                      .scheduledRiderModel
                                      .bookings!
                                      .bookings_destinations![0]
                                      .destin_address!,
                                  distance: widget
                                      .scheduledRiderModel
                                      .bookings!
                                      .bookings_destinations![0]
                                      .destin_distance!,
                                  time: widget.scheduledRiderModel.bookings!
                                      .bookings_destinations![0].destin_time!,
                                  fare: widget.scheduledRiderModel.bookings!
                                      .total_charges
                                      .toString(),
                                  // fare: widget.scheduledRiderModel.bookings!.bookings_destinations![0]!.destin_discounted_charges!,
                                ),
                              ),
                              // SizedBox(
                              //   height: 15.h,
                              // ),
                              isScheduled
                                  ? Column(
                                children: [
                                  isParcelPicked
                                      ? SizedBox(
                                    // width: 10.w,
                                    height: 10.h,
                                    child: const SpinKitThreeInOut(
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
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  isRideStarting
                                      ? const Padding(
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
                                ],
                              )
                                  : const SizedBox(),
                              SizedBox(
                                height: 25.h,
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

  ApiServices get service => GetIt.I<ApiServices>();
  bool isParcelPicked = false;
  bool packageStatus = false;
  APIResponse<ShowBookingsModel>? pickedResponse;

  parcelPickedMethod(BuildContext context) async {
    setState(() {
      isParcelPicked = true;
    });
    Map startRideData = {
      "bookings_id": widget.scheduledRiderModel.bookings_id.toString(),
      "bookings_destinations_id": widget.scheduledRiderModel.bookings_destinations_id.toString(),
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

  APIResponse<ShowBookingsModel>? startRideResponse;

  bool isRideStarting = false;
  startRideMethod(BuildContext context) async {
    if(packageStatus == false){
      showToastError('You\'ve to pick the parcel from pickup location first',
          FToast().init(context),
          seconds: 1);
    } else {
      setState(() {
        isRideStarting = true;
      });

      Map startRideData = {
        "bookings_id": widget.scheduledRiderModel.bookings_id.toString(),
        "bookings_destinations_id":
        widget.scheduledRiderModel.bookings_destinations_id.toString(),
        "bookings_destinations_status_id": startRideID.toString()
      };
      print('object start ride data:    ' + startRideData.toString());
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
          //     bookingModel: widget.scheduledRiderModel,
          //     userID: widget.userID,
          //     bookingDestinations: widget.bookingDestinations,
          //   ),
          // );
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const BottomNavBar(),
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

}
