import 'package:flutter/material.dart';

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
  final double height; // Height of the container
  final double inputHeight; // Height of the input field
  final void Function(DateTime selectedDate) onDateSelectedDate;
  final TextEditingController? checkin;
  final TextEditingController? checkout;
  final TextEditingController?  night;
final void Function(DateTime checkin, DateTime checkout, int nights) onChange;
  DateRangePickerWidget({
    this.controller,
    required this.labelText,
    this.borderColor = Colors.black, // Border color
    this.borderRadius = 10.0, // Border radius
    this.borderWidth = 1.0, // Border width
    this.width = 450, // Default margin
    this.height = 40, // Height of the container
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
  _DateRangePickerWidgetState createState() => _DateRangePickerWidgetState();
}

class _DateRangePickerWidgetState extends State<DateRangePickerWidget> {
  DateTime? _checkInDate;
  DateTime? _checkOutDate;
  
  int _numberOfNights = 1; // Initialize with 1 night as default
  

  @override
 void initState() {
    super.initState();
     if (widget.night!.text.isNotEmpty) {
  
      _numberOfNights = int.parse(widget.night!.text);
     }
    _checkInDate = widget.checkin!.text.isNotEmpty
        ? DateTime.parse(widget.checkin!.text)
        : widget.checkcurrentdate; // Use default or provided check-in date
    _checkOutDate = widget.checkout!.text.isNotEmpty
        ? DateTime.parse(widget.checkout!.text)
        : _checkInDate!.add(Duration(
            days:
                _numberOfNights)); // Use default or calculate check-out date based on check-in date
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
          // Ensure that check-out date is not before check-in date
          if (_checkOutDate!.isBefore(_checkInDate!)) {
            _checkOutDate = _checkInDate!.add(Duration(days: _numberOfNights));
             _updateValues();
          }
        } else {
          // Ensure that check-out date is not before check-in date
          if (picked!.isBefore(_checkInDate!)) {
            picked = _checkInDate!.add(Duration(days: _numberOfNights));
             _updateValues();
          }
          _checkOutDate = picked;

        }
        // Calculate the number of nights
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
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: SizedBox(height: 10),

          ),
          Text(
            'Check Out',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            width: 200,
            height: widget.height,
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(widget.borderRadius),
              border: Border.all(
                color: widget.borderColor,
                width: widget.borderWidth,
              ),
            ),
            child: InkWell(
              onTap: () {
                _selectDate(context, true); // Select Check-In date
                 _updateValues();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    _checkInDate != null
                        ? "${_checkInDate!.toLocal()}".split(' ')[0]
                        : 'Select Check-In',
                    style: TextStyle(fontSize: 16),
                  ),
                  Icon(Icons.calendar_today, color: Colors.blue),
                ],
              ),
            ),
            alignment: Alignment.center,
          ),
        ]),
        SizedBox(width: 15),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: SizedBox(height: 10),
          ),
          Text(
            'Check In',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            width: 200,
            height: widget.height,
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(widget.borderRadius),
              border: Border.all(
                color: widget.borderColor,
                width: widget.borderWidth,
              ),
            ),
            child: InkWell(
              onTap: () {
                 _updateValues();
                _selectDate(context, false); // Select Check-Out date
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    _checkOutDate != null
                        ? "${_checkOutDate!.toLocal()}".split(' ')[0]
                        : 'Select Check-Out',
                    style: TextStyle(fontSize: 16),
                  ),
                  Icon(Icons.calendar_today, color: Colors.blue),
                ],
              ),
            ),
            alignment: Alignment.center,
          ),
        ]),
        SizedBox(width: 15),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: SizedBox(height: 10),
          ),
          Text(
            'Nights',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            width: 120,
            height: widget.height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(widget.borderRadius),
              border: Border.all(
                color: widget.borderColor,
                width: widget.borderWidth,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (_numberOfNights > 1) {
                        _numberOfNights--;
                        _checkOutDate =
                            _checkInDate!.add(Duration(days: _numberOfNights));
                             _updateValues();
                      }
                    });
                  },
                ),
                Container(
                  child: Text(
                    '$_numberOfNights',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      _numberOfNights++;
                      _checkOutDate =
                          _checkInDate!.add(Duration(days: _numberOfNights));
                          _updateValues();
                    });
                  },
                ),
              ],
            ),
            alignment: Alignment.center,
          ),
        ])
      ],
    );
  }
  void _updateValues() {
    widget.onChange(_checkInDate!, _checkOutDate!, _numberOfNights);
  }
}
