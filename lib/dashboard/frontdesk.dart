import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/dialog/bookingdialog.dart';
import 'package:housekeepingmanagement/system_widget/eventcalendar.dart';
import 'package:housekeepingmanagement/system_widget/system_color.dart';
import 'package:housekeepingmanagement/system_widget/system_icon.dart';
import 'package:housekeepingmanagement/widget/bookingfilter.dart';
import 'package:housekeepingmanagement/widget/inputbox.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
DateTime dateurl = DateTime.now();
String roomStatusfilter ='All' ;
String housekeepingStatusfilter ='All' ;
String guestStatusfilter ='All' ;
class bookingLayout extends StatefulWidget {
  @override
  _bookingLayoutState createState() => _bookingLayoutState();
}

class _bookingLayoutState extends State<bookingLayout> {
  List<dynamic> bookings = [];
 
  bool isLoading = true;
  String message = '';
  
 void reloadData() {
    setState(() {
      fetchBookingData();
    });
  }

  @override
  void initState() {
    super.initState();
     _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!).cast<bookingLayout>());
    fetchBookingData();
  
  }
   bool isIcon1Active = false;
  bool isIcon2Active = false;
  Future<void> fetchBookingData() async {
      isLoading = true;
      String formattedDate = DateFormat('yyyy-MM-dd').format(dateurl);
    final response =
        await http.get(Uri.parse('http://localhost:8000/api/booking/all?date=${formattedDate}&room_status=${roomStatusfilter}&housekeeping_status=${housekeepingStatusfilter}&guest_name=${guestStatusfilter}'));
        print('http://localhost:8000/api/booking/all?date=${formattedDate}&room_status=${roomStatusfilter}&housekeeping_status=${housekeepingStatusfilter}&guest_name=${guestStatusfilter}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      setState(() {
        bookings = responseData['data'];
        message = responseData['message'];
        
        isLoading = false;
      });
    } else {
      print('Failed to load booking data');
    }
  }

  late final ValueNotifier<List<bookingLayout>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
