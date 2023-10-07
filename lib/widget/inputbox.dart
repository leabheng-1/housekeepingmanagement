import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final Color borderColor;
  final double borderRadius;
  final double borderWidth;
  final double width;
  final double height; // Height of the container
  final double inputHeight; // Height of the input field
  final bool isNumeric; // Indicates whether the input should be numeric or not

  CustomTextField({
    this.controller,
    required this.labelText,
    this.borderColor = Colors.black, // Border color
    this.borderRadius = 10.0, // Border radius
    this.borderWidth = 1.0, // Border width
    this.width = 450, // Default margin
    this.height = 40, // Height of the container
    this.inputHeight = 30, // Height of the input field
    this.isNumeric = false, // Default to regular text input
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10), // Set margin around the SizedBox
          child: SizedBox(height: 10), // Add spacing here
        ),
        Text(
          labelText,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          width: width,
          height: height, // Set the height of the container

          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: borderColor, // Border color
              width: borderWidth, // Border width
            ),
          ),
          child: Center(
            child: TextFormField(
              keyboardType:TextInputType.number,
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 13),
              ),
              style: TextStyle(fontSize: 16), // Adjust font size as needed
            ),
          ),
          alignment: Alignment.center, // Align the contents (Text) to the center
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
  final double height; // Height of the container
  final double inputHeight; // Height of the input field
  final void Function(DateTime selectedDate) onDateSelectedDate;

  DatePickerTextField({
    this.controller,
    required this.labelText,
    this.borderColor = Colors.black, // Border color
    this.borderRadius = 10.0, // Border radius
    this.borderWidth = 1.0, // Border width
    this.width = 450, // Default margin
    this.height = 40, // Height of the container
    this.inputHeight = 30,  this.mindate =  '1900-1-1' ,
    this.enddate = '2500-1-1', 
    required this.checkcurrnetdate,
    required this.onDateSelectedDate,
     // Height of the input field
  });

  @override
  _DatePickerTextFieldState createState() => _DatePickerTextFieldState();
}

class _DatePickerTextFieldState extends State<DatePickerTextField> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate =  widget.checkcurrnetdate; // Initialize with today's date
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
  final DateTime firstAllowedDate = DateTime(yearMin, monthMin, dayMin); // Set your minimum allowed date
  final DateTime lastAllowedDate = DateTime(yearMax, monthMax, dayMax); // Set your maximum allowed date

  final DateTime picked = (await showDatePicker(
    context: context,
    initialDate: currentDate,
    firstDate: firstAllowedDate,
    lastDate: lastAllowedDate,
  )) ?? currentDate;

    if (picked != null && picked != _selectedDate) {
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
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: SizedBox(height: 10),
        ),
        Text(
          widget.labelText,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          width:widget.width,
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
              _selectDate(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  _selectedDate != null
                      ? "${_selectedDate!.toLocal()}".split(' ')[0]
                      : 'Select Date',
                  style: TextStyle(fontSize: 16),
                ),
                Icon(Icons.calendar_today, color: Colors.blue),
              ],
            ),
          ),
          alignment: Alignment.center,
        ),
      ],
    );
  }
}

class CustomDropdownButton extends StatefulWidget {
  final double width;
  final List<String> items;
  final String? selectedValue;
  final String? labelText;
  
  final ValueChanged<String?>? onChanged;
  final String hintText;
  final double fontSize;
  final Color bg;
final double marginTop;
  CustomDropdownButton({
    required this.width,
    this.bg = Colors.white,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    this.labelText = '',
    this.marginTop=0,
    required this.hintText, // Change label to hintText
    this.fontSize = 14.0, // Default font size is 14.0
  });

  @override
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
      child: Padding(
        padding: EdgeInsets.only(left: 10),
        child: SizedBox(height: 10),
      ),
    ),
    Visibility(
      visible: widget.labelText != null && widget.labelText!.isNotEmpty,
      child: Text(
        widget.labelText!,
        style: TextStyle(
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
          color: Colors.black45,
        ),
      ),
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(fontSize: widget.fontSize),
          contentPadding: EdgeInsets.only(left: 10, top: 0, bottom: 8, right: 0),
          border: InputBorder.none,
        ),
        value: widget.selectedValue,
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

  IconBox({
    required this.icon1,
    required this.icon2,
    this.initialActiveIndex = 0,
    required this.onChange,
  });

  @override
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
      padding: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Row(
        children: [
          buildIcon(0, widget.icon1),
          SizedBox(width: 5),
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

          // Call the onChange callback with the new active index.
          widget.onChange(activeIndex);
        },
        child: Container(
          padding: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: isActive ? Colors.red : Colors.white,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Icon(
            icon,
            color: isActive ? Color.fromARGB(255, 124, 124, 124) : Colors.black,
            size: 24.0,
          ),
        ),
      ),
    );
  }
}
