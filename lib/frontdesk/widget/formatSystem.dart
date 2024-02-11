import 'package:intl/intl.dart';


String formatCurrency(dynamic amount) {
  // Check if amount is null
  if (amount == null) {
    return '\$0.00';
  }

  // Convert amount to double if it's a String
  double doubleAmount = amount is String ? double.tryParse(amount) ?? 0.0 : amount;

  // Create a NumberFormat instance with the desired currency code and symbol
  NumberFormat formatter = NumberFormat.currency(locale: 'en', symbol: '\$');

  // Format the amount using the NumberFormat instance
  String formattedAmount = formatter.format(doubleAmount);

  return formattedAmount;
}


String formatDate(DateTime? date, {String format = 'dd-MM-yyyy'}) {
  // Create a DateFormat instance with the desired format
  DateFormat formatter = DateFormat(format);

  // Format the date using the DateFormat instance
  String formattedDate = formatter.format(date!);

  return formattedDate;
}
String formatStringDate(String dateString, {String format = 'dd-MMM-yyyy'}) {
  // Parse the string to a DateTime object
  DateTime date = DateTime.parse(dateString);

  // Create a DateFormat instance with the desired format
  DateFormat formatter = DateFormat(format);

  // Format the date using the DateFormat instance
  String formattedDate = formatter.format(date);
  

  return formattedDate;
}

int GetNight(String checkInDateString, String checkOutDateString) {
  // Parse date strings to DateTime objects
  DateTime checkInDate = DateTime.parse(checkInDateString);
  DateTime checkOutDate = DateTime.parse(checkOutDateString);

  // Calculate duration difference
  Duration difference = checkOutDate.difference(checkInDate);

  // Get the number of nights
  int numberOfNights = difference.inDays;

  return numberOfNights;
}
