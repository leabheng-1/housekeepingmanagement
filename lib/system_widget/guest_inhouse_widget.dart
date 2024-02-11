import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:housekeepingmanagement/frontdesk/widget/Empty.dart';
import 'package:housekeepingmanagement/system_widget/box_detail.dart';
import 'package:housekeepingmanagement/system_widget/btn.dart';
import 'package:housekeepingmanagement/widget/country.dart';
import 'package:housekeepingmanagement/widget/inputbox.dart';
import 'package:housekeepingmanagement/system_widget/system_color.dart';
import 'package:housekeepingmanagement/system_widget/system_icon.dart';
import 'package:http/http.dart' as http;
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
  final String hkStatus;
  final String note;
  final String floor;
  final String room_rate;

  Hk({
     this.id = 0,
    this.roomId = 0,
    this.roomNumber = "",
    this.roomStatus = "",
    this.roomType = "",
    this.housekeeper = "",
    this.date = "",
    this.name = "",
    this.housekeepingStatus = "",
    this.last_page = "",
    this.hkStatus = "",
    this.note = "",
    this.floor = "",
    this.room_rate = "\$0"
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
      hkStatus: json['housekeeping_status'] ?? 'Dirty',
      note: json['note'] ?? '',
      floor: json['floor'].toString() ?? '',
      room_rate: json['room_rate'] ?? '0',
      roomId: json['roomId'] ?? -1,
    );
  }
}

class HkDataTable extends StatefulWidget {
  final VoidCallback reloadData;

  const HkDataTable({Key? key, required this.reloadData}) : super(key: key);

  @override
  _HkDataTableState createState() => _HkDataTableState();
}

class _HkDataTableState extends State<HkDataTable> {
  late List<Hk> hks;
  int currentPage = 1;
  int perPage = 10;
  String? roomStatusFilter = 'All';
  String? hkStatusFilter = 'All';
  String? guestNameFilter = 'All';
  int totalPages = 1;

  @override
  void initState() {
    super.initState();
    fetchData();
    textEditingController.text = '';
    guestNameFilter = '';
  }

