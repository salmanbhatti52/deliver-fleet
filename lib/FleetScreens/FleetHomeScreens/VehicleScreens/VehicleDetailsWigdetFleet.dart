import 'package:Deliver_Rider/Constants/Colors.dart';
import 'package:Deliver_Rider/Constants/PageLoadingKits.dart';
import 'package:Deliver_Rider/models/API%20models/GetAllSystemDataModel.dart';
import 'package:Deliver_Rider/models/GetFleetVehicleByIdModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/API models/API response.dart';
import '../../../services/API_services.dart';

class VehicleDetailsWigdetFleet extends StatefulWidget {
  final GetFleetVehicleByIdModel getFleetVehicleByIdModel;
  const VehicleDetailsWigdetFleet(
      {super.key, required this.getFleetVehicleByIdModel});

  @override
  State<VehicleDetailsWigdetFleet> createState() =>
      _VehicleDetailsWigdetFleetState();
}

class _VehicleDetailsWigdetFleetState extends State<VehicleDetailsWigdetFleet> {
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

  late APIResponse<List<GetAllSystemDataModel>> _getAllSystemDataResponse;
  List<GetAllSystemDataModel>? _getSystemDataList;

  String distanceUnit = '';

  init() async {
    _getAllSystemDataResponse = await service.getALlSystemDataAPI();
    _getSystemDataList = [];

    if (_getAllSystemDataResponse.status!.toLowerCase() == 'success') {
      if (_getAllSystemDataResponse.data != null) {
        _getSystemDataList!.addAll(_getAllSystemDataResponse.data!);
        for (GetAllSystemDataModel model in _getSystemDataList!) {
          if (model.type == 'distance_unit') {
            setState(() {
              distanceUnit = model.description!;
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
    return isLoading
        ? spinKitRotatingCircle
        : Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            height: 255.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: white,
              border: Border.all(
                color: grey,
              ),
            ),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.getFleetVehicleByIdModel.vehicles!.name!,
                  style: GoogleFonts.syne(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: black,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Driver',
                      style: GoogleFonts.syne(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: black,
                      ),
                    ),
                    Text(
                      widget.getFleetVehicleByIdModel.vehicle_assigned_to!
                                  .users_fleet_id !=
                              -1
                          ? '${widget.getFleetVehicleByIdModel.vehicle_assigned_to!.first_name!} ${widget.getFleetVehicleByIdModel.vehicle_assigned_to!.last_name!}'
                          : 'Not assigned',
                      style: GoogleFonts.syne(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: black,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 7.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Status',
                      style: GoogleFonts.syne(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: black,
                      ),
                    ),
                    Text(
                      widget.getFleetVehicleByIdModel.vehicle_assigned_to!
                                  .users_fleet_id ==
                              -1
                          ? 'Active'
                          : 'In Use',
                      style: GoogleFonts.syne(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: black,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 7.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Registration Number',
                      style: GoogleFonts.syne(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: black,
                      ),
                    ),
                    Text(
                      widget.getFleetVehicleByIdModel.vehicle_registration_no!,
                      style: GoogleFonts.syne(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: black,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 22),
                          width: 95.w,
                          height: 95.h,
                          decoration: BoxDecoration(
                            color: lightGrey,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  widget.getFleetVehicleByIdModel
                                      .trips_completed!,
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: black,
                                  ),
                                ),
                                Text(
                                  'Trips',
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: orange,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: -25,
                          child: Container(
                            width: 45.w,
                            height: 45.h,
                            decoration: BoxDecoration(
                              color: white,
                              border: Border.all(color: lightGrey),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: SvgPicture.asset(
                              'assets/images/total-trips-fleet-icon.svg',
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      alignment: Alignment.topCenter,
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 22),
                          width: 95.w,
                          height: 95.h,
                          decoration: BoxDecoration(
                            color: lightGrey,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  widget.getFleetVehicleByIdModel
                                      .distance_covered!,
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: black,
                                  ),
                                ),
                                Text(
                                  'Distance ($distanceUnit)',
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: orange,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: -25,
                          child: Container(
                            width: 45.w,
                            height: 45.h,
                            decoration: BoxDecoration(
                              color: white,
                              border: Border.all(color: lightGrey),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: SvgPicture.asset(
                              'assets/images/total-distnace-icon-fleet.svg',
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}
