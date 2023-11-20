import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/dialog/bookingdetail.dart';
import 'package:housekeepingmanagement/dialog/bookingdialog.dart';
import 'package:http/http.dart' as http;


Future<void> onCheck(BuildContext context, int bookingid, String check, VoidCallback? action) async {
  try {
    List<dynamic> bookingData = await ApiFunctionsBooking.fetchBookingData(bookingid);

    final String baseUrl1 = 'http://localhost:8000/api/booking/updatestatus/$check';
    final url = Uri.parse('$baseUrl1/$bookingid');

    final response = await http.put(url);
    final jsonResponse = json.decode(response.body);
    final errorMessage = jsonResponse['message'];

    if (response.statusCode == 200) {
      AwesomeDialog(
        width: 500,
        context: context,
        dialogType: DialogType.success,
        title: '$check Successfully',
        desc: errorMessage,
        btnOkOnPress: () {
          print(bookingData);
          //  Navigator.of(context).pop();
          // BookingDialog(context, action!).showBookingDetailsDialog(bookingData[0]);
          action?.call();
        },
      ).show();
      print('Booking created successfully.');
    } else if (response.statusCode == 400) {
      AwesomeDialog(
        width: 500,
        context: context,
        dialogType: DialogType.error,
        title: 'Booking Failed',
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
