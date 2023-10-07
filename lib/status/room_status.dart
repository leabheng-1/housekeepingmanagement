import 'package:flutter/material.dart';

class RoomStatus extends StatefulWidget {
  const RoomStatus({Key? key}) : super(key: key);

  @override
  State<RoomStatus> createState() => _RoomStatusState();
}

class _RoomStatusState extends State<RoomStatus> {
  String _selectedStatus = 'Room Status';

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
                  value: 'Room Status',
                  child: Text('Room Status'),
                ),
                const PopupMenuItem<String>(
                  value: 'Dirty',
                  child: Text('Dirty'),
                ),
                const PopupMenuItem<String>(
                  value: 'Cleaning',
                  child: Text('Cleaning'),
                ),
                const PopupMenuItem<String>(
                  value: 'Cleaned',
                  child: Text('Cleaned'),
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
