import 'package:Deliver_Rider/Constants/PageLoadingKits.dart';
import 'package:Deliver_Rider/models/API%20models/ShowBookingsModel.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Constants/Colors.dart';
import '../../../models/API models/API response.dart';
import '../../../models/API models/GetAllSystemDataModel.dart';
import '../../../services/API_services.dart';

class ModalSheetRideData extends StatefulWidget {
  final String pickupAddress;
  List<BookingDestinations>? bookingDestinationsList;

  ModalSheetRideData(
      {super.key, this.bookingDestinationsList, required this.pickupAddress});

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
    for (int i = 0; i < widget.bookingDestinationsList!.length; i++) {
      return Container(
        padding: const EdgeInsets.only(right: 10),
        width: double.infinity,
        height: MediaQuery.sizeOf(context).height / 1.15,
        child: isLoading
            ? spinKitRotatingCircle
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    height: 4.h,
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
                            width: 270.w,
                            child: AutoSizeText(
                              widget
                                  .bookingDestinationsList![i].destin_address!,
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
                    height: 18.h,
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
                                Text(
                                  widget
                                      .bookingDestinationsList![i].destin_time!,
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
                                  '$currency ${widget.bookingDestinationsList![i].destin_discounted_charges!}',
                                  style: GoogleFonts.inter(
                                    fontSize: 28,
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
      );
    }
    return SizedBox();
  }
}
