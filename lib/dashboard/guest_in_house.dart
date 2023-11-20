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
