import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:housekeepingmanagement/dialog/barDialog.dart';
import 'package:housekeepingmanagement/dialog/editBooking.dart';
import 'package:housekeepingmanagement/dialog/editGuest.dart';
import 'package:housekeepingmanagement/dialog/selectRoom.dart';
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


import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final GlobalKey<RefreshableDialogState> dialogKey = GlobalKey();

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return RefreshableDialog(
          key: dialogKey,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dialog Refresh Example"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _showDialog(context);
          },
          child: Text("Show Dialog"),
        ),
      ),
    );
  }
}

class RefreshableDialog extends StatefulWidget {
  RefreshableDialog({Key? key}) : super(key: key);

  @override
  RefreshableDialogState createState() => RefreshableDialogState();
}

class RefreshableDialogState extends State<RefreshableDialog> {
  // You can add data or state that you want to refresh in the dialog here

  void refreshDialog() {
    // Call this method to refresh the dialog content
    setState(() {
      // Update your dialog content or data here
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Refreshable Dialog"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Your dialog content goes here
          // You can display dynamic data or widgets that need to be refreshed
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Close"),
        ),
      ],
    );
  }
}



class viewGuestDetail {
  // final VoidCallback reloadDataCallback;
  final BuildContext context;
    final VoidCallback reloadDataCallback;
 

TextEditingController guestNameController = TextEditingController();
TextEditingController genderController = TextEditingController();
TextEditingController dobController = TextEditingController();
TextEditingController countryController = TextEditingController();
TextEditingController adultController = TextEditingController();
TextEditingController childController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController addressController = TextEditingController();
TextEditingController cardIdController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController guestNoteController = TextEditingController();
TextEditingController bookingNoteController = TextEditingController();
TextEditingController bookingIdController = TextEditingController();
TextEditingController checkInController = TextEditingController();
TextEditingController checkOutController = TextEditingController();
TextEditingController nightController = TextEditingController();
TextEditingController roomTypeController = TextEditingController();
TextEditingController BookingAirMethodController = TextEditingController();
TextEditingController roomNumberController = TextEditingController();
TextEditingController roomRateController = TextEditingController();
TextEditingController extraChargeController = TextEditingController();
TextEditingController totalPaymentController = TextEditingController();
TextEditingController totalChargeController = TextEditingController();
TextEditingController totalBalanceController = TextEditingController();
TextEditingController roomIdController= TextEditingController();
TextEditingController getroomrateController= TextEditingController();
// Check if the values are not null before assigning them to the controllers



String? minSelectDate;
String? selectCountry ;
  viewGuestDetail(this.context ,this.reloadDataCallback);
  
  void showBookingDetailsDialog(Map<String, dynamic> booking) {
    DateTime today = DateTime.now();
DateTime todaycorrent = DateTime(today.year, today.month, today.day );
DateTime todaycorrentCheckout = DateTime(today.year, today.month, today.day + 1 );
String checkInDateString = booking['checkin_date'];
String checkOutDateString = booking['checkout_date'];

DateTime checkInDate = DateTime.parse(checkInDateString);
DateTime checkOutDate = DateTime.parse(checkOutDateString);

Duration difference = checkOutDate.difference(checkInDate);
int numberOfNights = difference.inDays;

print('Number of nights: $numberOfNights');

      showDialog(
    context: context,
    builder: (BuildContext context) {
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
  value: booking['guest_id'].toString(),
),      
SizedBox(width: 20),
Boxdetail(
  title: "Guest Name",
  value:  booking['name'] ?? '',
  
),
 ]
        ),
        Row(
        children: [           
Boxdetail(
  title: "Gender",
  value: booking['gender'] ?? '',
),      
SizedBox(width: 20),
Boxdetail(
  title: "Date Of Birth",
  value:  booking['dob'] ?? '' ,
),
 ]
        ),
 Row(
        children: [           
Boxdetail(
  title: "Adults",
  value: booking['adults'].toString() ,
),      
SizedBox(width: 20),
Boxdetail(
  title: "Child",
  value:  booking['child'].toString() ,
),
 ]
        ),
 Row(
        children: [           
Boxdetail(
  title: "Country",
  value: booking['country'] ?? '',
),      
SizedBox(width: 20),
Boxdetail(
  title: "Address",
  value:  booking['address'] ?? '' ,
),
 ]
        ),
 Row(
        children: [           
Boxdetail(
  title: "Phone Number",
  value: booking['phone_number'].toString() ?? '',
),      
SizedBox(width: 20),
Boxdetail(
  title: "Email",
  value:  booking['email'] ?? '' ,
),
 ]
        ), 
  Row(
        children: [           
Boxdetail(
   width:900,
  title: "passport_number",
  value: booking['Passport Number'].toString(),
), 

 ]
        ),
Row(
          children: [
            Boxdetail(title: "Note", value: booking['note'] , height: 200, width:900)
          ],
        )                        

      ],() {
          editGuestDialog(
                                                            context, reloadDataCallback)
                                                        .showCreateeditGuestDialog(
                                                            booking);
            },isBtn:true),
      ),
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
              moreoptionbtnaction(booking['booking_id'])
            ],) 
            ) ,
            Expanded(
              child:Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [  
                 Visibility(
  visible:
   (DateTime.parse(booking['checkin_date']).isBefore(todaycorrent) || DateTime.parse(booking['checkin_date']).isAtSameMomentAs(todaycorrent) ) && booking['booking_status'] != 'In House', // Show "Check In" button if checkInDate is in the future
  child: BtnAction(
    background: Color.fromARGB(52, 0, 0, 0),
    icon: iconController.checkOutIcon,
    textColor: Colors.white,
    color: ColorController.checkInColor,
    label: "Check In",
    action: () {
      
      onCheck(context, booking['booking_id'],'checkin',reloadDataCallback);
      

      
    },
  ),
),
Visibility(
  visible:( DateTime.parse(booking['checkout_date']).isBefore(todaycorrentCheckout) || DateTime.parse(booking['checkout_date']).isAtSameMomentAs(todaycorrentCheckout)) && booking['booking_status'] == 'In House' ,  // Show "Check Out" button if checkOutDate is in the past
  child: BtnAction(
    background: Color.fromARGB(52, 0, 0, 0),
    icon: iconController.checkOutIcon,
    textColor: Colors.white,
    color:ColorController.checkOutColor,
    label: "Check Out",
    action: () {
      onCheck(context, booking['booking_id'],'checkout',reloadDataCallback);
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
    },
  );
}
}
