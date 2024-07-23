import 'dart:convert';
import 'package:deliver_partner/Constants/PageLoadingKits.dart';
import 'package:deliver_partner/RiderScreens/DrivingLicensePictureVerification.dart';
import 'package:deliver_partner/temploginReider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:deliver_partner/Constants/Colors.dart';
import 'package:deliver_partner/models/API_models/getFleetVehicleTask.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'CalenderWidget.dart';
import 'UpcomingDeadlinesWidget.dart';

class CalenderScreenFleet extends StatefulWidget {
  const CalenderScreenFleet({super.key});

  @override
  State<CalenderScreenFleet> createState() => _CalenderScreenFleetState();
}

class _CalenderScreenFleetState extends State<CalenderScreenFleet> {
  FleetTaskUpcomingModel fleetTaskUpcomingModel = FleetTaskUpcomingModel();
  bool isLoading = false;
  upComing() async {
    setState(() {
      isLoading = true;
    });
    sharedPreferences = await SharedPreferences.getInstance();
    userID = (sharedPreferences.getInt('userID') ?? -1);
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Content-Type': 'application/json'
    };
    var url = Uri.parse(
        'https://deliverbygfl.com/api/get_fleet_vehicles_taks_upcoming');

    var body = {"users_fleet_id": "$userID"};

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode == 200) {
      fleetTaskUpcomingModel = fleetTaskUpcomingModelFromJson(resBody);
      setState(() {
        isLoading = false;
      });
      print(resBody);
    } else {
      print(res.reasonPhrase);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    upComing();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: isLoading
          ? spinKitRotatingCircle
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // CalenderWidget(
                  //   onDateSelected: (DateTime selectedDate) {
                  //     // This is where you get the selected date from the calendar
                  //     print("Selected date: $selectedDate");
                  //     // You can now use `selectedDate` for your needs
                  //   },
                  // ),
                  // SizedBox(
                  //   height: 20.h,
                  // ),
                  // Text(
                  //   'Upcoming Deadlines',
                  //   textAlign: TextAlign.start,
                  //   style: GoogleFonts.syne(
                  //     fontSize: 14,
                  //     fontWeight: FontWeight.w700,
                  //     color: black,
                  //   ),
                  // ),
                  fleetTaskUpcomingModel.data != null
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: fleetTaskUpcomingModel.data!.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              String formattedDate = DateFormat('d MMMM yyyy')
                                  .format(DateTime.parse(fleetTaskUpcomingModel
                                      .data![index].dateAdded
                                      .toString()));
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 12.h),
                                padding: EdgeInsets.symmetric(
                                    vertical: 9.h, horizontal: 11.w),
                                height: 72.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: grey,
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                            'assets/images/oil-change.svg'),
                                        SizedBox(
                                          width: 7.w,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              fleetTaskUpcomingModel
                                                  .data![index].name,
                                              style: GoogleFonts.syne(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w700,
                                                color: black,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Text(
                                              formattedDate,
                                              style: GoogleFonts.inter(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500,
                                                color: grey,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: grey,
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      : const Center(
                          child: Text(
                            "No Task Found",
                            style: TextStyle(
                              fontSize: 20.0, // Sets the font size to 20
                              color: Colors.red, // Sets the text color to red
                              fontWeight:
                                  FontWeight.bold, // Makes the text bold
                            ),
                          ),
                        ),
                ],
              ),
            ),
    );
  }
}
