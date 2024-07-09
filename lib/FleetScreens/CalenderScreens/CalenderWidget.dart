import 'package:deliver_partner/Constants/Colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderWidget extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  const CalenderWidget({super.key, required this.onDateSelected});

  @override
  State<CalenderWidget> createState() => _CalenderWidgetState();
}

class _CalenderWidgetState extends State<CalenderWidget> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TableCalendar(
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(3000, 3, 14),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) {
          // Use `selectedDayPredicate` to determine which day is currently selected.
          // If this returns true, then `day` will be marked as selected.
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          if (selectedDay.isAfter(DateTime.now())) {
            // Update your state to reflect the new selected day
            // and the new focused day if the selected day is in the future.
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
            widget.onDateSelected(
                selectedDay); // Call the callback with the selected day
            print(_selectedDay);
          } else {
            // Optionally, show a message to the user explaining why the day can't be selected.
          }
        },
        calendarStyle: CalendarStyle(
          cellMargin: const EdgeInsets.all(2), // Reduced from 5 to 2
          canMarkersOverflow: true,
          todayDecoration: BoxDecoration(
            color: orange,
            borderRadius:
                BorderRadius.circular(3), // Reduced for a less rounded effect
          ),
          selectedDecoration: BoxDecoration(
            color: grey,
            borderRadius:
                BorderRadius.circular(3), // Consistency with todayDecoration
          ),
          todayTextStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize:
                14, // Consider reducing font size if it's currently larger
          ),
          // Consider adding or adjusting other text styles for consistency
        ),
        headerStyle: HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
          titleTextStyle: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: grey,
          ),
        ),
        calendarBuilders: CalendarBuilders(
          selectedBuilder: (context, date, events) => Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                  color: orange, borderRadius: BorderRadius.circular(10.0)),
              child: Text(
                date.day.toString(),
                style: const TextStyle(color: Colors.white),
              )),
          todayBuilder: (context, date, events) => Container(
              margin: const EdgeInsets.all(2.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: orange, borderRadius: BorderRadius.circular(10.0)),
              child: Text(
                date.day.toString(),
                style: const TextStyle(color: Colors.white),
              )),
        ),
      ),
    );
  }
}
