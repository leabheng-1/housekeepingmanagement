import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/data_list/textbutton_list.dart';
import 'package:housekeepingmanagement/dialog/bookingdialog.dart';
import 'package:housekeepingmanagement/frontdesk/widget/Empty.dart';
import 'package:housekeepingmanagement/widget/checkinandcheckout.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataCheckOutList extends StatefulWidget {
  const DataCheckOutList({
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _DataCheckOutListState createState() => _DataCheckOutListState();
}

class _DataCheckOutListState extends State<DataCheckOutList> {
  List<dynamic> bookingsData = [];
  Set<int> selectedRows = <int>{};
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
     isLoading = true;
    final response = await http
        .get(Uri.parse('http://localhost:8000/api/dashboard/today_booking'));

    if (response.statusCode == 200) {
       isLoading = false;
      Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        bookingsData = data['data']['check_out_bookings'];
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
    return 
    isLoading ? const 
     Padding(
      padding: const EdgeInsets.only(top: 100),
    child: Center(
                                      child: CircularProgressIndicator(),
                                    )
     )
                              :
    bookingsData.length <= 0 ? EmptyStateWidget() : 
     Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
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
                  // selected: isSelected,
                  // onSelectChanged: (isSelected) {
                  //   setState(() {
                  //     if (isSelected != null && isSelected) {
                  //       selectedRows.add(index);
                  //     } else {
                  //       selectedRows.remove(index);
                  //     }
                  //   });
                  // },
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
                        calculateDateDifference(
                            booking['checkin_date'], booking['checkout_date']),
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
                            title: 'Check-Out',
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
                      title: 'Check Out',
                      // padding: const EdgeInsets.all(5.0),
                      desc:
                          'Do you want Check Out this Booking',
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {
                              onCheck(context, booking['booking_id'],'checkout',fetchData,false);
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
    );
  }
}
