import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/system_widget/btn.dart';
import 'package:housekeepingmanagement/system_widget/custom_text_field.dart';
import 'package:housekeepingmanagement/widget/country.dart';
import 'package:housekeepingmanagement/widget/legend.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BookingDialog extends StatefulWidget {
  const BookingDialog({Key? key}) : super(key: key);

  @override
  State<BookingDialog> createState() => _BookingDialogState();
}

class _BookingDialogState extends State<BookingDialog> {
  @override
  Widget build(BuildContext context) {
    TextEditingController guestNameController = TextEditingController();
    TextEditingController genderController = TextEditingController();
    TextEditingController countryController = TextEditingController();
    TextEditingController dobController = TextEditingController();
    TextEditingController childController = TextEditingController();
    TextEditingController adultController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController cardIdController = TextEditingController();
    TextEditingController guestNoteController = TextEditingController();
    TextEditingController emailController = TextEditingController();

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      content: Container(
        height: 300,
        width: 300,
        color: const Color(0xffffffff),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Create Booking',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color(0xFF7C7C7C),
                  ),
                ),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEF3423),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CustomTextField(
                            controller: guestNameController,
                            labelText: 'Guest Name',
                            width: 270,
                          ),
                          const SizedBox(width: 10),
                          CustomDropdownButton(
                            width: 270,
                            items: const ['No set', 'Male', 'Female'],
                            selectedValue: genderController.text,
                            hintText: 'Room Status',
                            onChanged: (value) {
                              genderController.text = value!;
                            },
                          )
                        ],
                      ),
                      Row(
                        children: [
                          DatePickerTextField(
                            controller: dobController,
                            labelText: 'Date Of Birth',
                            width: 290,
                          ),
                          const SizedBox(width: 10),
                          selectCountry_dropdown(
                            width: 250,
                            labelText: 'Country',
                            selectedValue: countryController.text,
                            hintText: 'Country',
                            onChanged: (value) {
                              countryController.text = value!;
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          CustomTextField(
                            controller: adultController,
                            labelText: 'Adult',
                            width: 270,
                          ),
                          const SizedBox(width: 10),
                          CustomTextField(
                            controller: childController,
                            labelText: 'Child',
                            width: 270,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          CustomTextField(
                            controller: phoneController,
                            labelText: 'Phone Number',
                            width: 270,
                          ),
                          const SizedBox(width: 10),
                          CustomTextField(
                            controller: addressController,
                            labelText: 'Address',
                            width: 270,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          CustomTextField(
                            controller: cardIdController,
                            labelText: 'Card ID',
                            width: 270,
                          ),
                          const SizedBox(width: 10),
                          CustomTextField(
                            controller: emailController,
                            labelText: 'Email',
                            width: 270,
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Row(
                          children: [
                            CustomTextField(
                              controller: guestNoteController,
                              labelText: 'Guest Note',
                              width: 550,
                              height: 100,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BtnAction(
              icon: Icons.settings,
              textColor: Colors.white,
              color: const Color.fromRGBO(173, 17, 231, 1.0),
              label: "Save",
              action: () {
                BookingDialog();
              },
              background: const Color(0xFF761497),
            ),
          ],
        ),
      ],
    );
  }
}

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:8000/api';

  Future<List<dynamic>> fetchAllBookings() async {
    final response = await http.get(Uri.parse('$baseUrl/booking/all'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
