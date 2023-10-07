import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateBookingPage extends StatefulWidget {
  const CreateBookingPage({super.key});

  @override
  _CreateBookingPageState createState() => _CreateBookingPageState();
}

class _CreateBookingPageState extends State<CreateBookingPage> {
  final TextEditingController roomNumberController = TextEditingController();
  final TextEditingController roomStatusController = TextEditingController();
  final TextEditingController airConditionerController =
      TextEditingController();
  final TextEditingController housekeeperController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController paymentStatusController = TextEditingController();
  final TextEditingController roomIdController = TextEditingController();
  final TextEditingController housekeepingStatusController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController checkinDateController = TextEditingController();
  final TextEditingController roomTypeController = TextEditingController();
  final TextEditingController checkoutDateController = TextEditingController();

  void _submitForm() async {
    final url = Uri.parse('http://localhost:8000/api/booking/insert');

    final response = await http.post(
      url,
      body: {
        'room_number': roomNumberController.text,
        'room_status': roomStatusController.text,
        'air_conditioner': airConditionerController.text,
        'housekeeper': housekeeperController.text,
        'phone_number': phoneNumberController.text,
        'payment_status': paymentStatusController.text,
        'room_id': roomIdController.text,
        'housekeeping_status': housekeepingStatusController.text,
        'name': nameController.text,
        'checkin_date': checkinDateController.text,
        'room_type': roomTypeController.text,
        'checkout_date': checkoutDateController.text,
      },
    );

    if (response.statusCode == 200) {
      // Booking successfully created
      print('Booking created successfully.');
    } else {
      // Handle the error
      print('Failed to create booking. Status Code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Booking'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: roomNumberController,
              decoration:
                  InputDecoration(labelText: 'Room Number (comma-separated)'),
            ),
            TextFormField(
              controller: roomStatusController,
              decoration: InputDecoration(labelText: 'Room Status'),
            ),
            TextFormField(
              controller: airConditionerController,
              decoration: InputDecoration(labelText: 'Air Conditioner'),
            ),
            TextFormField(
              controller: housekeeperController,
              decoration: InputDecoration(labelText: 'Housekeeper'),
            ),
            TextFormField(
              controller: phoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            TextFormField(
              controller: paymentStatusController,
              decoration: InputDecoration(labelText: 'Payment Status'),
            ),
            TextFormField(
              controller: roomIdController,
              decoration: InputDecoration(labelText: 'Room ID'),
            ),
            TextFormField(
              controller: housekeepingStatusController,
              decoration: InputDecoration(labelText: 'Housekeeping Status'),
            ),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              controller: checkinDateController,
              decoration: InputDecoration(labelText: 'Check-in Date'),
            ),
            TextFormField(
              controller: roomTypeController,
              decoration: InputDecoration(labelText: 'Room Type'),
            ),
            TextFormField(
              controller: checkoutDateController,
              decoration: InputDecoration(labelText: 'Checkout Date'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
