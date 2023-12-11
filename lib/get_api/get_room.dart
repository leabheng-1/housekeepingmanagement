import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiFunctionsroom {
  static Future<List> fetchroomData(String roomstype) async {
    final response = await http.get(
        Uri.parse('http://localhost:8000/api/room/all?roomType=$roomstype'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> roomData = responseData['data'];
      return roomData;
    } else {
      throw Exception('Failed to load room data');
    }
  }
}
class ApiFunctionsFindByRoomId {
  static Future<List> fetchroomData(String roomstype) async {
    final response = await http.get(
        Uri.parse('http://localhost:8000/api/room/all?roomType=$roomstype'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> roomData = responseData['data'];
      return roomData;
    } else {
      throw Exception('Failed to load room data');
    }
  }
}
class ApiFunctionsroomid {
  static Future<List> fetchroomData(String roomstype ,int room_number) async {
    final response = await http.get(
        Uri.parse('http://localhost:8000/api/room/all?roomType=$roomstype&room_number=$room_number'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> roomData = responseData['data'];
      return roomData;
    } else {
      throw Exception('Failed to load room data');
    }
  }
}