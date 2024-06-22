import 'package:deliver_partner/WaitingPage.dart';
import 'package:deliver_partner/widgets/apiButton.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/Colors.dart';
import '../Constants/PageLoadingKits.dart';
import '../Constants/back-arrow-with-container.dart';
import '../Constants/buttonContainer.dart';
import '../models/API_models/API_response.dart';
import '../models/API_models/GetAllAvailableVehicles.dart';
import '../models/API_models/RequestBikeModel.dart';
import '../services/API_services.dart';
import '../utilities/showToast.dart';

class RequestRideFromFleetActive extends StatefulWidget {
  final String parentID;
  final String userFleetId;
  const RequestRideFromFleetActive(
      {super.key, required this.parentID, required this.userFleetId});

  @override
  State<RequestRideFromFleetActive> createState() =>
      _RequestRideFromFleetActiveState();
}

class _RequestRideFromFleetActiveState
    extends State<RequestRideFromFleetActive> {
  ApiServices get service => GetIt.I<ApiServices>();

  int userID = -1;
  late SharedPreferences sharedPreferences;
  int? checked;
  int selectedVehicleID = -1;
  bool isPageLoading = false;

  String? parentID;

  sharePref() async {
    sharedPreferences = await SharedPreferences.getInstance();
    parentID = sharedPreferences.getString('parentID')!;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checked = -1;
    sharePref();
    setState(() {
      isPageLoading = true;
    });
    init();
  }

  int bikeID = -1;
  late APIResponse<List<GetAllAvailableVehicles>>? getAvailableBikesResponse;
  List<GetAllAvailableVehicles>? getAvailableBikesList;

  init() async {
    bikeID = -1;
    sharedPreferences = await SharedPreferences.getInstance();
    userID = (sharedPreferences.getInt('userID') ?? -1);
    print("users_fleet_id ${widget.userFleetId}");
    print("parent_id $parentID");
    Map data = {
      "users_fleet_id": widget.userFleetId,
      "parent_id": parentID,
    };

    getAvailableBikesResponse = await service.getAllAvailableVehiclesApi(data);
    print("getAvailableBikesResponse: ${getAvailableBikesResponse!.data}");
    getAvailableBikesList = [];
    if (getAvailableBikesResponse!.status!.toLowerCase() == 'success') {
      print("object");
      if (getAvailableBikesResponse!.data != null) {
        getAvailableBikesList!.addAll(getAvailableBikesResponse!.data!);
      }
      selectedVehicleID = getAvailableBikesList![0].users_fleet_vehicles_id!;
      bikeID = getAvailableBikesList![0].vehicles!.vehicles_id!;
    } else {
      // showToastError(
      //     getAvailableBikesResponse!.message, FToast().init(context));
      print('listLength: ${getAvailableBikesList!.length}');
      print('listData: ${getAvailableBikesList!.toList()}');
      setState(() {
        isPageLoading = false;
      });
    }

    setState(() {
      isPageLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leadingWidth: 70,
        leading: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 20),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: backArrowWithContainer(context),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Request Ride',
          style: GoogleFonts.syne(
            fontWeight: FontWeight.w700,
            color: black,
            fontSize: 20,
          ),
        ),
      ),
      body: isPageLoading
          ? spinKitRotatingCircle
          : getAvailableBikesResponse!.data == null
              ? const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: Text('You didn\'t sign-up with fleet code')),
                  ],
                )
              : GlowingOverscrollIndicator(
                  axisDirection: AxisDirection.down,
                  color: orange,
                  child: getAvailableBikesResponse!.data != null
                      ? SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 22.w),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 30.h,
                                ),
                                Text(
                                  'Select from available rides to request \n a ride from fleet manager.',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.syne(
                                    fontSize: 18,
                                    color: grey,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                SvgPicture.asset(
                                  'assets/images/bike.svg',
                                  width: 150.w,
                                  height: 120.h,
                                  fit: BoxFit.scaleDown,
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: getAvailableBikesList!.length,
                                  padding: EdgeInsets.zero,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          checked = index;
                                          selectedVehicleID =
                                              getAvailableBikesList![index]
                                                  .users_fleet_vehicles_id!;
                                          bikeID = getAvailableBikesList![index]
                                              .vehicles!
                                              .vehicles_id!;
                                        });
                                        print(
                                            'selected bike id: ${bikeID.toString()}');
                                        print(
                                            'id of selected vehicle: ${selectedVehicleID.toString()}');
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(bottom: 20.h),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12.w, vertical: 12.h),
                                        width: double.infinity,
                                        height: 70.h,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: lightWhite,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: 67.w,
                                                  height: 67.h,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: white,
                                                          shape:
                                                              BoxShape.circle),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    child: Image.network(
                                                      'https://cs.deliverbygfl.com/public/${getAvailableBikesList![index].image}',
                                                      fit: BoxFit.cover,
                                                      errorBuilder:
                                                          (BuildContext context,
                                                              Object exception,
                                                              StackTrace?
                                                                  stackTrace) {
                                                        return SizedBox(
                                                          child: Image.asset(
                                                            'assets/images/place-holder.png',
                                                            fit: BoxFit
                                                                .scaleDown,
                                                          ),
                                                        );
                                                      },
                                                      loadingBuilder: (BuildContext
                                                              context,
                                                          Widget child,
                                                          ImageChunkEvent?
                                                              loadingProgress) {
                                                        if (loadingProgress ==
                                                            null) {
                                                          return child;
                                                        }
                                                        return Center(
                                                          child:
                                                              CircularProgressIndicator(
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
                                                  width: 7.w,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: 120.w,
                                                      child: AutoSizeText(
                                                        '${getAvailableBikesList![index].model}',
                                                        maxLines: 2,
                                                        minFontSize: 12,
                                                        style: GoogleFonts.syne(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: black,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 4.h,
                                                    ),
                                                    Text(
                                                      '${getAvailableBikesList![index].vehicles!.name}',
                                                      style: GoogleFonts.inter(
                                                        fontSize: 14,
                                                        color: grey,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            checked == index
                                                ? SvgPicture.asset(
                                                    'assets/images/checked.svg')
                                                : SvgPicture.asset(
                                                    'assets/images/unchecked.svg'),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 20.0.h),
                                  child: isRequesting
                                      ? apiButton(context)
                                      : GestureDetector(
                                          onTap: () {
                                            requestBike(context);
                                          },
                                          child:
                                              buttonContainer(context, 'NEXT'),
                                        ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'No data found',
                              style: GoogleFonts.syne(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: orange,
                              ),
                            ),
                            SvgPicture.asset(
                                'assets/images/no-data-found-2.svg'),
                          ],
                        ),
                ),
    );
  }

  bool isRequesting = false;
  late APIResponse<RequestBikeModel>? requestBikeResponse;

  requestBike(BuildContext context) async {
    if (bikeID == -1) {
      showToastError('Please select a bike to proceed', FToast().init(context));
    } else {
      setState(() {
        isRequesting = true;
      });
      Map requestData = {
        "users_fleet_id": widget.userFleetId,
        "vehicles_id": bikeID.toString(),
        "users_fleet_vehicles_id": selectedVehicleID.toString(),
      };
      requestBikeResponse = await service.requestBikeAPI(requestData);
      if (requestBikeResponse!.status!.toLowerCase() == 'success') {
        showToastSuccess('Request of this vehicle has been sent successfully',
            FToast().init(context));
        gotoNextScreen(context);
      } else {
        showToastError(requestBikeResponse!.message, FToast().init(context));
        print(
            'object request error:  ${requestBikeResponse!.status!}    ${requestBikeResponse!.message}');
      }
    }
    setState(() {
      isRequesting = false;
    });
  }

  gotoNextScreen(BuildContext context) async {
    await sharedPreferences.setInt('bikeID', bikeID);
    await sharedPreferences.setInt('selectedVehicleID', selectedVehicleID);
    // showToastSuccess(requestBikeResponse!.status, FToast().init(context));
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const WaitingPage(userType: 'Rider'),
      ),
    );
  }
}
