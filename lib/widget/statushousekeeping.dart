import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/system_widget/system_color.dart';
import 'package:http/http.dart' as http;


class statushousekeepingwidget extends StatefulWidget {
  @override
  _statushousekeepingwidgetState createState() => _statushousekeepingwidgetState();
}

class _statushousekeepingwidgetState extends State<statushousekeepingwidget> {
  Map<String, dynamic> statusData = {};

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:8000/api/dashboard/todayStatus'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        setState(() {
          statusData = responseData['data'];
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  // Function to show the dialog with status data
  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  // Function to create a status box
 Widget _buildStatusBox(IconData iconName, String name, String value, Color color ,double margin) {
  return GestureDetector(
    onTap: () {
      _showDialog(name, value);
    },
    child: Container(
      margin: EdgeInsets.only(right:margin), // Add margin to the container
      child: Material(
        elevation: 5.0, // Add elevation for the shadow
        borderRadius: BorderRadius.circular(10.0), // Round the borders
        color: color, // Set background color
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                width: 44.0, // Set a fixed width for the icon container
                height: 44.0, // Set a fixed height for the icon container
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.2), // Set background color with opacity
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Icon(
                    iconName,
                    size: 20.0,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
              SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 255, 255, 255),
                       height: 1.2,
                    ),
                  ),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 16,
                      color: const Color.fromARGB(255, 255, 255, 255),
                       height: 1.2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

  Widget build(BuildContext context) {
    var iconController;
    return Container(
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: [
        SizedBox(
          width:  MediaQuery.of(context).size.width /6 - 6.67,  // Set a fixed width for each status box
          child: _buildStatusBox(
            iconController.checkInIcon,
            'Check In',
            '${statusData['checkin_count']}',
            ColorController.checkInColor,
            15
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width /6 - 6.67,  // Set a fixed width for each status box
          child: _buildStatusBox(
            iconController.checkOutIcon,
            'Check Out',
            '${statusData['checkout_count']}',
            ColorController.checkOutColor,
            15
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width /6 - 6.67,  // Set a fixed width for each status box
          child: _buildStatusBox(
            iconController.occupiedIcon,
            'occupied',
            '${statusData['occupied']}',
            ColorController.dirtyColor,
            15
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width /6 - 6.67,  // Set a fixed width for each status box
          child: _buildStatusBox(
            iconController.blockIcon,
            'block',
            '${statusData['block']}',
            ColorController.blockColor,
            15
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width /6 - 6.67,  // Set a fixed width for each status box
          child: _buildStatusBox(
            iconController.arrivalsIcon,
            'Available',
            '${statusData['available_rooms']}',
            ColorController.availableColor,
            15
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width /6 - 6.67,  // Set a fixed width for each status box
          child: _buildStatusBox(
            iconController.inHouseIcon,
            'In House',
            '${statusData['inHouse']}',
            ColorController.inHouseColor,
            0
          ),
        ),
      ],
    ),
  );
  }
}
