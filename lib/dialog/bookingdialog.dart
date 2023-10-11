import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/dashboard/frontdesk.dart';
import 'package:housekeepingmanagement/frontdesk/widget/morebtnaction.dart';
import 'package:housekeepingmanagement/system_widget/box_detail.dart';
import 'package:housekeepingmanagement/system_widget/btn.dart';
import 'package:housekeepingmanagement/widget/Datebooking.dart';
import 'package:housekeepingmanagement/widget/checkinandcheckout.dart';
import 'package:housekeepingmanagement/widget/country.dart';
import 'package:housekeepingmanagement/widget/inputbox.dart';
import 'package:housekeepingmanagement/widget/legend.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

class BookingDialog {
  // final VoidCallback reloadDataCallback;
  final BuildContext context;
    final VoidCallback reloadDataCallback;

  BookingDialog(this.context ,this.reloadDataCallback);
   void showCreateBookingDialog(Map<String, dynamic> booking) {
 
 int? bookingId = booking['booking_id'] as int?;
int? id = booking['id'] as int?;
int? guestId = booking['guest_id'] as int?;
String? roomType = booking['roomtype'] as String?;
int? roomId = booking['room_id'] as int?;
int? paymentId = booking['payment_id'] as int?;
String? bookingStatus = booking['booking_status'] as String?;
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
String? roomRate = booking['room_rate'] as String?;
String? housekeeper = booking['housekeeper'] as String?;
String? airMethod = booking['air_method'] as String?;
int? payment = booking['payment'] as int?;
String? paymentStatus = booking['payment_status'] as String?;
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

String? date = booking['date'] as String?;

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

TextEditingController bookingIdController = TextEditingController();
TextEditingController checkInController = TextEditingController();
TextEditingController checkOutController = TextEditingController();
TextEditingController nightController = TextEditingController();
TextEditingController roomTypeController = TextEditingController();
TextEditingController roomNumberController = TextEditingController();
TextEditingController roomRateController = TextEditingController();
TextEditingController extraChargeController = TextEditingController();
TextEditingController totalPaymentController = TextEditingController();
TextEditingController totalChargeController = TextEditingController();
TextEditingController totalBalanceController = TextEditingController();

// Check if the values are not null before assigning them to the controllers
bookingIdController.text = bookingId?.toString() ?? '';
  checkInController.text = checkinDate ?? DateTime.now().toString();
  DateTime tomorrow = DateTime.now().add(Duration(days: 1));
    checkOutController.text = checkoutDate ?? tomorrow.toString();
DateTime checkInDate = DateTime.parse(checkInController.text);
DateTime checkOutDate = DateTime.parse(checkOutController.text);

int differenceInDays = checkOutDate.difference(checkInDate).inDays;
nightController.text = differenceInDays.toString() ?? '1';

roomTypeController.text = roomType ?? 'No set';
roomNumberController.text = roomNumber ?? '';
roomRateController.text = roomRate ?? '10';
extraChargeController.text = extraCharge ?? '';
totalPaymentController.text = payment?.toString() ?? '';
int nightCal = int.parse(nightController.text) ;
double roomRateCal = double.parse(roomRateController.text);
double result = nightCal * roomRateCal;

totalChargeController.text = charges?.toString() ?? result.toString();
totalBalanceController.text = balance ?? '';

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


String? minSelectDate;
String? selectCountry ;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        
        title: Text('Create Booking'),
        content: SingleChildScrollView(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Guest Detail',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
      children: [
                    CustomTextField(
                      controller: guestNameController,
                      labelText: 'Guest Name',
                      width: 250,
                      
                    ), SizedBox(width: 20), CustomDropdownButton(
            width: 250,
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
                      width: 250,
                      
                       onDateSelectedDate: (selectedDate) {
              // Handle the selected date here
              print('Selected Date: $selectedDate');
            },
                    ),
                      SizedBox(width: 20), 
                   selectCountry_dropdown(
          width: 250,
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
                      width: 250,
                    ),
                      SizedBox(width: 20), 
                    CustomTextField(
                      controller: childController,
                      labelText: 'Child',
                      width: 250,
                    )
      ]),
          Row(
      children: [
                    CustomTextField(
                      controller: phoneController,
                      labelText: 'Phone Number',
                      width: 250,
                    ),
                      SizedBox(width: 20), 
                    CustomTextField(
                      controller: addressController,
                      labelText: 'Address',
                      width: 250,
                    )
      ]),
          Row(
      children: [
                    CustomTextField(
                      controller: cardIdController,
                      labelText: 'Card ID',
                      width: 250,
                    ),
                    CustomTextField(
                      controller: emailController,
                      labelText: 'Email',
                      width: 250,
                    )]),  SizedBox(width: 20), 
                    CustomTextField(
                      controller: guestNoteController,
                      labelText: 'Guest Note',
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20), // Add spacing between columns
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Booking Detail',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                      SizedBox(width: 20), 
                 DateRangePickerWidget(
              controller: checkOutController,
              labelText: 'Check-Out Date',
              checkin:checkInController,
              checkout:checkOutController,
              night:nightController,
              checkcurrentdate: checkOutDate,
              onDateSelectedDate: (selectedDate) {
               
                
             
              }
              , onChange: (DateTime checkin, DateTime checkout, int nights) {
              
roomRateCal = double.parse(roomRateController.text);
totalChargeController.text = (nights * roomRateCal).toString();
  checkOutController.text = checkout.toString();
                  checkInController.text = checkin.toString();
                },
            ),
        
           Row(
      children: [ 

        CustomDropdownButton(
            width: 400,
            items: ['No set', 'Single Room', 'Twin Room'],
            selectedValue:roomTypeController.text ,
            hintText: 'Room Type',
            onChanged: (value) {
                roomTypeController.text = value!;
            },
          ),SizedBox(width: 20), 

                    CustomTextField(
                      width: 120,
                      controller: roomNumberController,
                      labelText: 'Room Number',
                    )
      ]),
       Row(
      children: [ 
                    CustomTextField(
                      width: 300,
                      controller: roomRateController,
                      labelText: 'Room Rate',
                    ),SizedBox(width: 20),
                    CustomTextField(
                      width: 170,
                      controller: extraChargeController,
                      labelText: 'Extra Charge',
                    ),
      ]),
        Row(
      children: [ 
                    CustomTextField(
                      width: 500/3,
                      controller: totalPaymentController,
                      labelText: 'Total Payment',
                    ),SizedBox(width: 20),
                    CustomTextField(
                      width: 500/3,
                      controller: totalChargeController,
                      labelText: 'Total Charge',
                    ),SizedBox(width: 20),
                    CustomTextField(
                      width: 500/3,
                      controller: totalBalanceController,
                      labelText: 'Total Balance',
                    )
      ])
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
           BtnAction(
  icon: Icons.star,
  textColor: Colors.white,
  color: Colors.blue,
  label: "Cancel",
  action: () {
       Navigator.of(context).pop();
  },
),
 BtnAction(
  icon: Icons.star,
  textColor: Colors.white,
  color: Colors.blue,
  label: "Cancel",
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

    final bookingId = bookingIdController.text;
    final checkIn = checkInController.text;
    final checkOut = checkOutController.text;
    final night = nightController.text;
    final roomType = roomTypeController.text;
    final roomNumber = roomNumberController.text;
    final roomRate = roomRateController.text;
    final extraCharge = extraChargeController.text;
    final totalPayment = totalPaymentController.text;
    final totalCharge = totalChargeController.text;
    final totalBalance = totalBalanceController.text;
    // Create a map containing the booking data
     submitUpdatedData(
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
  roomRate,
  extraCharge,
  totalPayment,
  totalCharge,
  totalBalance,
  checkIn,   // Use checkIn directly
  roomType,
  roomId! ); },
),
          
        ],
      );
    },
  );
}
Future<void> submitUpdatedData(    String name,
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
        int room_id,
    ) async {
  final String baseUrl1 = 'http://localhost:8000/api/booking/insert';
   final url = Uri.parse('$baseUrl1?room_id=$room_id&name=$name&gender=$gender&dob=$dob&country=$country&adult=$adult&child=$child&phone_number=$phone_number&address=$address&cardId=$cardId&email=$email&checkout_date=$checkout_date&room_type=$room_type&roomNumber=$roomNumber&roomRate=$roomRate&extra_charge=$extraCharge&total_payment=$totalPayment&totalCharge=$totalCharge&totalBalance=$totalBalance&checkin_date=$checkin_date&payment_status=leabheng');
  
    final response = await http.post(url);
    if (response.statusCode == 200) {
      AwesomeDialog(
         width: 500,  
        context: context,
        dialogType: DialogType.success,
        title: 'Booking Failed',
        desc: response.toString(),
        btnOkOnPress: () {
          
        },
      ).show();
      print('Booking created successfully.');
     
    } else {
      print('Response body: ${response.body}');
        // ignore: use_build_context_synchronously
        AwesomeDialog(
         width: 500,  
        context: context,
        dialogType: DialogType.error,
        title: 'Booking Failed',
        desc: response.toString(),
        btnOkOnPress: () {},
      ).show();
    }
}

