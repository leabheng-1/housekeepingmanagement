import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/report/widget/exportbtn.dart';
import 'package:housekeepingmanagement/system_widget/btn.dart';
import 'package:housekeepingmanagement/widget/Datebooking.dart';
import 'package:housekeepingmanagement/widget/current_date.dart';
import 'package:housekeepingmanagement/widget/inputbox.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class dailyReport extends StatefulWidget {
  @override
  _dailyReportState createState() => _dailyReportState();
}
String start_date = ''; 
String end_date = '';
String room_type = 'All'; 
String Url = '';
class _dailyReportState extends State<dailyReport> {
  List<dynamic> data = [];
  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/report/daily?start_date=$start_date&end_date=$end_date&room_type=$room_type'));
    print('http://127.0.0.1:8000/api/report/daily?start_date=$start_date&end_date=$end_date');
    Url='http://127.0.0.1:8000/api/report/daily?start_date=$start_date&end_date=$end_date&room_type=$room_type';
    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body)['data'];
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }


  @override
  Widget build(BuildContext context) {
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
      room_type = value!;
      fetchData();
    },
  ),
),

          Spacer(), // This will push the exportBtn to the right
          exportBtn(
            url: Url,
          ),
        ],
      ),

               
            
          ),
           
        Expanded(
          flex: 8,
          child: 
        DataTable(
        
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

        return DataRow(
          
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
    )
        )
      ],
    ) ;
    
    
  }
}
