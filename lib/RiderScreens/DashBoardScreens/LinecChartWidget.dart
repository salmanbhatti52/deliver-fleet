import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:deliver_partner/Constants/Colors.dart';
import 'package:deliver_partner/RiderScreens/DrivingLicensePictureVerification.dart';
import 'package:deliver_partner/models/getEarningsModel.dart';
import 'package:deliver_partner/temploginReider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:shared_preferences/shared_preferences.dart';

class LinecChartWidget extends StatefulWidget {
  final String? month;
  final String? fromDate0;
  final String? toDate0;
  final String? earningsBy;
    final Function() loadData;

  const LinecChartWidget(
      {super.key,
      this.month,
      this.fromDate0,
      this.toDate0,
     required this.loadData,
      this.earningsBy});

  @override
  _LinecChartWidgetState createState() => _LinecChartWidgetState();
}

class _LinecChartWidgetState extends State<LinecChartWidget> {
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

      setState(() {});
    } else {
      print(res.reasonPhrase);
      getEarningsModel = getEarningsModelFromJson(resBody);
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
    // widget.loadData();
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
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 999,
            getTitlesWidget: (value, _) {
              return Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  '\$${value.toInt()}',
                  style: const TextStyle(
                      fontSize: 10), // Adjust the font size here
                ),
              ); // Y-axis labels
            },
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 2,
            getTitlesWidget: (value, _) {
              return Padding(
                padding: const EdgeInsets.only(left: 10, top: 5),
                child: Text(
                  'Week ${value.toInt() + 1}',
                  style: const TextStyle(
                      fontSize: 10), // Adjust the font size here
                ),
              ); // X-axis labels
            },
          ),
        ),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          color: gradientColors[0],
          // colors: gradientColors,
          barWidth: 2,
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

  @override
  Widget build(BuildContext context) {
    return LineChart(mainData());
  }
}



// class LinecChartWidget extends StatefulWidget {
//   const LinecChartWidget({super.key});

//   @override
//   State<LinecChartWidget> createState() => _LinecChartWidgetState();
// }

// class _LinecChartWidgetState extends State<LinecChartWidget> {
//   final List<Color> gradientColors = [
//     const Color(0xffFBC403),
//     const Color(0xffFF6302),
//   ];
//   @override
//   Widget build(BuildContext context) => LineChart(
//         LineChartData(
//           minX: 0,
//           maxX: 11,
//           minY: 50,
//           maxY: 0,
//           titlesData: FlTitlesData(
//             bottomTitles: const AxisTitles(
//               drawBelowEverything: true,
//               sideTitles: SideTitles(
//                 showTitles: true,
//                 reservedSize: 35,

//                 // getTextStyles: (value) => const TextStyle(
//                 //   color: Color(0xff68737d),
//                 //   fontWeight: FontWeight.bold,
//                 //   fontSize: 16,
//                 // ),
//                 interval: 8,

//                 // getTitlesWidget: (value) {
//                 //   switch () {
//                 //     case 2:
//                 //       return 'MAR';
//                 //     case 5:
//                 //       return 'JUN';
//                 //     case 8:
//                 //       return 'SEP';
//                 //   }
//                 //   return '';
//                 // },
//               ),
//             ),
//             rightTitles: const AxisTitles(
//               sideTitles: SideTitles(
//                 showTitles: false,
//               ),
//             ),
//             topTitles: const AxisTitles(
//               sideTitles: SideTitles(
//                 showTitles: false,
//               ),
//             ),
//             leftTitles: AxisTitles(
//               sideTitles: SideTitles(
//                 showTitles: true,
//                 // getTextStyles: (value) => const TextStyle(
//                 //   color: Color(0xff67727d),
//                 //   fontWeight: FontWeight.bold,
//                 //   fontSize: 15,
//                 // ),

//                 getTitlesWidget: (double value, TitleMeta titleMeta) {
//                   final intValue = value.toInt();
//                   switch (intValue) {
//                     case 1:
//                       return const Text('data1');
//                     case 3:
//                       return const Text('data3');
//                     case 5:
//                       return const Text('data5');
//                   }
//                   return const Text('');
//                 },

//                 reservedSize: 35,
//                 interval: 12,
//               ),
//             ),
//             show: true,
//           ),
//           // titlesData: LineTitles.getTitleData(),
//           gridData: FlGridData(
//             show: true,
//             getDrawingHorizontalLine: (value) {
//               return const FlLine(
//                 color: Color(0xff37434d),
//                 strokeWidth: 1,
//               );
//             },
//             drawVerticalLine: true,
//             getDrawingVerticalLine: (value) {
//               return const FlLine(
//                 color: Color(0xff37434d),
//                 strokeWidth: 1,
//               );
//             },
//           ),
//           borderData: FlBorderData(
//             show: true,
//             //border: Border.all(color: const Color(0xff37434d), width: 1),
//             border: const Border.fromBorderSide(
//               BorderSide(
//                 color: black,
//               ),
//             ),
//           ),
//           lineBarsData: [
//             LineChartBarData(
//               spots: [
//                 const FlSpot(0, 22),
//                 const FlSpot(2, 18.5),
//                 const FlSpot(3, 20),
//                 const FlSpot(4, 35),
//                 const FlSpot(5, 40),
//                 const FlSpot(6, 30),
//                 const FlSpot(7, 45),
//                 const FlSpot(8, 42),
//                 const FlSpot(9, 20),
//                 const FlSpot(10, 10),
//                 const FlSpot(11, 26),
//               ],
//               preventCurveOverShooting: true,
//               dotData: const FlDotData(
//                 show: false,
//               ),
//               isCurved: true,
//               color: white,

//               // gradient: LinearGradient(
//               //   colors: [
//               //     Color(0xffFBC403),
//               //     Color(0xffFF6302),
//               //   ],
//               //   begin: Alignment.centerRight,
//               //   end: Alignment.centerLeft,
//               // ),

//               barWidth: 3,
//               // dotData: FlDotData(show: false),
//               belowBarData: BarAreaData(
//                 show: true,
//                 gradient: const LinearGradient(
//                   colors: [
//                     Color(0xffFBC403),
//                     Color(0xffFF6302),
//                   ],
//                   begin: Alignment.centerRight,
//                   end: Alignment.centerLeft,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
// }
