import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:housekeepingmanagement/widget/sub_button/sub_button_frontdesk.dart';
import 'package:intl/intl.dart';
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



class BookingDialog {
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
TextEditingController paymentTypeController= TextEditingController();
TextEditingController getroomrateController= TextEditingController();

// Check if the values are not null before assigning them to the controllers



String? minSelectDate;
String? selectCountry ;
  BookingDialog(this.context ,this.reloadDataCallback);
   void showCreateBookingDialog(Map<String, dynamic> booking,DateTime formattedDate) { 
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
String? roomNumber = booking['room_number'] as String?;
String? roomStatus = booking['room_status'] as String?;
String? roomtype = booking['roomtype'] as String?;
int? floor = booking['floor'] as int?;
String? roomRate = booking['booking_room_rate'] ?? booking['room_rate'] as String?;

String? housekeeper = booking['housekeeper'] as String?;
String? airMethod = booking['booking_air_method'] as String?;
int? payment = booking['payment'] as int?;
String? extraCharge = booking['extra_charge'] as String?;
int? charges = booking['charges'] as int?;
String? balance = booking['balance'] as String?;
String? itemExtraCharge = booking['item_extra_charge'] as String?;
String? name = booking['name'] as String?;
String? gender = booking['gender'] as String?;
String? phoneNumber = booking['phone_number'] as String?;
String? email = booking['email'] as String?;
String? country = booking['country'] as String?;
String? dob = booking['dob'] as String?;
String? passportNumber = booking['passport_number'] as String?;
String? cardId = booking['card_id'] as String?;
String? otherInformation = booking['other_information'] as String?;
int? isDelete = booking['is_delete'] as int?;
String? housekeepingStatus = booking['housekeeping_status'] as String?;
String newformattedDate = DateFormat('yyyy-MM-dd').format(formattedDate);
String? date = booking['date'] as String?;
 bookingIdController.text = bookingId?.toString() ?? '';
  checkInController.text = checkinDate ?? newformattedDate;
  DateTime tomorrow = formattedDate.add(Duration(days: 1));
    checkOutController.text = checkoutDate ?? tomorrow.toString();
DateTime checkInDate = DateTime.parse(checkInController.text);
DateTime checkOutDate = DateTime.parse(checkOutController.text);

int differenceInDays = checkOutDate.difference(checkInDate).inDays;
nightController.text = differenceInDays.toString() ?? '1';
roomTypeController.text =  roomType ?? 'No set';
BookingAirMethodController.text =  airMethod ?? 'No set';
roomNumberController.text = roomNumber ?? '';
roomRateController.text =  roomRate ?? '\$0';
String dpRoomRate  = roomRate ?? '\$0' ;
extraChargeController.text = extraCharge ?? '\$0';
totalPaymentController.text = payment?.toString() ?? '\$0';
int nightCal = int.parse(nightController.text) ;
double roomRateCal = double.parse(roomRateController.text.replaceAll('\$', ''));
double result = nightCal * roomRateCal;

totalChargeController.text = charges?.toString() ?? '\$' +  result.toString();
totalBalanceController.text = balance ?? dpRoomRate + '\$';

guestNameController.text = name ?? '';
genderController.text = gender ?? 'No set';
dobController.text = dob ?? '';
countryController.text = country ?? '';
adultController.text = adults?.toString() ?? '1';
childController.text = child?.toString() ?? '';
phoneController.text = phoneNumber ?? '';
cardIdController.text = cardId ?? '';
emailController.text = email ?? '';
guestNoteController.text = note ?? '';
bookingNoteController.text = note ?? '';
paymentTypeController.text = booking['payment_type'] ?? '';
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
String? validateName(String? value) {
  if (value == null || value.isEmpty) {
    print('object');
  }
  return null; // Return null if validation passes
}
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
        
        title: TitleBar(title: 'Create Booking'),
        
        content: 
        Form(
    key: _formKey,
    child:
          Container(
  margin: EdgeInsets.only(top: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child:buildLabelAndContent('Guest Information', 
                   [
                    Row(
      children: [
           
                    CustomTextField(
                      controller: guestNameController,
                                          validator: validateName,
                      labelText: 'Guest Name',
                      showAsterisk: true,
                      width: 265,
                      
                    ), SizedBox(width: 15), 
                    CustomDropdownButton(
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
                      labelText: 'Date of Birth',
                      width: 265,
                      
                       onDateSelectedDate: (selectedDate) {
              // Handle the selected date here
              print('Selected Date: $selectedDate');
            },
                    ),
                      SizedBox(width: 15), 
                   selectCountry_dropdown(
          width: 280,
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
                      showAsterisk: true,
                      labelText: 'Adult',
                      width: 265,
                      isNumeric:true, 
                    ),
                      SizedBox(width: 15), 
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
                                          validator: validateName,
                                          showAsterisk:true,
                      labelText: 'Phone Number',
                      width: 265,
                    ),
                      SizedBox(width: 15),
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
                    )]),  
                     Row(
      children: [ 
                    CustomTextField(
                      controller: guestNoteController,
                      labelText: 'Guest Noted',
                      height:200,
                      width:550,
                    ),
                 
      ]
                     ),
                     SizedBox(height: 20),]
                  ,() {
               
            }
            
                ),
                
              ),
              SizedBox(width: 15), // Add spacing between columns
              Expanded(
                child: buildLabelAndContent('Booking Information',[
                      SizedBox(width: 15), 
                 DateRangePickerWidget(
              labelText: 'Check-Out Date',
              checkin:checkInController,
              checkout:checkOutController,
              night:nightController,
              checkcurrentdate: checkOutDate,
              onDateSelectedDate: (selectedDate) {
            
              }
              , onChange: (DateTime checkin, DateTime checkout, int nights) {
                checkInController.text = checkin.toString();
                checkOutController.text = checkout.toString();
updateFields(nights);
nightCal = nights;
                },
            ),
        
           Row(
      children: [ 
CheckSelectRoomRate(
  roomTypeController: roomTypeController,
  roomNumberController: roomNumberController,
  roomIdController: roomIdController,
  getroomrateController:roomRateController,
  onTextChanged: (value) {
  isChecked = true;
  Timer(Duration(milliseconds: 500), () {
    updateFields(nightCal);
  });
},

  
  ),

          SizedBox(width: 15), 
          CustomDropdownButton(
            width: 150,
            labelText: 'Air Method',
            items: ['No set', 'Fan', 'Conditioner','All'],
            selectedValue:BookingAirMethodController.text ,
            hintText: 'Booking Air Method',
            onChanged: (value) {
                BookingAirMethodController.text = value!;
            },
          )
      ]),
       Row(
      children: [ 
                   CheckBoxCustomRoomRate(
          isChecked: isChecked,
          roomRateController:roomRateController,
          onChanged: (newValue) {
         
            isChecked = newValue ?? false;
            if(newValue == true){
              
            }else{
              roomRateController.text =  ( booking['room_rate'] ?? '\$0');
            }
            
   updateFields(nightCal);
          },
          onTextChanged:(value){
                 updateFields(nightCal);
          }
        ) ,SizedBox(width: 15),
           CustomDropdownButton(
                      labelText: 'Type',
            width: 155,
            items: ['Cash', 'Bank'],
            selectedValue:paymentTypeController.text ,
            hintText: 'Payment ',
            onChanged: (value) {
                paymentTypeController.text = value!;
                print(paymentTypeController.text);

            },
          ),SizedBox(width: 15),
                    CustomTextField(
                      width: 155,
                      isCurrency: true,
                      controller: extraChargeController,
                      labelText: 'Extra Charge',
                      onChanged:(value){
                 updateFields(nightCal);
          },
                    ),
      ]),
        Row(
      children: [ 
                    CustomTextField(
                      width: 510/3,
                      isCurrency: true,
                      controller: totalPaymentController,
                      labelText: 'Total Payment',
                      onChanged:(value){
                 updateFields(nightCal);
          },
                    ),SizedBox(width: 15),
                    CustomTextField(
                      width: 510/3,
                        isCurrency: true,
                        enabled: false,
                      controller: totalChargeController,
                      labelText: 'Total Charge',
                    ),SizedBox(width: 15),
                    CustomTextField(
                      width: 510/3,
                      enabled: false,
                        isCurrency: true,
                      controller: totalBalanceController,
                      labelText: 'Total Balance',
                    )
      ]),Row(
        children: [
           CustomTextField(
                      controller: bookingNoteController,
                      labelText: 'Booking Note',
                      isNote: true,
                      height:200,
                      width:550,
                    ),
                  
        ],
        
      ),
        SizedBox(height:20,)
                  ],() {
              // This is the action that will be executed when the button is pressed
              print('Button Pressed!');
            }
                ),
              ),
            ],
          ),
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
   
       Navigator.of(context).pop();
  },
),
SizedBox(width:20,),
 BtnAction(
    background: Color.fromARGB(52, 0, 0, 0),
  icon: iconController.saveIcon,
  textColor: Colors.white,
  color: Colors.blue,
  label: "Create",
  action: () {
      if (_formKey.currentState?.validate() == true) {
      // The form is valid, you can proceed with the submission
      // or other actions.
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
      bookingNote,
      bookingAirMethod,
      paymentStatus ?? 'Unpaid',
  guestName,
  gender,
  dob,
  country,
  adult,
  child,
  phone,
  address,
  cardId,
  email,
  guestNote,
  checkOut,  // Use checkOut directly
  roomType,  // Use roomType directly
  roomNumber,
  roomRate.replaceAll('\$', ''),
  extraCharge.replaceAll('\$', ''),
  totalPayment.replaceAll('\$', ''),
  totalCharge.replaceAll('\$', ''),
  totalBalance.replaceAll('\$', ''),
  checkIn,   // Use checkIn directly
  roomType,
  roomIdController.text,
  paymentTypeController.text
   ); }
  }
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
    ) async {
  final String baseUrl1 = 'http://localhost:8000/api/booking/insert';
   final url = Uri.parse('$baseUrl1?room_id=$room_id&payment_type=$paymentType&booking_note=$bookingNote&booking_air_method=$bookingAirMethod&room_rate=$roomRate&booking_status=booking&name=$name&gender=$gender&dob=$dob&country=$country&adult=$adult&child=$child&phone_number=$phone_number&address=$address&cardId=$cardId&email=$email&checkout_date=$checkout_date&room_type=$room_type&roomNumber=$roomNumber&extra_charge=$extraCharge&payment=$totalPayment&charges=$totalCharge&balance=$totalBalance&checkin_date=$checkin_date&arrival_date=$checkin_date&departure_date=$checkout_date&payment_status=$paymentStatus');
   print('$baseUrl1?room_id=$room_id&payment_type=$paymentType&booking_note=$bookingNote&booking_air_method=$bookingAirMethod&room_rate=$roomRate&booking_status=booking&name=$name&gender=$gender&dob=$dob&country=$country&adult=$adult&child=$child&phone_number=$phone_number&address=$address&cardId=$cardId&email=$email&checkout_date=$checkout_date&room_type=$room_type&roomNumber=$roomNumber&extra_charge=$extraCharge&payment=$totalPayment&charges=$totalCharge&balance=$totalBalance&checkin_date=$checkin_date&arrival_date=$checkin_date&departure_date=$checkout_date&payment_status=$paymentStatus');
    final response = await http.post(url);
    if (response.statusCode == 200) {
     
    
      print(totalCharge);
        Map<String, dynamic> data = jsonDecode(response.body); 
        print(data);
      AwesomeDialog(
         width: 500,  
        context: context,
        dialogType: DialogType.success,
        title: 'Booking Success',
        desc: data['message'],
        btnOkOnPress: () {
          
          Navigator.of(context).pop();
       reloadDataCallback();
         
        },
        
      ).show();
      print('Booking created successfully.');
     
    } else {
      Map<String, dynamic> data = jsonDecode(response.body); 
        // ignore: use_build_context_synchronously
        AwesomeDialog(
        width: 500,  
        context: context,
        dialogType: DialogType.error,
        title: 'Booking False',
        desc: data['data'],
        btnOkOnPress: () {

        },
      ).show();
    }
}

