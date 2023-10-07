import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class TableCalendarWidget extends StatefulWidget {
  const TableCalendarWidget({Key? key}) : super(key: key);

  @override
  State<TableCalendarWidget> createState() => _TableCalendarState();
}

class _TableCalendarState extends State<TableCalendarWidget> {
  DateTime today = DateTime.now();
  CalendarFormat calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    today = DateTime.now();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      today = selectedDay;
    });
  }

  void _goToToday() {
    setState(() {
      today = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          locale: 'en_US',
          rowHeight: 30,
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
          ),
          availableGestures: AvailableGestures.all,
          selectedDayPredicate: (day) => isSameDay(day, today),
          focusedDay: today, // Focus on the selected day
          firstDay: DateTime.utc(2010, 10, 10),
          lastDay: DateTime.utc(2050, 1, 1),
          onDaySelected: _onDaySelected,
          calendarStyle: const CalendarStyle(
            weekendTextStyle: TextStyle(color: Colors.red),
          ),
          calendarFormat: calendarFormat,
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextButton(
            onPressed: _goToToday,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              side: MaterialStateProperty.all(
                  BorderSide(color: Colors.grey.shade400, width: 2.0)),
              minimumSize: MaterialStateProperty.all(const Size(300.0, 40.0)),
            ),
            child: const Text(
              "Today",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }
}
