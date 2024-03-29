import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/system_widget/system_color.dart';

Widget buildLabelAndContent(
    String label, List<Widget> content, VoidCallback action , {bool isBtn = false ,  double maxWidthtitle = 200.0} ) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    ...content,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      Positioned(
        top: -20,
        left: 20,
        child: ConstrainedBox(
          constraints:  BoxConstraints(
            maxWidth: maxWidthtitle,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: ColorController.activeColor,
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
            child: Text(
              label,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
      ),
      if (isBtn) Positioned(
        top: 10,
        right: 10,
        child: Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            color: ColorController.barColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child:  IconButton(
            onPressed: action,
            icon: const Icon(Icons.edit),
            color: Colors.blue,
            iconSize: 16,
          ),
        ),
      )
    ],
  );
}