String url1 = '';


  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }


  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
        dateurl = selectedDay;
       print(_focusedDay);
       fetchBookingData();
    print(dateurl);
    
      });

      _selectedEvents.value = _getEventsForDay(selectedDay).cast<bookingLayout>();
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end).cast<bookingLayout>();
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start).cast<bookingLayout>();
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end).cast<bookingLayout>();
    }
  }
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> newbooking = {

};
    double screenWidth =MediaQuery.of(context).size.width * 0.4 ;
    return 
    
    Scaffold(
      body: Column(
        children: [
          // First row taking up 20% of vertical space
          Expanded(
  flex: 1, // 20% of available space in the column
  child: Container(
    margin: EdgeInsets.all(8.0), // Margin settings for Col 2
    decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(12.0), // Border radius for Col 2
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end, // Align the button to the right
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0), // Add padding to make the button bigger
          child: ElevatedButton.icon(
            onPressed: () {
               BookingDialog(context,reloadData).showCreateBookingDialog(newbooking);
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.blue, // Background color
            ),
            icon: Icon(Icons.add), // Icon
            label: Text('New Booking'), // Label
          ),
        ),
      ],
    ),
  ),
),


          // Second row taking up 80% of vertical space
          Expanded(
            flex: 9, // 80% of available space
            child: Row(
              children: [
                // First column taking up 20% of horizontal space
                Expanded(
                  flex: 3, // 20% of available space in the row
                  child: Column(
  children: [
    Expanded(
      flex: 5, 
      // 20% of available space in the column
      
      child: Container(// Margin settings for Col 1
        child: Center(
          child: Scaffold(
      body: Column(
        children: [
           Container(
    height: 80,
    margin: EdgeInsets.all(8.0), // Set margin for Col 1
    decoration: BoxDecoration(
      color: Colors.green, // Set background color for Col 1
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0), // Set the top-left corner radius
        topRight: Radius.circular(20.0), // Set the top-right corner radius
      ),
    ),
    child: Center(
      child: Text(
        'Calendar',
        style: TextStyle(
          color:Colors.white,
          fontSize: 24,
        ),
      ),
    ),
  ),
          TableCalendar<Event>(
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            calendarFormat: _calendarFormat,
            rangeSelectionMode: _rangeSelectionMode,
            eventLoader: _getEventsForDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: CalendarStyle(
              // Use `CalendarStyle` to customize the UI
              outsideDaysVisible: false,
               weekendTextStyle: TextStyle(
      color: Colors.red, // Set the color to red for Sat and Sun
    ),
            ),
            onDaySelected: _onDaySelected,
            onRangeSelected: _onRangeSelected,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          const SizedBox(height: 8.0),

        ],
      ),
    ),
        ),
      ),
    ),
    Expanded(
  child: Container(
    margin: EdgeInsets.all(8.0),
    height: 400.0, // Set the height to 100.0 (adjust as needed)
    child: Center(
      child: Text('Col 2'),
    ),
  ),
)

  ],
)
                ),
                // Second column taking up 80% of horizontal space
                Expanded(
                 
                  flex: 7, // 80% of available space in the row
                  child:  Column(
                    
              children: [
                Container(
      height: 80,
      padding: EdgeInsets.only(top:5,left:30),
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Padding(
  padding: EdgeInsets.all(16.0), // Adjust the padding as needed
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      CustomDropdownFilter(
        parameter: 'YourParameter',
        onChange: (roomStatus, housekeepingStatus, guestsname) {
          roomStatusfilter = roomStatus;
          housekeepingStatusfilter = housekeepingStatus ?? 'sdf';
          guestStatusfilter = guestsname;
          reloadData();
          print('Checkin: $roomStatusfilter, Checkout: $housekeepingStatus, Nights: $guestsname');
        },
        context: context,
      ),
      IconBox(
  icon1: Icons.star,
  icon2: Icons.favorite,
  initialActiveIndex: 1,
  onChange: (newActiveIndex) {
    // Do something with the new active index.
    print("Active index changed to $newActiveIndex");
  },
)

    ],
  ),
),

    ),
  
                Expanded(
                  
                child:
                Container( // Margin settings for Col 2

                    
                    child:
    Scaffold(
      body:

       isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
  itemCount: (bookings.length / 4).ceil(),
  itemBuilder: (BuildContext context, int rowIndex) {
    int startIndex = rowIndex * 4;
    int endIndex = (rowIndex + 1) * 4;
    if (endIndex > bookings.length) {
      endIndex = bookings.length;
    }

    List<Widget> bookingItems = [];
    for (int i = startIndex; i < endIndex; i++) {
      final booking = bookings[i];

      Color statusColor;
      Icon statusIcon;
      switch (booking['housekeeping_status']) {
        case 'clean':
          statusColor = Colors.green;
          statusIcon = Icon(Icons.check, color: Colors.white);
          break;
        case 'cleaning':
          statusColor = Colors.yellow;
          statusIcon = Icon(Icons.cleaning_services, color: Colors.black);
          break;
        case 'dirty':
          statusColor = Colors.brown;
          statusIcon = Icon(Icons.error, color: Colors.white);
          break;
        default:
          statusColor = Colors.grey;
          statusIcon = Icon(Icons.help, color: Colors.white);
          break;
      }

      bookingItems.add(
        GestureDetector(
          onTap: () {
            if (booking['booking_id'] == null) {
              BookingDialog(context,reloadData).showCreateBookingDialog(booking);
;
            } else {
              BookingDialog(context,reloadData).showBookingDetailsDialog(booking);
            }
          },
          child: Container(
            height: 160, // Set the height as desired
            width:(MediaQuery.of(context).size.width / 4 - MediaQuery.of(context).size.width * 0.08 ) - 20 , // Adjust based on your layout
            margin: EdgeInsets.all(8.0), // Add margin
            padding: EdgeInsets.all(16.0), // Add padding
            decoration: BoxDecoration(
              color: Colors.lightBlue, // Set the background color
              borderRadius: BorderRadius.circular(10.0), // Add rounded corners
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Tooltip(
      message: 'Room Need ${booking['air_method']} ',
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue,
        ),
        child: Icon(iconController.airMethod(booking['air_method']),size:16, color: Color.fromARGB(255, 255, 255, 255)),
      ),
    ),
                     
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                  children: [
                    Text(
                      '${booking['room_number']}',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        height: 1, // Set the line height for Room Number
                      ),
                    ),
                 SizedBox(height:2),
                                   Text(
                      '${booking['name']}',
                      style: TextStyle(height: 1,fontSize: 16), // Set the line height for other text
                    ),
                      Row(
  children: [
     Text(
                      '${booking['checkin_date']} - ',
                      style: TextStyle(height: 1,fontSize: 12), // Set the line height for other text
                    ),
                    Text(
                      '${booking['checkout_date']}',
                      style: TextStyle(height: 1,fontSize: 12), // Set the line height for other text
                    ),
  ]),
                   
                    SizedBox(height:30),
Row(
  children: [
    Tooltip(
      message: 'This Room ${booking['housekeeping_status'] ?? ''}',
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ColorController.getHKColor(booking['housekeeping_status'] ?? ''),
        ),
        child: Icon(iconController.khIcon, size: 16, color: Colors.white),
      ),
    ),
    SizedBox(width: 10),
    Tooltip(
      message: 'Room ${booking['booking_status'] ?? booking['room_status'] ?? ''}',
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ColorController.bookingStatus(booking['booking_status'] ?? booking['room_status'] ?? ''),
        ),
        child: Icon(iconController.bookingStatus(booking['booking_status'] ?? booking['room_status'] ?? ''), size: 16, color: Colors.white),
      ),
    ),
    SizedBox(width: 10),
    if (booking['booking_id'] != null)
      Tooltip(
        message: 'Your Tooltip Message 2',
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue,
          ),
          child: statusIcon,
        ),
      ),
  ],
)

                  ],
                ),
              ],
            ),
          
          ),
        ),
      );
    }

    return Row(
      children: bookingItems,
    );
  },
)
   )
                  ),
                )
              ]),
              
                ),
              ],
            ),
          ),
        ],
      ),
    ); 
    
    
  }
}