//   // Define the Booking Details Dialog
  void showBookingDetailsDialog(Map<String, dynamic> booking) {
    DateTime today = DateTime.now();
DateTime todaycorrent = DateTime(today.year, today.month, today.day );
DateTime todaycorrentCheckout = DateTime(today.year, today.month, today.day + 1 );

      showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Container(
          child: Text('Booking Details', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        
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
  value:  booking['name'],
  
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
  value: booking['adults'].toString() ?? '' ,
),      
SizedBox(width: 20),
Boxdetail(
  title: "Child",
  value:  booking['child'].toString() ?? '' ,
),
 ]
        ),
 Row(
        children: [           
Boxdetail(
  title: "Country d ",
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
              // This is the action that will be executed when the button is pressed
              print('Button Pressed!');
            }),
      ),
      SizedBox(width: 20),
      Expanded(
      flex: 6,
      child: 
      buildLabelAndContent('Booking Information ', [
        Row(
        children: [           
Boxdetail(
  title: "Guest ID",
  value: booking['guest_id'].toString(),
),      
SizedBox(width: 20),
Boxdetail(
  title: "Guest Name",
  value:  booking['name'],
  
),
 ]
        ),
        Row(
        children: [           
Boxdetail(
  title: "Gender",
  value: booking['gender'] ?? '',
),
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
  value: booking['adults'].toString() ?? '' ,
),      
SizedBox(width: 20),
Boxdetail(
  title: "Child",
  value:  booking['child'].toString() ?? '' ,
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
  title: "passport_number",
  value: booking['Passport Number'].toString(),
),      
SizedBox(width: 20),

 ]
        ),
     
Row(
          children: [
            Boxdetail(title: "Note", value: booking['note'] , height: 200 , width:900,)
          ],
        )
      ],() {
              // This is the action that will be executed when the button is pressed
              print('Button Pressed!');
            }),
      )
    ],
  
  ),
  
),
        actions: [
          Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Expanded(child:Row(children: [
              morebtnaction()
            ],) 
            ) ,
            Expanded(
              child:Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [  
                 Visibility(
  visible:
   (DateTime.parse(booking['checkin_date']).isBefore(todaycorrent) || DateTime.parse(booking['checkin_date']).isAtSameMomentAs(todaycorrent) ) && booking['booking_status'] != 'In house', // Show "Check In" button if checkInDate is in the future
  child: BtnAction(
    icon: Icons.star,
    textColor: Colors.white,
    color: Colors.blue,
    label: "Check In",
    action: () {
      onCheck(context, booking['booking_id'],'checkin');
    },
  ),
),
Visibility(
  visible: DateTime.parse(booking['checkout_date']).isBefore(todaycorrentCheckout) || DateTime.parse(booking['checkout_date']).isAtSameMomentAs(todaycorrentCheckout),  // Show "Check Out" button if checkOutDate is in the past
  child: BtnAction(
    icon: Icons.star,
    textColor: Colors.white,
    color: Colors.blue,
    label: "Check Out",
    action: () {
      onCheck(context, booking['booking_id'],'checkout');
    },
  ),
)
],) 
            )
            ],
          )
         
        ],
      );
    },
  );
}
}
