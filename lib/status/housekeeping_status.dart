import 'package:flutter/material.dart';

class HousekeepingStatus extends StatefulWidget {
  const HousekeepingStatus({Key? key}) : super(key: key);

  @override
  State<HousekeepingStatus> createState() => _HousekeepingStatusState();
}

class _HousekeepingStatusState extends State<HousekeepingStatus> {
  String _selectedStatus = 'Housekeeping Status';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Container(
        height: 35,
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  _selectedStatus,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
            PopupMenuButton<String>(
              onSelected: (value) {
                setState(() {
                  _selectedStatus = value;
                });
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'Housekeeping Status',
                  child: Text('Housekeeping Status'),
                ),
                const PopupMenuItem<String>(
                  value: 'Inhouse',
                  child: Text('Inhouse'),
                ),
                const PopupMenuItem<String>(
                  value: 'Blocked',
                  child: Text('Blocked'),
                ),
                const PopupMenuItem<String>(
                  value: 'Cancel',
                  child: Text('Cancel'),
                ),
                const PopupMenuItem<String>(
                  value: 'No Show',
                  child: Text('No Show'),
                ),
              ],
              icon: const Icon(Icons.arrow_drop_down_sharp),
            ),
          ],
        ),
      ),
    );
  }
}
