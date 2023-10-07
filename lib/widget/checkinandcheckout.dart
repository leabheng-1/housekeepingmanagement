import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<void> onCheck(BuildContext context, int bookingid , String check) async {
  final String baseUrl1 = 'http://localhost:8000/api/booking/$check';
  final url = Uri.parse('$baseUrl1/$bookingid');
  final response = await http.post(url);
  final jsonResponse = json.decode(response.body);
  final errorMessage = jsonResponse['message'];

  if (response.statusCode == 200) {
    // Successful check-in
    AwesomeDialog(
      width: 500,
      context: context,
      dialogType: DialogType.success,
      title: 'Booking Created Successfully',
      desc: errorMessage,
      btnOkOnPress: () {},
    ).show();
    print('Booking created successfully.');
  } else if (response.statusCode == 400) {
    // Handle the specific error message
    final jsonResponse = json.decode(response.body);
    final errorMessage = jsonResponse['message'];

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
    // Handle other error cases
    print('Response body: ${response.body}');
    AwesomeDialog(
      width: 500,
      context: context,
      dialogType: DialogType.error,
      title: 'Booking Failed',
      desc: response.toString(),
      btnOkOnPress: () {},
    ).show();
  }
}
