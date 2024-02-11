import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/frontdesk/widget/formatSystem.dart';
import 'package:housekeepingmanagement/get_api/get_room.dart';
import 'package:housekeepingmanagement/report/widget/exportbtn.dart';
import 'package:housekeepingmanagement/widget/inputbox.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
    TextEditingController number_room_select = TextEditingController();
class weeklyReport extends StatefulWidget {
  @override
  _weeklyReportState createState() => _weeklyReportState();
}
String start_date = ''; 
String end_date = '';
String room_type = 'All'; 
String Url = '';
String room_number_filter = 'All';
Key dropdownKey = UniqueKey();
List<dynamic> roomData = [];
List<String> roomNumbers = [];
class _weeklyReportState extends State<weeklyReport> {
   Map<String, dynamic> data = {} ; List<dynamic>  room_number = [];
  double total = 0;
  List<dynamic> data_fold = [] ;
  Future<void> fetchData() async {
      
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/report/weekly?start_date=$start_date&end_date=$end_date&room_type=$room_type&room_number=$room_number_filter'));
    Url='http://127.0.0.1:8000/api/report/weekly?start_date=$start_date&end_date=$end_date&room_type=$room_type&room_number=$room_number_filter';
 if (response.statusCode == 200) {
    
      fetchRoomDate('All');
      setState(() {
        data =  json.decode(response.body)['data'];
  data.forEach((day, details) {
    total += details['payment'];
  });

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
 Map<String, dynamic> weeklyData = data;
    List<DataRow> rows = weeklyData.entries.map((entry) {
      String day = entry.key;
      bool isEven = true;
      int index = weeklyData.keys.toList().indexOf(day);
      Map<String, dynamic> dayData = entry.value;
                final backgroundColor = index % 2 == 0
              ? Colors.grey[200]
              : Colors.white;
       isEven = !isEven;        
      return DataRow(
        color: MaterialStateProperty.all(backgroundColor),
        cells: [
          DataCell(Text(day)),
          DataCell(Text(dayData["date"])),
          DataCell(Text(dayData["check_in"].toString())),
          DataCell(Text(dayData["check_out"].toString())),
          DataCell(Text(dayData["single_room"].toString())),
          DataCell(Text(dayData["twin_room"].toString())),
          DataCell(Text( formatCurrency( dayData["payment"].toString()))),
        ],
      );
    }).toList();
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Row(
        children: [
           DatePickerTextField(
                    checkcurrnetdate: DateTime(2000),
                      controller: TextEditingController(),
                      labelText: 'Date',
                      width: 265,
                      
                       onDateSelectedDate: (selectedDate) {
              // Handle the selected date here
              print('Selected Date: $selectedDate');
            },
                    ),
         
          SizedBox(
            width:15,
          ),
          Container(// Adjust the margin as needed
  child: CustomDropdownButton(
   labelText: 'Room Type',
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
Container( 
  child:CustomDropdownButton(
    labelText: 'Room Number',
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
        columns: [
          DataColumn(label: Text('Day')),
          DataColumn(label: Text('Date')),
          DataColumn(label: Text('Check In')),
          DataColumn(label: Text('Check Out')),
         
          DataColumn(label: Text('Single Room')),
          DataColumn(label: Text('Twin Room')),
           DataColumn(label: Text('Payment')),
        ],
        rows: rows,
      ),
      
    ),
    
  ),
),
Row(
  children: <Widget>[
    // Other cells...
    Spacer(), // This will push the "Total" cell to the end
  Padding(
  padding: EdgeInsets.only(top: 30.0,right: 20), // Adjust the top margin as needed
  child: SizedBox(
    width: 240.0,
    height: 42.0,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Text(
        'Total ${total.toStringAsFixed(2)} \$ ',
        style: TextStyle(
          fontSize: 18,
          color: const Color.fromARGB(255, 0, 0, 0),
          height: 1,
        ),
        textAlign: TextAlign.end,
      ),
    ),
  ),
)

  ],
)

      ],
    ) ;
    
    
  }
}
