import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/dialog/editGuest.dart';
import 'package:housekeepingmanagement/dialog/editguestforguestinhouse.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:housekeepingmanagement/frontdesk/widget/Empty.dart';
import 'package:housekeepingmanagement/widget/country.dart';
import 'package:housekeepingmanagement/widget/inputbox.dart';
import 'package:housekeepingmanagement/system_widget/system_color.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

bool loading = true;

class Hk {
  final int id;
  final int roomId;
  final String roomNumber;
  final String roomStatus;
  final String roomType;
  final String housekeeper;
  final String date;
  final String name;
  final String housekeepingStatus;
  final String last_page;
  final String InHouseListtatus;
  final String note;

  Hk({
    required this.roomId,
    required this.id,
    required this.roomNumber,
    required this.roomStatus,
    required this.roomType,
    required this.housekeeper,
    required this.date,
    required this.name,
    required this.housekeepingStatus,
    // ignore: non_constant_identifier_names
    required this.last_page,
    required this.InHouseListtatus,
    required this.note,
  });

  factory Hk.fromJson(Map<String, dynamic> json) {
    return Hk(
      id: json['id'] ?? -1,
      roomNumber: json['room_number'] ?? '',
      roomStatus: json['room_status'] ?? '',
      roomType: json['roomtype'] ?? '',
      housekeeper: json['housekeeper'] ?? '',
      date: json['date'] ?? '',
      name: json['name'] ?? '',
      housekeepingStatus: json['housekeeping_status'] ?? 'Dirty',
      last_page: json['last_page'] ?? '',
      InHouseListtatus: json['housekeeping_status'] ?? 'Dirty',
      note: json['note'] ?? '',
      roomId: json['roomId'] ?? -1,
    );
  }
}

class GuestInHouseList extends StatefulWidget {
 

  const GuestInHouseList({Key? key}) : super(key: key);

  @override
  _GuestInHouseListState createState() => _GuestInHouseListState();
}

class _GuestInHouseListState extends State<GuestInHouseList> {
  late List<Hk> InHouseList;
  List<Map<String, dynamic>> bookingsData = [];
  int currentPage = 1;
  int perPage = 10;
  String? roomStatusFilter = 'All';
  String? InHouseListtatusFilter = 'All';
  String?  Search = 'All';
  int totalPages = 1;

  @override
  void initState() {
    super.initState();
    fetchData();
    textEditingController.text = ''; 
    Search = '';

  }

  Future<void> fetchData() async {
    loading = true;
    if ( Search!.isEmpty) {
       Search = 'All';
    }
    final response = await http.get(Uri.parse(
        'http://localhost:8000/api/guests/select_all?page=$currentPage&Search=$Search'));
    if (response.statusCode == 200) {
      loading = false;
      final jsonData = json.decode(response.body);
      final List<dynamic> jsonDataList = jsonData['data']['data'];
      final totalRecords = jsonData['data']['total'];
       Map<String, dynamic> data = json.decode(response.body);
      setState(() {
         bookingsData = List<Map<String, dynamic>>.from(data['data']['data']);
        InHouseList = jsonDataList.map((item) => Hk.fromJson(item)).toList();
        totalPages = (totalRecords / perPage).ceil(); // Calculate totalPages
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> showViewDialog(Hk hk) async {

    // Determine the room status text and background color based on the hk's roomStatus
    switch (hk.housekeepingStatus) {
      case 'Clean':
        break;
      case 'Cleaning':
        break;
      case 'Dirty':
        break;
      default:
    }

  }


  DateTime currentDate = DateTime.now();

  List<int> selectedRows = [];
  String? selectedValue;
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
    String formattedDate = DateFormat('dd-MM-yyyy').format(currentDate);
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(10.0),
      ),
      
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    child: Row(
                      children: [
                      
                        CustomTextField(
                          controller: textEditingController,
                          labelText: 'Search',
                          width: 265,
                          onChanged: (value) {
                             Search = value;
                            currentPage = 1;
                            fetchData();
                            print(Search);
                          },
                        ),
                     
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
          loading
              ? Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 120.0),
                    child: const CircularProgressIndicator(),
                  ),
                )
              : InHouseList.isEmpty
                  ? EmptyStateWidget()
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                     columnSpacing: 100,
                       columns: const [
                  DataColumn(
                    label: SizedBox(
                       
                      child: Text(
                        'Guest ID',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                       
                      child: Text(
                        'Guest Name',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Check-In',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Check-Out',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      child: Text(
                        'Room Number',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Night',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Note',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: 100.0,
                      child: Center(
                        child: Text(
                          'Action',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
                rows: bookingsData.asMap().entries.map((entry) {
                  Map<String, dynamic> booking = entry.value;
                  return loading
                      ? const DataRow(
                          cells: [DataCell(CircularProgressIndicator())],
                        )
                      : DataRow(
                          cells: [
                            DataCell(
                              Text(booking['guest_id']?.toString() ?? ''),
                            ),
                            DataCell(
                              Text(booking['name'] ?? ''),
                            ),
                            DataCell(
                              Text(booking['arrival_date'] ?? ''),
                            ),
                            DataCell(
                              Text(booking['departure_date']?.toString() ?? ''),
                            ),
                            DataCell(
                              Text(booking['room_number'] ?? ''),
                            ),
                            DataCell(
                              Text(
                                calculateDifference(
                                  booking['arrival_date'],
                                  booking['departure_date'],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            DataCell(
                              Text(booking['note'] ?? ''),
                            ),
                            DataCell(
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 60,
                                    child: TextButton(
                                      onPressed: () {
                                        editGuestDialog_guest_inhouse(context, fetchData)
                                            .showCreateeditGuestDialog_guest_inhouse(booking);
                                      },
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
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
                    ),
          const SizedBox(
            height: 20,
          ),
          loading
              ? const Center(
                  child: null,
                )
              : InHouseList.isEmpty
                  ? EmptyStateWidget()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.first_page, size: 20),
                          onPressed: () {
                            setState(() {
                              currentPage = 1;
                              fetchData();
                            });
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.navigate_before, size: 20),
                          onPressed: () {
                            if (currentPage > 1) {
                              setState(() {
                                currentPage--;
                                fetchData();
                              });
                            }
                          },
                        ),
                        for (int page = 1; page <= totalPages; page++)
                          MouseRegion(
                            onEnter: (event) {},
                            onExit: (event) {},
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  currentPage = page;
                                  fetchData();
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(14),
                                margin: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: currentPage == page
                                      ? ColorController.primaryColor
                                      : Colors.transparent,
                                ),
                                child: Text(
                                  '$page',
                                  style: TextStyle(
                                    color: currentPage == page
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        IconButton(
                          icon: const Icon(Icons.navigate_next, size: 20),
                          onPressed: () {
                            if (currentPage < totalPages) {
                              setState(() {
                                currentPage++;
                                fetchData();
                              });
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.last_page, size: 20),
                          onPressed: () {
                            setState(() {
                              currentPage = totalPages;
                              fetchData();
                            });
                          },
                        ),
                      ],
                    ),
        ],
      ),
    );
  }
}
