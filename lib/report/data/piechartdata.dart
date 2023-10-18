import 'dart:convert';
import 'package:http/http.dart' as http;

void fetchMonthlyGuestCount() async {
  final String apiUrl = "http://127.0.0.1:8000/api/report/monthlyGuestCount";

  final Map<String, dynamic> requestData = {
    "success": true,
    "data": [
      {
        "guest": [
          {"Single Room": 29},
          {"Twin Room": 0},
        ],
        "noShowCount": 0,
        "cancelCount": 0,
      }
    ],
    "message": "Monthly guest counts (excluding no-show and cancel) for the current year by room type retrieved successfully",
  };

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(requestData),
  );

  if (response.statusCode == 200) {
    // Request was successful, and you can process the response here.
    final responseData = jsonDecode(response.body);
    print("Response: $responseData");
  } else {
    // Request failed with a non-200 status code, handle the error here.
    print("Request failed with status code: ${response.statusCode}");
  }
}

void main() {
  fetchMonthlyGuestCount();
}
