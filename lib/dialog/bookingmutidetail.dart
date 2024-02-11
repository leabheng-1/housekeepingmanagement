import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/data_list/textbutton_list.dart';
import 'package:housekeepingmanagement/dialog/AwesomeDialogCs.dart';
import 'package:housekeepingmanagement/dialog/bookingdialog.dart';
import 'package:housekeepingmanagement/dialog/checkBtn.dart';
import 'package:housekeepingmanagement/frontdesk/widget/Empty.dart';
import 'package:housekeepingmanagement/frontdesk/widget/formatSystem.dart';
import 'package:housekeepingmanagement/system_widget/guest_inhouse_widget.dart';
import 'package:housekeepingmanagement/system_widget/system_color.dart';
import 'package:housekeepingmanagement/widget/checkinandcheckout.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class mutibookingdialog extends StatefulWidget {
   final String group_id;
   final void Function(String booking_id ) onChange;
   const mutibookingdialog({
      required this.group_id, 
      required this.onChange
   });
  void reloadData() {
    _mutibookingdialogState? state = _key.currentState;
    state?.reloadData();
  }
  @override
  // ignore: library_private_types_in_public_api
  _mutibookingdialogState createState() => _mutibookingdialogState();
}
final GlobalKey<_mutibookingdialogState> _key = GlobalKey<_mutibookingdialogState>();
class _mutibookingdialogState extends State<mutibookingdialog> {
  
  List<dynamic> bookingsData = [];
  Set<int> selectedRows = <int>{};
String selectedRowsString = '';
 bool isLoading = false;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    isLoading = true;
    final response = await http.get(Uri.parse('http://localhost:8000/api/booking/BookingDailog?group_id=${widget.group_id}'));


    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
       isLoading = false;
      setState(() {
        bookingsData = data['data'];
        print(bookingsData.length);
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
 Future<void> reloadData() async {
    await fetchData();
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
    Container(
      height: 400,
      child: 
    Padding(
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
                        child: Text('Booking ID',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: 100,
                        child: Text('Room Type',
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
                        width: 100,
                        child: Text('Payment',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: 100,
                        child: Text('Charge',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: 100,
                        child: Text('Balance',
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
                        width: 130,
                        child: Text('Booking Status',
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
                    bool isSelected = selectedRows.contains(booking['booking_id']);

                    return DataRow(
                      selected: isSelected,
                      onSelectChanged: (isSelected) {
                          
                        setState(() {
                          if (isSelected != null && isSelected) {
                            selectedRows.add(booking['booking_id']);
                          } else {
                            selectedRows.remove(booking['booking_id']);
                          }
                        });
                        Future.delayed(const Duration(milliseconds: 100), () {
                         selectedRowsString = selectedRows.toList().join(', ');
widget.onChange(selectedRowsString); 
                          print(selectedRowsString);
                          }
                          );
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
                             
                            child: Text(
                              booking['booking_id'].toString() ?? 'N/A',
                            ),
                          ),
                        ),
                        DataCell(
                          SizedBox(
                             
                            child: Text(
                              booking['room_type'] ?? 'N/A',
                            ),
                          ),
                        ),
                        DataCell(
                          SizedBox(
                            width: 50,
                            child: Center(
                              child: Text(
                                booking['room_number']?.toString() ?? 'N/A',
                              ),
                            ),
                          ),
                        ),
                         DataCell(
                          SizedBox(
                             
                            child: Text(
                              formatCurrency(booking['payment']).toString() ?? 'N/A',
                            ),
                          ),
                        ),
                         DataCell(
                          SizedBox(
                             
                            child: Text(
                              formatCurrency(booking['charges']).toString() ?? 'N/A',
                            ),
                          ),
                        ),
                         DataCell(
                          SizedBox(
                             
                            child: Text(
                              formatCurrency(booking['balance']).toString()
                               ?? 'N/A',
                            ),
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
                          Center(
                                  child: Container(
                                    width: 140,
                                    height: 30,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: ColorController.bookingStatus(booking['booking_status'])
                             ,
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      booking['booking_status'],
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
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
                              checkbtncheckin(booking) ? 
                              TextButttonList(
                                title: 'Check-In',
                                height: 0.1,
                                width: 0.06,
                                backgroundColor: ColorController.checkInColor,
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
      title:  'Check In',
      // padding: const EdgeInsets.all(5.0),
      desc: 'Do you want to check in this booking ?',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        print('this it booking ${ booking['booking_id']}');
        onCheck(context, booking['booking_id'], 'checkin', fetchData, false  );
      },
    ).show();
                                  },
                              ) : booking['booking_status'] == 'In House' ?
                               TextButttonList(
                                title: 'Check-out',
                                height: 0.1,
                                width: 0.06,
                                backgroundColor: ColorController.checkOutColor,
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
      desc:  'Do you want to check Out this booking ?',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        print('this it booking ${ booking['booking_id']}');
        onCheck(context, booking['booking_id'], 'checkout', fetchData, false  );
      },
    ).show(); 
                            
                                  },
                              ) : Row()
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
    )
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
