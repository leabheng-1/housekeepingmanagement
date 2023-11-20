import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/get_api/get_room.dart';
import 'package:housekeepingmanagement/widget/inputbox.dart';

class CheckSelectRoomRate extends StatefulWidget {
  final ValueChanged<bool?>? onChanged;
  final TextEditingController roomTypeController;
  final TextEditingController roomNumberController;
  final TextEditingController roomIdController;
   final TextEditingController getroomrateController;
  final ValueChanged<String>? onTextChanged;

  

  CheckSelectRoomRate({
    this.onChanged,
    required this.roomTypeController,
    required this.roomNumberController,
    this.onTextChanged,
    required this.roomIdController,
    required this.getroomrateController
  });

  @override
  _CheckSelectRoomRateState createState() => _CheckSelectRoomRateState();
}

class _CheckSelectRoomRateState extends State<CheckSelectRoomRate> {
  List<dynamic> roomData = [];
  List<String> roomNumbers = [];
String RoomID = '';
Key dropdownKey = UniqueKey();
Future<void> RoomDateType() async { 
  roomData = await ApiFunctionsroom.fetchroomData('All');
            roomNumbers = roomData
          .where((room) => room["roomtype"] == widget.roomTypeController.text)
          .map((room) => room["room_number"].toString() )
          .toList(); 
        setState(() {  
            fetchRoomDate(widget.roomTypeController.text!);
});
       
          dropdownKey = UniqueKey();
  }

void fetchRoomDate(String value) {
 
      roomNumbers = roomData
          .where((room) => room["roomtype"] == value)
          .map((room) => room["room_number"].toString() )
          .toList();

}
void fetchRoomId(String value) {
  RoomID =
  roomData
          .where((room) => room["room_number"] == value)
          .map((room) => room["room_id"].toString() )
          .toString();
widget.roomIdController.text = RoomID.toString().replaceAll('(', '').replaceAll(')', '');

widget.getroomrateController.text =  roomData
          .where((room) => room["room_number"] == value)
          .map((room) => room["room_rate"].toString() )
          .toString().replaceAll('(', '\$').replaceAll(')', '');
          print(widget.roomIdController.text);
}



  @override
  void initState() {
    fetchRoomDate(widget.roomTypeController.text);
    RoomDateType();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CustomDropdownButton(
              
              width: 250,
              labelText: 'Room Types',
              items: ['No set', 'Single Room', 'Twin Room'],
              selectedValue: widget.roomTypeController.text,
              hintText: 'Room Type',
              onChanged: (value) async {
                setState(() {
                  widget.roomTypeController.text = value!;
                  fetchRoomDate(value!);
                  dropdownKey = UniqueKey();
                    widget.roomNumberController.text = '';
                });
              },
            ),
            SizedBox(width: 20),
            CustomDropdownButton(
              key: dropdownKey,
              width: 100,
              labelText: 'Room Numbers',
              items: roomNumbers,
              selectedValue:widget.roomNumberController.text ,
              hintText: 'Room Number',
              onChanged: (value) async {
                setState(() {
                   widget.onTextChanged?.call(value!);
                   fetchRoomId(value.toString());
                  widget.roomNumberController.text = value.toString()!;
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}
