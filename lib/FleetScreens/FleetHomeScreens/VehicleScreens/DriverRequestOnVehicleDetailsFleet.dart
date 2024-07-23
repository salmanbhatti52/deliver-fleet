import 'package:deliver_partner/Constants/Colors.dart';
import 'package:deliver_partner/Constants/PageLoadingKits.dart';
import 'package:deliver_partner/models/GetFleetVehicleByIdModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/API_models/API_response.dart';
import '../../../models/APIModelsFleet/GetFleetVehicleRequestByIdModel.dart';
import '../../../services/API_services.dart';
import '../../../utilities/showToast.dart';
import 'DriverDetailsFleet/RequestedRiderDetailsFleet.dart';

class DriverRequestOnVehicleDetailsFleet extends StatefulWidget {
  final String users_fleet_vehicles_id;
  final GetFleetVehicleByIdModel requestedVehicleById;
  const DriverRequestOnVehicleDetailsFleet(
      {super.key,
      required this.users_fleet_vehicles_id,
      required this.requestedVehicleById});

  @override
  State<DriverRequestOnVehicleDetailsFleet> createState() =>
      _DriverRequestOnVehicleDetailsFleetState();
}

class _DriverRequestOnVehicleDetailsFleetState
    extends State<DriverRequestOnVehicleDetailsFleet> {
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

  late APIResponse<List<GetFleetVehicleRequestByIdModel>>
      _getAllVehicleFleetRequestResponse;
  List<GetFleetVehicleRequestByIdModel>? _getAllVehicleFleetRequestList;

  init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userID = (sharedPreferences.getInt('userID') ?? -1);
    print("userID $userID");

    Map userData = {
      "users_fleet_vehicles_id": widget.users_fleet_vehicles_id,
    };

    _getAllVehicleFleetRequestResponse =
        await service.getAllFleetVehicleRequestByIdApi(userData);

    _getAllVehicleFleetRequestList = [];
    if (_getAllVehicleFleetRequestResponse.status!.toLowerCase() == 'success') {
      if (_getAllVehicleFleetRequestResponse.data != null) {
        // for (int i = 0; i <= _bikeCategoryResponse.data!.length; i++) {
        //   print('object category  ' +
        //       _bikeCategoryResponse.data![i].category.toString());
        //   getBikeCategoryModel!.add(_bikeCategoryResponse.data![i].category!);
        // }
        _getAllVehicleFleetRequestList!
            .addAll(_getAllVehicleFleetRequestResponse.data!);
      }
    } else {
      showToastError(
          'No requests for this vehicle yet', FToast().init(context));
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? spinKitRotatingCircle
        : _getAllVehicleFleetRequestResponse.status!.toLowerCase() != 'error'
            ? ListView.builder(
                itemCount: _getAllVehicleFleetRequestList!.length,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final item = _getAllVehicleFleetRequestList![index];
                  return GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => RequestedRiderDetailsFleet(
                          getFleetVehicleRequestByIdModel:
                              _getAllVehicleFleetRequestList![index],
                          requestVehicleById: widget.requestedVehicleById,
                        ),
                      ),
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      width: double.infinity,
                      height: 75.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: mildGrey,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 50.w,
                                height: 50.h,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: orange,
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    'https://deliverbygfl.com/public/${item.users_fleet!.profile_pic}',
                                    fit: BoxFit.cover,
                                    errorBuilder: (BuildContext context,
                                        Object exception,
                                        StackTrace? stackTrace) {
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
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 180.w,
                                        child: Text(
                                          '${item.users_fleet!.first_name} ${item.users_fleet!.last_name}',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: GoogleFonts.syne(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: black,
                                          ).copyWith(
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 40.w,
                                        height: 15.h,
                                        decoration: BoxDecoration(
                                          color: orange,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            const Icon(
                                              Icons.star_rate_rounded,
                                              color: Colors.yellow,
                                              size: 12,
                                            ),
                                            Text(
                                              '${item.users_fleet!.bookings_ratings}',
                                              style: GoogleFonts.inter(
                                                fontSize: 12,
                                                color: white,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '${item.users_fleet!.wallet_amount}',
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: black,
                            size: 14,
                          ),
                        ],
                      ),
                    ),
                  );
                })
            : Center(
                child: Text(
                  _getAllVehicleFleetRequestResponse.message!,
                  style: GoogleFonts.syne(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: orange,
                  ),
                ),
              );
  }
}
