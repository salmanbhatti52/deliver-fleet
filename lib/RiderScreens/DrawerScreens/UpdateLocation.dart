import 'package:deliver_partner/Constants/PageLoadingKits.dart';
import 'package:deliver_partner/Constants/buttonContainer.dart';
import 'package:deliver_partner/widgets/apiButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Constants/Colors.dart';
import '../../Constants/back-arrow-with-container.dart';
import '../../models/API models/API response.dart';
import '../../models/API models/LogInModel.dart';
import '../../services/API_services.dart';
import '../../utilities/showToast.dart';

class UpdateLocation extends StatefulWidget {
  const UpdateLocation({super.key});

  @override
  State<UpdateLocation> createState() => _UpdateLocationState();
}

class _UpdateLocationState extends State<UpdateLocation> {
  ApiServices get service => GetIt.I<ApiServices>();

  int userID = -1;
  late SharedPreferences sharedPreferences;

  bool isPageLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      isPageLoading = true;
    });
    init();
  }

  late APIResponse<LogInModel>? getUserProfileResponse;

  init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userID = (sharedPreferences.getInt('userID') ?? -1);

    Map data = {
      "users_fleet_id": userID.toString(),
    };

    getUserProfileResponse = await service.getUserProfileAPI(data);

    if (getUserProfileResponse!.status!.toLowerCase() == 'success') {
      if (getUserProfileResponse!.data != null) {}
    } else {
      showToastError(getUserProfileResponse!.message, FToast().init(context));
    }

    setState(() {
      isPageLoading = false;
    });
  }

  /// Location permission methods for longitude and latitude:

  locationPermission() async {
    PermissionStatus status = await Permission.location.request();

    if (status.isGranted) {
      // Permission granted, navigate to the next screen
    } else if (status.isDenied || status.isPermanentlyDenied) {
      // Permission denied, show a message and provide information
      showLocationPermissionSnackBar();
    }
  }

  void showLocationPermissionSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        width: MediaQuery.of(context).size.width,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        duration: const Duration(seconds: 5),
        content: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              stops: [0.1, 1.5],
              colors: [
                orange,
                lightOrange,
              ],
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 2,
                spreadRadius: 2,
                offset: const Offset(0, 3),
                color: black.withOpacity(0.2),
              ),
            ],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 2,
              color: const Color(0xFF707070).withOpacity(0.5),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Location permission is required\nto continue.',
                style: TextStyle(
                  color: white,
                  fontSize: 12,
                  fontFamily: 'Syne-Regular',
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              GestureDetector(
                onTap: () {
                  openAppSettings();
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.04,
                  width: MediaQuery.of(context).size.width * 0.33,
                  decoration: BoxDecoration(
                    color: const Color(0xFF36454F),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      'Grant Permission',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: white,
                        fontSize: 12,
                        fontFamily: 'Syne-Medium',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future<bool> _handleLocationPermission() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //     //     content: Text(
  //     //         )));
  //     showToastError(
  //         'Location services are disabled. Please enable the services',
  //         FToast().init(context),
  //         seconds: 4);
  //     return false;
  //   }
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       // ScaffoldMessenger.of(context).showSnackBar(
  //       //     const SnackBar(content: Text('Location permissions are denied')));
  //       showToastError(
  //           'Location permissions are denied', FToast().init(context),
  //           seconds: 4);
  //       return false;
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //     //     content: Text(
  //     //         )));
  //     showToastError(
  //         'Location permissions are permanently denied, Enable it from app permission',
  //         FToast().init(context),
  //         seconds: 4);
  //     return false;
  //   }
  //   return true;
  // }

  // String? _currentAddress;

  var hasPermission = false;
  Position? _currentPosition;

  Future<void> _getCurrentPosition() async {
    hasPermission = await locationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  /// Location permission methods for longitude and latitude:

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
          'Update Location',
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
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 40.h,
                    ),
                    Text(
                      'Hi there! ${getUserProfileResponse!.data!.first_name} ${getUserProfileResponse!.data!.last_name}',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.syne(
                        fontWeight: FontWeight.w700,
                        color: orange,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      'Update your location to get nearest requests',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.syne(
                        fontWeight: FontWeight.w700,
                        color: grey,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Lottie.asset(
                      'assets/images/animation_lmoizymy.json',
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: isUpdatingLocation
                          ? apiButton(context)
                          : GestureDetector(
                              onTap: () => hasPermission
                                  ? updateLocationMethod(context)
                                  : _getCurrentPosition(),
                              child:
                                  buttonContainer(context, 'Update Location'),
                            ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  bool isUpdatingLocation = false;
  APIResponse<LogInModel>? updateLocationResponse;

  updateLocationMethod(BuildContext context) async {
    setState(() {
      isUpdatingLocation = true;
    });
    Map updateLocationData = {
      "users_fleet_id": userID.toString(),
      "latitude": _currentPosition!.latitude.toString(),
      "longitude": _currentPosition!.longitude.toString(),
    };
    updateLocationResponse =
        await service.updateLocationOneTimeAPI(updateLocationData);
    print('object update loaction map:   $updateLocationData');
    if (updateLocationResponse!.status!.toLowerCase() == 'success') {
      if (updateLocationResponse!.data != null) {
        print(
            'object update loaction:   ${updateLocationResponse!.data!.latitude}    ${updateLocationResponse!.data!.longitude}');
        showToastSuccess(
            'location is updated successfully', FToast().init(context),
            seconds: 1);
      }
    } else {
      showToastError('something went wrong', FToast().init(context),
          seconds: 1);
    }
    setState(() {
      isUpdatingLocation = false;
    });
  }
}
