import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/report/widget/exportbtn.dart';
import 'package:housekeepingmanagement/widget/inputbox.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
    TextEditingController number_room_select = TextEditingController();
class dailyReport extends StatefulWidget {
  @override
  _dailyReportState createState() => _dailyReportState();
}
String start_date = ''; 
String end_date = '';
String room_type = 'All'; 
String Url = '';
String room_number_filter = 'ALL';

  List<String> roomNumbers = ["All"];
class _dailyReportState extends State<dailyReport> {
  List<dynamic> data = [] , room_number = [];
  
  Future<void> fetchData() async {
      
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/report/daily?start_date=$start_date&end_date=$end_date&room_type=$room_type'));
    Url='http://127.0.0.1:8000/api/report/daily?start_date=$start_date&end_date=$end_date&room_type=$room_type';
print(Url);
    if (response.statusCode == 200) {
      fetchDataroom();
      setState(() {
        data = json.decode(response.body)['data'];
      });
    } else {
      throw Exception('Failed to load data');
    }
  }
Future<void> fetchDataroom() async {
  final url = Uri.parse('http://127.0.0.1:8000/api/room/all?roomType=$room_type'); // Replace with your actual URL.

  try {
    print('http://127.0.0.1:8000/api/room/all?roomType=$room_type');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Successfully retrieved the data.
      setState(() {
        final jsonResponse = jsonDecode(response.body);
        room_number = jsonResponse["data"]; // Update the roomData with new data

        // Clear the roomNumbers list and add "All" as the first element.
        roomNumbers.clear();
        roomNumbers.add("All");

        for (var room in room_number) { // Use room_number instead of data
          roomNumbers.add(room["room_number"]);
        }
      });

      // Now you can work with the updated roomData and roomNumbers list.
      print(roomNumbers);
    } else {
      // Handle the case when the request was not successful.
      print('Failed to retrieve data. Status code: ${response.statusCode}');
    }
  } catch (error) {
    // Handle any exceptions that may occur.
    print('Error: $error');
  }
}

  @override
  void initState() {
    super.initState();
    fetchDataroom();
    fetchData();
   
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
          DateRangeWidget(
            controller: TextEditingController(),
            labelText: 'Check-Out Date',
            checkin: TextEditingController(),
            checkout: TextEditingController(),
            checkcurrentdate: DateTime.now(),
            onDateSelectedDate: (selectedDate) {
              // Handle date selection
            },
            onChange: (DateTime checkin, DateTime checkout, int nights) {
              start_date = DateFormat('yyyy-MM-dd').format(checkin).toString();
              end_date = DateFormat('yyyy-MM-dd').format(checkout).toString();
              fetchData();
            },
          ),
          SizedBox(
            width:10,
          ),
          Container(
  margin: EdgeInsets.only(top: 10.0), // Adjust the margin as needed
  child: CustomDropdownButton(
    width: 300,
    items: ['All', 'Single Room', 'Twin Room'],
    selectedValue: 'All',
    hintText: 'Room Type',
    onChanged: (value) {
       number_room_select.text = 'All';
      room_type = value!;
      fetchData();
      print(number_room_select.text);
      fetchDataroom();
          },
  ),
),Container(
  margin: EdgeInsets.only(top: 10.0), // Adjust the margin as needed
  child:CustomDropdownButton(
  width: 100,
  items: roomNumbers, // Provide a default value 'All' if roomNumbers is null or empty
  selectedValue: number_room_select.text ,
  hintText: 'Room Type',
  onChanged: (value) {
    number_room_select.text = value!;
    fetchData();
    print(number_room_select.text);
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
          DataColumn(label: Text('Guest ID')),
          DataColumn(label: Text('Room Type')),
          DataColumn(label: Text('Room Number')),
          DataColumn(label: Text('Guest Name')),
          DataColumn(label: Text('Check In')),
          DataColumn(label: Text('Check Out')),
          DataColumn(label: Text('Balance')),
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
              DataCell(Text(item['guest_id'].toString())),
              DataCell(Text(item['room_type'])),
              DataCell(Text(item['room_number'])),
              DataCell(Text(item['name'])),
              DataCell(Text(item['checkin_date'])),
              DataCell(Text(item['checkout_date'])),
              DataCell(Text(item['balance']?.toString() ?? '')),
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
