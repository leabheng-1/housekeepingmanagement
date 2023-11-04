import 'package:flutter/material.dart';

class TitleBar extends StatelessWidget {
  final String title;
  final VoidCallback? onClose;

  TitleBar({required this.title, this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          InkWell(
            onTap: onClose ?? () {
              Navigator.of(context).pop();
            },
            child: Container(
              width: 40,
              height: 40,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
