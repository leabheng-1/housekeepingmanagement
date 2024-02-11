import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/dialog/barDialog.dart';
import 'package:housekeepingmanagement/dialog/bookingdetail.dart';
import 'package:housekeepingmanagement/dialog/bookingdialog.dart';
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



class editGuestDialog_guest_inhouse {
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
  editGuestDialog_guest_inhouse(this.context ,this.reloadDataCallback);
   void showCreateeditGuestDialog_guest_inhouse(Map<String, dynamic> booking) {
   
    int? bookingId = booking['booking_id'] as int?;
int? id = booking['id'] as int?;
int? guestId = booking['guest_id'] as int?;
String? roomType = booking['roomtype'] as String?;
roomIdController.text = booking['room_id'].toString();
int? paymentId = booking['payment_id'] as int?;
String? bookingStatus = booking['booking_status'] as String?;
String? paymentStatus = booking['payment_status'] as String?;
String? cancelDate = booking['cancel_date'] as String?;
String? arrivalDate = booking['arrival_date'] as String?;
String? departureDate = booking['departure_date'] as String?;
String? checkinDate = booking['checkin_date'] as String?;
String? checkoutDate = booking['checkout_date'] as String?;
int? adults = booking['adults'] as int?;
int? child = booking['child'] as int?;
String? createdBy = booking['created_by'] as String?;
String? note = booking['note'] as String?;
String? createdAt = booking['created_at'] as String?;
String? updatedAt = booking['updated_at'] as String?;
String? roomNumber = booking['room_number'].toString() as String?;
String? roomStatus = booking['room_status'] as String?;
String? roomtype = booking['roomtype'] as String?;
int? floor = booking['floor'] as int?;
String? roomRate = booking['booking_room_rate'].toString() ?? booking['room_rate'].toString() as String?;

String? housekeeper = booking['housekeeper'] as String?;
String? airMethod = booking['booking_air_method'] as String?;
double? payment = booking['payment'] as double?;
String? extraCharge = booking['extra_charge'].toString();
double? charges = booking['charges'] as double?;
String? balance = booking['balance'].toString();
String? itemExtraCharge = booking['item_extra_charge'] as String?;
String? name = booking['name'] as String?;
String? gender = booking['gender'] as String?;
String? phoneNumber = booking['phone_number'].toString();
String? email = booking['email'] as String?;
String? country = booking['country'] as String?;
String? dob = booking['dob'] as String?;
String? passportNumber = booking['passport_number'] as String?;
String? cardId = booking['card_id'] as String?;
String? otherInformation = booking['other_information'] as String?;
int? isDelete = booking['is_delete'] as int?;
String? housekeepingStatus = booking['housekeeping_status'] as String?;

String? date = booking['date'] as String?;
 bookingIdController.text = bookingId?.toString() ?? '';
  checkInController.text = checkinDate ?? DateTime.now().toString();
  DateTime tomorrow = DateTime.now().add(Duration(days: 1));
    checkOutController.text = checkoutDate ?? tomorrow.toString();
DateTime checkInDate = DateTime.parse(checkInController.text);
DateTime checkOutDate = DateTime.parse(checkOutController.text);

int differenceInDays = checkOutDate.difference(checkInDate).inDays;
nightController.text = differenceInDays.toString() ?? '1';
roomTypeController.text =  roomType ?? 'No set';
BookingAirMethodController.text =  airMethod ?? 'No set';
roomNumberController.text = roomNumber.toString() ?? '';
roomRateController.text =  roomRate.toString() ?? '\$10';
String dpRoomRate  = roomRate.toString() ?? '\$0' ;
extraChargeController.text = extraCharge.toString() ?? '\$0';
totalPaymentController.text = payment?.toString() ?? '\$0';
int nightCal = int.parse(nightController.text) ;
double roomRateCal = double.parse(roomRateController.text.replaceAll('\$', ''));
double result = nightCal * roomRateCal;

totalChargeController.text = charges?.toString() ?? '\$' +  result.toString();
totalBalanceController.text = balance ??  '\$0';

guestNameController.text = name ?? '';
genderController.text = gender ?? 'No set';
dobController.text = dob ?? '';
countryController.text = country ?? '';
adultController.text = adults?.toString() ?? '';
childController.text = child?.toString() ?? '';
phoneController.text = phoneNumber ?? '';
cardIdController.text = cardId ?? '';
emailController.text = email ?? '';
guestNoteController.text = note ?? '';
bookingNoteController.text = note ?? '';

 bool isInputRoomRate = true;
  bool isChecked = false;
     double totalCharge = double.parse(totalChargeController.text.replaceAll('\$', '')) ?? 0;
      double totalBalance = double.parse(totalBalanceController.text.replaceAll('\$', '')) ?? 0;
        double extraCharge_val = double.parse(extraChargeController.text.replaceAll('\$', '')) ?? 0; 
  // double roomRateCal = double.parse(roomRateController.text);
   void updateFields(int nights) {
  
    roomRateCal = double.parse(roomRateController.text.replaceAll('\$', ''));
    totalCharge = (nights * roomRateCal ) + (double.parse(extraChargeController.text.replaceAll('\$', '')) ?? 0) ;
    totalBalance = totalCharge - ( (double.parse(totalPaymentController.text.replaceAll('\$', '')) ?? 0 ) + (double.parse(extraChargeController.text.replaceAll('\$', '')) ?? 0) );
    totalChargeController.text = '\$' + totalCharge.toString();
    totalBalanceController.text = '\$' + totalBalance.toString();
    PaymentStatusChecker paymentStatusCheck = PaymentStatusChecker(totalCharge, totalBalance);
  paymentStatus = paymentStatusCheck.checkPaymentStatus();
  } 
  List<dynamic> roomData = [];
  List<String> roomNumbers = roomData.map((room) => room["room_number"] as String).toList();
  showDialog(

    
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        
        title: TitleBar(title: 'Update Guest'),
        content:   Container(
  margin: EdgeInsets.only(top: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 20), // Add spacing between columns
             Expanded(
                child:buildLabelAndContent('Guest Information', 
                   [
                    Row(
      children: [
           
                    CustomTextField(
                      controller: guestNameController,
                      labelText: 'Guest Name',
                      width: 265,
                      
                    ), SizedBox(width: 20), CustomDropdownButton(
                      labelText: 'Gender',
            width: 265,
            items: ['No set', 'Male', 'Female'],
            selectedValue:genderController.text ,
            hintText: 'Room Status',
            onChanged: (value) {
                genderController.text = value!;

            },
          )
          
      ]),
          Row(
      children: [
        
                    DatePickerTextField(
                    checkcurrnetdate: DateTime(2000),
                      controller: dobController,
                      labelText: 'DOB',
                      width: 265,
                      
                       onDateSelectedDate: (selectedDate) {
              // Handle the selected date here
              print('Selected Date: $selectedDate');
            },
                    ),
                      SizedBox(width: 20), 
                   selectCountry_dropdown(
          width: 270,
          labelText: 'Country',
            selectedValue:countryController.text ,
            hintText: 'Room Status',
            onChanged: (value) {
                countryController.text = value!;
                print(countryController.text);

            },
      ),
      ]),

         Row(
      children: [ 
        
                    CustomTextField(
                      controller: adultController,
                      labelText: 'Adult',
                      width: 265,
                      isNumeric:true, 
                    ),
                      SizedBox(width: 20), 
                    CustomTextField(
                      controller: childController,
                      labelText: 'Child',
                      width: 265,
                       isNumeric:true,
                    )
      ]),
          Row(
      children: [
                    CustomTextField(
                       isNumeric:true,
                      controller: phoneController,
                      labelText: 'Phone Number',
                      width: 265,
                    ),
                      SizedBox(width: 20),
                        CustomTextField(
                      controller: cardIdController,
                      labelText: 'Card ID',
                      width: 265,
                    ) 
                    
      ]),
      Row(
        children: [
          CustomTextField(
                      controller: addressController,
                      labelText: 'Address',
                      width: 550,
                    )
        ],
      ),
          Row(
      children: [
                   
                    CustomTextField(
                      
                      controller: emailController,
                      labelText: 'Email',
                      width: 550,
                    )]),  SizedBox(width: 20), 
                    CustomTextField(
                      controller: guestNoteController,
                      labelText: 'Guest Noted',
                      height:200,
                      width:550,
                    ),
                  ]
                  ,() {
               
            }
                ),
              ),
                ],
          ),
        ),
        actions: [
        Padding(
  padding: EdgeInsets.only(left:16,right:16,bottom:16,top: 0), // Adjust the padding as needed
  child:
          Row(  
            mainAxisAlignment: MainAxisAlignment.end,
children: [
           BtnAction(
   background: Color.fromARGB(52, 0, 0, 0),
  icon: iconController.closeIcon,
  textColor: Colors.white,
  color: Colors.red,
  label: "Cancel",
  action: () {
      print(roomRateController.text);
      print(totalBalanceController.text);
      print(totalChargeController.text);
       print(extraChargeController.text);
           print(roomIdController.text);
       Navigator.of(context).pop();
  },
),
SizedBox(width:20,),
 BtnAction(
    background: Color.fromARGB(52, 0, 0, 0),
  icon: iconController.saveIcon,
  textColor: Colors.white,
  color: Colors.blue,
  label: "Update",
  action: () {
       final guestName = guestNameController.text;
    final gender = genderController.text ;
    final dob = dobController.text;
    final country = countryController.text;
    final adult = adultController.text;
    final child = childController.text;
    final phone = phoneController.text;
    final address = addressController.text;
    final cardId = cardIdController.text;
    final email = emailController.text;
    final guestNote = guestNoteController.text;
    final bookingNote = bookingNoteController.text;

    final bookingId = bookingIdController.text;
    final checkIn = checkInController.text;
    final checkOut = checkOutController.text;
    final night = nightController.text;
    final roomType = roomTypeController.text;
    final bookingAirMethod = BookingAirMethodController.text;
    final roomNumber = roomNumberController.text;
    final roomRate = roomRateController.text.replaceAll('\$', '');
    final extraCharge = extraChargeController.text.replaceAll('\$', '');
    final totalPayment = totalPaymentController.text.replaceAll('\$', '');
    final totalCharge = totalChargeController.text.replaceAll('\$', '');
    final totalBalance = totalBalanceController.text.replaceAll('\$', '');
    // Create a map containing the booking data
     submitUpdatedData(
      booking,
      booking['booking_id'].toString(),
      bookingNote,
      bookingAirMethod,
      paymentStatus ?? 'Unpaid',
  guestName,
  gender,
  dob,
  country,
  adult.toString(),
  child.toString(),
  phone.toString(),
  address,
  cardId,
  email,
  guestNote,
  checkOut,  // Use checkOut directly
  roomType,  // Use roomType directly
  roomNumber.toString(),
  roomRate.replaceAll('\$', ''),
  extraCharge.replaceAll('\$', ''),
  totalPayment.replaceAll('\$', ''),
  totalCharge.replaceAll('\$', ''),
  totalBalance.replaceAll('\$', ''),
  checkIn,   // Use checkIn directly
  roomType,
  roomIdController.text,
  booking['payment_type'] ?? 'Not set',
  booking['booking_status'] ?? 'booking'
   ); },
)
]
          )
        )
        ],
      );
    },
  );
}
Future<void> submitUpdatedData(
   Map<String, dynamic> booking, 
  String booking_id,
  String bookingNote,
  String bookingAirMethod, 
  String paymentStatus,
   String name,
    String gender ,
    String dob,
    String country,
    String adult,
    String child,
    String phone_number,
    String address,
    String cardId,
    String email,
    String guestNote,
    String checkout_date,
    String room_type,
    String roomNumber,
    String roomRate,
    String extraCharge,
    String totalPayment,
    String totalCharge,
    String totalBalance,
    String checkin_date,
    String roomType,
        String room_id,
        String paymentType,
        String bookingStatus
    ) async {

  final String baseUrl1 = 'http://localhost:8000/api/booking/update/$booking_id';
   final url = Uri.parse('$baseUrl1?booking_note=$bookingNote&payment_type=$paymentType&booking_air_method=$bookingAirMethod&room_rate=$roomRate&booking_status=$bookingStatus&name=$name&gender=$gender&dob=$dob&country=$country&adult=$adult&child=$child&phone_number=$phone_number&address=$address&cardId=$cardId&email=$email&checkout_date=$checkout_date&room_type=$room_type&roomNumber=$roomNumber&extra_charge=$extraCharge&payment=$totalPayment&charges=$totalCharge&balance=$totalBalance&checkin_date=$checkin_date&arrival_date=$checkin_date&departure_date=$checkout_date&payment_status=$paymentStatus');
    final response = await http.put(url);      
    print(url);
    List<dynamic> bookingData = await ApiFunctionsBookingbyid.fetchBookingData(booking['booking_id']);
     AwesomeDialog(
         width: 500,  
        context: context,
        dialogType: DialogType.success,
        title: 'Update Guest Success',
        btnOkOnPress: () {  
          reloadDataCallback();
           Navigator.of(context).pop();
     
        BookingDialog(context, reloadDataCallback!).showBookingDetailsDialog(bookingData[0]);
         
        },
        
      ).show();
    if (response.statusCode == 200) {
         
    
      print(bookingData[0]);
     
      print('Booking created successfully.');
     
    } else {
      print('Response body: ${response.body}');
        // ignore: use_build_context_synchronously
        AwesomeDialog(
         width: 500,  
        context: context,
        dialogType: DialogType.error,
        title: 'Update Guest Failed',
        desc: response.toString(),
        btnOkOnPress: () {

        },
      ).show();
    }
}

//   // Define the Booking Details Dialog


}
