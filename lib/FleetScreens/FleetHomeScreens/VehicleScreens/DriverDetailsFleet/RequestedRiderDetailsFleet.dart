import 'package:Deliver_Rider/Constants/buttonConatinerWithBorder.dart';
import 'package:Deliver_Rider/FleetScreens/BottomNavBarFleet.dart';
import 'package:Deliver_Rider/FleetScreens/FleetHomeScreens/VehicleScreens/DriverDetailsFleet/ContactHistoryOfDriverFleet.dart';
import 'package:Deliver_Rider/FleetScreens/FleetHomeScreens/VehicleScreens/DriverDetailsFleet/DriverInfoWidgetFleet.dart';
import 'package:Deliver_Rider/FleetScreens/FleetHomeScreens/VehicleScreens/DriverDetailsFleet/ReviewsOfDrivers.dart';
import 'package:Deliver_Rider/models/APIModelsFleet/AcceptAndRejectRequestedVehicleModel.dart';
import 'package:Deliver_Rider/models/APIModelsFleet/GetFleetVehicleRequestByIdModel.dart';
import 'package:Deliver_Rider/models/GetFleetVehicleByIdModel.dart';
import 'package:Deliver_Rider/utilities/showToast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Constants/Colors.dart';
import '../../../../Constants/back-arrow-with-container.dart';
import '../../../../Constants/buttonContainer.dart';
import '../../../../models/API models/API response.dart';
import '../../../../services/API_services.dart';
import '../../../../widgets/apiButton.dart';

class RequestedRiderDetailsFleet extends StatefulWidget {
  final GetFleetVehicleRequestByIdModel getFleetVehicleRequestByIdModel;
  final GetFleetVehicleByIdModel requestVehicleById;
  const RequestedRiderDetailsFleet(
      {super.key,
      required this.getFleetVehicleRequestByIdModel,
      required this.requestVehicleById});

  @override
  State<RequestedRiderDetailsFleet> createState() =>
      _RequestedRiderDetailsFleetState();
}

