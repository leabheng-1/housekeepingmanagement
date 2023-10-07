import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/data_booking/add_booking_sub_botton.dart';
import 'package:housekeepingmanagement/data_booking/gender_botton.dart';

class AddBookingDialog extends StatefulWidget {
  const AddBookingDialog({Key? key}) : super(key: key);

  @override
  State<AddBookingDialog> createState() => _AddBookingDialogState();
}

class _AddBookingDialogState extends State<AddBookingDialog> {
  String selectedItem = 'Not Set';
  List<String> items = ['Female', 'Male', 'Not Set'];
  String hintTitle = 'Select an item';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 40,
            width: 150,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 94, 156, 206),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.add_circle,
                  color: Colors.white,
                ),
                TextButton(
                  onPressed: () {
                    _showInsertDataDialog(context);
                  },
                  child: const Text(
                    "Add Booking",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showInsertDataDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Booking'),
          content: SingleChildScrollView(
            child: SizedBox(
              height: 1000,
              width: 1000,
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AddBookingSubBotton(
                          hintTitle: 'Guest Name',
                          controller: TextEditingController(),
                          title: 'Guest Name',
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const GenderBotton(),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Insert'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
