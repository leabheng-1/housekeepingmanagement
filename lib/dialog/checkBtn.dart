bool checkbtncheckin(Map<String, dynamic> booking, {DateTime? today}) {
  today ??= DateTime.now();
  
  DateTime checkinDate = DateTime.parse(booking['checkin_date']);
  
  return (checkinDate.isBefore(today) || checkinDate.isAtSameMomentAs(today)) &&
         booking['booking_status'] != 'In House' &&
         booking['booking_status'] != 'Checked Out';
}