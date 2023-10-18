import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TestingAPI extends StatelessWidget {
  const TestingAPI({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('API Example'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              _showAlertDialog(context);
            },
            child: const Text('Fetch API Data'),
          ),
        ),
      ),
    );
  }
}

Future<void> _showAlertDialog(BuildContext context) async {
  String? inputText; // Store the input text from TextFormField
  String apiResponse = 'No data';

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Enter Text'),
        content: TextFormField(
          decoration: const InputDecoration(
            labelText: 'Text',
          ),
          onChanged: (value) {
            inputText = value; // Update inputText on text change
          },
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              if (inputText != null) {
                // Send the input text to the API
                final response = await http.post(
                  'http://127.0.0.1:8000/api/booking/all' as Uri,
                  body: {'text': inputText},
                );

                // Handle API response
                if (response.statusCode == 200) {
                  // Successful API call
                  apiResponse = 'Data saved to API: $inputText';
                } else {
                  // Error in API call
                  apiResponse =
                      'Failed to save data to API. Status code: ${response.statusCode}';
                }

                Navigator.of(context).pop();
                _showApiResponse(context, apiResponse);
              }
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

Future<void> _showApiResponse(BuildContext context, String responseText) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('API Response'),
        content: SingleChildScrollView(
          child: Text(responseText),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
