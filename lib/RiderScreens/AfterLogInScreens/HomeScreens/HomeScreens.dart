import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:Deliver_Rider/Constants/buttonContainer.dart';
import 'package:Deliver_Rider/RiderScreens/AfterLogInScreens/HomeScreens/modalBottomSheetOnHome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
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
import '../../../models/API models/API response.dart';
import '../../../models/API models/GetAllSystemDataModel.dart';
import '../../../models/API models/ShowBookingsModel.dart';
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

    Map data = {
      "users_fleet_id": userID.toString(),
    };
    getAllClientRequestsResponse = await service.getAllClientRequestsAPI(data);

    if (getAllClientRequestsResponse.status!.toLowerCase() == 'success') {
      if (getAllClientRequestsResponse.data != null) {
        showToastSuccess('Getting all ride requests', FToast().init(context),
            seconds: 1);
        getAllClientRequestsList!.addAll(getAllClientRequestsResponse.data!);
        for (int i = 0; i < getAllClientRequestsList!.length; i++) {
          print(
              'object getting requests  : ${getAllClientRequestsList![i].bookings!.pickup_longitude}   ${getAllClientRequestsList![i].bookings!.pickup_latitude}');
          print(
              "name: ${getAllClientRequestsList![i].bookings!.users_customers!.first_name}");
          print("fleet id: ${getAllClientRequestsList![i].bookings_fleet_id}");
        }
      }
    } else {
      print('object error getting requests  ' +
          getAllClientRequestsResponse.status!.toString() +
          '        ' +
          getAllClientRequestsResponse.message!.toString());
      showToastError('No ride requests yet', FToast().init(context));
    }

    _getAllSystemDataResponse = await service.getALlSystemDataAPI();
    _getSystemDataList = [];

    if (_getAllSystemDataResponse.status!.toLowerCase() == 'success') {
      if (_getAllSystemDataResponse.data != null) {
        _getSystemDataList!.addAll(_getAllSystemDataResponse.data!);
        for (GetAllSystemDataModel model in _getSystemDataList!) {
          if (model.type == 'system_currency') {
            setState(() {
              currency = model.description!;
            });
          }
        }
      }
    }

    addCustomIcon();
    getPolyPoints();

    setState(() {
      isHomeLoading = false;
    });
  }

  /// Add custom icon method:
  void addCustomIcon() async {
    customMarkerIcon = await getBitmapDescriptorFromAssetBytes(
        "assets/images/custom-icon.png", 300);
    setState(() {});
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
                Navigator.of(context).pop();
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
                  padding: EdgeInsets.symmetric(
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
                                      'https://deliver.eigix.net/public/${profilePicture}',
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
                                fontSize: 20,
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
                double.parse(
                    getAllClientRequestsList![i].bookings!.pickup_latitude!),
                double.parse(
                    getAllClientRequestsList![i].bookings!.pickup_longitude!)),
            onTap: () {
              getData(
                LatLng(
                    double.parse(getAllClientRequestsList![i]
                        .bookings!
                        .pickup_latitude!),
                    double.parse(getAllClientRequestsList![i]
                        .bookings!
                        .pickup_longitude!)),
                getAllClientRequestsList![i]
                    .bookings!
                    .users_customers!
                    .first_name!,
                getAllClientRequestsList![i].bookings!.pickup_address,
                getAllClientRequestsList![i]
                    .bookings!
                    .users_customers!
                    .profile_pic!,
                getAllClientRequestsList![i].bookings!.total_discounted_charges,
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
    });

    return markers;
  }

  List<LatLng> polylineCoordinates = [];
  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      ' AIzaSyAk-CA4yYf-txNZvvwmCshykjpLiASEkcw', // Your Google Map Key
      PointLatLng(30.2399443, 71.4853788),
      PointLatLng(31.410483, 72.484598),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    LatLng initialPosition =
        LatLng(double.parse(userLatitude!), double.parse(userLongitude!));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: white,
        body: isHomeLoading
            ? spinKitRotatingCircle
            : Stack(
                alignment: Alignment.bottomRight,
                children: [
                  GoogleMap(
                    onMapCreated: _onMapCreated,
                    onCameraMove: _onCameraMove(
                        CameraPosition(
                            target: LatLng(double.parse(userLatitude!),
                                double.parse(userLongitude!))),
                        LatLng(double.parse(userLatitude!),
                            double.parse(userLongitude!))),
                    initialCameraPosition: CameraPosition(
                      target: initialPosition,
                      zoom: 15.5,
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
                  // Positioned(
                  //   child: Padding(
                  //     padding: EdgeInsets.only(right: 22.0.w, bottom: 130.h),
                  //     child: Column(
                  //       mainAxisAlignment: MainAxisAlignment.end,
                  //       children: [
                  //         GestureDetector(
                  //           onTap: () {},
                  //           child: Container(
                  //             width: 40.w,
                  //             height: 40.h,
                  //             decoration: const BoxDecoration(
                  //               color: orange,
                  //               shape: BoxShape.circle,
                  //             ),
                  //             child: SvgPicture.asset(
                  //               'assets/images/circle-pointer.svg',
                  //               colorFilter: const ColorFilter.mode(
                  //                   white, BlendMode.srcIn),
                  //               fit: BoxFit.scaleDown,
                  //             ),
                  //           ),
                  //         ),
                  //         SizedBox(
                  //           height: 40.h,
                  //         ),
                  //         GestureDetector(
                  //           // onTap: () {
                  //           //   showModalBottomSheet(
                  //           //     backgroundColor: white,
                  //           //     shape: RoundedRectangleBorder(
                  //           //       borderRadius: BorderRadius.vertical(
                  //           //         top: Radius.circular(20),
                  //           //       ),
                  //           //     ),
                  //           //     isScrollControlled: true,
                  //           //     context: context,
                  //           //     builder: (context) => ModalBottomSheetOnHome(
                  //           //         // clientData: getAllClientRequestsList[0],
                  //           //         ),
                  //           //   );
                  //           // },
                  //           child: Container(
                  //             width: 40.w,
                  //             height: 40.h,
                  //             decoration: const BoxDecoration(
                  //               color: orange,
                  //               shape: BoxShape.circle,
                  //             ),
                  //             child: SvgPicture.asset(
                  //               'assets/images/flag-map-icon.svg',
                  //               colorFilter: const ColorFilter.mode(
                  //                   white, BlendMode.srcIn),
                  //               fit: BoxFit.scaleDown,
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
      ),
    );
  }
}