//   // Define the Booking Details Dialog

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
SizedBox(width: 15),
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
SizedBox(width: 15),
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
SizedBox(width: 15),
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
SizedBox(width: 15),
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
SizedBox(width: 15),
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
      SizedBox(width: 15),
      Expanded(
      flex: 6,
      child: 
      buildLabelAndContent('Booking Information ', [
        Row(
        children: [           
Boxdetail(
  title: "Booking ID",
  value: booking['booking_id'].toString(),
),      
 ]
        ),
        Row(
        children: [           
Boxdetail(
  title: "Check In",
  value: booking['checkin_date'] ?? '',
),
SizedBox(width: 15),
      Boxdetail(
  title: "Check Out",
  value:  booking['checkout_date'] ?? '' ,
), 
SizedBox(width: 15),  Boxdetail(
  title: "Night",
  value:  numberOfNights.toString() ?? '' ,
),
 ]
        ),
 Row(
        children: [           
Boxdetail(
  title: "Room Tpye",
  value: booking['roomtype'].toString() ?? '' ,
),      
SizedBox(width: 15),
Boxdetail(
  title: "Room Number",
  value:  booking['room_number'].toString() ?? '' ,
),
 ]
        ),
 Row(
        children: [           
Boxdetail(
  title: "Room Rate",
  value: '\$' + ( booking['booking_room_rate' ].toString()  ?? booking['room_rate'].toString()),
),      
SizedBox(width: 15),
Boxdetail(
  title: "Extra Charge",
  value: '\$' + booking['extra_charge'].toString() ?? '' ,
),
 ]
        ),
 Row(
        children: [           
Boxdetail(
  title: "Payment",
  value: '\$' + booking['payment'].toString() ?? '',
),
SizedBox(width: 15),
Boxdetail(
  title: "Payment Type",
  value: booking['payment_type'].toString() ?? '',
),      
SizedBox(width: 15),
Boxdetail(
  title: "Total charges",
  value: '\$' +  booking['charges'].toString() ?? '' ,
),
SizedBox(width: 15),
Boxdetail(
  title: "Total Balance",
  value: '\$' +  booking['balance'].toString() ?? '' ,
),
 ]
        ), 
     
Row(
          children: [
            Boxdetail(title: "Note", value: booking['booking_note'] , height: 200 , width:900,)
          ],
        )
      ],() {
                 editBookingDialog(
                                                            context, reloadDataCallback)
                                                        .showCreateeditBookingDialog(
                                                            booking);
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
