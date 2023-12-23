// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/data_booking/add_booking_dialog.dart';
import 'package:housekeepingmanagement/dialog/bookingdialog.dart';
import 'package:housekeepingmanagement/frontdesk/widget/ListView.dart';
import 'package:housekeepingmanagement/frontdesk/widget/gridView.dart';
import 'package:housekeepingmanagement/housekeeping_status/housekeeping_botton.dart';
import 'package:housekeepingmanagement/system_widget/eventcalendar.dart';
import 'package:housekeepingmanagement/system_widget/system_color.dart';
import 'package:housekeepingmanagement/widget/bookingfilter.dart';
import 'package:housekeepingmanagement/widget/inputbox.dart';
import 'package:housekeepingmanagement/widget/sub_button/sub_button_frontdesk.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:table_calendar/table_calendar.dart';

DateTime dateurl = DateTime.now();
String roomStatusfilter = 'All';
String housekeepingStatusfilter = 'All';
String guestStatusfilter = 'All';

class FrontDesk extends StatefulWidget {
  const FrontDesk({super.key});

  @override
  _FrontDeskState createState() => _FrontDeskState();
}

class _FrontDeskState extends State<FrontDesk> {
  List<dynamic> bookings = [];
Key dropdownKey = UniqueKey();
  bool isLoading = true;
  String message = '';

  void reloadData() {
    setState(() {
      fetchBookingData();
      dropdownKey = UniqueKey();
    });
  }

  @override
  void initState() {
       isLoading = true;
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents =
        ValueNotifier(_getEventsForDay(_selectedDay!).cast<FrontDesk>());
    fetchBookingData();
  }

