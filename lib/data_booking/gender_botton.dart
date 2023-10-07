import 'package:flutter/material.dart';

class GenderBotton extends StatefulWidget {
  const GenderBotton({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GenderBottonState createState() => _GenderBottonState();
}

class _GenderBottonState extends State<GenderBotton> {
  final TextEditingController _genderController = TextEditingController();
  String selectedItem = 'Not Set';
  List<String> items = ['Female', 'Male', 'Not Set'];
  String hintTitle = 'Select an item';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Gender'),
        SizedBox(
          width: 170,
          height: 35,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: DropdownButton<String>(
              value: selectedItem,
              onChanged: (String? newValue) {
                setState(() {
                  selectedItem = newValue!;
                  _genderController.text = newValue;
                });
              },
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(item),
                  ),
                );
              }).toList(),
              hint: Text(
                hintTitle,
                style: const TextStyle(fontSize: 15),
              ),
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              isExpanded: true,
            ),
          ),
        ),
      ],
    );
  }
}
