import 'package:deliver_partner/Constants/Colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:math' as math;

import 'package:deliver_partner/RiderScreens/DrivingLicensePictureVerification.dart';
import 'package:deliver_partner/models/getEarningsModel.dart';
import 'package:deliver_partner/temploginReider.dart';
import 'package:intl/intl.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../Constants/back-arrow-with-container.dart';
import 'LinecChartWidget.dart';
import 'MonthlyEarnings.dart';
import 'WeeklyEarnings.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  Map<String, String> monthNumbers = {
    'January': '01',
    'February': '02',
    'March': '03',
    'April': '04',
    'May': '05',
    'June': '06',
    'July': '07',
    'August': '08',
    'September': '09',
    'October': '10',
    'November': '11',
    'December': '12',
  };
  String? errorMessage;
  String earnings_by = 'perMonth'; // default value
  String dropdownValue = 'January';
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();
  String monthNumber = '01';
  double totalEarnings = 0.0;
  num totalBookings = 0;
  GetEarningsModel getEarningsModel = GetEarningsModel();
  weekly() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userID = (sharedPreferences.getInt('userID') ?? -1);

    print("UserID $userID");
    var headersList = {'Accept': '*/*', 'Content-Type': 'application/json'};
    var url = Uri.parse('https://cs.deliverbygfl.com/api/get_earnings_fleet');

    var body = {
      "users_fleet_id": userID,
      "user_type": "Rider",
      "earnings_by": earnings_by, // "perMonth" or "customDates"
      "month": monthNumber,
      "year": "2024",
      "from_date": "$fromDate",
      "to_date": "$toDate"
    };

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode == 200) {
      var responseJson = json.decode(resBody);
      if (responseJson['status'] == 'error') {
        setState(() {
          errorMessage = responseJson['message'];
        });
      } else {
        print(resBody);
        getEarningsModel = getEarningsModelFromJson(resBody);

        totalEarnings = 0.0;
        for (var item in getEarningsModel.data!) {
          totalEarnings += double.parse(item.totalAmount!);
        }

        totalBookings = 0;
        for (var item in getEarningsModel.data!) {
          totalEarnings += double.parse(item.totalAmount!);
          totalBookings += item.totalBookings ?? 0;
          totalBookings += item.totalBookings ?? 0;
        }
        setState(() {
          errorMessage = null;
        });
      }
    } else {
      print(res.reasonPhrase);
      getEarningsModel = getEarningsModelFromJson(resBody);
    }
  }

  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  double calculateTotalEarnings() {
    double total = 0;
    for (var week in getEarningsModel.data!) {
      total += double.parse(week.totalAmount ?? '0');
    }
    return total;
  }

  final List<Color> gradientColors = [
    const Color(0xffFBC403),
    const Color(0xffFF6302),
  ];

  LineChartData mainData() {
    if (getEarningsModel.data == null ||
        getEarningsModel.data == null ||
        getEarningsModel.data!.isEmpty) {
      return LineChartData(lineBarsData: []);
    }

    List<FlSpot> spots = [];
    for (int i = 0; i < getEarningsModel.data!.length; i++) {
      double y = double.parse(getEarningsModel.data![i].totalAmount ?? '0');
      spots.add(FlSpot(i.toDouble(), y));
    }

    return LineChartData(
      minX: 0,
      maxX: getEarningsModel.data!.length.toDouble() - 1,
      minY: 0,
      maxY: spots.map((spot) => spot.y).reduce(math.max),
      titlesData: FlTitlesData(
        topTitles: const AxisTitles(
            sideTitles: SideTitles(
          showTitles: false,
        )),
        rightTitles: const AxisTitles(
            sideTitles: SideTitles(
          showTitles: false,
        )),
        // leftTitles: AxisTitles(
        //   sideTitles: SideTitles(
        //     showTitles: true,
        //     interval: 999,
        //     getTitlesWidget: (value, _) {
        //       return Padding(
        //         padding: const EdgeInsets.all(2.0),
        //         child: Text(
        //           '\$${value.toInt()}',
        //           style:
        //               const TextStyle(fontSize: 7), // Adjust the font size here
        //         ),
        //       ); // Y-axis labels
        //     },
        //   ),
        // ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 2,
            getTitlesWidget: (value, _) {
              return Padding(
                padding: const EdgeInsets.only(left: 10, top: 5),
                child: Text(
                  'Week ${value.toInt() + 1}',
                  style:
                      const TextStyle(fontSize: 7), // Adjust the font size here
                ),
              ); // X-axis labels
            },
          ),
        ),
      ),
      lineBarsData: [
        LineChartBarData(
          preventCurveOverShooting: true,
          spots: spots,
          isCurved: true,
          color: gradientColors[0],
          // colors: gradientColors,
          barWidth: 1,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),

          belowBarData: BarAreaData(
            show: true,
            gradient: const LinearGradient(
              colors: [
                Color(0xffFBC403),
                Color(0xffFF6302),
              ],
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
            ),
          ),
        ),
      ],
    );
  }

  String? formattedToDate;
  String? formattedFromDate;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController.dispose();
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
          'Dashboard',
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
      body: GlowingOverscrollIndicator(
        axisDirection: AxisDirection.down,
        color: orange,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              DropdownButton<String>(
                value: dropdownValue,
                onChanged: (String? newValue) async {
                  setState(() {
                    isLoading = true;
                    dropdownValue = newValue!;
                    earnings_by = (newValue == 'Custom Dates')
                        ? 'customDates'
                        : 'perMonth';
                    if (newValue != 'Custom Dates') {
                      monthNumber = monthNumbers[dropdownValue]!;
                      print('Month: $monthNumber');
                      // await weekly();
                    }
                    print('Earnings by: $earnings_by');
                  });

                  await weekly();
                  setState(() {
                    isLoading =
                        false; // Set isLoading to false after data is loaded
                  });
                },
                items: <String>[
                  'January',
                  'February',
                  'March',
                  'April',
                  'May',
                  'June',
                  'July',
                  'August',
                  'September',
                  'October',
                  'November',
                  'December',
                  'Custom Dates'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              if (dropdownValue == 'Custom Dates') ...[
                DatePickerWidget(
                  title: 'From Date',
                  selectedDate: fromDate,
                  selectDate: (DateTime date) {
                    setState(() {
                      isLoading = true;
                      formattedFromDate = DateFormat('yyyy-MM-dd').format(date);
                      print('From Date: $formattedFromDate');
                    });
                  },
                ),
                DatePickerWidget(
                  title: 'To Date',
                  selectedDate: toDate,
                  selectDate: (DateTime date) async {
                    setState(() {
                      formattedToDate = DateFormat('yyyy-MM-dd').format(date);
                      print('To Date: $formattedToDate');
                    });
                    await weekly();
                    setState(() {
                      isLoading =
                          false; // Set isLoading to false after data is loaded
                    });
                  },
                ),
              ],
              if (isLoading)
                const Center(child: CircularProgressIndicator())
              else if (errorMessage != null)
                Text(errorMessage!)
              else
                Container(
                  padding: EdgeInsets.only(
                    top: 14.h,
                  ),
                  width: double.infinity,
                  height: 340.h,
                  decoration: BoxDecoration(
                    color: orange,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Monthly Earnings',
                                  style: GoogleFonts.inter(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: white,
                                  ),
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/images/currency.svg'),
                                    Text(
                                      totalEarnings.toStringAsFixed(2),
                                      style: GoogleFonts.inter(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w700,
                                        color: white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Expanded(
                        child: isLoading
                            ? const CircularProgressIndicator()
                            : Padding(
                                padding:
                                    const EdgeInsets.only(right: 12, top: 0),
                                child: LineChart(mainData()),
                              ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          height: 50.h,
                          color: lightWhite,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                      'assets/images/totalRides-icon.svg'),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Text(
                                    '$totalBookings Rides',
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: black,
                                    ),
                                  ),
                                ],
                              ),
                              // Row(
                              //   children: [
                              //     SvgPicture.asset(
                              //         'assets/images/timer-icon.svg'),
                              //     SizedBox(
                              //       width: 10.w,
                              //     ),
                              //     Text(
                              //       '6790 h 5678 mint',
                              //       style: GoogleFonts.inter(
                              //         fontSize: 12,
                              //         fontWeight: FontWeight.w700,
                              //         color: black,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              SizedBox(
                height: 20.h,
              ),
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
              //   // padding: EdgeInsets.all(6),
              //   width: 250,
              //   height: 50.h,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(10),
              //     border: Border.all(
              //       color: lightGrey,
              //       width: 1,
              //     ),
              //     color: lightWhite,
              //   ),
              //   child: TabBar(
              //     unselectedLabelColor: black,
              //     labelColor: white,
              //     controller: tabController,
              //     indicator: BoxDecoration(
              //       gradient: const LinearGradient(
              //         colors: [
              //           Color(0xffFF6302),
              //           Color(0xffFBC403),
              //         ],
              //         begin: Alignment.centerRight,
              //         end: Alignment.centerLeft,
              //       ),
              //       borderRadius: BorderRadius.circular(
              //         10,
              //       ),
              //     ),
              //     tabs: [
              //       Text(
              //         'Weekly',
              //         textAlign: TextAlign.center,
              //         style: GoogleFonts.syne(
              //           fontWeight: FontWeight.w400,
              //           fontSize: 14,
              //         ),
              //       ),
              //       Text(
              //         'Monthly',
              //         textAlign: TextAlign.center,
              //         style: GoogleFonts.syne(
              //           fontWeight: FontWeight.w400,
              //           fontSize: 14,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: 20.h,
              // ),
              // Expanded(
              //     child: TabBarView(
              //   controller: tabController,
              //   physics: const BouncingScrollPhysics(),
              //   children: [

              //     const MonthlyEarnings(),
              //   ],
              // )),
              Expanded(
                child: WeeklyEarnings(
                  month: monthNumber,
                  fromDate0: fromDate.toString(),
                  toDate0: toDate.toString(),
                  earningsBy: earnings_by,
                ),
              ),
              // Expanded(
              //     child: TabBarView(
              //   controller: tabController,
              //   physics: const BouncingScrollPhysics(),
              //   children: [

              //     const MonthlyEarnings(),
              //   ],
              // )),
            ],
          ),
        ),
      ),
    );
  }
}

class DatePickerWidget extends StatelessWidget {
  final String title;
  final DateTime selectedDate;
  final ValueChanged<DateTime> selectDate;

  const DatePickerWidget({
    super.key,
    required this.title,
    required this.selectedDate,
    required this.selectDate,
  });

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      selectDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text("${selectedDate.toLocal()}".split(' ')[0]),
      onTap: () => _selectDate(context),
    );
  }
}
