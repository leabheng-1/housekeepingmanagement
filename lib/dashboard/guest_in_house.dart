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
    return
    Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey[300],
          child: Column(
            children: [
              Row(
          children: [
            Expanded(
              
              child: GuestInHouseBotton(),
            ),
          ],
        ),
              SizedBox(
                height: 750.0,
                child: Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: GuestInHouseList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
