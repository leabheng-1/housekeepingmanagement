import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:housekeepingmanagement/system_widget/btn.dart';
import 'package:housekeepingmanagement/system_widget/system_color.dart';
import 'package:housekeepingmanagement/system_widget/system_icon.dart';
import 'package:housekeepingmanagement/widget/checkinandcheckout.dart';

class moreoptionbtnaction extends StatefulWidget {
   int bookingId;
  // Constructor that takes a key and a String
   moreoptionbtnaction(this.bookingId);

  @override
  State<moreoptionbtnaction> createState() => _moreoptionbtnactionState();
}

// ignore: camel_case_types
class _moreoptionbtnactionState extends State<moreoptionbtnaction> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
     
        customButton: 
GestureDetector(
 
  child: Container(
    decoration: BoxDecoration(
      color: ColorController.moreOptionColor,
      borderRadius: BorderRadius.circular(8.0),
    ),
    padding: const EdgeInsets.only(left: 5, top: 5, bottom: 5, right: 10),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: ColorController.bgIconColorop,
          ),
          child: Icon(
            iconController.settiongIcon,
            size: 16,
            color: Colors.white, // Icon color
          ),
        ),
        const SizedBox(width: 8.0),
        Text(
          "More Option",
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          ),
        ),
      ],
    ),
  ),
),
        
        //  const BtnAction(
        //   icon: iconController.settiongIcon,
        //   textColor: Colors.white,
        //   color: ColorController.moreOptionColor,
        //   label: "More Option",
        //   background: ColorController.bgIconColorop,
        // ),
        items: [
          ...MenuItems.firstItems.map(
            (item) => DropdownMenuItem<MenuItem>(
              value: item,
              child: MenuItems.buildItem(item),
            ),
          )
        ],
        onChanged: (value) {
  MenuItems.onChanged(context, value! as MenuItem, widget.bookingId);
},
        dropdownStyleData: DropdownStyleData(
          width: 200,
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: ColorController.moreOptionColor,
          ),
          offset: const Offset(0, 8),
        ),
        menuItemStyleData: MenuItemStyleData(
          customHeights: [
            ...List<double>.filled(MenuItems.firstItems.length, 48),
          ],
          padding: const EdgeInsets.only(left: 16, right: 16),
        ),
      ),
    );
  }
}

class MenuItem {
  const MenuItem({
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData icon;
}

abstract class MenuItems {
  static const List<MenuItem> firstItems = [NoShow, Cancel, UndoCheckIn,UndoCheckOut];

  static const NoShow = MenuItem(text: 'No Show', icon: iconController.noshow);
  static const Cancel = MenuItem(text: 'Cancel', icon: iconController.CancelIcon);
  static const UndoCheckIn = MenuItem(text: 'Undo Check In', icon: iconController.checkInIcon);
  static const UndoCheckOut = MenuItem(text: 'Undo Check Out', icon: iconController.checkOutIcon);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.white, size: 22),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            item.text,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
static void noac(){

}
  static void onChanged(BuildContext context, MenuItem item, int bookingId) {
    switch (item) {
      case MenuItems.NoShow:
      print(bookingId);
         AwesomeDialog(
          width: 650,
                      context: context,
                      keyboardAware: true,
                      dismissOnBackKeyPress: false,
                      dialogType: DialogType.warning,
                      animType: AnimType.bottomSlide,
                      btnCancelText: "NO",
                      btnOkText: "YES",
                      title: 'DO YOU WANT TO NO SHOW THIS BOOKING',
                      // padding: const EdgeInsets.all(5.0),
                      desc:
                          'This Booking Will Remove From Room Table',
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {   
                             onCheck(context, bookingId,'no_show',noac,true);
                      },
                    ).show();
        break;
      case MenuItems.UndoCheckIn:
       AwesomeDialog(
          width: 650,
                      context: context,
                      keyboardAware: true,
                      dismissOnBackKeyPress: false,
                      dialogType: DialogType.warning,
                      animType: AnimType.bottomSlide,
                      btnCancelText: "NO",
                      btnOkText: "YES",
                      title: 'DO YOU WANT TO Undo Check In THIS BOOKING',
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {   
                             onCheck(context, bookingId,'undocheckin',noac,true);
                      },
                    ).show();
        //Do something
        break;
       case MenuItems.UndoCheckOut:
        AwesomeDialog(
          width: 650,
                      context: context,
                      keyboardAware: true,
                      dismissOnBackKeyPress: false,
                      dialogType: DialogType.warning,
                      animType: AnimType.bottomSlide,
                      btnCancelText: "NO",
                      btnOkText: "YES",
                      title: 'DO YOU WANT TO Undo Check Out THIS BOOKING',
                      // padding: const EdgeInsets.all(5.0),
                      desc:
                          'This Booking Will BACK IN HOUSE',
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {   
                           onCheck(context, bookingId,'undocheckout',noac,true);
                      },
                    ).show();
       
        //Do something
        break;  
      case MenuItems.Cancel:
       AwesomeDialog(
          width: 650,
                      context: context,
                      keyboardAware: true,
                      dismissOnBackKeyPress: false,
                      dialogType: DialogType.warning,
                      animType: AnimType.bottomSlide,
                      btnCancelText: "NO",
                      btnOkText: "YES",
                      title: 'DO YOU WANT TO CANCEL THIS BOOKING',
                      // padding: const EdgeInsets.all(5.0),
                      desc:
                          'This Booking Will Remove From Room Table',
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {   
                              onCheck(context, bookingId,'cancel',noac,true);
                      },
                    ).show();
    
        //Do something
        break;
    }
  }
}
