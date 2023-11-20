import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:housekeepingmanagement/dashboard/frontdesk.dart';
import 'package:housekeepingmanagement/dialog/barDialog.dart';
import 'package:housekeepingmanagement/dialog/editBooking.dart';
import 'package:housekeepingmanagement/dialog/editGuest.dart';
import 'package:housekeepingmanagement/frontdesk/widget/Morebtnaction.dart';
import 'package:housekeepingmanagement/system_widget/box_detail.dart';
import 'package:housekeepingmanagement/system_widget/btn.dart';
import 'package:housekeepingmanagement/system_widget/CheckBoxCustomRoomRate.dart';
import 'package:housekeepingmanagement/system_widget/system_color.dart';
import 'package:housekeepingmanagement/system_widget/system_icon.dart';
import 'package:housekeepingmanagement/widget/Datebooking.dart';
import 'package:housekeepingmanagement/widget/checkinandcheckout.dart';
import 'package:housekeepingmanagement/widget/country.dart';
import 'package:housekeepingmanagement/widget/inputbox.dart';
import 'package:housekeepingmanagement/widget/legend.dart';
import 'package:housekeepingmanagement/widget/paymentcheck.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

class BookingDetailsDialog extends StatefulWidget {
  final Map<String, dynamic> booking;
  final Function onRefresh; // Callback to trigger a refresh

  BookingDetailsDialog({required this.booking, required this.onRefresh});

  @override
  _BookingDetailsDialogState createState() => _BookingDetailsDialogState();
}
  DateTime today = DateTime.now();
