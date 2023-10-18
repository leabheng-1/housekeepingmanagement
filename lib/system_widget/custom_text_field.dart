import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final Color borderColor;
  final double borderRadius;
  final double borderWidth;
  final double width;
  final double height;
  final double inputHeight;

  const CustomTextField({
    super.key,
    this.controller,
    required this.labelText,
    this.borderColor = Colors.black,
    this.borderRadius = 10.0,
    this.borderWidth = 1.0,
    this.width = 450,
    this.height = 40,
    this.inputHeight = 30,
  });

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
          labelText,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          width: width,
          height: height,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: borderColor,
              width: borderWidth,
            ),
          ),
          alignment: Alignment.center,
          child: Center(
            child: TextFormField(
              controller: controller,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 13),
              ),
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}

class DatePickerTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String labelText;
  final Color borderColor;
  final double borderRadius;
  final double borderWidth;
  final double width;
  final double height;
  final double inputHeight;

  const DatePickerTextField({
    super.key,
    this.controller,
    required this.labelText,
    this.borderColor = Colors.black,
    this.borderRadius = 10.0,
    this.borderWidth = 1.0,
    this.width = 450,
    this.height = 40,
    this.inputHeight = 30,
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
    _selectedDate = DateTime.now(); // Initialize with today's date
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
          context: context,
          initialDate: _selectedDate ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        )) ??
        DateTime.now();

    if (picked != _selectedDate) {
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
          padding: EdgeInsets.all(6),
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
                  _selectedDate != null
                      ? "${_selectedDate!.toLocal()}".split(' ')[0]
                      : 'Select Date',
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
}

class CustomDropdownButton extends StatefulWidget {
  final double width;
  final List<String> items;
  final String? selectedValue;
  final ValueChanged<String?>? onChanged;
  final String hintText;
  final double fontSize;
  final Color bg;
  final double marginTop;
  const CustomDropdownButton({
    super.key,
    required this.width,
    this.bg = Colors.white,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
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
    return Container(
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
          contentPadding:
              const EdgeInsets.only(left: 10, top: 0, bottom: 8, right: 0),
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
    );
  }
}

// ignore: must_be_immutable
class CSTextField extends StatefulWidget {
  String? fullName;

  CSTextField({super.key, this.fullName = ''});

  @override
  // ignore: library_private_types_in_public_api
  _CSTextFieldState createState() => _CSTextFieldState();
}

class _CSTextFieldState extends State<CSTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16),
        hintText: 'Enter Your Full Name.',
        hintStyle: const TextStyle(fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      onChanged: (value) {
        setState(() {
          widget.fullName = value;
        });
      },
    );
  }
}
