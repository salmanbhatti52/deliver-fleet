import 'package:deliver_partner/Constants/PageLoadingKits.dart';
import 'package:deliver_partner/models/API_models/ShowBookingsModel.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../Constants/Colors.dart';
import '../../../models/API_models/API_response.dart';
import '../../../models/API_models/GetAllSystemDataModel.dart';
import '../../../services/API_services.dart';

class ModalSheetRideData extends StatefulWidget {
  final String pickupAddress;
  final String? deliveryType;
  ScrollController? scrollController;
  List<BookingDestinations>? bookingDestinationsList;
  final BookingModel customersModel;

  ModalSheetRideData({
    super.key,
    this.deliveryType,
    this.scrollController,
    this.bookingDestinationsList,
    required this.customersModel,
    required this.pickupAddress,
  });

  @override
  State<ModalSheetRideData> createState() => _ModalSheetRideDataState();
}

class _ModalSheetRideDataState extends State<ModalSheetRideData> {
  late APIResponse<List<GetAllSystemDataModel>> _getAllSystemDataResponse;
  List<GetAllSystemDataModel>? _getSystemDataList;
  String? distance;
  String currency = '';
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      isLoading = true;
    });
    init();
  }

  ApiServices get service => GetIt.I<ApiServices>();

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

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < widget.bookingDestinationsList!.length;) {
      return widget.deliveryType == 'Single'
          ? Container(
              padding: const EdgeInsets.only(right: 10),
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.325,
              child: isLoading
                  ? spinKitRotatingCircle
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
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
                              '${widget.bookingDestinationsList![i].receiver_name}',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: black,
                              ),
                            ),
                            Text(
                              '${widget.bookingDestinationsList![i].receiver_phone}',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: black,
                              ),
                            )
                          ],
                        ),
                        widget.customersModel.scheduled == "Yes"
                            ? SizedBox(
                                height: 5.h,
                              )
                            : SizedBox(
                                height: 20.h,
                              ),
                        widget.customersModel.scheduled == "Yes"
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
                                        '${widget.customersModel.delivery_date}',
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: black,
                                        ),
                                      ),
                                      Text(
                                        DateFormat('h:mm a').format(
                                          DateFormat('HH:mm:ss').parse(widget
                                              .customersModel.delivery_time!),
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
                              width: 250.w,
                              child: AutoSizeText(
                                widget.pickupAddress,
                                maxLines: 3,
                                minFontSize: 12,
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
                                  width: 270.w,
                                  child: AutoSizeText(
                                    widget.bookingDestinationsList![i]
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
                          height: 15.h,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: SizedBox(
                                  width: 40.w,
                                  child: Column(
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
                                        widget.bookingDestinationsList![i]
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
                                        '${widget.bookingDestinationsList![i].destin_distance!} $distance',
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
                                        '${widget.customersModel.total_charges}',
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
                      ],
                    ),
            )
          : Column(
              children: [
                Expanded(
                  child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      controller:
                          PageController(), // Adjust the PageController as needed
                      itemCount: widget.bookingDestinationsList!.length,
                      onPageChanged: (int index) {
                        setState(() {
                          currentPage = index;
                        });
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          color: Colors.transparent,
                          padding: const EdgeInsets.only(right: 10),
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.345,
                          child: isLoading
                              ? spinKitRotatingCircle
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10.h,
                                    ),
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
                                          '${widget.bookingDestinationsList![index].receiver_name}',
                                          style: GoogleFonts.inter(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: black,
                                          ),
                                        ),
                                        Text(
                                          '${widget.bookingDestinationsList![index].receiver_phone}',
                                          style: GoogleFonts.inter(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: black,
                                          ),
                                        )
                                      ],
                                    ),
                                    widget.customersModel.scheduled == "Yes"
                                        ? SizedBox(
                                            height: 5.h,
                                          )
                                        : SizedBox(
                                            height: 20.h,
                                          ),
                                    widget.customersModel.scheduled == "Yes"
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
                                                    textAlign: TextAlign.start,
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
                                                    DateFormat('h:mm a').format(
                                                      DateFormat('HH:mm:ss')
                                                          .parse(widget
                                                              .customersModel
                                                              .delivery_time!),
                                                    ),
                                                    style: GoogleFonts.inter(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: black,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${widget.customersModel.delivery_time}',
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
                                          width: 250.w,
                                          child: AutoSizeText(
                                            widget
                                                .bookingDestinationsList![index]
                                                .pickup_address!,
                                            maxLines: 3,
                                            minFontSize: 12,
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
                                              width: 270.w,
                                              child: AutoSizeText(
                                                widget
                                                    .bookingDestinationsList![
                                                        index]
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
                                      height: 15.h,
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: SizedBox(
                                              width: 40.w,
                                              child: Column(
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
                                                    widget
                                                        .bookingDestinationsList![
                                                            index]
                                                        .destin_time!,
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
                                                    '${widget.bookingDestinationsList![index].destin_distance!} $distance',
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
                                                    '${widget.customersModel.total_charges}',
                                                    // '$currency ${widget.bookingDestinationsList![i].destin_discounted_charges!}',
                                                    style: GoogleFonts.inter(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: black,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      'Fare',
                                                      style: GoogleFonts.syne(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
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
                                  ],
                                ),
                        );
                      }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      widget.bookingDestinationsList!.length, (index) {
                    return Container(
                      width: 10.0,
                      height: 10.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: currentPage == index ? orange : Colors.grey,
                      ),
                    );
                  }),
                )
              ],
            );
    }
    return const SizedBox();
  }

  int currentPage = 0;
}