  Future<void> fetchData() async {
    loading = true;
    if (guestNameFilter!.isEmpty) {
      guestNameFilter = 'All';
    }
    final response = await http.get(Uri.parse(
        'http://localhost:8000/api/booking/all?page=$currentPage&room_status=$roomStatusFilter&housekeeping_status=$hkStatusFilter&guest_name=$guestNameFilter'));
    if (response.statusCode == 200) {
      loading = false;
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
                title: "Room Id : ${hk.id}",
                titleFontSize: 16.0,
                iconData: Icons.single_bed,
                iconSize: 24.0,
                buttonBackgroundColor: const Color.fromARGB(255, 109, 149, 218),
                iconBackgroundColor: const Color.fromARGB(38, 0, 0, 0),
                iconColor: Colors.white,
                textColor: Colors.white,
              ),
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
                      textColor: Colors.white,
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
                    title: "Note", value: hk.note, height: 150, width: 920),
              ),
            ],
          ),
          actions: [
            BtnAction(
              background: const Color.fromARGB(52, 0, 0, 0),
              icon: iconController.closeIcon,
              textColor: Colors.white,
              color: ColorController.CloseColor,
              label: "Cancel",
              action: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showEditDialog(Hk hk , {bool is_insert = false}) async {
    final TextEditingController roomTypeController = TextEditingController();
    final TextEditingController housekeeperController = TextEditingController();
    final TextEditingController roomNumberController = TextEditingController();
    final TextEditingController floorController = TextEditingController();
    final TextEditingController dateController = TextEditingController();
      final TextEditingController roomRateController = TextEditingController();
    
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
    floorController.text = hk.floor;
    roomRateController.text = hk.room_rate;
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
                title: "Room Id : ${hk.id}",
                titleFontSize: 16.0,
                iconData: Icons.single_bed,
                iconSize: 24.0,
                buttonBackgroundColor: const Color.fromARGB(255, 109, 149, 218),
                iconBackgroundColor: const Color.fromARGB(38, 0, 0, 0),
                iconColor: Colors.white,
                textColor: Colors.white,
              ),
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
              Row(
                children: [
                  DatePickerTextField(
                    checkcurrnetdate: DateTime(2000),
                    labelText: 'Select a Date',
                    controller: selectedDate,
                    onDateSelectedDate: (selectedDate) {},
                  ),
                ],
              ),
              Row(children: [
                  CustomDropdownButton(
                  labelText: 'Room Type',
                  bg: const Color.fromRGBO(255, 255, 255, 1),
                  width: 450,
                  items: const ['Single Room', 'Twin Room'],
                  selectedValue: roomTypeController.text,
                  hintText: 'Room Type',
                  onChanged: (value) {
                    setState(() {
                      roomTypeController.text = value!;
                  
                    });
                  },
                ),
                
                const SizedBox(width: 15),
                CustomTextField(
                  controller: roomNumberController,
                  labelText: "Room Number",
                ),
                
              ]),
              Row(children: [
                 CustomDropdownButton(
                  labelText: 'Floor',
                  bg: const Color.fromRGBO(255, 255, 255, 1),
                  width: 216,
                  items: const ['1', '2', '3' , '4'],
                  selectedValue: floorController.text,
                  hintText: 'Floor',
                  onChanged: (value) {
                    setState(() {
                      floorController.text = value!;
                      hknew = value;
                    });
                  },
                ),
                SizedBox(width: 15),
                  CustomTextField(
                    width: 216,
                  controller: roomRateController,
                  isCurrency: true,
                  labelText: "Room Rate",
                ),
                const SizedBox(width: 15),
                  CustomDropdownButton(
                          bg: const Color.fromRGBO(235, 235, 235, 1.0),
                          width: 450,
                          
                          labelText: 'Room Status',
                          items: const ['Block', 'Available', 'Occupied'],
                          selectedValue: RoomStatusController.text,
                          hintText: 'Room Status',
                          onChanged: (value) {
                            setState(() {
                              RoomStatusController.text = value!;
                            });
                          },
                        ),
                
               
              ]),
              Row(children: [
                 CustomDropdownButton(
                  labelText: 'Housekeeping Status',
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
                SizedBox(width: 15,),
                CustomTextField(
                  controller: housekeeperController,
                  labelText: "Housekeeper",
                ),
              ]),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  CustomTextField(
                      labelText: "Note",
                      controller: noteController,
                      height: 150,
                      width: 920),
                ],
              ),
            ],
          ),
          actions: [
            BtnAction(
              background: const Color.fromARGB(52, 0, 0, 0),
              icon: iconController.closeIcon,
              textColor: Colors.white,
              color: ColorController.CloseColor,
              label: "Cancel",
              action: () {
                Navigator.of(context).pop();
              },
            ),
            BtnAction(
              background: const Color.fromARGB(52, 0, 0, 0),
              icon: iconController.saveIcon,
              textColor: Colors.white,
              color: ColorController.primaryColor,
              label: is_insert ? "Create" : "Update",
              action: () {
                submitUpdatedData(
                    roomTypeController.text,
                    housekeeperController.text,
                    hk.roomId,
                    hknew,
                    selectedDate.text,
                    noteController.text,
                    RoomStatusController.text,
                    hk.date,
                    is_insert ? "insert" : "update",
                    roomNumberController.text,
                    floorController.text,
                    roomRateController.text.replaceAll('\$', '')
                    );
              },
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
      String date,
      String action,
      String room_number,
      String floor,
      String RoomRate
      ) async {
    String baseUrl1 = '';
    if (action == 'update') {
      baseUrl1 = 'http://localhost:8000/api/room/$action/$roomID'; 
    }else{
       baseUrl1 = 'http://localhost:8000/api/room/$action'; 
    }
    
    if (dateController == '') {
      dateController = DateFormat('yyyy-MM-dd').format(currentDate);
    }
    final url = Uri.parse(
        '$baseUrl1?room_status=$RoomStatus&roomtype=$roomType&note=$noteController&housekeeper=$housekeeper&housekeeping_status=$hkStatus&date=$dateController&room_number=$room_number&floor=$floor&room_rate=$RoomRate');
    final response =  action == 'update' ? await http.put(url) : await http.post(url) ;
    print('$baseUrl1?room_status=$RoomStatus&roomtype=$roomType&note=$noteController&housekeeper=$housekeeper&housekeeping_status=$hkStatus&date=$dateController&room_number=$room_number&floor=$floor&room_rate=$RoomRate');
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      // ignore: use_build_context_synchronously
      AwesomeDialog(
        width: 500,
        context: context,
        dialogType: DialogType.success,
        title: 'Update Success',
        desc: data['message'],
        btnOkOnPress: () {
          fetchData();
          widget.reloadData();
          Navigator.of(context).pop();
        },
      ).show();
    } else {
      Map<String, dynamic> data = jsonDecode(response.body);
      // ignore: use_build_context_synchronously
      AwesomeDialog(
        width: 500,
        context: context,
        dialogType: DialogType.error,
        title: 'Update False',
        desc: data['data'],
        btnOkOnPress: () {},
      ).show();
    }
  }

  DateTime currentDate = DateTime.now();
