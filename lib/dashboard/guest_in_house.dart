import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/guest_in_house_widget/guest_in_house_botton.dart';
import 'package:housekeepingmanagement/guest_in_house_widget/guest_in_house_list.dart';
import 'package:housekeepingmanagement/housekeeping_status/housekeeping_botton_widget.dart';
import 'package:housekeepingmanagement/housekeeping_status/housekeeping_data_guest.dart';

class GuestInHouse extends StatefulWidget {
  const GuestInHouse({Key? key}) : super(key: key);


  @override
  State<GuestInHouse> createState() => _GuestInHouseState();
}

class _GuestInHouseState extends State<GuestInHouse> {
  @override
  Widget build(BuildContext context) {
    return
    Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey[300],
          child: Column(
            children: [
                Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                height: 120.0,
                child: const Row(
                  children: [
                    Expanded(
                      child: HouseKeepingBottonWidget(),
                    ),
                  ],
                ),
              ),
               Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                height: 750.0,
                child: const Row(
                  children: [
                    Expanded(
                      child: GuestInHouseList(),
                    ),
                  ],
                ),
              ),
        //       Row(
        //   children: [
        //     Expanded(
              
        //       child: GuestInHouseBotton(),
        //     ),
        //   ],
        // ),
              // SizedBox(
              //   height: 750.0,
              //   child: Expanded(
              //     child: Container(
              //       padding: const EdgeInsets.symmetric(
              //           vertical: 10, horizontal: 20),
              //       child: GuestInHouseList(),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
