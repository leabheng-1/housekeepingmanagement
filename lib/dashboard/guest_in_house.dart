import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/guest_in_house_widget/guest_in_house_botton.dart';
import 'package:housekeepingmanagement/guest_in_house_widget/guest_in_house_list.dart';

class GuestInHouse extends StatefulWidget {
  const GuestInHouse({super.key});

  @override
  State<GuestInHouse> createState() => _GuestInHouseState();
}

class _GuestInHouseState extends State<GuestInHouse> {
  late String selectedValue;
  String? guestNameFilter;

  List<String> dropdownItems = ['Item 1', 'Item 2', 'Item 3'];
  String? selectedDropdownValue;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            Expanded(
              child: GuestInHouseBotton(),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 30, right: 10, top: 10, bottom: 10),
            child: Container(
              width: double.infinity,
              height: 550,
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: Row(
                      children: [
                        Container(
                          width: 300,
                          height: 35,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: DropdownButton<String>(
                              hint: const Text(
                                'HouseKeeping Status',
                                textAlign: TextAlign.center,
                              ),
                              isExpanded: true,
                              style: const TextStyle(),
                              items: <String>[
                                'Option 1',
                                'Option 2',
                                'Option 3',
                                'Option 4'
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Center(
                                    child: Text(value),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedDropdownValue = newValue;
                                });
                              },
                              value: selectedDropdownValue,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        SizedBox(
                          height: 35,
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: Expanded(
                            flex: 1,
                            child: TextFormField(
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10),
                                hintText: 'Guest Name',
                                hintStyle: const TextStyle(fontSize: 14),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: const Icon(Icons.search),
                                filled: true,
                                fillColor: Colors.grey[200],
                              ),
                              onChanged: (value) {
                                setState(() {
                                  guestNameFilter = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Row(
                    children: [
                      GuestInHouseList(),
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