Hk newRoom = Hk() ;
  List<int> selectedRows = [];
  String? selectedValue;
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomDropdownButton(
                          bg: const Color.fromRGBO(235, 235, 235, 1.0),
                          width: 300,
                          labelText: 'Room Status',
                          items: const ['All', 'Available', 'Occupied'],
                          selectedValue: roomStatusFilter ?? 'All',
                          hintText: 'Room Status',
                          onChanged: (value) {
                            setState(() {
                              roomStatusFilter = value;
                              currentPage = 1;
                              fetchData();
                            });
                          },
                        ),
                        const SizedBox(width: 10),
                        CustomDropdownButton(
                          labelText: 'Housekeeping Status',
                          bg: const Color.fromRGBO(235, 235, 235, 1.0),
                          width: 300,
                          items: const ['All', 'Clean', 'Cleaning', 'Dirty'],
                          selectedValue: hkStatusFilter ?? 'All',
                          hintText: 'Housekeeping Status',
                          onChanged: (value) {
                            setState(() {
                              hkStatusFilter = value;
                              currentPage = 1;
                              fetchData();
                            });
                          },
                        ),
                        const SizedBox(width: 10),
                        CustomTextField(
                          controller: textEditingController,
                          labelText: 'Search',
                          width: 265,
                          onChanged: (value) {
                            guestNameFilter = value;
                            currentPage = 1;
                            fetchData();
                          },
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                          Container(
  width: 420,
  margin: EdgeInsets.only(top: 20.0), // Adjust the value as needed
  alignment: Alignment.centerRight,
  child: BtnAction(
    background: Color.fromARGB(52, 0, 0, 0),
    icon: iconController.addIcon,
    textColor: Colors.white,
    color: Color.fromARGB(255, 54, 73, 244),
    label: "Add New Room",
    action: () {
     showEditDialog(newRoom,is_insert: true);
    
    },
  ),
)

                          ],
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
                    margin: const EdgeInsets.only(top: 100.0),
                    child: const CircularProgressIndicator(),
                  ),
                )
              : hks.isEmpty
                  ? EmptyStateWidget()
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columnSpacing: MediaQuery.of(context).size.width * 0.05,
                        columns: const [
                          DataColumn(
                            label: Center(
                              child: Text(
                                'No',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            numeric: true,
                          ),
                          DataColumn(
                            label: Center(
                              child: Text(
                                'Room Number',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            numeric: false,
                          ),
                          DataColumn(
                            label: Center(
                              child: Text(
                                'Room Type',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            numeric: false,
                          ),
                          DataColumn(
                            label: Center(
                              child: Text(
                                'Room Status',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            numeric: false,
                          ),
                          DataColumn(
                            label: Center(
                              child: Text(
                                'Guest Name',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            numeric: false,
                          ),
                          DataColumn(
                            label: Center(
                              child: Text(
                                'Housekeeping Status',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            numeric: false,
                          ),
                          DataColumn(
                            label: Center(
                              child: Text(
                                'Housekeeper',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            numeric: false,
                          ),
                          DataColumn(
                            label: SizedBox(
                              width: 150,
                              child: Center(
                                child: Text(
                                  'Action',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            numeric: false,
                          ),
                        ],
                        rows: hks.asMap().entries.map((entry) {
                          int index = entry.key + 1;
                          Hk hk = entry.value;

                          Color statusColor =
                              ColorController.getHKColor(hk.housekeepingStatus);

                          return DataRow(
                            cells: [
                              DataCell(
                                Center(
                                  child: Text(
                                    index.toString(),
                                  ),
                                ),
                                showEditIcon: false,
                              ),
                              DataCell(
                                Center(
                                  child: Text(hk.roomNumber),
                                ),
                                showEditIcon: false,
                              ),
                              DataCell(
                                Center(
                                  child: Text(hk.roomType),
                                ),
                                showEditIcon: false,
                              ),  DataCell(
                              Center(
                                  child: Container(
                                    width: 100,
                                    height: 30,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: hk.roomStatus == 'Block' ? Colors.black : hk.roomStatus == 'Available' ? Colors.green : Color.fromARGB(255, 59, 159, 241)
                             ,
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      hk.roomStatus,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                showEditIcon: false,
                              ),
                              DataCell(
                                Center(
                                  child: Text(
                                    hk.name.isEmpty ? '' : hk.name,
                                  ),
                                ),
                                showEditIcon: false,
                              ),
                              DataCell(
                                Center(
                                  child: Container(
                                    width: 100,
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
                                      style:
                                          const TextStyle(color: Colors.white),
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
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  const Color.fromARGB(
                                                      255, 138, 214, 255)),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                          ),
                                        ),
                                        child: const Text(
                                          "View",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      TextButton(
                                        onPressed: () {
                                          showEditDialog(hk);
                                          print(
                                        hk
                                          );
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  const Color.fromARGB(
                                                      255, 41, 55, 255)),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
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
          loading
              ? const Center(
                  child: null,
                )
              : hks.isEmpty
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
