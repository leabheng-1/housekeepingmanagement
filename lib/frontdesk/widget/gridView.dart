import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/system_widget/system_color.dart';
import 'package:housekeepingmanagement/system_widget/system_icon.dart';

class gridViewbooking extends StatelessWidget {
   Map<String, dynamic> booking;

  gridViewbooking({required this.booking});
  @override
  Widget build(BuildContext context,) {
    return Container(
                                                      height: 140,
                                                      margin:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              16.0),
                                                      decoration: BoxDecoration(
                                                        color: ColorController
                                                            .boxBooingColor,
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
                                                            ),
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                '${booking['room_number']}',
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 24,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  height: 1,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 2),
                                                              Text(
                                                                  booking['booking_id'] == null
      ? 'Variable'
                                                                :'${booking['name']}',
                                                                style:
                                                                    const TextStyle(
                                                                        height:
                                                                            1,
                                                                        fontSize:
                                                                            16),
                                                              ),
                                                              booking['booking_id'] == null
      ?   SizedBox(
        height: 10,
                                                               
                                                              )
                                                                :
                                                              Row(children: [
                                                                Text(
                                                                  '${booking['arrival_date']} - ',
                                                                  style: const TextStyle(
                                                                      height: 1,
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                                Text(
                                                                  '${booking['departure_date']}',
                                                                  style: const TextStyle(
                                                                      height: 1,
                                                                      fontSize:
                                                                          12),
                                                                ),
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
                                                                          '${booking['payment_status']}',
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
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    );
                        }
}