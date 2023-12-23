import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/system_widget/custom_text_field.dart';


class CustomDropdownFilter extends StatefulWidget {
  final String parameter;
  final void Function(String roomStatus, String housekeepingStatus, String GuestsName) onChange;
final BuildContext context;
  CustomDropdownFilter({
    required this.parameter,
    required this.onChange,
    required this.context,
  });

  @override
  _CustomDropdownFilterState createState() => _CustomDropdownFilterState();
}

class _CustomDropdownFilterState extends State<CustomDropdownFilter> {
  String? roomStatus = 'All';
  String? housekeepingStatus = 'All';
  String? GuestsName = 'All';
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomDropdownButton(
             bg:Color.fromRGBO(255, 255, 255, 1),
            width: 200,
            items: ['All','In House', 'Varaible', 'Block' , 'No Show' , 'Void' , 'Checked In' , 'Checked Out'],
            selectedValue:  'All',
            hintText: 'Housekeeping Status',
            onChanged: (value) {
              setState(() {
                roomStatus = value; 
                _updateValues();
              });
            },
          ),
          SizedBox(width:20,),
          CustomDropdownButton(
             bg:Color.fromRGBO(255, 255, 255, 1),
            width: 200,
            items: ['All','Clean', 'Cleaning', 'Dirty'],
            selectedValue:  'All',
            hintText: 'Housekeeping Status',
            onChanged: (value) {
              setState(() {
               housekeepingStatus = value;
               _updateValues();
              });
            },
          ),
          SizedBox(width:20,),
        Container(
  height: 40,
  width: 200,
  decoration: BoxDecoration(
    color: Colors.white, // Replace with your desired background color
    borderRadius: BorderRadius.circular(10),
  ),
  child: TextFormField(
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.all(16),
      hintText: 'Search',
      hintStyle: const TextStyle(fontSize: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      suffixIcon: GestureDetector(
        onTap: () {
          _updateValues();
        },
        child: Icon(
          Icons.search, // Replace with the icon you want to use
          color: Colors.grey, // Customize the icon color
        ),
      ),
    ),
    onChanged: (value) {
      setState(() {
        GuestsName = value == '' ? 'All' : value;
        print(GuestsName);
      });
    },
    onFieldSubmitted: (value) {
      // This function is called when the user submits (e.g., by pressing Enter)
      _updateValues();
    },
  ),
)



        
      ],
    );
  }

  void _updateValues() {
    widget.onChange(roomStatus!, housekeepingStatus! , GuestsName!); // Replace with your logic
  }
}
