// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:deliver_partner/Constants/buttonContainer.dart';
import 'package:deliver_partner/Constants/drawer_container.dart';
import 'package:deliver_partner/RiderScreens/AfterLogInScreens/HomeScreens/modalBottomSheetOnHome.dart';
import 'package:deliver_partner/RiderScreens/BottomNavBar.dart';
import 'package:deliver_partner/widgets/DrawerWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'
    show SystemChrome, SystemUiMode, rootBundle;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Constants/Colors.dart';
import '../../../Constants/PageLoadingKits.dart';
import '../../../location_update_global.dart';
import '../../../models/API_models/API_response.dart';
import '../../../models/API_models/GetAllSystemDataModel.dart';
import '../../../models/API_models/LogInModel.dart';
import '../../../models/API_models/ShowBookingsModel.dart';
import '../../../services/API_services.dart';
import '../../../utilities/showToast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ApiServices get service => GetIt.I<ApiServices>();

  int userID = -1;
  String? userLatitude = '30.2398331';
  String? userLongitude = '71.4854126';
  late SharedPreferences sharedPreferences;
  bool isHomeLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      isHomeLoading = true;
    });
    init();

    init2();
    // loadCustomMarker();
  }

  late APIResponse<LogInModel>? getUserProfileResponse;
  bool isLoading = false;
  init2() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userID = (sharedPreferences.getInt('userID') ?? -1);
    Map data = {
      "users_fleet_id": userID.toString(),
    };
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }

    getUserProfileResponse = await service.getUserProfileAPI(data);

    if (getUserProfileResponse!.status!.toLowerCase() == 'success') {
      if (getUserProfileResponse!.data != null) {
        // showToastSuccess('Loading user data', FToast().init(context));
        print(
            "getUserProfileResponse ${getUserProfileResponse!.data!.profile_pic}");
        if (getUserProfileResponse!.data != null) {
          await sharedPreferences.setString(
              'userProfilePic', getUserProfileResponse!.data!.profile_pic!);
          await sharedPreferences.setString(
              'parentId', getUserProfileResponse!.data!.parent_id.toString());
        }
      }
    } else {
      print("${getUserProfileResponse!.message}");
      // showToastError(getUserProfileResponse!.message, FToast().init(context));
    }

    if (mounted) {
      setState(() {
        isLoading = false;
        isHomeLoading = false;
        // gettingCategory = false;
      });
    }
  }

  late APIResponse<List<ShowBookingsModel>> getAllClientRequestsResponse;

  List<ShowBookingsModel>? getAllClientRequestsList;

  late APIResponse<List<GetAllSystemDataModel>> _getAllSystemDataResponse;
  List<GetAllSystemDataModel>? _getSystemDataList;

  String currency = '';

  init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userID = (sharedPreferences.getInt('userID') ?? -1);
    userLatitude = (sharedPreferences.getString('userLatitude') ?? '');
    userLongitude = (sharedPreferences.getString('userLongitude') ?? '');
    getAllClientRequestsList = [];
    final locationService = LocationService();
    await locationService.init();
    print("userId $userID");
    Map data = {
      "users_fleet_id": userID.toString(),
    };
    getAllClientRequestsResponse = await service.getAllClientRequestsAPI(data);

    if (getAllClientRequestsResponse.status!.toLowerCase() == 'success') {
      if (getAllClientRequestsResponse.data != null) {
        // await audioPlayer.play(AssetSource('tune.mp3'));
        showToastSuccess('Getting all ride requests', FToast().init(context),
            seconds: 1);
        getAllClientRequestsList!.addAll(getAllClientRequestsResponse.data!);
        for (int i = 0; i < getAllClientRequestsList!.length; i++) {
          print(
              'object getting requests: ${getAllClientRequestsList![i].bookings!.bookings_destinations![0].pickup_longitude}   ${getAllClientRequestsList![i].bookings!.bookings_destinations![0].pickup_latitude}');
          print(
              "name: ${getAllClientRequestsList![i].bookings!.users_customers!.first_name}");
          print("fleet id: ${getAllClientRequestsList![i].bookings_fleet_id}");
        }
      }
    } else {
      print(
          'object error getting requests  ${getAllClientRequestsResponse.status!} ${getAllClientRequestsResponse.message!}');
      showToastError('No ride requests yet', FToast().init(context));
    }

    _getAllSystemDataResponse = await service.getALlSystemDataAPI();
    _getSystemDataList = [];

    if (_getAllSystemDataResponse.status!.toLowerCase() == 'success') {
      await init2();
      if (_getAllSystemDataResponse.data != null) {
        _getSystemDataList!.addAll(_getAllSystemDataResponse.data!);
        for (GetAllSystemDataModel model in _getSystemDataList!) {
          if (model.type == 'system_currency') {
            if (mounted) {
              setState(() {
                currency = model.description!;
              });
            }
          }
        }
      }
    }

    addCustomIcon();
    // getPolyPoints();

    if (mounted) {
      setState(() {
        isHomeLoading = false;
      });
    }
  }

  /// Add custom icon method:
  void addCustomIcon() async {
    customMarkerIcon = await getBitmapDescriptorFromAssetBytes(
        "assets/images/custom-icon.png", 300);
    if (mounted) {
      setState(() {});
    }
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<BitmapDescriptor> getBitmapDescriptorFromAssetBytes(
      String path, int width) async {
    final Uint8List imageData = await getBytesFromAsset(path, width);
    return BitmapDescriptor.fromBytes(imageData);
  }

  BitmapDescriptor? customMarkerIcon;

  /// Add custom icon method:

  getData(tapped, String name, address, profilePicture, totalCharges,
      BookingModel? customersModel,
      {List<BookingDestinations>? bookingDestinations}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: GestureDetector(
              onTap: () {
                // Navigator.of(context).pop();
                // audioPlayer.stop();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const BottomNavBar(),
                    ),
                        (Route<dynamic> route) => false);
                showModalBottomSheet(
                    backgroundColor: white,
                    isDismissible: false,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => ModalBottomSheetOnHome(
                          userID: userID.toString(),
                          bookingDestinationsList: bookingDestinations,
                          customersModel: customersModel!,
                        ));
              },
              child: Container(
                width: 80.w,
                height: 160.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  color: white,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 50.w,
                                height: 50.h,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: white,
                                    border: Border.all(color: orange)),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(45),
                                    child: Image.network(
                                      'https://deliverbygfl.com/public/$profilePicture',
                                      fit: BoxFit.cover,
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                        return SizedBox(
                                            child: Image.asset(
                                          'assets/images/place-holder.png',
                                          fit: BoxFit.scaleDown,
                                        ));
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
                                    )),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 120.w,
                                    child: Text(
                                      name,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.syne(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: black,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 8.w,
                                        height: 8.h,
                                        child: SvgPicture.asset(
                                          'assets/images/location.svg',
                                          fit: BoxFit.scaleDown,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      SizedBox(
                                        width: 120.w,
                                        child: Text(
                                          address,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.inter(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Expanded(
                            child: Text(
                              '$currency $totalCharges',
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: orange,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                          width: 150.w,
                          child: buttonContainer(context, 'SEE DETAILS')),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  final Completer<GoogleMapController> googleMapController = Completer();

  void _onMapCreated(GoogleMapController controller) {
    googleMapController.complete(controller);
  }

  _onCameraMove(CameraPosition cameraPosition, LatLng position) {
    CameraPosition(target: position = cameraPosition.target, zoom: 15.5);
  }

  final Set<Marker> markers = {};

  Set<Marker> getMarkers() {
    //markers to place on map:
    setState(() {
      for (int i = 0; i < getAllClientRequestsList!.length; i++) {
        markers.add(
          Marker(
            position: LatLng(
                double.parse(getAllClientRequestsList![i]
                    .bookings!
                    .bookings_destinations![0]
                    .pickup_latitude!),
                double.parse(getAllClientRequestsList![i]
                    .bookings!
                    .bookings_destinations![0]
                    .pickup_longitude!)),
            onTap: () {
              getData(
                LatLng(
                    double.parse(getAllClientRequestsList![i]
                        .bookings!
                        .bookings_destinations![0]
                        .pickup_latitude!),
                    double.parse(getAllClientRequestsList![i]
                        .bookings!
                        .bookings_destinations![0]
                        .pickup_longitude!)),
                getAllClientRequestsList![i]
                    .bookings!
                    .users_customers!
                    .first_name!,
                getAllClientRequestsList![i]
                    .bookings!
                    .bookings_destinations![0]
                    .pickup_address,
                getAllClientRequestsList![i]
                    .bookings!
                    .users_customers!
                    .profile_pic!,
                getAllClientRequestsList![i].bookings!.total_charges,
                getAllClientRequestsList![i].bookings,
                bookingDestinations: getAllClientRequestsList![i]
                    .bookings!
                    .bookings_destinations,
              );
              setState(() {});
            },
            icon: customMarkerIcon ?? BitmapDescriptor.defaultMarker,
            draggable: true,
            infoWindow: InfoWindow(
              title:
                  '${getAllClientRequestsList![i].bookings!.users_customers!.first_name!} ${getAllClientRequestsList![i].bookings!.users_customers!.last_name!}',
            ),
            markerId: MarkerId(getAllClientRequestsList![i]
                .bookings!
                .users_customers!
                .users_customers_id!
                .toString()),
          ),
        );
      }
      // if (newCustomMarkerIcon != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('currentLocation'),
          position:
              LatLng(double.parse(userLatitude!), double.parse(userLongitude!)),
          // infoWindow:
          // const InfoWindow(title: 'Your Current Location'),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
      // }
    });

    return markers;
  }

  late GoogleMapController _controller;

  List<LatLng> polylineCoordinates = [];
  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      ' AIzaSyAk-CA4yYf-txNZvvwmCshykjpLiASEkcw', // Your Google Map Key
      const PointLatLng(30.2399443, 71.4853788),
      const PointLatLng(31.410483, 72.484598),
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        );
      }
      setState(() {});
    }
  }

  bool isContainerVisible = true;
  int currentLocationIndex = 0;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isLargeScreen = screenSize.width > 600;
    LatLng initialPosition =
        LatLng(double.parse(userLatitude!), double.parse(userLongitude!));
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const DrawerWidget(),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              child: const Icon(
                Icons.refresh,
                size: 30,
                color: Colors.black,
              ),
              onTap: () async {
                // await init();
                isHomeLoading = true;

                init();

                init2();
              },
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 70,
        leading: Builder(builder: (context) {
          return Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 20),
            child: GestureDetector(
                onTap: () => Scaffold.of(context).openDrawer(),
                child: const Icon(
                  Icons.menu,
                  color: Colors.black,
                )),
          );
        }),
        centerTitle: true,
        title: GestureDetector(
          onTap: () {
            //             sharedPreferences = await SharedPreferences.getInstance();
            //             userID = (sharedPreferences.getInt('userID') ?? -1);
            //             // var status = await OneSignal.shared.getDeviceState();
            //             // // print("OneSignal Device ID: ${status!.deviceId}");
            //             // String? tokenId = status!.userId;
            //             // print("OneSignal User ID: $tokenId");
            //             var ID4 = OneSignal.User.pushSubscription.id;
            //             print("$ID4");
            //             final response = await sendNotification(
            //                 [ID4!],
            //                 "You got notification From Deliver Partner",
            //                 "Deliver Partner");
            //             print(response.body);
            //             print(response.persistentConnection);

            //             // var ID2 = OneSignal.User.pushSubscription.optedIn;
            //             // var ID3 = OneSignal.User.pushSubscription.token;
            //             // var externalId = await OneSignal.User.getExternalId();
            //             // var tags = await OneSignal.User.getTags();
            //             // print("tags: $tags");
            //             // print("Setting external user ID $userID");
            //             // if (userID == null) return;
            //             // OneSignal.loginWithJWT(userID.toString(), "$ID3");
            //             // OneSignal.User.addAlias("PartnerID", "$userID");
            //             // void observePushSubscription() {
            //             //   OneSignal.User.pushSubscription
            //             //       .addObserver((stateChanges) {
            //             //     print(
            //             //         'Subscription Status: ${stateChanges.current.optedIn}');
            //             //     print(OneSignal.User.pushSubscription.id);
            //             //     print(OneSignal.User.pushSubscription.token);
            //             //     print(stateChanges.current.jsonRepresentation());
            //             //   });
            //             // }

            //             // var url =
            //             //     Uri.parse('https://onesignal.com/api/v1/notifications');
            //             // var response = await http.post(
            //             //   url,
            //             //   headers: {
            //             //     'Content-Type': 'application/json; charset=utf-8',
            //             //     'Authorization':
            //             //         'Basic OGMxMWE2ZDgtNmRiNi00Y2VjLTk5MTMtZmE3Y2Q3YTQ3MDE2',
            //             //   },
            //             //   body: jsonEncode({
            //             //     'app_id': appID,
            //             //     'contents': {'en': 'English Message'},
            //             //     'headings': {'en': 'English Title'},
            //             //     'include_player_ids': [
            //             //       '96079b55-52c0-4797-bb43-86b8c413af5e'
            //             //     ], // Add the user's OneSignal ID here
            //             //   }),
            //             // );

            //             // if (response.statusCode == 200) {
            //             //   print("Notification sent successfully");
            //             //   print("Notification Body ${response.body}");
            //             // } else {
            //             //   print("Failed to send notification: ${response.body}");
            //             // }
            //             // print("ID: $ID");
            //             // print("ID2: $ID2");
            //             // print("ID3: $ID3");
            //             // observePushSubscription();
            //             // print('External ID: $externalId');
            //             // print("Tapping");
            //             // OneSignal.User.pushSubscription.addObserver((state) {
            //             //   print('Subscription Status: ${state.current.optedIn}');
            //             //   print(OneSignal.User.pushSubscription.id);
            //             //   print(OneSignal.User.pushSubscription.token);
            //             //   print(state.current.jsonRepresentation());
            //             // });

            //             // Navigator.push(
            //             //   context,
            //             //   MaterialPageRoute(builder: (context) => ONE()),
            //             // );
          },
          child: Text(
            'Home',
            style: GoogleFonts.syne(
              fontSize: isLargeScreen ? 32 : 22,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: isHomeLoading
          ? spinKitRotatingCircle
          : Stack(
              alignment: Alignment.bottomRight,
              children: [
                Stack(
                  children: [
                    GoogleMap(
                      // onMapCreated: _onMapCreated,
                      onMapCreated: (GoogleMapController controller) {
                        _controller = controller;
                      },
                      onCameraMove: _onCameraMove(
                          CameraPosition(
                              target: LatLng(double.parse(userLatitude!),
                                  double.parse(userLongitude!))),
                          LatLng(double.parse(userLatitude!),
                              double.parse(userLongitude!))),
                      initialCameraPosition: CameraPosition(
                        target: initialPosition,
                        zoom: 12.5,
                      ),
                      mapType: MapType.normal,
                      polylines: {
                        Polyline(
                          polylineId: const PolylineId("route"),
                          points: polylineCoordinates,
                          color: orange,
                          geodesic: true,
                          patterns: [
                            PatternItem.dash(40),
                            PatternItem.gap(10),
                          ],
                          width: 6,
                        ),
                      },
                      compassEnabled: true,
                      markers: getMarkers(),
                      scrollGesturesEnabled: true,
                      buildingsEnabled: true,
                    ),
                  ],
                ),
                getAllClientRequestsList!.isNotEmpty && isContainerVisible
                    ? Visibility(
                        visible: isContainerVisible,
                        child: Positioned(
                            top: 15,
                            right: 20,
                            left: 20,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  if (getAllClientRequestsList != null &&
                                      getAllClientRequestsList!.isNotEmpty) {
                                    _controller
                                        .animateCamera(
                                      CameraUpdate.newLatLng(
                                        LatLng(
                                          double.parse(
                                              getAllClientRequestsList![
                                                      currentLocationIndex]
                                                  .bookings!
                                                  .bookings_destinations![0]
                                                  .pickup_latitude!),
                                          double.parse(
                                              getAllClientRequestsList![
                                                      currentLocationIndex]
                                                  .bookings!
                                                  .bookings_destinations![0]
                                                  .pickup_longitude!),
                                        ),
                                      ),
                                    )
                                        .then((_) {
                                      setState(() {
                                        isContainerVisible = false;
                                      });
                                    });
                                    currentLocationIndex =
                                        (currentLocationIndex + 1) %
                                            getAllClientRequestsList!.length;
                                  }
                                },
                                child: Container(
                                  width: 200,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white.withOpacity(
                                            0.5), // Change the opacity as needed
                                        spreadRadius: 5, // Change as needed
                                        blurRadius: 7, // Change as needed
                                        offset: const Offset(
                                            0, 3), // Change as needed
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          const Text(
                                            "New Ride Request",
                                            style: TextStyle(
                                              fontSize:
                                                  18, // Change this value as needed
                                              // Makes the text bold
                                              color: Colors
                                                  .black, // Change this value as needed
                                            ),
                                          ),
                                          SizedBox(
                                              width: 100.w,
                                              height: 40.h,
                                              child: buttonContainer(
                                                  context, 'View')),
                                        ]),
                                  ),
                                ),
                              ),
                            )),
                      )
                    : const SizedBox(),
              ],
            ),
    );
  }
}
