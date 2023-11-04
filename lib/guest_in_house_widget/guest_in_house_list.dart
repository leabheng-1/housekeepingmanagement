import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/dialog/editGuest.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GuestInHouseList extends StatefulWidget {
  const GuestInHouseList({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _GuestInHouseListState createState() => _GuestInHouseListState();
}

class _GuestInHouseListState extends State<GuestInHouseList> {
  List<Map<String, dynamic>> bookingsData = [];
  List<bool> selectedCheckboxes = [];
  String? selectedDropdownValue;
  bool selectAll = false;
bool loading = false;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
       loading = false;
      final response = await http
          .get(Uri.parse('http://localhost:8000/api/booking/allTime'));

      if (response.statusCode == 200) {
        bool loading = true;
        Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          bookingsData = List<Map<String, dynamic>>.from(data['data']);
          selectedCheckboxes =
              List.generate(bookingsData.length, (index) => false);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {}
  }

  String calculateDifference(
      String? arrivalDateString, String? departureDateString) {
    if (arrivalDateString == null || departureDateString == null) {
      return 'N/A';
    }

    DateTime arrivalDate = DateTime.parse(arrivalDateString);
    DateTime departureDate = DateTime.parse(departureDateString);

    int differenceInDays = departureDate.difference(arrivalDate).inDays;

    return differenceInDays.toString();
  }

  @override
  Widget build(BuildContext context) {
    return loading
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Expanded(
      child: DataTable(
        columnSpacing: 15.0,
        columns: [
          DataColumn(
            label: Row(
              children: [
                Checkbox(
                  value: selectAll,
                  onChanged: (value) {
                    setState(() {
                      selectAll = value!;
                      selectedCheckboxes =
                          List.filled(selectedCheckboxes.length, value);
                    });
                  },
                ),
              ],
            ),
          ),
          const DataColumn(label: Text('Guest ID')),
          const DataColumn(label: Text('Guest Name')),
          const DataColumn(label: Text('Check-In')),
          const DataColumn(label: Text('Check-Out')),
          const DataColumn(label: Text('Room Number')),
          const DataColumn(label: Text('Night')),
          const DataColumn(label: Text('Note')),
          const DataColumn(
            label: SizedBox(
              width: 100.0,
              child: Center(
                child: Text('Action'),
              ),
            ),
          ),
        ],
        rows: bookingsData.asMap().entries.map((entry) {
          int index = entry.key;
          Map<String, dynamic> booking = entry.value;
          return DataRow(
            cells: [
              DataCell(
                Checkbox(
                  value: selectedCheckboxes[index],
                  onChanged: (bool? value) {
                    setState(() {
                      selectedCheckboxes[index] = value!;
                    });
                  },
                ),
              ),
              DataCell(
                Text(booking['guest_id']?.toString() ?? 'N/A'),
              ),
              DataCell(
                Text(booking['name'] ?? 'N/A'),
              ),
              DataCell(
                Text(booking['arrival_date'] ?? 'N/A'),
              ),
              DataCell(
                Text(booking['departure_date']?.toString() ?? 'N/A'),
              ),
              DataCell(
                Text(booking['room_number'] ?? 'N/A'),
              ),
              DataCell(
                Text(
                  calculateDifference(
                    booking!['arrival_date'],
                    booking!['departure_date'],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              DataCell(
                Text(booking['note'] ?? 'N/A'),
              ),
              DataCell(
                Row(
                  children: [
                    SizedBox(
                      width: 70.0,
                      child: TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFF419674),
                          ),
                        ),
                        child: const Text(
                          'View',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 60,
                      child: TextButton(
                        onPressed: () {
                            editGuestDialog(
                                                            context, fetchData)
                                                        .showCreateeditGuestDialog(
                                                            booking);
                        },
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFF3091C5),
                          ),
                        ),
                        child: const Text(
                          'Edit',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
