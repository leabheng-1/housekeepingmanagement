import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/dialog/bookingdetail.dart';
import 'package:housekeepingmanagement/dialog/bookingdialog.dart';
import 'package:http/http.dart' as http;


Future<void> onCheck(BuildContext context, dynamic bookingid, String check, VoidCallback action,bool isdialog,{dynamic groupcheckinid , bool isgourpcheck = false } ) async {
  try {
   

    final String baseUrl1 = 'http://localhost:8000/api/booking/updatestatus/$check';
    final url = Uri.parse('$baseUrl1/$bookingid?booking_id=$groupcheckinid');
print('$baseUrl1/$bookingid?booking_id=$groupcheckinid');
    final response = await http.put(url);
    final jsonResponse = json.decode(response.body);
    final errorMessage = jsonResponse['message'];

    if (response.statusCode == 200) {
    
              Future.delayed(const Duration(milliseconds: 500), () {
            action.call();
              });
      // ignore: use_build_context_synchronously
      AwesomeDialog(
        width: 500,
        context: context,
        dialogType: DialogType.success,
        title: '$check Successfully',
        desc: errorMessage,
        btnOkOnPress: () async { 
          List<dynamic> bookingData = await ApiFunctionsBooking.fetchBookingData(bookingid);
         
          if (isdialog) {
              Navigator.of(context).pop();
          }
         if (isgourpcheck) {
          BookingDialog(context, action).showBookingGroupDetailsDialog(bookingData[0]); 
         }else{
          BookingDialog(context, action).showBookingDetailsDialog(bookingData[0]);
         }
          
        },
      ).show();
      print('Booking created successfully.');
    } else if (response.statusCode == 400) {
      AwesomeDialog(
        width: 500,
        context: context,
        dialogType: DialogType.error,
        title: '$check Failed',
        desc: errorMessage,
        btnOkOnPress: () {},
      ).show();
      print('Booking failed: $errorMessage');
    } else {
      AwesomeDialog(
        width: 500,
        context: context,
        dialogType: DialogType.error,
        title: 'Booking Failed',
        desc: response.toString(),
        btnOkOnPress: () {},
      ).show();
    }
  } catch (e) {

    print('Error during API call: $e');
  }
}
