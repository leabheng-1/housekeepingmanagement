import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/frontdesk/widget/formatSystem.dart';

class DateRangePickerWidget extends StatefulWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? mindate;
  final String? enddate;
  final DateTime checkcurrentdate;
  final Color borderColor;
  final double borderRadius;
  final double borderWidth;
  final double width;
  final double height;
  final double inputHeight;
  final void Function(DateTime selectedDate) onDateSelectedDate;
  final TextEditingController? checkin;
  final TextEditingController? checkout;
  final TextEditingController? night;
  final void Function(DateTime checkin, DateTime checkout, int nights) onChange;
  const DateRangePickerWidget({
    super.key,
    this.controller,
    required this.labelText,
    this.borderColor = const Color(0xFFb4b4b4),
    this.borderRadius = 10.0,
    this.borderWidth = 1.0,
    this.width = 450,
    this.height = 40,
    this.inputHeight = 30,
    this.mindate = '1900-1-1',
    this.enddate = '2500-1-1',
    required this.checkcurrentdate,
    required this.onDateSelectedDate,
    this.checkin,
    this.checkout,
    this.night,
    required this.onChange,
  });
  @override
  // ignore: library_private_types_in_public_api
  _DateRangePickerWidgetState createState() => _DateRangePickerWidgetState();
}

class _DateRangePickerWidgetState extends State<DateRangePickerWidget> {
  DateTime? _checkInDate;
  DateTime? _checkOutDate;

  int _numberOfNights = 1;

  @override
  void initState() {
    super.initState();
    if (widget.night!.text.isNotEmpty) {
      _numberOfNights = int.parse(widget.night!.text);
      _updateValues();
    }
    _checkInDate = widget.checkin!.text.isNotEmpty
        ? DateTime.parse(widget.checkin!.text)
        : widget.checkcurrentdate;
    _checkOutDate = widget.checkout!.text.isNotEmpty
        ? DateTime.parse(widget.checkout!.text)
        : _checkInDate!.add(
          
            Duration(days: _numberOfNights),
          );
  }

  Future<void> _selectDate(BuildContext context, bool isCheckIn) async {
    String? mindate = widget.mindate;
    String? maxdate = widget.enddate;
    List<String> minCom = mindate!.split('-');
    List<String> maxCom = maxdate!.split('-');
    int yearMin = int.parse(minCom[0]);
    int monthMin = int.parse(minCom[1]);
    int dayMin = int.parse(minCom[2]);
    int yearMax = int.parse(maxCom[0]);
    int monthMax = int.parse(maxCom[1]);
    int dayMax = int.parse(maxCom[2]);

    final DateTime currentDate = isCheckIn ? _checkInDate! : _checkOutDate!;
    final DateTime firstAllowedDate = DateTime(yearMin, monthMin, dayMin);
    final DateTime lastAllowedDate = DateTime(yearMax, monthMax, dayMax);
_updateValues();
    DateTime? picked = (await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: firstAllowedDate,
      lastDate: lastAllowedDate,
    ));

    if (picked != null) {
      setState(() {
        if (isCheckIn) {
          _checkInDate = picked;
_updateValues();
          if (_checkOutDate!.isBefore(_checkInDate!)) {

            _checkOutDate = _checkInDate!.add(
              
              Duration(days: _numberOfNights),
            );
            
            _updateValues();
          }
        } else {
          if (picked!.isBefore(_checkInDate!)) {
            picked = _checkInDate!.add(
              Duration(days: _numberOfNights),
            );
            _updateValues();
          }
          _checkOutDate = picked;

_updateValues();        }

        final duration = _checkOutDate!.difference(_checkInDate!);
        _numberOfNights = duration.inDays;
      });
      widget.onDateSelectedDate(picked!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: SizedBox(height: 10),
          ),
           
                RichText(
  text: TextSpan(
    children: [
      TextSpan(
        text: 'Check In',
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),  // Replace 'showAsterisk' with your actual condition
        TextSpan(
          text: ' *',
          style: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
    ],
  ),
),
SizedBox(height: 5,),
          Container(
            width: 200,
            height: widget.height,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: const Color(0xFFF6F6F6),
              borderRadius: BorderRadius.circular(widget.borderRadius),
              border: Border.all(
                color: widget.borderColor,
                width: widget.borderWidth,
              ),
            ),
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {
                _selectDate(context, true);
                _updateValues();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    formatDateToDdMmmYyyy(_checkInDate),
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Icon(Icons.calendar_today, color: Colors.blue),
                ],
              ),
            ),
          ),
        ]),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: SizedBox(height: 10),
            ),
                            RichText(
  text: TextSpan(
    children: [
      TextSpan(
        text: 'Check Out',
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),  // Replace 'showAsterisk' with your actual condition
        TextSpan(
          text: ' *',
          style: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
    ],
  ),
),
SizedBox(height: 5,),
            Container(
              width: 200,
              height: widget.height,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFFF6F6F6),
                borderRadius: BorderRadius.circular(widget.borderRadius),
                border: Border.all(
                  color: widget.borderColor,
                  width: widget.borderWidth,
                ),
              ),
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  _updateValues();
                  _selectDate(context, false);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      formatDateToDdMmmYyyy(_checkOutDate),
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Icon(Icons.calendar_today, color: Colors.blue),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: SizedBox(height: 10),
            ),
                            RichText(
  text: TextSpan(
    children: [
      TextSpan(
        text: 'Nights',
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),  // Replace 'showAsterisk' with your actual condition
        TextSpan(
          text: ' *',
          style: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
    ],
  ),
),
SizedBox(height: 5,),
            Container(
              width: 120,
              height: widget.height,
              decoration: BoxDecoration(
                color: const Color(0xFFF6F6F6),
                borderRadius: BorderRadius.circular(widget.borderRadius),
                border: Border.all(
                  color: widget.borderColor,
                  width: widget.borderWidth,
                ),
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      setState(
                        () {
                          if (_numberOfNights > 1) {
                            _numberOfNights--;
                            _checkOutDate = _checkInDate!.add(
                              Duration(days: _numberOfNights),
                            );
                            _updateValues();
                          }
                        },
                      );
                    },
                  ),
                  Text(
                    '$_numberOfNights',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(
                        () {
                          _numberOfNights++;
                          _checkOutDate = _checkInDate!.add(
                            Duration(days: _numberOfNights),
                          );
                          _updateValues();
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  void _updateValues() {
    if (_checkInDate != null && _checkOutDate != null) {
      int numberOfNights = _checkOutDate!.difference(_checkInDate!).inDays;

      widget.onChange(_checkInDate!, _checkOutDate!, numberOfNights);
    }
  }

  String formatDateToDdMmmYyyy(DateTime? date) {
    if (date == null) {
      return 'Select Check-Out';
    } else {
      final List<String> months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ];

      String day = date.day.toString().padLeft(2, '0');
      String month = months[date.month - 1];
      String year = date.year.toString();

      return '$day-$month-$year';
    }
  }
}