DateTime todaycorrent = DateTime(today.year, today.month, today.day );
DateTime todaycorrentCheckout = DateTime(today.year, today.month, today.day + 1 );
class _BookingDetailsDialogState extends State<BookingDetailsDialog> {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
       title:TitleBar(title:'booking Detail'),
        content: 
        Container(
  margin: EdgeInsets.only(top: 20), // Set your desired top margin here
  child: Row(
    children: [   
      Expanded(
      flex: 4,
      child:  
      
      buildLabelAndContent('Guest Information', [
       
        Row(
        children: [           
Boxdetail(
  title: "Guest ID",
  value: widget.booking['guest_id'].toString(),
),      
SizedBox(width: 20),
Boxdetail(
  title: "Guest Name",
  value:  widget.booking['name'] ?? '',
  
),
 ]
        ),
        Row(
        children: [           
Boxdetail(
  title: "Gender",
  value: widget.booking['gender'] ?? '',
),      
SizedBox(width: 20),
Boxdetail(
  title: "Date Of Birth",
  value:  widget.booking['dob'] ?? '' ,
),
 ]
        ),
 Row(
        children: [           
Boxdetail(
  title: "Adults",
  value: widget.booking['adults'].toString() ?? '' ,
),      
SizedBox(width: 20),
Boxdetail(
  title: "Child",
  value:  widget.booking['child'].toString() ?? '' ,
),
 ]
        ),
 Row(
        children: [           
Boxdetail(
  title: "Country",
  value: widget.booking['country'] ?? '',
),      
SizedBox(width: 20),
Boxdetail(
  title: "Address",
  value:  widget.booking['address'] ?? '' ,
),
 ]
        ),
 Row(
        children: [           
Boxdetail(
  title: "Phone Number",
  value: widget.booking['phone_number'].toString() ?? '',
),      
SizedBox(width: 20),
Boxdetail(
  title: "Email",
  value:  widget.booking['email'] ?? '' ,
),
 ]
        ), 
  Row(
        children: [           
Boxdetail(
   width:900,
  title: "passport_number",
  value: widget.booking['Passport Number'].toString() ?? '',
), 

 ]
        ),
Row(
          children: [
            Boxdetail(title: "Note", value: widget.booking['note'] , height: 200, width:900)
          ],
        )                        

      ],() {
         
            },isBtn:true),
      ),
      SizedBox(width: 20),
      Expanded(
      flex: 6,
      child: 
      buildLabelAndContent('Booking Information ', [
        Row(
        children: [           
Boxdetail(
  title: "Booking ID",
  value: widget.booking['booking_id'].toString() ?? '',
),      
 ]
        ),
        Row(
        children: [           
Boxdetail(
  title: "Check In",
  value: widget.booking['checkin_date'] ?? '',
),
SizedBox(width: 20),
      Boxdetail(
  title: "Check Out",
  value:  widget.booking['checkout_date'] ?? '' ,
), 
SizedBox(width: 20),  Boxdetail(
  title: "Night",
  value:  widget.booking['dob'] ?? '' ,
),
 ]
        ),
 Row(
        children: [           
Boxdetail(
  title: "Room Tpye",
  value: widget.booking['roomtype'].toString() ?? '' ,
),      
SizedBox(width: 20),
Boxdetail(
  title: "Room Number",
  value:  widget.booking['room_number'].toString() ?? '' ,
),
 ]
        ),
 Row(
        children: [           
Boxdetail(
  title: "Room Rate",
  value: '\$' + ( widget.booking['booking_room_rate' ]  ?? widget.booking['room_rate'] as String?),
),      
SizedBox(width: 20),
Boxdetail(
  title: "Extra Charge",
  value: '\$' + widget.booking['extra_charge'].toString() ?? '' ,
),
 ]
        ),
 Row(
        children: [           
Boxdetail(
  title: "Payment",
  value: '\$' + widget.booking['payment'].toString() ?? '',
),      
SizedBox(width: 20),
Boxdetail(
  title: "Total charges",
  value: '\$' +  widget.booking['charges'].toString() ?? '' ,
),
SizedBox(width: 20),
Boxdetail(
  title: "Total Balance",
  value: '\$' +  widget.booking['balance'].toString() ?? '' ,
),
 ]
        ), 
     
Row(
          children: [
            Boxdetail(title: "Note", value: widget.booking['note'] , height: 200 , width:900,)
          ],
        )
      ],() {
              
            },isBtn: true),
      )
    ],
  
  ),
  
),
        actions: [
          Padding(
  padding: EdgeInsets.only(left:16,right:16,bottom:16,top: 0), // Adjust the padding as needed
  child:
          Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          
            children: [
            
            Expanded(child:Row(children: [
              moreoptionbtnaction(widget.booking['booking_id'])
            ],) 
            ) ,
            Expanded(
              child:Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [  
                 Visibility(
  visible:
   (DateTime.parse(widget.booking['checkin_date']).isBefore(todaycorrent) || DateTime.parse(widget.booking['checkin_date']).isAtSameMomentAs(todaycorrent) ) && widget.booking['booking_status'] != 'In House', // Show "Check In" button if checkInDate is in the future
  child: BtnAction(
    background: Color.fromARGB(52, 0, 0, 0),
    icon: iconController.checkOutIcon,
    textColor: Colors.white,
    color: ColorController.checkInColor,
    label: "Check In",
    action: () {
      // onCheck(context, widget.booking['booking_id'],'checkin',widget.onRefresh);
    },
  ),
),
Visibility(
  visible:( DateTime.parse(widget.booking['checkout_date']).isBefore(todaycorrentCheckout) || DateTime.parse(widget.booking['checkout_date']).isAtSameMomentAs(todaycorrentCheckout)) && widget.booking['booking_status'] == 'In House' ,  // Show "Check Out" button if checkOutDate is in the past
  child: BtnAction(
    background: Color.fromARGB(52, 0, 0, 0),
    icon: iconController.checkOutIcon,
    textColor: Colors.white,
    color:ColorController.checkOutColor,
    label: "Check Out",
    action: () {
      // onCheck(context, widget.booking['booking_id'],'checkout',w);
    },
  ),
)
],) 
            )
            ],
          )
)
        ],
      );
  }

  // Create a method to update the content of the dialog
  void refreshContent() {
    setState(() {
      // Update the content of the dialog based on new data
      // You can access the booking details using widget.booking
    });
  }
}

void showBookingDetailsDialog(BuildContext context, Map<String, dynamic> booking) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return BookingDetailsDialog(
        booking: booking,
        onRefresh: () {
          // Handle the refresh logic here, e.g., update the booking data
          // and then call refreshContent to update the dialog's content
        },
      );
    },
  );
}
