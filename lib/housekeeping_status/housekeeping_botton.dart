import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/housekeeping_status/housekeeping_status_widget.dart';
import 'package:housekeepingmanagement/system_widget/system_color.dart';
import 'package:housekeepingmanagement/system_widget/system_icon.dart';

class HousekeepingButton extends StatefulWidget {
  const HousekeepingButton({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HousekeepingButtonState createState() => _HousekeepingButtonState();
}

class _HousekeepingButtonState extends State<HousekeepingButton> {
  // A variable to keep track of the selected index in the navigation rail
  final int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
  flex: 3,
  child: Container(
    height: 50,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Padding(
      padding: const EdgeInsets.only(
        right: 10,
        left: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          HouseKeepingStatus(
            
            title: 'Dirty',
            icon: Icons.cleaning_services_rounded,
            backgroundColor: _selectedIndex == 0
                ? Colors.blue.shade800
                : Colors.grey.shade800,
          ),
          HouseKeepingStatus(
            title: 'Cleaning',
            icon: Icons.cleaning_services_rounded,
            backgroundColor: _selectedIndex == 0
                ? Colors.yellow.shade600
                : Colors.grey.shade800,
          ),
          HouseKeepingStatus(
            title: 'Clean',
            icon: Icons.cleaning_services_rounded,
            backgroundColor: _selectedIndex == 0
                ? Colors.green
                : Colors.grey.shade800,
          ),
        ],
      ),
    ),
  ),
),

        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Expanded(
            flex: 4,
            child: Container(
              height: 50,
              width: 600,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: HouseKeepingStatus(
                        title: 'Inhouse',
                        icon: iconController.inHouseIcon,
                        backgroundColor: ColorController.inHouseColor),
                  ),
                  HouseKeepingStatus(
                      title: 'Blocked',
                      icon: Icons.cleaning_services_rounded,
                      backgroundColor: ColorController.blockColor),
                  HouseKeepingStatus(
                      title: 'Cancel',
                      icon: Icons.block,
                      backgroundColor: ColorController.cancel),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: HouseKeepingStatus(
                        title: 'No Show',
                        icon: iconController.noshow,
                        backgroundColor: ColorController.noshow),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HouseKeepingStatus(
                        title: 'Unpaid',
                        icon: iconController.dollar,
                        backgroundColor: ColorController.unPaid),
                    HouseKeepingStatus(
                        title: 'Deposit',
                        icon: iconController.dollar,
                        backgroundColor: ColorController.deposit),
                    HouseKeepingStatus(
                        title: 'Paid',
                        icon: iconController.dollar,
                        backgroundColor: ColorController.paid),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
