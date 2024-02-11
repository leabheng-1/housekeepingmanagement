import 'dart:async';
import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/dialog/selectRoom.dart';
import 'package:housekeepingmanagement/system_widget/system_color.dart';
import 'package:housekeepingmanagement/widget/inputbox.dart';

List<String> roomTypeitem = [];
List<String> roomIditem = [];
List<String> methoditem = [];
TextEditingController check_in = TextEditingController();

int index = 0;
class MutiRoom extends StatefulWidget {
  final TextEditingController check_in;
   final TextEditingController check_out;
  final void Function(String roomTypeitem, String roomIditem, String methoditem,String roomrate) onChange;
  const MutiRoom({
    required this.onChange,
    required this.check_in,
    required this.check_out
  });
  @override
  _MutiRoomState createState() => _MutiRoomState();
}

class _MutiRoomState extends State<MutiRoom> {
  List<TextEditingController> controllers = [];
  List<TextEditingController> controllersroomid = [];
  List<TextEditingController> controllersroomNumber = [];
  List<TextEditingController> controllersairmethod = [];
  List<TextEditingController> controllersroomrate = [];
  List<String> inputValues = [];
  List<String> inputRoomId = [];
  List<String> inputRoomRate = [];
    List<String> roomNumber = [];
   List<String> inputRoomMethod = [];
  int numberOfRooms = 1; // Initial number of rooms
  List<Widget> widgets = []; // List to store new sets of widgets
  void _showValues() {
   setState(() {
  inputValues = controllers.map((controller) => controller.text).toList();


 
  String allInputs = inputValues.join(', ');
  inputRoomId = controllersroomid.map((controller) => controller.text).toList();
  inputRoomRate = controllersroomrate.map((controller) => controller.text).toList();
inputRoomMethod = controllersairmethod.map((controller) => controller.text).toList();

  String allRoomId = inputRoomId.join(', ');
  String allinputRoomRate = inputRoomRate.join(', ');
  double totalAmount = 0;
for (String amountString in inputRoomRate) {
  // Remove the dollar sign and parse the string to double
  double parsedAmount = double.parse(amountString.replaceAll('\$', ''));
  
  // Add the parsed amount to the total
  totalAmount = ( totalAmount + parsedAmount );
}
   String inputRoomMethodvalue = inputRoomMethod.join(', ');

widget.onChange(allInputs, allRoomId , inputRoomMethodvalue,totalAmount.toString()); 

}); 



    
  }
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < numberOfRooms; i++) {
      controllers.add(TextEditingController());
controllersairmethod.add(TextEditingController());
      controllersroomid.add(TextEditingController());
      controllersroomNumber.add(TextEditingController());
      controllersroomrate.add(TextEditingController());
    }
    _initializeWidgets();
  }

  void _initializeWidgets() {
    for (int i = 0; i < numberOfRooms; i++) {
      widgets.add(_buildWidget(i));
    }
  }

  Widget _buildWidget(int index) {
     String? allRoomnumber = inputRoomId.join(', ');
    return Row(
      children: [
        CheckSelectRoomRate(
         
          roomTypeController: controllers[index],
          roomNumberController: controllersroomNumber[index],
          roomIdController: controllersroomid[index],
          getroomrateController: controllersroomrate[index],
          check_in:widget.check_in,
          check_out:widget.check_out,
          roomNumbersselect:allRoomnumber,
          onTextChanged: (value) {
            Future.delayed(const Duration(milliseconds: 100), () {
      _showValues();
      roomNumber = controllersroomNumber.map((controller) => controller.text).toList();
      print(roomNumber);
    // You can perform other operations or call a function here
  });
      
          },
          onChanged: (value){
              Future.delayed(const Duration(milliseconds: 500), () {
      _showValues();
    // You can perform other operations or call a function here
  });
          },
        ),
        SizedBox(width: 15),
        CustomDropdownButton(
          width: 100,
          labelText: 'Air Method',
          items: ['No set', 'Fan', 'Conditioner', 'All'],
          selectedValue: controllersairmethod[index].text,
          hintText: 'Booking Air Method',
          onChanged: (value) {
            controllersairmethod[index].text = value!; 
                Future.delayed(const Duration(milliseconds: 500), () {
            _showValues();
            print(controllersairmethod[index].text);
                }
                );
          },
        ),
        SizedBox(width: 15),
        index == 0 ? 
        SizedBox(
          child: Container(  
           margin: EdgeInsets.only(top: 20),
           child:
        Column(
          children: [
            
   Container(
       margin: EdgeInsets.only(top:10),
    child: InkWell(
            onTap: () {
              setState(() {
                  _addNewInputField();
            _showValues();
              });
            },
            child: Tooltip(
  message: 'Add Room',
  child: 
  
   Container(
    width: 40,
    height: 40,
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Center(
      child: Icon(
        Icons.add,
        color: Colors.white,
        size: 24,
      ),
    ),
  ),
)

          ),
   )
          ],
        
        ) ,  
           ),
        ):
            SizedBox(
              child: Container(
                margin: EdgeInsets.only(top: 27.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('', style: TextStyle(fontWeight: FontWeight.bold)),
                    InkWell(
                      onTap: () {
                       _removeInputField(index);
                      }, 
                      child: Container(
                        width: 40,
                        height: 40,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: ColorController.CloseColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
      ],
    );
  }

  @override
 Widget build(BuildContext context) {
  return Column(
    children: [
  Column(
  children: List.generate(
    numberOfRooms,
    (index) => widgets[index],
    
  ),
),
    ],
  );

      
    
}

  void _addNewInputField() {
    setState(() {
      numberOfRooms++;
      controllers.add(TextEditingController());
      controllersroomid.add(TextEditingController());
      controllersroomNumber.add(TextEditingController());
      controllersairmethod.add(TextEditingController());
      controllersroomrate.add(TextEditingController());
      widgets.add(_buildWidget(numberOfRooms - 1));
    });
  }
void _removeInputField(int index) {
  setState(() {
    if (numberOfRooms > 1) {
      numberOfRooms--;
      controllers.removeAt(index);
      controllersroomid.removeAt(index);
      controllersroomrate.removeAt(index);
      controllersroomNumber.removeAt(index);
      controllersairmethod.removeAt(index);
      widgets.removeAt(index);
    }
  });
}

}
