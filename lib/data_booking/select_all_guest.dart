import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Guests extends StatefulWidget {
  @override
  _GuestsState createState() => _GuestsState();
}

class _GuestsState extends State<Guests> {
  List<dynamic> guests = [];
  bool isLoading = true;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _passportNumberController =
      TextEditingController();
  final TextEditingController _cardIdController = TextEditingController();
  final TextEditingController _otherInformationController =
      TextEditingController();

  String? selectedGender;
  DateTime? selectedDate; // For birthdate

  final List<String> genderOptions = ['Male', 'Female', 'Others'];

  @override
  void initState() {
    super.initState();
    fetchGuestData();
  }

  Future<void> fetchGuestData() async {
    final response = await http
        .get(Uri.parse('http://localhost:8000/api/guests/select_all'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      setState(() {
        guests = responseData['data'];
        isLoading = false;
      });
    } else {
      print('Failed to load guest data');
    }
  }

  Future<void> deleteGuest(int guestId) async {
    final response = await http.delete(
      Uri.parse('http://localhost:8000/api/guests/delete/$guestId'),
    );

    if (response.statusCode == 200) {
      print('Guest deleted successfully');
      setState(() {
        guests.removeWhere((guest) => guest['id'] == guestId);
      });
    } else {
      print('Failed to delete guest');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guest List'),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    _showInsertGuestDialog();
                  },
                  child: Text('Insert Guest'),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: guests.length,
                    itemBuilder: (BuildContext context, int index) {
                      final guest = guests[index];
                      return Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ListTile(
                              title: Text('Name: ${guest['name']}'),
                              subtitle: Text('Email: ${guest['email']}'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                deleteGuest(guest['id']);
                              },
                              child: Text('Delete Guest'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> _showInsertGuestDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Insert Guest'),
          content: Form(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Gender'),
                    value: selectedGender,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedGender = newValue;
                      });
                    },
                    items: genderOptions.map((String gender) {
                      return DropdownMenuItem<String>(
                        value: gender,
                        child: Text(gender),
                      );
                    }).toList(),
                  ),
                  TextFormField(
                    controller: _phoneNumberController,
                    decoration: InputDecoration(labelText: 'Phone Number'),
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an email address';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _countryController,
                    decoration: InputDecoration(labelText: 'Country'),
                  ),
                  // Date of Birth field with Date Picker
                  TextFormField(
                    controller: _dobController,
                    decoration: InputDecoration(labelText: 'Date of Birth'),
                    readOnly: true,
                    onTap: () {
                      _selectDate(context);
                    },
                  ),
                  // Other fields
                  TextFormField(
                    controller: _passportNumberController,
                    decoration: InputDecoration(labelText: 'Passport Number'),
                  ),
                  TextFormField(
                    controller: _cardIdController,
                    decoration: InputDecoration(labelText: 'Card ID'),
                  ),
                  TextFormField(
                    controller: _otherInformationController,
                    decoration: InputDecoration(labelText: 'Other Information'),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
            TextButton(
              onPressed: () {
                // Validate and submit the form
                if (Form.of(context)!.validate()) {
                  final guestData = {
                    'name': _nameController.text,
                    'gender': selectedGender,
                    'phone_number': _phoneNumberController.text,
                    'email': _emailController.text,
                    'country': _countryController.text,
                    'dob': _dobController.text,
                    'passport_number': _passportNumberController.text,
                    'card_id': _cardIdController.text,
                    'other_information': _otherInformationController.text,
                  };
                  insertGuest(guestData);
                  Navigator.of(context).pop();
                }
              },
              child: Text('Insert'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        _dobController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> insertGuest(Map<String, dynamic> guestData) async {
    final response = await http.post(
      Uri.parse('http://localhost:8000/api/guests/insert'),
      body: json.encode(guestData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print('Guest inserted successfully');
      fetchGuestData();
      showSnackbar('Guest inserted successfully');
    } else {
      print('Failed to insert guest');
      showSnackbar('Failed to insert guest');
    }
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
