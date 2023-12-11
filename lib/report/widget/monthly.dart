import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/get_api/get_room.dart';
import 'package:housekeepingmanagement/report/widget/exportbtn.dart';
import 'package:housekeepingmanagement/widget/inputbox.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
    TextEditingController number_room_select = TextEditingController();
class monthReport extends StatefulWidget {
  @override
  _monthReportState createState() => _monthReportState();
}
String start_date = ''; 
String end_date = '';
String room_type = 'All'; 
String Url = '';
String room_number_filter = 'All';
Key dropdownKey = UniqueKey();
List<dynamic> roomData = [];
List<String> roomNumbers = [];
class _monthReportState extends State<monthReport> {
  List<dynamic> data = [] , room_number = [];
  
  Future<void> fetchData() async {
      
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/report/monthly?start_date=$start_date&end_date=$end_date&room_type=$room_type&room_number=$room_number_filter'));
    Url='http://127.0.0.1:8000/api/report/daily?start_date=$start_date&end_date=$end_date&room_type=$room_type&room_number=$room_number_filter';
    if (response.statusCode == 200) {
      fetchRoomDate('All');
      setState(() {
        data = json.decode(response.body)['data'];
      });
    } else {
      throw Exception('Failed to load data');
    }
  }
 List<dynamic> roomData = [];
  List<String> roomNumbers = [];
String RoomID = '';
Future<void> RoomDateType() async { 
  roomData = await ApiFunctionsroom.fetchroomData('All');
            roomNumbers = roomData
          .where((room) => room["roomtype"] == room_type)
          .map((room) => room["room_number"].toString() )
          .toList(); 
        setState(() {  
            fetchRoomDate(room_type!);
});
       
          dropdownKey = UniqueKey();
  }

void fetchRoomDate(String value) {
 if (value == 'All') {
  roomNumbers = roomData
          .map((room) => room["room_number"].toString() )
          .toList();  
 }else{
  roomNumbers = roomData
          .where((room) => room["roomtype"] == value)
          .map((room) => room["room_number"].toString() )
          .toList();
 }
      

}

  @override
  void initState() {
    
    room_type = 'All'; 
    room_number_filter = 'All';
    RoomDateType();
    super.initState();
    fetchData();
    fetchRoomDate('All');
  }


  @override
  Widget build(BuildContext context) {
 number_room_select.text = 'All';

    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Row(
        children: [
          
          Container(
  margin: EdgeInsets.only(top: 5.0), // Adjust the margin as needed
  child: CustomDropdownButton(
   
    width: 300,
    items: ['All', 'Single Room', 'Twin Room'],
    selectedValue: 'All',
    hintText: 'Room Type',
    onChanged: (value) {
      room_type = value!;
      fetchData();
      RoomDateType();
      fetchRoomDate(value);
      number_room_select.text = 'All';
         dropdownKey = UniqueKey();
          },
  ),
),
SizedBox(width: 15,),
Container( // Adjust the margin as needed
  margin: EdgeInsets.only(top: 5.0),
  child:CustomDropdownButton(
     key: dropdownKey,
  width: 150,
  items: roomNumbers, // Provide a default value 'All' if roomNumbers is null or empty
  selectedValue: number_room_select.text ,
  hintText: 'Room Number',
  onChanged: (value) {
    number_room_select.text = value!;
    room_number_filter = value;
    fetchData();
  },
)

),

          Spacer(), // This will push the exportBtn to the right
          Padding(
  padding: EdgeInsets.all(16.0), // Adjust the padding values as needed
  child: exportBtn(
    url: Url,
  ),
)

        ],
      ),

               
            
          ),
           
  Expanded(
  flex: 8,
  child: Container(
    width: double.infinity,
    child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: <DataColumn>[
          DataColumn(label: Text('Month')),
          DataColumn(label: Text('Check In')),
          DataColumn(label: Text('Check Out')),
          DataColumn(label: Text('Single Room')),
          DataColumn(label: Text('Twin Room')),
          DataColumn(label: Text('Payment')),
        ],
        rows: data.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final backgroundColor = index % 2 == 0
              ? Colors.grey[200]
              : Colors.white;

          return DataRow(
            color: MaterialStateProperty.all(backgroundColor),
            cells: <DataCell>[
                 DataCell(Text(item["week"].toString() ?? '')),
          DataCell(Text(item["check_in"].toString()?? '')),
          DataCell(Text(item["check_out"].toString()?? '')),
         
          DataCell(Text(item["single_room"].toString()?? '')),
          DataCell(Text(item["twin_room"].toString()?? '')), 
          DataCell(Text( item["summary_sum_payment"].toString()?? '')),
            ],
          );
        }).toList(),
      ),
    ),
  ),
)

      ],
    ) ;
    
    
  }
}
