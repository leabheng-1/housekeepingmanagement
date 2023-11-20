import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:housekeepingmanagement/system_widget/system_color.dart';
import 'package:housekeepingmanagement/widget/CurrencyInputFormatter.dart';
import 'package:money_input_formatter/money_input_formatter.dart';
class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final String? noteText;
  final Color borderColor;
  final double borderRadius;
  final double borderWidth;
  final double width;
  final double height;
  final double inputHeight;
  final bool isNumeric;
  final bool isCurrency;
  final bool enabled;
  final bool isNote;
  final ValueChanged<String>? onChanged; // New callback for text changes

  CustomTextField({
    Key? key,
    this.controller,
    required this.labelText,
    this.noteText,
    this.borderColor = const Color(0xFFb4b4b4),
    this.borderRadius = 10.0,
    this.borderWidth = 1.0,
    this.width = 450,
    this.height = 40,
    this.inputHeight = 30,
    this.isNumeric = false,
    this.isCurrency = false,
    this.enabled = true,
    this.isNote = false,
    this.onChanged, // Pass the callback function
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10),
          child: SizedBox(height: 2),
        ),
        Text(
          labelText,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (isNote && noteText != null)
          Text(
            noteText!,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        Container(
          width: width,
          height: height,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFf6f6f6),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: borderColor,
              width: borderWidth,
            ),
          ),
          alignment: Alignment.topLeft,
          child: TextFormField(
            keyboardType: isNumeric
                ? TextInputType.number
                : TextInputType.text,
            enabled: enabled,
            inputFormatters: isNumeric
                ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
                : (isCurrency
                    ? [CurrencyInputFormatter()]
                    : null),
            controller: controller,
            onChanged: (text) {
              // Invoke the callback function when text changes
              onChanged?.call(text);
            },
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 13),
            ),
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}



class DatePickerTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String labelText;
  final String mindate;
  final String enddate;
  final DateTime checkcurrnetdate;
  final Color borderColor;
  final double borderRadius;
  final double borderWidth;
  final double width;
  final double height;
  final double inputHeight;
  final void Function(DateTime selectedDate) onDateSelectedDate;

  const DatePickerTextField({
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
    required this.checkcurrnetdate,
    required this.onDateSelectedDate,
  });

  @override
  // ignore: library_private_types_in_public_api
  _DatePickerTextFieldState createState() => _DatePickerTextFieldState();
}

