import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/system_widget/box_detail.dart';
import 'package:housekeepingmanagement/system_widget/btn.dart';
import 'package:housekeepingmanagement/widget/Datebooking.dart';
import 'package:housekeepingmanagement/widget/country.dart';
import 'package:housekeepingmanagement/widget/inputbox.dart';
import 'package:housekeepingmanagement/widget/legend.dart';
import 'package:http/http.dart' as http;
import 'package:housekeepingmanagement/system_widget/system_icon.dart';

class BookingDialog {
  final BuildContext context;
  final VoidCallback reloadDataCallback;

  BookingDialog(this.context, this.reloadDataCallback);
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
    int nightCal = int.parse(nightController.text);
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
    String? selectCountry;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          content: SizedBox(
            height: 590,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Create Booking',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color(0xFF7C7C7C),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEF3423),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: IconButton(
                        icon: Icon(
                          iconController.closeIcon,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          buildLabelAndContent(
                              'Guest Detail',
                              [
                                Row(
                                  children: [
                                    CustomTextField(
                                      controller: guestNameController,
                                      labelText: 'Guest Name',
                                      width: 270,
                                    ),
                                    const SizedBox(width: 10),
                                    CustomDropdownButton(
                                      width: 270,
                                      items: const ['No set', 'Male', 'Female'],
                                      selectedValue: genderController.text,
                                      hintText: 'Room Status',
                                      labelText: 'Gender',
                                      onChanged: (value) {
                                        genderController.text = value!;
                                      },
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    DatePickerTextField(
                                      checkcurrnetdate: DateTime(2000),
                                      controller: dobController,
                                      labelText: 'Date Of Birth',
                                      width: 290,
                                      onDateSelectedDate: (selectedDate) {},
                                    ),
                                    const SizedBox(width: 10),
                                    selectCountry_dropdown(
                                      width: 250,
                                      labelText: 'Country',
                                      selectedValue: countryController.text,
                                      hintText: 'Country',
                                      onChanged: (value) {
                                        countryController.text = value!;
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    CustomTextField(
                                      controller: adultController,
                                      labelText: 'Adult',
                                      width: 270,
                                    ),
                                    const SizedBox(width: 10),
                                    CustomTextField(
                                      controller: childController,
                                      labelText: 'Child',
                                      width: 270,
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    CustomTextField(
                                      controller: phoneController,
                                      labelText: 'Phone Number',
                                      width: 270,
                                    ),
                                    const SizedBox(width: 10),
                                    CustomTextField(
                                      controller: addressController,
                                      labelText: 'Address',
                                      width: 270,
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    CustomTextField(
                                      controller: cardIdController,
                                      labelText: 'Card ID',
                                      width: 270,
                                    ),
                                    const SizedBox(width: 10),
                                    CustomTextField(
                                      controller: emailController,
                                      labelText: 'Email',
                                      width: 270,
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: Row(
                                    children: [
                                      CustomTextField(
                                        controller: guestNoteController,
                                        labelText: 'Guest Note',
                                        width: 550,
                                        height: 100,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                              () {}),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          buildLabelAndContent(
                            'Booking Detail',
                            [
                              const SizedBox(width: 10),
                              DateRangePickerWidget(
                                controller: checkOutController,
                                labelText: 'Check-Out Date',
                                checkin: checkInController,
                                checkout: checkOutController,
                                night: nightController,
                                checkcurrentdate: checkOutDate,
                                onDateSelectedDate: (selectedDate) {},
                                onChange: (DateTime checkin, DateTime checkout,
                                    int nights) {
                                  roomRateCal =
                                      double.parse(roomRateController.text);
                                  totalChargeController.text =
                                      (nights * roomRateCal).toString();
                                  checkOutController.text = checkout.toString();
                                  checkInController.text = checkin.toString();
                                },
                              ),
                              Row(
                                children: [
                                  CustomDropdownButton(
                                    width: 420,
                                    items: const [
                                      'No set',
                                      'Single Room',
                                      'Twin Room'
                                    ],
                                    selectedValue: roomTypeController.text,
                                    labelText: 'Room Type',
                                    onChanged: (value) {
                                      roomTypeController.text = value!;
                                    },
                                    hintText: 'Room Type',
                                  ),
                                  const SizedBox(width: 10),
                                  CustomTextField(
                                    width: 120,
                                    controller: roomNumberController,
                                    labelText: 'Room Number',
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  CustomTextField(
                                    width: 300,
                                    controller: roomRateController,
                                    labelText: 'Room Rate',
                                  ),
                                  const SizedBox(width: 10),
                                  CustomTextField(
                                    width: 240,
                                    controller: extraChargeController,
                                    labelText: 'Extra Charge',
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  CustomTextField(
                                    width: 180,
                                    controller: totalPaymentController,
                                    labelText: 'Total Payment',
                                  ),
                                  const SizedBox(width: 10),
                                  CustomTextField(
                                    width: 180,
                                    controller: totalChargeController,
                                    labelText: 'Total Charge',
                                  ),
                                  const SizedBox(width: 10),
                                  CustomTextField(
                                    width: 170,
                                    controller: totalBalanceController,
                                    labelText: 'Total Balance',
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: CustomTextField(
                                  controller: guestNoteController,
                                  labelText: 'Note',
                                  width: 550,
                                  height: 170,
                                ),
                              ),
                            ],
                            () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BtnAction(
                  icon: iconController.settiongIcon,
                  textColor: Colors.white,
                  color: const Color.fromRGBO(173, 17, 231, 1.0),
                  label: "Option",
                  action: () {
                    Navigator.of(context).pop();
                  },
                  background: const Color(0xFF761497),
                ),
                Row(
                  children: [
                    BtnAction(
                      icon: iconController.closeIcon,
                      textColor: Colors.white,
                      color: const Color(0xFFf1463b),
                      label: "Cancel",
                      action: () {
                        Navigator.of(context).pop();
                      },
                      background: const Color(0xFFa43230),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    BtnAction(
                      icon: iconController.saveIcon,
                      textColor: Colors.white,
                      color: Colors.blue,
                      label: "Save",
                      background: Colors.blue.shade900,
                      action: () {
                        final guestName = guestNameController.text;
                        final gender = genderController.text;
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
                            checkOut,
                            roomType,
                            roomNumber,
                            roomRate,
                            extraCharge,
                            totalPayment,
                            totalCharge,
                            totalBalance,
                            checkIn,
                            roomType,
                            roomId!);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> submitUpdatedData(
    String name,
    String gender,
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
    const String baseUrl1 = 'http://localhost:8000/api/booking/insert';
    final url = Uri.parse(
        '$baseUrl1?room_id=$room_id&name=$name&gender=$gender&dob=$dob&country=$country&adult=$adult&child=$child&phone_number=$phone_number&address=$address&cardId=$cardId&email=$email&checkout_date=$checkout_date&room_type=$room_type&roomNumber=$roomNumber&roomRate=$roomRate&extra_charge=$extraCharge&total_payment=$totalPayment&totalCharge=$totalCharge&totalBalance=$totalBalance&checkin_date=$checkin_date&payment_status=leabheng');

    final response = await http.post(url);
    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      AwesomeDialog(
        width: 500,
        context: context,
        dialogType: DialogType.success,
        title: 'Booking Failed',
        desc: response.toString(),
        btnOkOnPress: () {},
      ).show();
    } else {
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

  void showBookingDetailsDialog(Map<String, dynamic> booking) {
    DateTime today = DateTime.now();
    DateTime todaycorrent = DateTime(today.year, today.month, today.day);
    DateTime todaycorrentCheckout =
        DateTime(today.year, today.month, today.day + 1);
    String selectedValue;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          content: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Booking Details',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color(0xFF7C7C7C),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEF3423),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: IconButton(
                      icon: Icon(
                        iconController.closeIcon,
                        size: 25,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        buildLabelAndContent(
                            'Guest Information',
                            [
                              Row(
                                children: [
                                  Boxdetail(
                                      title: "Guest ID",
                                      value: booking['guest_id'].toString(),
                                      width: 600),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Boxdetail(
                                      title: "Guest Name",
                                      value: booking['name'],
                                      width: 600),
                                ],
                              ),
                              Row(
                                children: [
                                  Boxdetail(
                                      title: "Gender",
                                      value: booking['gender'] ?? '',
                                      width: 600),
                                  const SizedBox(width: 10),
                                  Boxdetail(
                                      title: "Date Of Birth",
                                      value: booking['dob'] ?? '',
                                      width: 600),
                                ],
                              ),
                              Row(
                                children: [
                                  Boxdetail(
                                      title: "Adult",
                                      value: booking['adults'].toString() ?? '',
                                      width: 600),
                                  const SizedBox(width: 20),
                                  Boxdetail(
                                      title: "Child",
                                      value: booking['child'].toString() ?? '',
                                      width: 600),
                                ],
                              ),
                              Row(
                                children: [
                                  Boxdetail(
                                      title: "Country",
                                      value: booking['country'] ?? '',
                                      width: 600),
                                  const SizedBox(width: 10),
                                  Boxdetail(
                                      title: "Address",
                                      value: booking['address'] ?? '',
                                      width: 600),
                                ],
                              ),
                              Row(
                                children: [
                                  Boxdetail(
                                      title: "Phone Number",
                                      value:
                                          booking['phone_number'].toString() ??
                                              '',
                                      width: 600),
                                  const SizedBox(width: 10),
                                  Boxdetail(
                                      title: "Email",
                                      value: booking['email'] ?? '',
                                      width: 600),
                                ],
                              ),
                              Row(
                                children: [
                                  Boxdetail(
                                    width: 900,
                                    title: "Card ID / Passport ID",
                                    value:
                                        booking['Passport Number'].toString(),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Row(
                                  children: [
                                    Boxdetail(
                                      title: "Note",
                                      value: booking['note'],
                                      height: 110,
                                      width: 900,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            () {}),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      children: [
                        buildLabelAndContent(
                          'Stay Information',
                          [
                            Row(
                              children: [
                                Boxdetail(
                                  title: "Booking ID",
                                  value: booking['guest_id'].toString(),
                                  width: 300,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Boxdetail(
                                  title: "Check In Date",
                                  value: booking['gender'] ?? '',
                                  width: 400,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Boxdetail(
                                  title: "Check Out Date",
                                  value: booking['name'],
                                  width: 300,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Boxdetail(
                                  title: "Date Of Birth",
                                  value: booking['dob'] ?? '',
                                  width: 300,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Boxdetail(
                                  title: "Room Type",
                                  value: booking['country'] ?? '',
                                  width: 600,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Boxdetail(
                                  title: "Room Number",
                                  value: booking['address'] ?? '',
                                  width: 600,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Boxdetail(
                                  title: "Room Rate",
                                  value: booking['country'] ?? '',
                                  width: 600,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Boxdetail(
                                  title: "Extra Charge",
                                  value: booking['address'] ?? '',
                                  width: 600,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Boxdetail(
                                  title: "Total Payment",
                                  value: booking['country'] ?? '',
                                  width: 300,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Boxdetail(
                                  title: "Total Charge",
                                  value: booking['address'] ?? '',
                                  width: 300,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Boxdetail(
                                  title: "Total Balance",
                                  value: booking['address'] ?? '',
                                  width: 300,
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Row(
                                children: [
                                  Boxdetail(
                                    title: "Note",
                                    value: booking['note'],
                                    height: 180,
                                    width: 900,
                                  )
                                ],
                              ),
                            )
                          ],
                          () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFAB11EC),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: PopupMenuButton<String>(
                    onSelected: (String value) {},
                    itemBuilder: (BuildContext context) {
                      return [
                        const PopupMenuItem(
                          value: "cancel",
                          child: Text("Cancel"),
                        ),
                        const PopupMenuItem(
                          value: "delete",
                          child: Text("Delete"),
                        ),
                      ];
                    },
                    child: BtnAction(
                      icon: iconController.settiongIcon,
                      textColor: Colors.white,
                      color: Colors.red,
                      label: "Option",
                      background: const Color(0xFF740893),
                    ),
                  ),
                ),
                Row(
                  children: [
                    BtnAction(
                      icon: iconController.closeIcon,
                      textColor: Colors.white,
                      color: const Color(0xFFf1463b),
                      label: "Cancel",
                      action: () {
                        Navigator.of(context).pop();
                      },
                      background: const Color(0xFFa43230),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    BtnAction(
                      icon: iconController.saveIcon,
                      textColor: Colors.white,
                      color: Colors.blue,
                      label: "Save",
                      action: () {
                        Navigator.of(context).pop();
                      },
                      background: Colors.blue.shade900,
                    ),
                  ],
                )
              ],
            )
          ],
        );
      },
    );
  }
}
