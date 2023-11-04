import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/data_list/textbutton_list.dart';
import 'package:housekeepingmanagement/dialog/bookingdialog.dart';
import 'package:housekeepingmanagement/system_widget/guest_inhouse_widget.dart';
import 'package:housekeepingmanagement/system_widget/system_color.dart';
import 'package:housekeepingmanagement/widget/checkinandcheckout.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataCheckInList extends StatefulWidget {
  const DataCheckInList({
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _DataCheckInListState createState() => _DataCheckInListState();
}

class _DataCheckInListState extends State<DataCheckInList> {
  List<dynamic> bookingsData = [];
  Set<int> selectedRows = <int>{};

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http
        .get(Uri.parse('http://localhost:8000/api/dashboard/today_booking'));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        bookingsData = data['data']['check_in_bookings'];
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  String calculateDateDifference(String checkinDate, String checkoutDate) {
    DateTime checkin = DateTime.parse(checkinDate);
    DateTime checkout = DateTime.parse(checkoutDate);

    Duration difference = checkout.difference(checkin);

    return '${difference.inDays} nighs';
  }

  String formatDate(String date) {
    // ignore: unnecessary_null_comparison
    if (date == null) {
      return '';
    }

    DateTime parsedDate = DateTime.parse(date);
    String month = getAbbreviatedMonthName(parsedDate.month);

    String formattedDate = '${parsedDate.day.toString().padLeft(2, '0')}-'
        '$month-${parsedDate.year.toString()}';

    return formattedDate;
  }

  String getAbbreviatedMonthName(int month) {
    final months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    return months[month];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: DataTable(
                  columnSpacing: 16.0,
                  headingRowHeight: 48.0,
                  columns: const [
                    DataColumn(
                      label: SizedBox(
                          width: 50,
                          child: Text('No',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      numeric: true,
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: 100,
                        child: Text('Guest Name',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: 100,
                        child: Text('Phone Number',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: 100,
                        child: Text('Room #',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: 120,
                        child: Text('Stay Date',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: 100,
                        child: Text('Pax A/C',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: 100,
                        child: Text('Night',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: 250,
                        child: Center(
                          child: Text(
                            'Action',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                  rows: bookingsData.asMap().entries.map<DataRow>((entry) {
                    int index = entry.key;
                    Map<String, dynamic> booking = entry.value;
                    bool isSelected = selectedRows.contains(index);

                    return DataRow(
                      selected: isSelected,
                      onSelectChanged: (isSelected) {
                        setState(() {
                          if (isSelected != null && isSelected) {
                            selectedRows.add(index);
                          } else {
                            selectedRows.remove(index);
                          }
                        });
                      },
                      cells: [
                        DataCell(
                          SizedBox(
                            width: 50,
                            child: Text(
                              (index + 1).toString(),
                            ),
                          ),
                        ),
                        DataCell(
                          SizedBox(
                            width: 180,
                            child: Text(
                              booking['name'] ?? 'N/A',
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            booking['phone_number'] ?? 'N/A',
                          ),
                        ),
                        DataCell(
                          SizedBox(
                            width: 50,
                            child: Center(
                              child: Text(
                                booking['room_id']?.toString() ?? 'N/A',
                              ),
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            '${formatDate(booking['checkin_date'])} - ${formatDate(booking['checkout_date'])}',
                          ),
                        ),
                        DataCell(
                          SizedBox(
                            width: 50,
                            child: Center(
                              child: Text(
                                '${booking['adults'] ?? 0} / ${booking['child'] ?? 0}',
                              ),
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            calculateDateDifference(booking['checkin_date'],
                                booking['checkout_date']),
                          ),
                        ),
                        DataCell(
                          Row(
                            children: [
                              TextButttonList(
                                title: 'View',
                                height: 0.1,
                                width: 0.05,
                                backgroundColor: Colors.green,
                                onPressed: () {
                                   BookingDialog(
                                                            context, fetchData)
                                                        .showBookingDetailsDialog(
                                                            booking);
  },
                              ),
                              TextButttonList(
                                title: 'Check-In',
                                height: 0.1,
                                width: 0.06,
                                backgroundColor: Colors.purple.shade800,
                                onPressed: (){
                                  AwesomeDialog(
          width: 650,
                      context: context,
                      keyboardAware: true,
                      dismissOnBackKeyPress: false,
                      dialogType: DialogType.warning,
                      animType: AnimType.bottomSlide,
                      btnCancelText: "NO",
                      btnOkText: "YES",
                      title: booking['booking_id'].toString(),
                      // padding: const EdgeInsets.all(5.0),
                      desc:
                          'You will be logged out of your account and returned to the login page.',
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {
                         onCheck(context, booking['booking_id'],'checkin',fetchData);
                      },
                    ).show();
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 200,
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

  late List<Hk> hks;
  int currentPage = 1;
  int perPage = 10;
  String? roomStatusFilter;
  String? hkStatusFilter;
  String? guestNameFilter;
  int totalPages = 1;
}
