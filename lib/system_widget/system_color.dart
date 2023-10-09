import 'package:flutter/material.dart';

class ColorController {
  static const Color primaryColor = Colors.blue;
  static const Color secondaryColor = Colors.green;
  static const Color textColor = Colors.black;
  static const Color backgroundColor = Colors.white;
  static const Color blockColor = Color(0xFFFC0D08);
  static const Color cleaningColor = Color(0xFFffe327);
  static const Color cleanColor = Color(0xFF1caa26);
  static const Color dirtyColor = Color(0xFF564f21);
  static const Color checkInColor = Color(0xFF7575FF);
  static const Color checkOutColor = Color(0xFFE67475);
  static const Color arrivalsColor = Color(0xFF317EE6);
  static const Color departuresColor = Color(0xFFB9B9B9);
  static const Color availableColor = Color(0xFF317EE6);
  static const Color inHouseColor = Color(0xFF7AD3FF);
  static const Color allRoomsColor = Color(0xFF7575FF);
  static const Color unPaid = Color(0xFFF77777);
  static const Color deposit = Color(0xFFB7B7B7);
  static const Color paid = Color(0xFF5D978E);
  static const Color inhouse = Color(0xFF7FCEFB);
  static const Color clean = Color(0xFF18A52B);
  static const Color cleaning = Color(0xFFfee948);
  static const Color dirty = Color(0xFF4E4A15);
  static const Color cancel = Color(0xFFDE52CF);
  static const Color noshow = Color(0xFF757172);
  static const Color othercolor = Color(0xFFA5C2D4);
  static const Color totalroom = Color(0xFF4562F4);
  static const Color colorbackground = Color(0xFFFFFFFF);
  static const Color occupiedcolor = Color(0xFF7370ED);
  static const Color bottonbackcolor = Color(0xFFFFFFFF);
  static const Color iconbackgroundcolor = Color(0xFFE0E4FF);

 static const Color btnBookingColor = Color(0xFF8585FF);
  static const Color barColor = Color(0xFFA5C2D5);
  static const Color boxBooingColor = Color(0xFFE7E8FF);
  static const Color activeColor = Color(0xFF5AAAFF);

  
  


   static Color getHKColor(String hkState) {
    switch (hkState.toLowerCase()) {
      case "cleaning":
        return cleaningColor;
      case "clean":
        return cleanColor;
      case "dirty":
        return dirtyColor;
      default:
        return Colors.black;
    }
  }
 static bookingStatus(String? bookingStatus) {
    switch (bookingStatus?.toLowerCase()) {
      case "in-house":
        return checkInColor;
      case "cancel":
        return checkOutColor;
      case "void":
        return blockColor;
      case "no-show":
        return allRoomsColor;     
      case "block":
        return blockColor;
      case "booking":
        return allRoomsColor;       
      default:
        return allRoomsColor; // Default color if the state is not recognized
    }
}

}
