import 'package:deliver_partner/Constants/PageLoadingKits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Constants/Colors.dart';
import '../../../models/API models/API response.dart';
import '../../../models/APIModelsFleet/GetAllVehiclesFleetModel.dart';
import '../../../services/API_services.dart';
import 'VehicleWidget.dart';

class VehicleScreenFleet extends StatefulWidget {
  const VehicleScreenFleet({super.key});

  @override
  State<VehicleScreenFleet> createState() => _VehicleScreenFleetState();
}

class _VehicleScreenFleetState extends State<VehicleScreenFleet> {
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

  late APIResponse<List<GetAllVehiclesFleetModel>> _getAllVehicleFleetResponse;
  List<GetAllVehiclesFleetModel>? _getAllVehicleFleetList;

  init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userID = (sharedPreferences.getInt('userID') ?? -1);
    print("UserID $userID");

    Map userData = {
      "users_fleet_id": userID.toString(),
    };

    _getAllVehicleFleetResponse =
        await service.getAllVehiclesFleetApi(userData);

    _getAllVehicleFleetList = [];
    if (_getAllVehicleFleetResponse.status!.toLowerCase() == 'success') {
      if (_getAllVehicleFleetResponse.data != null) {
        _getAllVehicleFleetList!.addAll(_getAllVehicleFleetResponse.data!);
      }
    }
    // else {
    //   showToastError('something went wrong!', FToast().init(context));
    // }

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? spinKitRotatingCircle
        : RefreshIndicator(
            color: orange,
            onRefresh: refreshGetAllVehicles,
            child: GlowingOverscrollIndicator(
              color: orange,
              axisDirection: AxisDirection.down,
              child:
                  _getAllVehicleFleetResponse.status!.toLowerCase() == 'success'
                      ? ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 22, vertical: 30),
                          itemCount: _getAllVehicleFleetList!.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return VehicleWidget(
                              getAllVehiclesFleetModel:
                                  _getAllVehicleFleetList![index],
                            );
                          },
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  'No vehicle found. \nAdd one to assign to any rider.',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.syne(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: orange,
                                  ),
                                ),
                              ),
                              SvgPicture.asset(
                                'assets/images/no-data-found-1.svg',
                                height: 150.h,
                                width: 150.w,
                                fit: BoxFit.scaleDown,
                              ),
                            ],
                          ),
                        ),
            ),
          );
  }

  Future<void> refreshGetAllVehicles() async {
    // print('refresh indicator called');
    init();
  }
}