  bool isIcon1Active = false;
  bool isIcon2Active = false;
  Future<void> fetchBookingData() async {
    isLoading = true;
  
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateurl);
    final response = await http.get(Uri.parse(
        'http://localhost:8000/api/booking/all?date=${formattedDate}&booking_status=${roomStatusfilter}&housekeeping_status=${housekeepingStatusfilter}&guest_name=${guestStatusfilter}'));
    if (response.statusCode == 200) {
      
      isLoading = false;
      final Map<String, dynamic> responseData = json.decode(response.body);
      setState(() {
        bookings = responseData['data'];
        message = responseData['message'];

        
      });
    } else {
      print('Failed to load booking data');
    }
  }

  late final ValueNotifier<List<FrontDesk>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  int is_list_view = 4;
  bool list_view = false;
  String url1 = '';

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
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
        _rangeStart = null;
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
        dateurl = selectedDay;
        fetchBookingData();
      });

      _selectedEvents.value = _getEventsForDay(selectedDay).cast<FrontDesk>();
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

    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end).cast<FrontDesk>();
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start).cast<FrontDesk>();
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end).cast<FrontDesk>();
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateurl);
    Map<String, dynamic> newbooking = {};
     newbooking = {
      "booking_id": null,
      "id": null,
      "guest_id": null,
      "room_type": null,
      "room_id": 0,
      "payment_id": null,
      "booking_status": null,
      "cancel_date": null,
      "arrival_date": null,
      "departure_date": null,
      "checkin_date": null,
      "checkout_date": null,
      "adults": null,
      "child": null,
      "created_by": null,
      "note": null,
      "roomId": null,
      "room_number":null,
      "room_status":null,
      "roomtype":null,
      "floor": null,
      "room_rate": null,
      "housekeeper": null,
      "air_method": null,
      "payment": null,
      "payment_status": null,
      "extra_charge": null,
      "charges": null,
      "balance": null,
      "item_extra_charge": null,
      "name": null,
      "gender": null,
      "phone_number": null,
      "email": null,
      "country": null,
      "dob": null,
      "passport_number": null,
      "card_id": null,
      "other_information": null,
      "is_delete": null,
      "housekeeping_status": null,
      "date": null
    };
    return SingleChildScrollView(
      
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 880,
        child: Column(
          children: [
            Container(
              height: 70,
              margin: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AddBookingDialog(
                    action: () {
                      
                      BookingDialog(context, reloadData)
                          .showCreateBookingDialog(newbooking,dateurl);
                    },
                    key: UniqueKey(),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 9,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 7,
                            child: Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Scaffold(
                                  backgroundColor: Colors.transparent,
                                  body: Column(
                                    children: [
                                      Container(
                                        height: 80,
                                        decoration: const BoxDecoration(
                                          color: ColorController.barColor,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20.0),
                                            topRight: Radius.circular(20.0),
                                          ),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'Calendar',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 400,
                                        padding: const EdgeInsets.only(
                                            left: 20,
                                            top: 0,
                                            bottom: 10,
                                            right: 20),
                                        child: TableCalendar<Event>(
                                          firstDay: kFirstDay,
                                          lastDay: kLastDay,
                                          focusedDay: _focusedDay,
                                          selectedDayPredicate: (day) =>
                                              isSameDay(_selectedDay, day),
                                          rangeStartDay: _rangeStart,
                                          rangeEndDay: _rangeEnd,
                                          calendarFormat: _calendarFormat,
                                          rangeSelectionMode:
                                              _rangeSelectionMode,
                                          // eventLoader: _getEventsForDay,
                                          startingDayOfWeek:
                                              StartingDayOfWeek.monday,
                                          calendarStyle: const CalendarStyle(
                                            outsideDaysVisible: false,
                                            weekendTextStyle: TextStyle(
                                              color: Colors.red,
                                            ),
                                          ),
                                          onDaySelected: _onDaySelected,
                                          onRangeSelected: _onRangeSelected,
                                          onFormatChanged: (format) {
                                            if (_calendarFormat != format) {
                                              setState(
                                                () {
                                                  _calendarFormat = format;
                                                },
                                              );
                                            }
                                          },
                                          onPageChanged: (focusedDay) {
                                            _focusedDay = focusedDay;
                                          },
                                        ),
                                      ),
                                      const SizedBox(height: 8.0),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                           
                            child: Container(
                                key:UniqueKey(),
                             
                              padding: const EdgeInsets.all(10),
                              child: const Center(
                                child: SubButtonFrontdesk(),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    flex: 7,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 80,
                            padding: const EdgeInsets.only(top: 5, left: 35),
                            decoration: const BoxDecoration(
                              color: ColorController.barColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomDropdownFilter(
                                    parameter: 'YourParameter12',
                                    onChange: (roomStatus, housekeepingStatus,
                                        guestsname) {
                                      roomStatusfilter = roomStatus;
                                      housekeepingStatusfilter =
                                          housekeepingStatus;
                                      guestStatusfilter = guestsname;
                                      reloadData();
                                    },
                                    context: context,
                                  ),
                                  IconBox(
                                    icon1: Icons.grid_view_rounded,
                                    icon2: Icons.list,
                                    initialActiveIndex: 0,
                                    onChange: (newActiveIndex) {
                                      if (newActiveIndex == 0) {
                                       is_list_view = 4; 
                                       list_view =false;
                                      }else{
                                        list_view = true;
is_list_view = 1;
                                      }
                                      isLoading = true;
 fetchBookingData();

                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Scaffold(
                              backgroundColor: Colors.transparent,
                              body:   Skeletonizer(
        enabled: isLoading,
        child: ListView.builder(
                                      itemCount: (bookings.length / is_list_view).ceil(),
                                      itemBuilder:
                                          (BuildContext context, int rowIndex) {
                                        int startIndex = rowIndex * is_list_view;
                                        int endIndex = (rowIndex + 1) * is_list_view;
                                        if (endIndex > bookings.length) {
                                          endIndex = bookings.length;
                                        }
                                        List<Widget> bookingItems = [];
                                        for (int i = startIndex;
                                            i < endIndex;
                                            i++) {
                                          final booking = bookings[i];

                                          Icon statusIcon;
                                          switch (
                                              booking['housekeeping_status']) {
                                            case 'clean':
                                              statusIcon = const Icon(
                                                  Icons.check,
                                                  color: Colors.white);
                                              break;
                                            case 'cleaning':
                                              statusIcon = const Icon(
                                                  Icons.cleaning_services,
                                                  color: Colors.black);
                                              break;
                                            case 'dirty':
                                              statusIcon = const Icon(
                                                  Icons.error,
                                                  color: Colors.white);
                                              break;
                                            default:
                                              statusIcon = const Icon(
                                                  Icons.help,
                                                  color: Colors.white);
                                              break;
                                          }

                                          bookingItems.add(
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () {
                                                  if (booking['booking_id'] ==
                                                      null) {
                                                    BookingDialog(
                                                            context, reloadData)
                                                        .showCreateBookingDialog(
                                                            booking,dateurl);
                                                    ;
                                                  } else {
                                                    BookingDialog(
                                                            context, reloadData)
                                                        .showBookingDetailsDialog(
                                                            booking);
                                                  }
                                                },
                                                child: Column(
                                                  children: [
                                                    list_view ? ListViewbooking(booking: booking,) :
                                                    gridViewbooking(booking: booking,)
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
                                    ),
                              )
                            ),
                          )
                        ],
                      
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(
              flex: 1,
              child: HousekeepingButton(),
            ),
          ],
        ),
      ),
    );
  }
}
