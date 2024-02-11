import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/system_widget/system_color.dart';
import 'package:housekeepingmanagement/system_widget/system_icon.dart';

class ListViewbooking extends StatelessWidget {
   Map<String, dynamic> booking;

  ListViewbooking({required this.booking});
  @override
  Widget build(BuildContext context,) {
    return Container(
                                                      height: 70,
                                                      margin:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              16.0),
                                                      decoration: BoxDecoration(
                                                        color: booking['booking_id'] != null ? Color.fromARGB(255, 193, 255, 194) : ColorController.boxBooingColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                      ),
                                                      child: Stack(
                                                        children: [
                                                          Align(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                                 children:
                                                              
                                                               [
                                                    
                                                              ],
                                                            ),
                                                          ),
                                                          Row(
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            mainAxisAlignment:MainAxisAlignment.spaceAround,
                                                            children: [
                                                              
                                                             Container(
  width: 50, // Set the desired width
  child: Text(
    '${booking['room_number']}',
    style: const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      height: 1,
    ),
    maxLines: 1, // Set the maximum number of lines
    overflow: TextOverflow.ellipsis, // Define the overflow behavior
  ),
),

                                                              const SizedBox(
                                                                  height: 2),
                                 Container(
  width: 130, // Set the desired width
  child: Text(
    booking['booking_id'] == null
        ? 'Room Available'
        : '${booking['name']}',
    style: const TextStyle(
      height: 1,
      fontSize: 16,
    ),
  ),
),

                                                              booking['booking_id'] == null
      ?   SizedBox(
        height: 10,
        width: 150,
                                                               
                                                              )
                                                                :
                                                              Row(children: [
                                                                
                                                             Container(
  width: 150, // Set the desired width
  child: Row(
    children: [
      Text(
        '${booking['arrival_date']} - ',
        style: const TextStyle(
          height: 1,
          fontSize: 12,
        ),
      ),
      Text(
        '${booking['departure_date']}',
        style: const TextStyle(
          height: 1,
          fontSize: 12,
        ),
      ),
    ],
  ),
)

                                                              ]),
                                                              const SizedBox(
                                                                  height: 19),
                                                              Row(
                                                                children: [
                                                                  Tooltip(
                                                                    message:
                                                                        'This Room ${booking['housekeeping_status'] ?? ''}',
                                                                    child:
                                                                        Container(
                                                                      width: 35,
                                                                      height:
                                                                          35,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        color: ColorController.getHKColor(booking['housekeeping_status'] ??
                                                                            ''),
                                                                      ),
                                                                      child: const Icon(
                                                                          iconController
                                                                              .khIcon,
                                                                          size:
                                                                              12,
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                      width:
                                                                          10),
                                                                  Tooltip(
                                                                    message:
                                                                        'Room ${booking['booking_status'] ?? booking['room_status'] ?? ''}',
                                                                    child:
                                                                        Container(
                                                                      width: 35,
                                                                      height:
                                                                          35,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        color: ColorController.bookingStatus(booking['booking_status'] ??
                                                                            booking['room_status'] ??
                                                                            ''),
                                                                      ),
                                                                      child: Icon(
                                                                          iconController.bookingStatus(booking['booking_status'] ??
                                                                              booking[
                                                                                  'room_status'] ??
                                                                              ''),
                                                                          size:
                                                                              16,
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                      width:
                                                                          10),
                                                                  if (booking['booking_id'] !=null)
                                                                    Tooltip(
                                                                      message:
                                                                          '${booking['payment_type']}',
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            35,
                                                                        height:
                                                                            35,
                                                                        decoration: BoxDecoration(
                                                                          shape:
                                                                              BoxShape.circle,
                                                                          color: ColorController.paymentStatus(booking['payment_status'] ??
                                                                            ''),
                                                                        ),
                                                                        child:Icon(
                                                                          iconController.dollar,
                                                                          size:
                                                                              16,
                                                                          color:
                                                                              Colors.white),
                                                                      ),
                                                                    ),
                                                                   const SizedBox(
                                                                      width:
                                                                          10),
                                                                if(  booking['booking_air_method'] != null && booking['booking_air_method'] != "No set" )
                                                                Tooltip(
                                                                  message:
                                                                      '${booking['booking_air_method']} ',
                                                                  child:
                                                                      Container(
                                                                    width: 35,
                                                                    height: 35,
                                                                    decoration:
                                                                         
                                                                        BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.1),
                                                                    ),
                                                                    
                                                                    child: 
                                                                    
                                                                    Icon(
                                                                      iconController
                                                                          .airMethod(booking['booking_air_method']),
                                                                      size: 20,
                                                                      color: const Color
                                                                          .fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255),
                                                                    ),
                                                                  ),
                                                                ),
                                                                if (booking['booking_air_method'] == 'All')
                                                                SizedBox(width: 5,),
                                                                 if (booking['booking_air_method'] == 'All')
                                                                Tooltip(
                                                                  message:
                                                                      '${booking['booking_air_method']} ',
                                                                  child:
                                                                      Container(
                                                                    width: 35,
                                                                    height: 35,
                                                                    decoration:
                                                                         
                                                                        BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.1),
                                                                    ),
                                                                    
                                                                    child: 
                                                                    const Icon(
                                                                      iconController
                                                                          .heatIcon,
                                                                      size: 20,
                                                                      color: Color
                                                                          .fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255),
                                                                    ),
                                                                  ),
                                                                ),
                                                                 
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    );
  }
}