class _DatePickerTextFieldState extends State<DatePickerTextField> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.checkcurrnetdate;
  }

  Future<void> _selectDate(BuildContext context) async {
    String mindate = widget.mindate;
    String maxdate = widget.enddate;
    List<String> minCom = mindate.split('-');
    List<String> maxCom = maxdate.split('-');
    int yearMin = int.parse(minCom[0]);
    int monthMin = int.parse(minCom[1]);
    int dayMin = int.parse(minCom[2]);
    int yearMax = int.parse(maxCom[0]);
    int monthMax = int.parse(maxCom[1]);
    int dayMax = int.parse(maxCom[2]);
    final DateTime currentDate = _selectedDate ?? DateTime.now();
    final DateTime firstAllowedDate = DateTime(yearMin, monthMin, dayMin);
    final DateTime lastAllowedDate = DateTime(yearMax, monthMax, dayMax);

    final DateTime picked = (await showDatePicker(
          context: context,
          initialDate: currentDate,
          firstDate: firstAllowedDate,
          lastDate: lastAllowedDate,
        )) ??
        currentDate;

    if (picked != _selectedDate) {
      widget.onDateSelectedDate(picked);
      setState(() {
        _selectedDate = picked;

        if (widget.controller != null) {
          widget.controller!.text = "${picked.toLocal()}".split(' ')[0];
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10),
          child: SizedBox(height: 10),
        ),
        Text(
          widget.labelText,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          width: widget.width,
          height: widget.height,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border.all(
              color: widget.borderColor,
              width: widget.borderWidth,
            ),
          ),
          alignment: Alignment.center,
          child: InkWell(
            onTap: () {
              _selectDate(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  formatDateToDdMmmYyyy(_selectedDate),
                  style: const TextStyle(fontSize: 16),
                ),
                const Icon(Icons.calendar_today, color: Colors.blue),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String formatDateToDdMmmYyyy(DateTime? date) {
    if (date == null) {
      return 'Select Date';
    }

    final months = [
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

    final day = date.day.toString().padLeft(2, '0');
    final month = months[date.month - 1];
    final year = date.year;

    return '$day-$month-$year';
  }
}

class CustomDropdownButton extends StatefulWidget {
  final double width;
  final List<String> items;
  final String? selectedValue;
  final String? labelText;
  final List<String> items_value;
  final ValueChanged<String?>? onChanged;
  final String hintText;
  final double fontSize;
  final Color bg;
  final double marginTop;
  
  const CustomDropdownButton({
    super.key,
    required this.width,
    this.bg = const Color(0xFFf6f6f6),
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    this.items_value = const [],
    this.labelText = '',
    this.marginTop = 0,
    required this.hintText,
    this.fontSize = 14.0,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomDropdownButtonState createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: widget.labelText != null && widget.labelText!.isNotEmpty,
          child: const Padding(
            padding: EdgeInsets.only(left: 10),
            child: SizedBox(height: 10),
          ),
        ),
        Visibility(
          visible: widget.labelText != null && widget.labelText!.isNotEmpty,
          child: Text(
            widget.labelText!,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          height: 40,
          width: widget.width,
          margin: EdgeInsets.only(top: widget.marginTop),
          decoration: BoxDecoration(
            color: widget.bg,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color(0xFFb4b4b4),
            ),
          ),
          child: DropdownButtonFormField<String>(
            isExpanded: true,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(fontSize: widget.fontSize),
              contentPadding:
                  const EdgeInsets.only(left: 10, top: 0, bottom: 8, right: 0),
              border: InputBorder.none,
            ),
            
            value: widget.selectedValue!.isNotEmpty && widget.items.contains(widget.selectedValue) ? widget.selectedValue : null,
            items: widget.items.map((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: TextStyle(
                    fontSize: widget.fontSize,
                  ),
                ),
              );
            }).toList(),
            onChanged: widget.onChanged,
            selectedItemBuilder: (BuildContext context) {
              return widget.items.map<Widget>((String item) {
                return Text(
                  item,
                  style: TextStyle(
                    fontSize: widget.fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }).toList();
            },
          ),
        ),
      ],
    );
    
  }
  
}

class IconBox extends StatefulWidget {
  final IconData icon1;
  final IconData icon2;
  final int initialActiveIndex;
  final Function(int) onChange;
  final int view ;

  const IconBox({
    super.key,
    required this.icon1,
    required this.icon2,
    this.initialActiveIndex = 0,
    required this.onChange,
    this.view = 1
  });

  @override
  // ignore: library_private_types_in_public_api
  _IconBoxState createState() => _IconBoxState();
}

class _IconBoxState extends State<IconBox> {
  late int activeIndex;
  @override
  void initState() {
    super.initState();
    activeIndex = widget.initialActiveIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Row(
        children: [
          buildIcon(0, widget.icon1),
          const SizedBox(width: 5),
          buildIcon(1, widget.icon2),
        ],
      ),
    );
  }

  Widget buildIcon(int index, IconData icon) {
    final isActive = activeIndex == index;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          setState(() {
            activeIndex = index;
          });

          widget.onChange(activeIndex);
        },
        child: Container(
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: isActive
                ? ColorController.activeColor.withOpacity(0.2)
                : Colors.white,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Icon(
            icon,
            color: isActive ? ColorController.activeColor : Colors.black,
            size: 24.0,
          ),
        ),
      ),
    );
  }
}

class DateRangeWidget extends StatefulWidget {
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
final void Function(DateTime checkin, DateTime checkout, int nights) onChange;
  DateRangeWidget({
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
     required this.onChange,
  });
  @override
  _DateRangeWidgetState createState() => _DateRangeWidgetState();
}

class _DateRangeWidgetState extends State<DateRangeWidget> {
  DateTime? _checkInDate;
  DateTime? _checkOutDate;
  
  int _numberOfNights = 1; // Initialize with 1 night as default
  

  @override
 void initState() {
    super.initState();
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
           _updateValues();

        }
        // Calculate the number of nights
        final duration = _checkOutDate!.difference(_checkInDate!);
        _numberOfNights = duration.inDays;
      });
      widget.onDateSelectedDate(picked!);
       _updateValues();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
  children: [
    Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: SizedBox(height: 10),
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
        ],
      ),
    ),
    
    
    Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: SizedBox(height: 10),
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
                _selectDate(context, false); // Select Check-Out date
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    _checkOutDate != null
                        ? "${_checkOutDate!.toLocal()}".split(' ')[0]
                        : 'Select',
                    style: TextStyle(fontSize: 16),
                  ),
                  Icon(Icons.calendar_today, color: Colors.blue),
                ],
              ),
            ),
            alignment: Alignment.center,
          ),
        ],
      ),
    ),
  ],
);

  }
  void _updateValues() {
    widget.onChange(_checkInDate!, _checkOutDate!, _numberOfNights);
  }
}

