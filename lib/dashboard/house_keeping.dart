import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/housekeeping_status/housekeeping_botton_widget.dart';
import 'package:housekeepingmanagement/housekeeping_status/housekeeping_data_guest.dart';
import 'package:housekeepingmanagement/system_widget/guest_inhouse_widget.dart';

class Housekeeping extends StatefulWidget {
  const Housekeeping({Key? key}) : super(key: key);

  @override
  _HousekeepingState createState() => _HousekeepingState();
}

class _HousekeepingState extends State<Housekeeping> {
  late HouseKeepingDataGuest houseKeepingDataGuest;
Key dropdownKey = UniqueKey();
  @override
  void initState() {
    super.initState();
    houseKeepingDataGuest = HouseKeepingDataGuest();
  }

  void reloadData() {
    setState(() {
      dropdownKey = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(255, 232, 232, 232),
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                height: 120.0,
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
                     key:UniqueKey(),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: HouseKeepingDataGuest(),
                  ),
                ),
              ),
              SizedBox(
                height: 750.0,
                child: Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: HkDataTable(reloadData:reloadData),
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
