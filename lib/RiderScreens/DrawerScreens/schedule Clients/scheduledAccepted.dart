import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:deliver_partner/Constants/Colors.dart';
import 'package:deliver_partner/Constants/PageLoadingKits.dart';
import 'package:deliver_partner/Constants/SeeDetailsOnCompletedRidesButton.dart';
import 'package:deliver_partner/Constants/details-button.dart';
import 'package:deliver_partner/RiderScreens/DrawerScreens/schedule%20Clients/NewScheduledRides/scheduledRidesDetails.dart';
import 'package:deliver_partner/RiderScreens/DrivingLicensePictureVerification.dart';
import 'package:deliver_partner/models/API_models/ScheduledRidesAPIModel.dart';
import 'package:deliver_partner/models/API_models/acceptedScheduledRides.dart';
import 'package:deliver_partner/temploginReider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'AcceptedScheduledRides/acceptedScheduledRides.dart';

class ScheduledAccepted extends StatefulWidget {
  const ScheduledAccepted({super.key});

  @override
  State<ScheduledAccepted> createState() => _ScheduledAcceptedState();
}

class _ScheduledAcceptedState extends State<ScheduledAccepted> {
  bool opened = false;
  bool closed = false;
  int selectedIndex = -1;
  String? name;
  int? statusID;
  int? startRideID;
  String? startRide;
  String currency = '';
  String? distance;
  bool isLoading = false;
  AcceptedScheduledRides acceptedScheduledRides = AcceptedScheduledRides();
  Future<void> getAcceptedScheduledRides() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userID = (sharedPreferences.getInt('userID') ?? -1);
    print('object userId on Scheduled rides is: $userID');
    setState(() {
      isLoading = true;
    });
    var headersList = {'Accept': '*/*', 'Content-Type': 'application/json'};
    var url = Uri.parse(
        'https://cs.deliverbygfl.com/api/get_bookings_scheduled_accepted_fleet');

    var body = {"users_fleet_id": "$userID"};

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode == 200) {
      print(resBody);
      acceptedScheduledRides = acceptedScheduledRidesFromJson(resBody);
      setState(() {
        isLoading = false;
      });
    } else {
      print(res.reasonPhrase);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAcceptedScheduledRides();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: isLoading
          ? spinKitRotatingCircle
          : acceptedScheduledRides.data != null
              ? ListView.builder(
                  itemCount: acceptedScheduledRides
                      .data?.length, // replace "yourList" with your actual list
                  itemBuilder: (context, index) {
                    final itemList = acceptedScheduledRides.data![index];
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      width: double.infinity,
                      height: 138.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: lightWhite,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 70.w,
                                height: 70.h,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    width: 1,
                                    color: lightGrey.withOpacity(0.8),
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: itemList.bookings!.usersCustomers!
                                              .profilePic !=
                                          null
                                      ? Image.network(
                                          'https://cs.deliverbygfl.com/public/${itemList.bookings!.usersCustomers!.profilePic}',
                                          fit: BoxFit.cover,
                                          errorBuilder: (BuildContext context,
                                              Object exception,
                                              StackTrace? stackTrace) {
                                            return SizedBox(
                                              child: SvgPicture.asset(
                                                'assets/images/bike.svg',
                                                fit: BoxFit.scaleDown,
                                              ),
                                            );
                                          },
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent?
                                                  loadingProgress) {
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
                                        )
                                      : SvgPicture.asset(
                                          'assets/images/bike.svg',
                                          fit: BoxFit.scaleDown,
                                        ),
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.59,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 160.w,
                                            child: AutoSizeText(
                                              '${itemList.bookings!.usersCustomers!.firstName} '
                                              '${itemList.bookings!.usersCustomers!.lastName}',
                                              maxLines: 2,
                                              minFontSize: 12,
                                              style: GoogleFonts.inter(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w400,
                                                color: black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    SizedBox(
                                      width: 200.w,
                                      child: AutoSizeText(
                                        '${itemList.usersFleetVehicles!.model}',
                                        minFontSize: 13,
                                        maxLines: 2,
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: grey,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 200.w,
                                      child: AutoSizeText(
                                        '(${itemList.usersFleetVehicles!.vehicleIdentificationNo})',
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                  });
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AcceptedScheduledRidesPage(
                                                userID: userID.toString(),
                                                bookingID: itemList.bookingsId.toString()

                                                // bookingID: itemList.bookingsId
                                                //     .toString(),
                                                // // inProgressRidesList:
                                                // //     jsonResponse!['data'][index],
                                                // // inProgressRidesList2:
                                                // //     inProgressRidesList,
                                                // index: selectedIndex,
                                              )));
                                },
                                child:
                                    SeeDetailsOnCompletedRidesButton(context),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  })
              : Center(
                  child: Text(
                    'No Schedule Rides',
                    style: GoogleFonts.syne(
                      fontWeight: FontWeight.w300,
                      color: black,
                      fontSize: 20,
                    ),
                  ),
                ),
    );
  }
}
