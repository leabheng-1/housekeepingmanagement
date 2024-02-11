import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiFunctionsBooking {
  static Future<List> fetchBookingData(dynamic bookingsId) async {
    final response = await http.get(
        Uri.parse('http://localhost:8000/api/booking/all?booking_id=$bookingsId'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> bookingData = responseData['data'];
      return bookingData;
    } else {
      throw Exception('Failed to load booking data');
    }
  }
}
class ApiFunctionsBookingbyid {
  static Future<List> fetchBookingData(int bookingsId) async {
    final response = await http.get(
        Uri.parse('http://localhost:8000/api/booking/all?booking_id=$bookingsId'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> bookingData = responseData['data'];
      return bookingData;
    } else {
      throw Exception('Failed to load booking data');
    }
  }
}