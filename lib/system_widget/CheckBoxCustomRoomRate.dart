import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/widget/inputbox.dart';

class CheckBoxCustomRoomRate extends StatefulWidget {
  final ValueChanged<bool?>? onChanged;
  final TextEditingController roomRateController;
  final ValueChanged<String>? onTextChanged; // New callback for text changes
  final bool isChecked;

  CheckBoxCustomRoomRate({
    required this.isChecked,
    this.onChanged,
    required this.roomRateController,
    this.onTextChanged, // Pass the callback function
  });

  @override
  _CheckBoxCustomRoomRateState createState() => _CheckBoxCustomRoomRateState();
}

class _CheckBoxCustomRoomRateState extends State<CheckBoxCustomRoomRate> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Row(
  children: [
    Stack(
      children: [
        CustomTextField(
          width: 200,
          controller: widget.roomRateController,
          labelText: 'Room Rate',
          isCurrency: true,
          enabled: _isChecked,
          onChanged: (text) {
            // Invoke the callback function when text changes
            widget.onTextChanged?.call(text);
          },
        ),
        Positioned(
          right: 5,
          top: 15,
          child: Container(
            margin: EdgeInsets.only(top: 16.0),
            padding: EdgeInsets.only(left: 10),
            child: Checkbox(
              value: _isChecked,
              onChanged: (value) {
                widget.onChanged?.call(value);
                setState(() {
                  _isChecked = value ?? false;
                });
              },
            ),
          ),
        ),
      ],
    ),
  ],
)

          ],
        ),
      ],
    );
  }
}
