import 'package:flutter/material.dart';

// ignore: camel_case_types
class iconController {
  static const IconData checkInIcon = Icons.login_sharp;
  static const IconData checkOutIcon = Icons.logout_sharp;
  static const IconData arrivalsIcon = Icons.flight_land;
  static const IconData departuresIcon = Icons.airplay_rounded;
  static const IconData availableIcon = Icons.room_service;
  static const IconData inHouseIcon = Icons.camera_outdoor;
  static const IconData allRoomsIcon = Icons.bed_sharp;
  static const IconData khIcon = Icons.cleaning_services;
  static const IconData occupiedIcon = Icons.sensor_occupied;
  static const IconData blockIcon = Icons.block;
  static const IconData dollar = Icons.attach_money;
  static const IconData noshow = Icons.person_remove;
  static const IconData cancel = Icons.block;
  static const IconData blocked = Icons.block;
  static const IconData inhouse = Icons.block;
  static const IconData dirty = Icons.dry_cleaning;
  static const IconData clean = Icons.cleaning_services_outlined;
  static const IconData heatIcon = Icons.heat_pump;
  static const IconData fanIcon = Icons.wind_power;
  static IconData saveIcon = Icons.edit_calendar_outlined;
  static IconData closeIcon = Icons.close;
  static const IconData settiongIcon = Icons.settings;

  static airMethod(String? airMethod) {
    switch (airMethod?.toLowerCase()) {
      case "conditioner":
        return heatIcon;
      case "fan":
        return fanIcon;
      default:
        return fanIcon;
    }
  }

  static const IconData CancelIcon = Icons.do_not_disturb_on;
  static const IconData noshowIcon = Icons.usb_rounded;
  static bookingStatus(String? bookingStatus) {
    switch (bookingStatus?.toLowerCase()) {
      case "in house":
        return inHouseIcon;
      case "cancel":
        return CancelIcon;
      case "void":
        return fanIcon;
      case "no show":
        return noshow;
      case "block":
        return blockIcon;
      case "booking":
        return arrivalsIcon;
      default:
        return Icons.check; // Default color if the state is not recognized
    }
  }
  
}
