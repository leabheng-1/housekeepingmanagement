import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/system_widget/system_color.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final Color borderColor;
  final double borderRadius;
  final double borderWidth;
  final double width;
  final double height;
  final double inputHeight;
  final bool isNumeric;

  const CustomTextField({
    super.key,
    this.controller,
    required this.labelText,
    this.borderColor = const Color(0xFFb4b4b4),
    this.borderRadius = 10.0,
    this.borderWidth = 1.0,
    this.width = 450,
    this.height = 40,
    this.inputHeight = 30,
    this.isNumeric = false,
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
            color: const Color(0xFFf6f6f6),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: borderColor,
              width: borderWidth,
            ),
          ),
          alignment: Alignment.center,
          child: Center(
            child: TextFormField(
              keyboardType: TextInputType.number,
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

  const IconBox({
    super.key,
    required this.icon1,
    required this.icon2,
    this.initialActiveIndex = 0,
    required this.onChange,
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
