import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/dashboard/frontdesk.dart';
import 'package:housekeepingmanagement/dialog/barDialog.dart';
import 'package:housekeepingmanagement/dialog/bookingdialog.dart';
import 'package:housekeepingmanagement/dialog/editBooking.dart';
import 'package:housekeepingmanagement/dialog/editGuest.dart';
import 'package:housekeepingmanagement/frontdesk/widget/Empty.dart';
import 'package:housekeepingmanagement/frontdesk/widget/Morebtnaction.dart';
import 'package:housekeepingmanagement/system_widget/box_detail.dart';
import 'package:housekeepingmanagement/system_widget/btn.dart';
import 'package:housekeepingmanagement/system_widget/system_color.dart';
import 'package:housekeepingmanagement/system_widget/system_icon.dart';
import 'package:housekeepingmanagement/widget/Datebooking.dart';
import 'package:housekeepingmanagement/widget/checkinandcheckout.dart';
import 'package:housekeepingmanagement/widget/country.dart';
import 'package:housekeepingmanagement/widget/inputbox.dart';
import 'package:housekeepingmanagement/widget/legend.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

class statusDialog {
  // final VoidCallback reloadDataCallback;
  final BuildContext context;
    final VoidCallback reloadDataCallback;
    String title;
 void _handleRowTap(Map<String, dynamic> booking) {
 BookingDialog(
                                                            context, reloadDataCallback)
                                                        .showBookingDetailsDialog(
                                                            booking);
  }
  statusDialog(this.context ,this.reloadDataCallback,this.title);
   void showCreatestatusDialog(List<dynamic> booking) {
 
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(

        title: TitleBar(title:title),
        content:   Container(
  margin: EdgeInsets.only(top: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
    width: 800, // Set the desired width
    height: 600, // Set the desired height
    child:
              Expanded(
                child:
                  booking.isEmpty ? EmptyStateWidget() :
  
                  SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: [
          DataColumn(label: Text('Booking ID')),
          DataColumn(label: Text('Room Type')),
          DataColumn(label: Text('Arrival Date')),
          DataColumn(label: Text('Departure Date')),
        ],
        rows: booking.map((booking) {
          return            DataRow(
            cells: [
              DataCell(Text(booking['booking_id'].toString())),
              DataCell(Text(booking['room_type'].toString())),
              DataCell(Text(booking['arrival_date'].toString())),
              DataCell(Text(booking['departure_date'].toString())),
            ],
            onSelectChanged: (_) {
         _handleRowTap(booking);
            },
          );
        }).toList(),
      ),
    )
              ),
              )
            ],
          ),
        ),
        actions: [
        Padding(
  padding: EdgeInsets.only(left:16,right:16,bottom:16,top: 0), // Adjust the padding as needed
  child:
          Row(  
            mainAxisAlignment: MainAxisAlignment.end,
children: [
           BtnAction(
   background: Color.fromARGB(52, 0, 0, 0),
  icon: iconController.closeIcon,
  textColor: Colors.white,
  color: Colors.red,
  label: "Close",
  action: () {
       Navigator.of(context).pop();
  },
),
]
          )
        )
        ],
      );
    },
  );

}
}
