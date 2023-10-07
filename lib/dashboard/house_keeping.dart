import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/housekeeping_status/housekeeping_botton_widget.dart';
import 'package:housekeepingmanagement/housekeeping_status/housekeeping_data_guest.dart';
import 'package:housekeepingmanagement/system_widget/guest_inhouse_widget.dart';

class Housekeeping extends StatelessWidget {
  const Housekeeping({super.key});

  @override
  Widget build(BuildContext context) {
    false;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(255, 232, 232, 232),
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                height: 100.0,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: HouseKeepingBottonWidget(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 140.0,
                child: Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: const HouseKeepingDataGuest(),
                  ),
                ),
              ),
              SizedBox(
                height: 750.0,
                child: Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: const HkDataTable(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
