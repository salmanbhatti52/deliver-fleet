import 'package:deliver_partner/Constants/Colors.dart';
import 'package:deliver_partner/Constants/PageLoadingKits.dart';
import 'package:deliver_partner/models/API%20models/GetAllSystemDataModel.dart';
import 'package:deliver_partner/models/GetFleetVehicleByIdModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/API models/API response.dart';
import '../../../services/API_services.dart';

class VehicleDetailsWigdetFleet extends StatefulWidget {
  final GetFleetVehicleByIdModel getFleetVehicleByIdModel;
  final int? usersFleetVehiclesAssigned;
  const VehicleDetailsWigdetFleet(
      {super.key, required this.getFleetVehicleByIdModel, this.usersFleetVehiclesAssigned});

  @override
  State<VehicleDetailsWigdetFleet> createState() =>
      _VehicleDetailsWigdetFleetState();
}

class _VehicleDetailsWigdetFleetState extends State<VehicleDetailsWigdetFleet> {
  bool isLoading = false;
  int? userFleetId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      isLoading = true;
      userFleetId = widget.getFleetVehicleByIdModel.users_fleet_vehicles_id;
    });
    print('userFleetId: $userFleetId');
    print('usersFleetVehiclesAssigned3: ${widget.usersFleetVehiclesAssigned}');
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
            height: 280.h,
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
                      widget.usersFleetVehiclesAssigned == -1
                          ? 'Not Assigned'
                          : widget.usersFleetVehiclesAssigned != -1
                              ? '${widget.getFleetVehicleByIdModel.users_fleet!.first_name!} ${widget.getFleetVehicleByIdModel.users_fleet!.last_name!}'
                              : '',
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
                      widget.usersFleetVehiclesAssigned == -1
                          ? 'Active'
                          : widget.usersFleetVehiclesAssigned != -1
                              ? 'In Use'
                              : '',
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
                  height: 40.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 22),
                          width: 120.w,
                          height: 100.h,
                          decoration: BoxDecoration(
                            color: lightGrey,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  widget.getFleetVehicleByIdModel
                                      .trips_completed!,
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: black,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
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
                          top: -20,
                          child: Container(
                            width: 50.w,
                            height: 50.h,
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
                    SizedBox(
                      width: 20.w,
                    ),
                    Stack(
                      alignment: Alignment.topCenter,
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 22),
                          width: 120.w,
                          height: 100.h,
                          decoration: BoxDecoration(
                            color: lightGrey,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  widget.getFleetVehicleByIdModel
                                      .distance_covered!,
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: black,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
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
                          top: -20,
                          child: Container(
                            width: 50.w,
                            height: 50.h,
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
