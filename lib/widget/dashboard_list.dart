import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/widget/table_list_check_in.dart';

class DashboardList extends StatefulWidget {
  const DashboardList({super.key});

  @override
  State<DashboardList> createState() => _DashboardListState();
}

class _DashboardListState extends State<DashboardList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 300,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: TableListCheckIn(),
          )
        ],
      ),
    );
  }
}