class _RequestedRiderDetailsFleetState extends State<RequestedRiderDetailsFleet>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
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
            'Driver Profile',
            style: GoogleFonts.syne(
              fontWeight: FontWeight.w700,
              color: black,
              fontSize: 20,
            ),
          ),
        ),
        backgroundColor: white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 30.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 155.w,
                    height: 155.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        width: 4.5,
                        color: lightGrey,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        'https://deliver.eigix.net/public/${widget.getFleetVehicleRequestByIdModel.users_fleet!.profile_pic}',
                        fit: BoxFit.cover,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return SizedBox(
                            child: Image.asset(
                              'assets/images/place-holder.png',
                              fit: BoxFit.scaleDown,
                            ),
                          );
                        },
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              color: orange,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        '${widget.getFleetVehicleRequestByIdModel.users_fleet!.first_name} ${widget.getFleetVehicleRequestByIdModel.users_fleet!.last_name}',
                        style: GoogleFonts.syne(
                          fontWeight: FontWeight.w700,
                          color: black,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      SizedBox(
                        width: 134.w,
                        height: 45.h,
                        child: isAccepting
                            ? SpinKitFadingCircle(
                                color: orange,
                                size: 50.0,
                              )
                            : GestureDetector(
                                onTap: () => accpetVehicleRequest(context),
                                child: buttonContainer(context, 'Accept'),
                              ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      SizedBox(
                        width: 134.w,
                        height: 45.h,
                        child: GestureDetector(
                          onTap: () => showAdaptiveDialog(
                            context: context,
                            builder: (context) => AlertDialog.adaptive(
                              title: Text(
                                'Are you sure you want to reject the request?',
                                style: GoogleFonts.syne(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: black,
                                ),
                              ),
                              actions: [
                                GestureDetector(
                                  onTap: () => Navigator.of(context).pop(),
                                  child: SizedBox(
                                    height: 45.h,
                                    width: 100.w,
                                    child: buttonContainerWithBorder(
                                        context, 'NO'),
                                  ),
                                ),
                                isRejecting
                                    ? apiButton(context)
                                    : GestureDetector(
                                        onTap: () =>
                                            rejectVehicleRequest(context),
                                        child: SizedBox(
                                          height: 45.h,
                                          width: 100.w,
                                          child:
                                              buttonContainer(context, 'YES'),
                                        ),
                                      ),
                              ],
                              actionsAlignment: MainAxisAlignment.spaceAround,
                            ),
                          ),
                          child: buttonContainerWithBorder(context, 'Reject'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 25.h,
              ),
              DriverInfoWidgetFleet(
                emailAddress: widget.getFleetVehicleRequestByIdModel
                            .users_fleet!.email !=
                        null
                    ? widget.getFleetVehicleRequestByIdModel.users_fleet!.email!
                    : 'No Email Given',
                phoneNumber: widget.getFleetVehicleRequestByIdModel.users_fleet!
                            .phone !=
                        null
                    ? widget.getFleetVehicleRequestByIdModel.users_fleet!.phone!
                    : 'No phone number given',
                location: widget.getFleetVehicleRequestByIdModel.users_fleet!
                            .address !=
                        null
                    ? widget
                        .getFleetVehicleRequestByIdModel.users_fleet!.address!
                    : 'No Address given',
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                width: double.infinity,
                height: 75.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: white,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 65.w,
                      height: 65.h,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: orange,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(65),
                        child: Image.network(
                          'https://deliver.eigix.net/public/${widget.requestVehicleById.image!}',
                          fit: BoxFit.cover,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return SizedBox(
                              child: Image.asset(
                                'assets/images/place-holder.png',
                                fit: BoxFit.scaleDown,
                              ),
                            );
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
                    SizedBox(
                      width: 15.w,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Requested Ride',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: GoogleFonts.syne(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: orange,
                          ).copyWith(
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          widget.requestVehicleById.model!,
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
                        Text(
                          widget.requestVehicleById.vehicle_registration_no!,
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
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                // padding: EdgeInsets.all(6),
                width: double.infinity,
                height: 50.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: lightGrey,
                    width: 1,
                  ),
                  color: white,
                ),
                child: TabBar(
                  unselectedLabelColor: black,
                  labelColor: white,
                  controller: tabController,
                  indicator: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xffFF6302),
                        Color(0xffFBC403),
                      ],
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                    ),
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  tabs: [
                    Text(
                      'Contact History',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.syne(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'Reviews',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.syne(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  physics: const BouncingScrollPhysics(),
                  children: const [
                    ContactHistoryOfDriverFleet(),
                    ReviewsOfDrivers(),
                    // RidesTabOnFleetDetails(),
                    // ContactHistoryTabOnFleetDetails(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ApiServices get service => GetIt.I<ApiServices>();

  /// accept vehicle request method:
  bool isAccepting = false;
  APIResponse<AcceptAndRejectRequestedVehicleModel>? acceptResponse;
  accpetVehicleRequest(BuildContext context) async {
    setState(() {
      isAccepting = true;
    });

    Map acceptData = {
      "users_fleet_vehicles_assigned_id": widget
          .getFleetVehicleRequestByIdModel.users_fleet_vehicles_assigned_id
          .toString(),
      "users_fleet_id": widget
          .getFleetVehicleRequestByIdModel.users_fleet!.users_fleet_id
          .toString(),
      "users_fleet_vehicles_id": widget
          .getFleetVehicleRequestByIdModel.users_fleet_vehicles_id
          .toString(),
    };

    acceptResponse = await service.acceptVehicleRequest(acceptData);
    if (acceptResponse!.status!.toLowerCase() == 'success') {
      showToastSuccess(
          'The request has been successfully accepted', FToast().init(context),
          seconds: 1);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => BottomNavBarFleet(),
        ),
      );
    } else {
      showToastError(acceptResponse!.message!, FToast().init(context));
    }
    setState(() {
      isAccepting = false;
    });
  }

  /// reject vehicle request method:
  bool isRejecting = false;
  APIResponse<AcceptAndRejectRequestedVehicleModel>? rejectResponse;
  rejectVehicleRequest(BuildContext context) async {
    setState(() {
      isRejecting = true;
    });

    Map acceptData = {
      "users_fleet_vehicles_assigned_id": widget
          .getFleetVehicleRequestByIdModel.users_fleet_vehicles_assigned_id
          .toString(),
      "users_fleet_id": widget
          .getFleetVehicleRequestByIdModel.users_fleet!.users_fleet_id
          .toString(),
      "users_fleet_vehicles_id": widget
          .getFleetVehicleRequestByIdModel.users_fleet_vehicles_id
          .toString(),
    };

    rejectResponse = await service.rejectVehicleRequest(acceptData);
    if (rejectResponse!.status!.toLowerCase() == 'success') {
      showToastSuccess(
          'The request has been successfully rejected', FToast().init(context),
          seconds: 1);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => BottomNavBarFleet(),
        ),
      );
    } else {
      showToastError(rejectResponse!.message!, FToast().init(context));
    }
    setState(() {
      isRejecting = false;
    });
  }
}
