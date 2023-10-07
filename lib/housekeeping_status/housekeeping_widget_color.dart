import 'package:flutter/material.dart';

class HouseKeepingColorWidget extends StatelessWidget {
  final Icon icon;
  final String title;
  final int value;
  final Color backgroundColor;
  final Color iconbackground;

  const HouseKeepingColorWidget({
    Key? key,
    required this.icon,
    required this.value,
    required this.title,
    required this.backgroundColor,
    required this.iconbackground,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double iconSize = MediaQuery.of(context).size.width > 600 ? 40 : 32;
    double containerWidth = MediaQuery.of(context).size.width > 600 ? 250 : 200;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: containerWidth,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Row(
            children: [
              Container(
                height: iconSize,
                width: iconSize,
                decoration: BoxDecoration(
                  color: iconbackground,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: icon,
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      title,
                      style: TextStyle(
                          fontSize:
                              MediaQuery.of(context).size.width > 600 ? 18 : 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Text(
                    value.toString(),
                    style: TextStyle(
                        fontSize:
                            MediaQuery.of(context).size.width > 600 ? 24 : 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
