import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/system_widget/box_detail.dart';
import 'package:housekeepingmanagement/system_widget/btn.dart';
import 'package:housekeepingmanagement/system_widget/custom_text_field.dart';
import 'package:housekeepingmanagement/system_widget/system_color.dart';
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

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
  final String hkStatus;
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
    required this.hkStatus,
    required this.note,
  });

  factory Hk.fromJson(Map<String, dynamic> json) {
    return Hk(
      id: json['id'] ?? -1,
      roomNumber: json['room_number'] ?? 'N/A',
      roomStatus: json['room_status'] ?? 'N/A',
      roomType: json['roomtype'] ?? 'N/A',
      housekeeper: json['housekeeper'] ?? 'N/A',
      date: json['date'] ?? '',
      name: json['name'] ?? '',
      housekeepingStatus: json['housekeeping_status'] ?? 'Dirty',
      last_page: json['last_page'] ?? 'N/A',
      hkStatus: json['housekeeping_status'] ?? 'Dirty',
      note: json['note'] ?? 'N/A',
      roomId: json['roomId'] ?? -1,
    );
  }
}

class HkDataTable extends StatefulWidget {
  const HkDataTable({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HkDataTableState createState() => _HkDataTableState();
}

class _HkDataTableState extends State<HkDataTable> {
  late List<Hk> hks;
  int currentPage = 1;
  int perPage = 10;
  String? roomStatusFilter;
  String? hkStatusFilter;
  String? guestNameFilter;
  int totalPages = 1;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(
        Uri.parse('http://localhost:8000/api/booking/all?page=$currentPage'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> jsonDataList = jsonData['data']['data'];
      final totalRecords = jsonData['data']['total'];
      setState(() {
        hks = jsonDataList.map((item) => Hk.fromJson(item)).toList();
        totalPages = (totalRecords / perPage).ceil(); // Calculate totalPages
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  // Filter hk data based on room status, hk status, and guest name
  List<Hk> getFilteredHks() {
    List<Hk> filteredHks = [...hks];

    if (roomStatusFilter != null && roomStatusFilter!.isNotEmpty) {
      filteredHks =
          filteredHks.where((hk) => hk.roomStatus == roomStatusFilter).toList();
    }

    if (hkStatusFilter != null && hkStatusFilter!.isNotEmpty) {
      filteredHks =
          filteredHks.where((hk) => hk.hkStatus == hkStatusFilter).toList();
    }

    if (guestNameFilter != null && guestNameFilter!.isNotEmpty) {
      filteredHks = filteredHks
          .where((hk) =>
              hk.name.toLowerCase().contains(guestNameFilter!.toLowerCase()))
          .toList();
    }

    return filteredHks;
  }

  Future<void> showViewDialog(Hk hk) async {
    Color roomStatusColor;

    // Determine the room status text and background color based on the hk's roomStatus
    switch (hk.housekeepingStatus) {
      case 'Clean':
        roomStatusColor = Colors.green;
        break;
      case 'Cleaning':
        roomStatusColor = Colors.yellow;
        break;
      case 'Dirty':
        roomStatusColor = Colors.brown;
        break;
      default:
        roomStatusColor = Colors.grey;
    }

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              const Expanded(
                child: Center(
                  child: Text(
                    "Room Details",
                    style: TextStyle(
                      fontSize: 24.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              CustomButton(
                  title: "Room Id # ${hk.id}",
                  titleFontSize: 16.0,
                  iconData: Icons.single_bed,
                  iconSize: 24.0,
                  buttonBackgroundColor: const Color(0xFFC9FFD7),
                  iconBackgroundColor: const Color.fromARGB(38, 0, 0, 0),
                  iconColor: Colors.white,
                  textColor: const Color.fromARGB(38, 0, 0, 0)),
              Container(
                width: 550,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: 40,
                  height: 40,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              )
            ],
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Boxdetail(title: "Date", value: hk.date, width: 450),
              ]),
              Row(children: [
                Boxdetail(title: "Room Type", value: hk.roomType, width: 450),
                const SizedBox(width: 20),
                Boxdetail(
                  title: "Room Number",
                  value: hk.roomNumber.toString(),
                  width: 450,
                ),
              ]),
              Row(
                children: [
                  Boxdetail(
                      title: "Room Status ", value: hk.roomStatus, width: 450),
                  const SizedBox(width: 20),
                  Boxdetail(
                      title: "Housekeeping Status",
                      value: hk.housekeepingStatus,
                      backgroundColor: roomStatusColor,
                      width: 450),
                ],
              ),
              Row(
                children: [
                  Boxdetail(
                      title: "Housekeeper", value: hk.housekeeper, width: 450),
                ],
              ),
              Expanded(
                child: Boxdetail(
                    title: "Note", value: hk.note, height: 200, width: 920),
              ),
            ],
          ),
          actions: [
            SizedBox(
              width: 150,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.blue.withOpacity(0.4)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 5, bottom: 5),
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    const Text(
                      "Edit",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Future<void> showEditDialog(Hk hk) async {
    final TextEditingController roomTypeController = TextEditingController();
    final TextEditingController housekeeperController = TextEditingController();
    final TextEditingController roomNumberController = TextEditingController();
    final TextEditingController dateController = TextEditingController();
    // ignore: non_constant_identifier_names
    final TextEditingController RoomStatusController = TextEditingController();
    final TextEditingController noteController = TextEditingController();
    final TextEditingController hkStatusController = TextEditingController();
    TextEditingController selectedDate = TextEditingController();

    // Initialize the controllers with the existing data
    roomTypeController.text = hk.roomType;
    roomNumberController.text = hk.roomNumber;
    housekeeperController.text = hk.housekeeper;
    dateController.text = hk.date;
    RoomStatusController.text = hk.roomStatus;
    hkStatusController.text = hk.hkStatus;
    noteController.text = hk.note;
    String? hknew = hkStatusController.text;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              const Expanded(
                child: Center(
                  child: Text(
                    "Room Details",
                    style: TextStyle(
                      fontSize: 24.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              CustomButton(
                  title: "Room Id # ${hk.id}",
                  titleFontSize: 16.0,
                  iconData: Icons.single_bed,
                  iconSize: 24.0,
                  buttonBackgroundColor: const Color(0xFFC9FFD7),
                  iconBackgroundColor: const Color.fromARGB(38, 0, 0, 0),
                  iconColor: Colors.white,
                  textColor: const Color.fromARGB(38, 0, 0, 0)),
              Container(
                width: 550,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: 40,
                  height: 40,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              )
            ],
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                DatePickerTextField(
                  labelText: 'Select a Date',
                  controller:
                      selectedDate, // You can provide a controller if needed
                ),
              ]),
              Row(children: [
                CustomTextField(
                  controller: roomTypeController,
                  labelText: "Room Status",
                ),
                const SizedBox(width: 30),
                CustomTextField(
                  controller: roomNumberController,
                  labelText: "Room Number",
                ),
              ]),
              Row(children: [
                CustomTextField(
                  controller: RoomStatusController,
                  labelText: "Room Status",
                ),
                const SizedBox(width: 30),
                CustomDropdownButton(
                  bg: const Color.fromRGBO(255, 255, 255, 1),
                  width: 450,
                  items: const ['Clean', 'Cleaning', 'Dirty'],
                  selectedValue: hkStatusController.text,
                  hintText: 'Housekeeping Status',
                  onChanged: (value) {
                    setState(() {
                      hknew = value;
                    });
                  },
                ),
              ]),
              Row(children: [
                CustomTextField(
                  controller: housekeeperController,
                  labelText: "Housekeeper",
                ),
              ]),
              const SizedBox(
                height: 20,
              ),
              Row(children: [
                CustomTextField(
                    labelText: "Note",
                    controller: noteController,
                    height: 200,
                    width: 920),
              ]),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the edit dialog
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                submitUpdatedData(
                    roomTypeController.text,
                    housekeeperController.text,
                    hk.roomId,
                    hknew,
                    selectedDate.text,
                    noteController.text,
                    RoomStatusController.text,
                    hk.date);
              },
              child: const Text("Save Changes"),
            ),
          ],
        );
      },
    );
  }

// Function to submit updated hk data to the API
  Future<void> submitUpdatedData(
      String roomType,
      String housekeeper,
      int roomID,
      String? hkStatus,
      String dateController,
      String noteController,
      // ignore: non_constant_identifier_names
      String RoomStatus,
      String date) async {
    final String baseUrl1 = 'http://localhost:8000/api/room/update/$roomID';
    if (dateController == '') {
      dateController = DateFormat('yyyy-MM-dd').format(currentDate);
    }
    final url = Uri.parse(
        '$baseUrl1?room_status=$RoomStatus&note=$noteController&housekeeper=$housekeeper&housekeeping_status=$hkStatus&date=$dateController');
    final response = await http.put(url);
    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      fetchData();
    } else {}
  }

  DateTime currentDate = DateTime.now();

  // Format the DateTime as "DDD-MM-YYYY"

  List<int> selectedRows = [];
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd-MM-yyyy').format(currentDate);
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(
            255, 255, 255, 255), // Set your desired background color
        borderRadius:
            BorderRadius.circular(10.0), // Set your desired border radius
      ), // Replace with your desired background color
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    child: Row(
                      children: [
                        CustomDropdownButton(
                          bg: Color.fromRGBO(235, 235, 235, 1.0),
                          width: 300,
                          items: ['All', 'Available', 'Occupied'],
                          selectedValue: roomStatusFilter,
                          hintText: 'Room Status',
                          onChanged: (value) {
                            setState(() {
                              roomStatusFilter = value;
                            });
                          },
                        ),
                        const SizedBox(width: 10),
                        CustomDropdownButton(
                          bg: const Color.fromRGBO(235, 235, 235, 1.0),
                          width: 300,
                          items: const ['', 'Clean', 'Cleaning', 'Dirty'],
                          selectedValue: hkStatusFilter,
                          hintText: 'Housekeeping Status',
                          onChanged: (value) {
                            setState(() {
                              hkStatusFilter = value;
                            });
                          },
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          height: 40,
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: Expanded(
                            flex: 1,
                            child: TextFormField(
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(16),
                                hintText: 'Guest Name',
                                hintStyle: const TextStyle(fontSize: 14),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  guestNameFilter = value;
                                });
                              },
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            formattedDate,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: MediaQuery.of(context).size.width * 0.06,
              columns: const [
                DataColumn(
                  label: Center(child: Text('No')),
                  numeric: true,
                ),
                DataColumn(
                  label: Center(child: Text('Room Number')),
                  numeric: false,
                ),
                DataColumn(
                  label: Center(child: Text('Room Type')),
                  numeric: false,
                ),
                DataColumn(
                  label: Center(child: Text('Room Status')),
                  numeric: false,
                ),
                DataColumn(
                  label: Center(child: Text('Guest Name')),
                  numeric: false,
                ),
                DataColumn(
                  label: Center(child: Text('Housekeeping Status')),
                  numeric: false,
                ),
                DataColumn(
                  label: Center(child: Text('Housekeeper')),
                  numeric: false,
                ),
                DataColumn(
                  label: Center(child: Text('Action')),
                  numeric: false,
                ),
              ],
              rows: getFilteredHks().asMap().entries.map((entry) {
                int index = entry.key + 1;
                Hk hk = entry.value;

                Color statusColor =
                    ColorController.getHKColor(hk.housekeepingStatus);

                bool isSelected = selectedRows.contains(index + 1);

                return DataRow(
                  selected: isSelected,
                  onSelectChanged: (isSelected) {
                    setState(() {
                      if (isSelected!) {
                        selectedRows.add(index);
                      } else {
                        selectedRows.remove(index);
                      }
                    });
                  },
                  cells: [
                    DataCell(
                      Center(child: Text(index.toString())),
                      showEditIcon: false,
                    ),
                    DataCell(
                      Center(child: Text(hk.roomNumber)),
                      showEditIcon: false,
                    ),
                    DataCell(
                      Center(child: Text(hk.roomType)),
                      showEditIcon: false,
                    ),
                    DataCell(
                      Center(child: Text(hk.roomStatus)),
                      showEditIcon: false,
                    ),
                    DataCell(
                      Center(child: Text(hk.name)),
                      showEditIcon: false,
                    ),
                    DataCell(
                      Center(
                        child: Container(
                          width: 120,
                          height: 30,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: statusColor,
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            hk.housekeepingStatus,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      showEditIcon: false,
                    ),
                    DataCell(
                      Center(child: Text(hk.housekeeper)),
                      showEditIcon: false,
                    ),
                    DataCell(
                      Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                showViewDialog(hk);
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<
                                        Color>(
                                    const Color.fromRGBO(49, 145, 196, 1.0)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                              ),
                              child: const Text(
                                "View",
                                style: TextStyle(
                                  color:
                                      Colors.white, // Set text color to white
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            TextButton(
                              onPressed: () {
                                showEditDialog(hk);
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<
                                        Color>(
                                    const Color.fromRGBO(49, 145, 196, 1.0)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                              ),
                              child: const Text(
                                "Update",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      showEditIcon: false,
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
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
                          color:
                              currentPage == page ? Colors.white : Colors.black,
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
