import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class CustomDialog {
  static void showCheckInDialog(BuildContext context, Map<String, dynamic> booking, Function onCheck , VoidCallback fetchData , String urlcheck,String title,String dp) {
    AwesomeDialog(
      width: 650,
      context: context,
      keyboardAware: true,
      dismissOnBackKeyPress: false,
      dialogType: DialogType.warning,
      animType: AnimType.bottomSlide,
      btnCancelText: "NO",
      btnOkText: "YES",
      title: title,
      // padding: const EdgeInsets.all(5.0),
      desc: dp,
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        print('this it booking ${ booking['booking_id']}');
        onCheck(context, booking['booking_id'], urlcheck, fetchData, false  );
      },
    ).show();
  }
  static void dialogError(BuildContext context,String title,String dp) {
     AwesomeDialog(
      width: 650,
      context: context,
      keyboardAware: true,
      dismissOnBackKeyPress: false,
      dialogType: DialogType.warning,
      animType: AnimType.bottomSlide,
      btnCancelText: "NO",
      btnOkText: "YES",
      title: title,
      // padding: const EdgeInsets.all(5.0),
      desc: dp,
      btnCancelOnPress: () {},
      btnOkOnPress: () {
       
      },
    ).show();
  }
}

                               