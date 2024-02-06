import 'package:deliver_partner/Constants/Colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LinecChartWidget extends StatefulWidget {
  const LinecChartWidget({super.key});

  @override
  State<LinecChartWidget> createState() => _LinecChartWidgetState();
}

class _LinecChartWidgetState extends State<LinecChartWidget> {
  final List<Color> gradientColors = [
    const Color(0xffFBC403),
    const Color(0xffFF6302),
  ];
  @override
  Widget build(BuildContext context) => LineChart(
        LineChartData(
          minX: 0,
          maxX: 11,
          minY: 50,
          maxY: 0,
          titlesData: FlTitlesData(
            bottomTitles: const AxisTitles(
              drawBelowEverything: true,
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 35,

                // getTextStyles: (value) => const TextStyle(
                //   color: Color(0xff68737d),
                //   fontWeight: FontWeight.bold,
                //   fontSize: 16,
                // ),
                interval: 8,

                // getTitlesWidget: (value) {
                //   switch () {
                //     case 2:
                //       return 'MAR';
                //     case 5:
                //       return 'JUN';
                //     case 8:
                //       return 'SEP';
                //   }
                //   return '';
                // },
              ),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                // getTextStyles: (value) => const TextStyle(
                //   color: Color(0xff67727d),
                //   fontWeight: FontWeight.bold,
                //   fontSize: 15,
                // ),

getTitlesWidget: (double value, TitleMeta titleMeta) {
  final intValue = value.toInt();
  switch (intValue) {
    case 1:
      return Text('data1');
    case 3:
      return Text('data3');
    case 5:
      return Text('data5');
  }
  return Text('defaultData');
},

                reservedSize: 35,
                interval: 12,
              ),
            ),
            show: true,
          ),
          // titlesData: LineTitles.getTitleData(),
          // gridData: FlGridData(
          //   show: true,
          //   getDrawingHorizontalLine: (value) {
          //     return FlLine(
          //       color: const Color(0xff37434d),
          //       strokeWidth: 1,
          //     );
          //   },
          //   drawVerticalLine: true,
          //   getDrawingVerticalLine: (value) {
          //     return FlLine(
          //       color: const Color(0xff37434d),
          //       strokeWidth: 1,
          //     );
          //   },
          // ),
          borderData: FlBorderData(
            show: true,
            //border: Border.all(color: const Color(0xff37434d), width: 1),
            border: const Border.fromBorderSide(
              BorderSide(
                color: black,
              ),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: [
                const FlSpot(0, 22),
                const FlSpot(2, 18.5),
                const FlSpot(3, 20),
                const FlSpot(4, 35),
                const FlSpot(5, 40),
                const FlSpot(6, 30),
                const FlSpot(7, 45),
                const FlSpot(8, 42),
                const FlSpot(9, 20),
                const FlSpot(10, 10),
                const FlSpot(11, 26),
              ],
              preventCurveOverShooting: true,
              dotData: const FlDotData(
                show: false,
              ),
              isCurved: true,
              color: white,

              // gradient: LinearGradient(
              //   colors: [
              //     Color(0xffFBC403),
              //     Color(0xffFF6302),
              //   ],
              //   begin: Alignment.centerRight,
              //   end: Alignment.centerLeft,
              // ),

              barWidth: 3,
              // dotData: FlDotData(show: false),
              // belowBarData: BarAreaData(
              //   show: true,
              //   gradient: LinearGradient(
              //     colors: [
              //       Color(0xffFBC403),
              //       Color(0xffFF6302),
              //     ],
              //     begin: Alignment.centerRight,
              //     end: Alignment.centerLeft,
              //   ),
              // ),
            ),
          ],
        ),
      );
}
