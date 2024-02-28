import 'package:fl_chart/fl_chart.dart';

class LineTitles {
  static getTitleData() => const FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
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
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            // getTextStyles: (value) => const TextStyle(
            //   color: Color(0xff67727d),
            //   fontWeight: FontWeight.bold,
            //   fontSize: 15,
            // ),
            // getTitles: (value) {
            //   switch (value.toInt()) {
            //     case 1:
            //       return '10k';
            //     case 3:
            //       return '30k';
            //     case 5:
            //       return '50k';
            //   }
            //   return '';
            // },
            reservedSize: 35,
            interval: 12,
          ),
        ),
      );
}
