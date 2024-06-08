import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:deliver_partner/Constants/PageLoadingKits.dart';
import 'package:deliver_partner/Constants/buttonContainer.dart';
import 'package:deliver_partner/widgets/apiButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Constants/Colors.dart';
import '../../Constants/back-arrow-with-container.dart';
import '../../models/API_models/API_response.dart';
import '../../models/API_models/LogInModel.dart';
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
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //     content: Text(
      //         )));
      showToastError(
          'Location services are disabled. Please enable the services',
          FToast().init(context),
          seconds: 4);
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(content: Text('Location permissions are denied')));
        showToastError(
            'Location permissions are denied', FToast().init(context),
            seconds: 4);
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //     content: Text(
      //         )));
      showToastError(
          'Location permissions are permanently denied, Enable it from app permission',
          FToast().init(context),
          seconds: 4);
      return false;
    }
    return true;
  }

  String? currentLat;
  String? currentLng;
  LatLng? currentLocation;
  LatLng? selectedLocation;
  LatLng? selectedAddressLocation;
  Future<void> getCurrentLocation() async {
    hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    final Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
      timeLimit: const Duration(seconds: 5),
      forceAndroidLocationManager: true,
    );

    final List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    if (placemarks.isNotEmpty) {
      final Placemark currentPlace = placemarks.first;
      final String currentAddress =
          "${currentPlace.name}, ${currentPlace.locality}, ${currentPlace.country}";
      final String postalCode = currentPlace.postalCode!;
      final String city = currentPlace.locality!;
      final String state = currentPlace.administrativeArea!;
      final String country = currentPlace.country!;
      double latitude = double.parse(currentLat!);
      double longitude = double.parse(currentLng!);
      getPostalCode(latitude, longitude);
      setState(() {
        currentLocation = LatLng(position.latitude, position.longitude);
        selectedLocation = null; // Clear selected location
        selectedAddressLocation = null; // Clear address location
        currentLat = position.latitude.toString();
        currentLng = position.longitude.toString();
        debugPrint("currentLat: $currentLat");
        debugPrint("currentLng: $currentLng");
        debugPrint("currentPickupLocation: $currentAddress");
        debugPrint("Postal Code: $postalCode");
        debugPrint("City: $city");
        debugPrint("State: $state");
        debugPrint("Country: $country");
      });
    }
  }

  // String? _currentAddress;
  var hasPermission = false;
  Position? _currentPosition;
  Future<void> _getCurrentPosition() async {
    hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> handleLocationUpdate() async {
    if (hasPermission) {
      await updateLocationMethod(context);
    } else {
      await getCurrentLocation();
    }
  }

  Future<String> getPostalCode(double lat, double lng) async {
    final response = await http.get(
      Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=AIzaSyAk-CA4yYf-txNZvvwmCshykjpLiASEkcw',
      ),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Data received from API: $data'); // Print the entire data

      final results = data['results'] as List;
      if (results.isNotEmpty) {
        print('First result: ${results[0]}'); // Print the first result

        final components = results[0]['address_components'] as List;
        final postalCodeComponent = components.firstWhere(
          (c) => c['types'].contains('postal_code'),
          orElse: () => null,
        );
        if (postalCodeComponent != null) {
          print(
              'Postal code component: $postalCodeComponent'); // Print the postal code component
          return postalCodeComponent['long_name'];
        }
      }
    }

    return "";
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
                              onTap: () async {
                                await handleLocationUpdate();
                              },
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
    await getCurrentLocation();
    Map updateLocationData = {
      "users_fleet_id": userID.toString(),
      "latitude": currentLat.toString(),
      "longitude": currentLng.toString(),
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
