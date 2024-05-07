import 'package:deliver_partner/Constants/Colors.dart';
import 'package:deliver_partner/Constants/PageLoadingKits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Constants/back-arrow-with-container.dart';
import '../../../models/API_models/API_response.dart';
import '../../../models/API_models/GetAllAvailableVehicles.dart';
import '../../../services/API_services.dart';
import '../../../utilities/showToast.dart';
import 'RiderBikeDetailsWidget.dart';
import 'ScooterOwnerDetailsWidget.dart';

class ScooterDetails extends StatefulWidget {
  const ScooterDetails({super.key});

  @override
  State<ScooterDetails> createState() => _ScooterDetailsState();
}

class _ScooterDetailsState extends State<ScooterDetails> {
  ApiServices get service => GetIt.I<ApiServices>();

  int userID = -1;
  int bikeID = -1;
  late SharedPreferences sharedPreferences;
  bool isPageLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
    isPageLoading = true;
  }

  APIResponse<GetAllAvailableVehicles>? vehicleDetailsResponse;

  init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userID = (sharedPreferences.getInt('userID') ?? -1);

    Map data = {
      "users_fleet_id": userID.toString(),
      "user_type": "Rider",
    };

    vehicleDetailsResponse = await service.getVehicleDetailsForRiderAPI(data);

    if (vehicleDetailsResponse!.status!.toLowerCase() == 'success') {
      if (vehicleDetailsResponse!.data != null) {
        showToastSuccess('getting vehicle details', FToast().init(context),
            seconds: 1);
      }
    } else {
      showToastError(vehicleDetailsResponse!.message!, FToast().init(context));
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
        centerTitle: true,
        title: Text(
          'Vehicle Details',
          style: GoogleFonts.syne(
            fontWeight: FontWeight.w700,
            color: black,
            fontSize: 20,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 20),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: backArrowWithContainer(context),
          ),
        ),
      ),
      body: isPageLoading
          ? spinKitRotatingCircle
          : GlowingOverscrollIndicator(
              axisDirection: AxisDirection.down,
              color: orange,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30.h,
                      ),
                      Container(
                        width: double.infinity,
                        height: 250.h,
                        decoration: BoxDecoration(
                          gradient: gradient,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            'https://cs.deliverbygfl.com/public/${vehicleDetailsResponse!.data!.image}',
                            fit: BoxFit.cover,
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace? stackTrace) {
                              return SizedBox(
                                  child: Image.asset(
                                'assets/images/place-holder.png',
                                fit: BoxFit.scaleDown,
                              ));
                            },
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                  color: orange,
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      // vehicleDetailsResponse?.data?.users_fleet?.user_type
                      //             ?.toLowerCase() ==
                      //         'fleet'
                      //     ?
                      // Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           SizedBox(
                      //             height: 10.h,
                      //           ),
                      //           Text(
                      //             'Vehicle Service Details',
                      //             style: GoogleFonts.syne(
                      //               fontSize: 14,
                      //               fontWeight: FontWeight.w700,
                      //               color: orange,
                      //             ),
                      //           ),
                      //           SizedBox(
                      //             height: 10.h,
                      //           ),
                      //           Row(
                      //             mainAxisAlignment:
                      //                 MainAxisAlignment.spaceBetween,
                      //             children: [
                      //               Text(
                      //                 'Last Vehicle Service Date',
                      //                 style: GoogleFonts.syne(
                      //                   fontSize: 16,
                      //                   fontWeight: FontWeight.w400,
                      //                   color: black,
                      //                 ),
                      //               ),
                      //               Text(
                      //                 '12 May 202214',
                      //                 style: GoogleFonts.inter(
                      //                   fontSize: 14,
                      //                   fontWeight: FontWeight.w400,
                      //                   color: black,
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //           SizedBox(
                      //             height: 10.h,
                      //           ),
                      //           Row(
                      //             mainAxisAlignment:
                      //                 MainAxisAlignment.spaceBetween,
                      //             children: [
                      //               Text(
                      //                 'Vehicle Service Station',
                      //                 style: GoogleFonts.syne(
                      //                   fontSize: 16,
                      //                   fontWeight: FontWeight.w400,
                      //                   color: black,
                      //                 ),
                      //               ),
                      //               Text(
                      //                 'abc xyz, Nigeria',
                      //                 style: GoogleFonts.inter(
                      //                   fontSize: 14,
                      //                   fontWeight: FontWeight.w400,
                      //                   color: black,
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         ],
                      //       )
                      //     : SizedBox(),
                      SizedBox(
                        height: 20.h,
                      ),
                      RiderBikeDetailsWidget(
                        model: vehicleDetailsResponse!.data!.model ?? 'N/A',
                        color: vehicleDetailsResponse!.data!.color ?? 'N/A',
                        chassisNumber: vehicleDetailsResponse!
                                .data!.vehicle_identification_no ??
                            'N/A',
                        yearOfManufacture:
                            vehicleDetailsResponse!.data!.manufacture_year ??
                                'N/A',
                        bikeInsuranceDate: vehicleDetailsResponse!
                                .data!.vehicle_insurance_expiry_date ??
                            'N/A',
                        licenseExpiryDate: vehicleDetailsResponse!
                                .data!.vehicle_license_expiry_date ??
                            'N/A',
                        status: vehicleDetailsResponse!.data!.status ?? 'N/A',
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      ScooterOwnerDetailsWidget(
                        name:
                            "${vehicleDetailsResponse?.data?.users_fleet?.first_name ?? 'N/A'} ${vehicleDetailsResponse?.data?.users_fleet?.last_name ?? 'N/A'}",
                        contactNumber:
                            vehicleDetailsResponse?.data?.users_fleet?.phone ??
                                'N/A',
                        address: vehicleDetailsResponse
                                ?.data?.users_fleet?.address ??
                            'N/A',
                        userTypeOfVehicleOwner: vehicleDetailsResponse
                                ?.data?.users_fleet?.user_type ??
                            'N/A',
                        statusOfVehicleOwner:
                            vehicleDetailsResponse?.data?.users_fleet?.status ??
                                'N/A',
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
