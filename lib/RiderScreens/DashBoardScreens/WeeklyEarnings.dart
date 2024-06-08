import 'dart:convert';
import 'package:deliver_partner/RiderScreens/DrivingLicensePictureVerification.dart';
import 'package:deliver_partner/models/API_models/CheckPhoneNumberModel.dart';
import 'package:deliver_partner/models/getEarningsModel.dart';
import 'package:deliver_partner/temploginReider.dart';
import 'package:http/http.dart' as http;
import 'package:deliver_partner/Constants/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class WeeklyEarnings extends StatefulWidget {
  final String? month;
  final String? fromDate0;
  final String? toDate0;
  final String? earningsBy;

  const WeeklyEarnings(
      {super.key, this.month, this.fromDate0, this.toDate0, this.earningsBy});

  @override
  State<WeeklyEarnings> createState() => _WeeklyEarningsState();
}

class _WeeklyEarningsState extends State<WeeklyEarnings> {
  GetEarningsModel getEarningsModel = GetEarningsModel();
  bool isLoading = false;
  weekly() async {
    setState(() {
      isLoading = true; // Set isLoading to true when starting to load data
    });
    sharedPreferences = await SharedPreferences.getInstance();
    userID = (sharedPreferences.getInt('userID') ?? -1);

    print("UserID $userID");
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('https://cs.deliverbygfl.com/api/get_earnings_fleet');

    var body = {
      "users_fleet_id": userID,
      "user_type": "Rider",
      "earnings_by": "${widget.earningsBy}", // "perMonth" or "customDates"
      "month": "${widget.month}",
      "year": "2024",
      "from_date": "${widget.fromDate0}",
      "to_date": "${widget.toDate0}"
    };

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode == 200) {
      print(resBody);
      getEarningsModel = getEarningsModelFromJson(resBody);

      setState(() {
        isLoading = false; // Set isLoading to false after data is loaded
      });
    } else {
      print(res.reasonPhrase);
    }
  }

  double calculateTotalEarnings() {
    double total = 0;
    for (var week in getEarningsModel.data!) {
      total += double.parse(week.totalAmount ?? '0');
    }
    return total;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    super.initState();
    if (widget.month!.isNotEmpty || widget.fromDate0!.isNotEmpty) {
      weekly();
    }
  }

  @override
  void didUpdateWidget(covariant WeeklyEarnings oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.month != widget.month ||
        oldWidget.fromDate0 != widget.fromDate0 ||
        oldWidget.toDate0 != widget.toDate0 ||
        oldWidget.earningsBy != widget.earningsBy) {
      weekly();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : getEarningsModel.data != null
                ? Column(
                    children: [
                      Text(
                        'Details of Driver Weekly Earning',
                        style: GoogleFonts.syne(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: orange,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: getEarningsModel.data!.length ?? 0,
                          itemBuilder: (context, index) {
                            final week = getEarningsModel.data![index];
                            DateTime? date = week.dateAdded;
                            String formattedDate =
                                DateFormat('dd/MM/yyyy').format(date!);
                            String dayOfWeek = DateFormat('EEEE').format(date);
                            return Card(
                              child: ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '$formattedDate, $dayOfWeek',
                                      style: GoogleFonts.inter(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/currency.svg',
                                          colorFilter: const ColorFilter.mode(
                                              Colors.black, BlendMode.srcIn),
                                        ),
                                        const SizedBox(
                                          width:
                                              5, // adjust this value as needed
                                        ),
                                        Text(
                                          '${week.totalAmount}',
                                          style: GoogleFonts.inter(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                subtitle: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Rides ${week.totalBookings}',
                                            style: GoogleFonts.inter(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Weekly Earnings:',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/images/currency.svg',
                                  colorFilter: const ColorFilter.mode(
                                      Colors.black, BlendMode.srcIn),
                                ),
                                Text(
                                  calculateTotalEarnings().toStringAsFixed(2),
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : const Center(child: Text("No Data Availble")));
  }
}
