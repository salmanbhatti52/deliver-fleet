import 'package:Deliver_Rider/Constants/Colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderWidget extends StatefulWidget {
  const CalenderWidget({super.key});

  @override
  State<CalenderWidget> createState() => _CalenderWidgetState();
}

class _CalenderWidgetState extends State<CalenderWidget> {
  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(3000, 3, 14),
      focusedDay: DateTime.now(),
      calendarStyle: CalendarStyle(
          canMarkersOverflow: true,
          todayDecoration: BoxDecoration(
              color: orange, borderRadius: BorderRadius.circular(5)),
          selectedDecoration: BoxDecoration(
            color: grey,
          ),
          todayTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
              color: Colors.white)),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleTextStyle: GoogleFonts.inter(
          fontSize: 17,
          fontWeight: FontWeight.w500,
          color: grey,
        ),
        // titleCentered: true,
        // formatButtonDecoration: BoxDecoration(
        //   color: Colors.orange,
        //   borderRadius: BorderRadius.circular(20.0),
        // ),
        // formatButtonTextStyle: TextStyle(color: Colors.white),
        // formatButtonShowsNext: false,
      ),
      calendarBuilders: CalendarBuilders(
        selectedBuilder: (context, date, events) => Container(
            margin: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10.0)),
            child: Text(
              date.day.toString(),
              style: TextStyle(color: Colors.white),
            )),
        todayBuilder: (context, date, events) => Container(
            margin: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(10.0)),
            child: Text(
              date.day.toString(),
              style: TextStyle(color: Colors.white),
            )),
      ),
    );
  }
}
