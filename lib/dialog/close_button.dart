import 'package:flutter/material.dart';

class CloseButtonDialog extends StatelessWidget {
  const CloseButtonDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: const Color(0xFFE03226),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Icon(
          Icons.close,
          size: 25,
          color: Colors.white,
        ),
      ),
    );
  }
}
