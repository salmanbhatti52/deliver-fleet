import 'package:deliver_partner/Constants/Colors.dart';
import 'package:deliver_partner/Constants/PageLoadingKits.dart';
import 'package:deliver_partner/models/GetFleetVehicleByIdModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Constants/back-arrow-with-container.dart';
import '../../../models/API models/API response.dart';
import '../../../services/API_services.dart';
import '../../../utilities/showToast.dart';
import 'DriverRequestOnVehicleDetailsFleet.dart';
import 'VehicleDetailsWigdetFleet.dart';

class VehicleDetailScreenFleet extends StatefulWidget {
  final int users_fleet_vehicles_id;
  const VehicleDetailScreenFleet(
      {super.key, required this.users_fleet_vehicles_id});

  @override
  State<VehicleDetailScreenFleet> createState() =>
      _VehicleDetailScreenFleetState();
}

class _VehicleDetailScreenFleetState extends State<VehicleDetailScreenFleet> {
  int userID = -1;

  late SharedPreferences sharedPreferences;
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

  late APIResponse<GetFleetVehicleByIdModel> _getVehicleFleetByIdResponse;

  init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userID = (sharedPreferences.getInt('userID') ?? -1);
    print("id ${widget.users_fleet_vehicles_id.toString()}");

    Map userData = {
      "users_fleet_vehicles_id": widget.users_fleet_vehicles_id.toString(),
    };

    _getVehicleFleetByIdResponse =
        await service.getFleetVehicleByIdApi(userData);

    if (_getVehicleFleetByIdResponse.status!.toLowerCase() == 'success') {
      if (_getVehicleFleetByIdResponse.data != null) {
        showToastSuccess('getting bike details', FToast().init(context),
            seconds: 1);
      }
    } else {
      showToastError(
          'This bike is not assigned to anyone yet', FToast().init(context));
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leadingWidth: 70,
        leading: Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 20),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: backArrowWithContainer(context),
          ),
        ),
        centerTitle: true,
        title: Text(
          isLoading ? 'Loading....' : _getVehicleFleetByIdResponse.data!.model!,
          style: GoogleFonts.syne(
            fontWeight: FontWeight.w700,
            color: black,
            fontSize: 20,
          ),
        ),
      ),
      body: isLoading
          ? spinKitRotatingCircle
          : GlowingOverscrollIndicator(
              color: orange,
              axisDirection: AxisDirection.down,
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        Container(
                          height: 200.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: orange),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              'https://deliver.eigix.net/public/${_getVehicleFleetByIdResponse.data!.image}',
                              fit: BoxFit.cover,
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace) {
                                return SizedBox(
                                  child: Image.asset(
                                    'assets/images/place-holder.png',
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
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        VehicleDetailsWigdetFleet(
                          getFleetVehicleByIdModel:
                              _getVehicleFleetByIdResponse.data!,
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          'Driver\'s Requests',
                          style: GoogleFonts.syne(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: black,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        _getVehicleFleetByIdResponse.data!.vehicle_assigned_to!
                                    .users_fleet_id ==
                                -1
                            ? DriverRequestOnVehicleDetailsFleet(
                                users_fleet_vehicles_id:
                                    _getVehicleFleetByIdResponse
                                        .data!.users_fleet_vehicles_id!
                                        .toString(),
                                requestedVehicleById:
                                    _getVehicleFleetByIdResponse.data!,
                              )
                            : Text('data'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
