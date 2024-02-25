
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/system_widget/btn.dart';
import 'package:housekeepingmanagement/system_widget/system_color.dart';
import 'package:housekeepingmanagement/system_widget/system_icon.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:housekeepingmanagement/report/widget/pdfview.dart';
import 'package:http/http.dart' as http;
String format = '';
class exportBtn extends StatefulWidget {
  final String url; 
  exportBtn({Key? key, required this.url}) : super(key: key);

  @override
  State<exportBtn> createState() => _exportBtnState();
}

class _exportBtnState extends State<exportBtn> {
Future<void> submitRequest() async  {
    String url_new = widget.url;
    WidgetsFlutterBinding.ensureInitialized();
    
     final url = '$url_new&format=$format';
  
        final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    // Use the url_launcher package to open the URL in a web browser
    await launchUrl(Uri.parse(url));
  } else {
    // Handle the error
    print('Failed to download PDF: ${response.statusCode}');
  }
    //   if ( format == 'excel' ) {  }else{
    //     showWebViewDialog(context,url); 
    //  }

 

  }
  
  @override
  Widget build(BuildContext context) {
    return  DropdownButtonHideUnderline(
          child: DropdownButton2(
            customButton:
      GestureDetector(
 
  child: Container(
    decoration: BoxDecoration(
      color: ColorController.moreOptionColor,
      borderRadius: BorderRadius.circular(8.0),
    ),
    padding: const EdgeInsets.only(left: 5, top: 5, bottom: 5, right: 10),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: ColorController.bgIconColorop,
          ),
          child: Icon(
            iconController.settiongIcon,
            size: 16,
            color: Colors.white, // Icon color
          ),
        ),
        const SizedBox(width: 8.0),
        Text(
          "Export",
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          ),
        ),
      ],
    ),
  ),
),      
  //            BtnAction(
  //   icon: Icons.print,
  //   textColor: Colors.white,
  //   color: Color.fromARGB(255, 0, 0, 0),
  //   label: "Export",
  //   background: Colors.red,
  // ),
            items: [
              ...MenuItems.firstItems.map(
                (item) => DropdownMenuItem<MenuItem>(
                  value: item,
                  child: MenuItems.buildItem(item),
                ),
              ),
              const DropdownMenuItem<Divider>(enabled: false, child: Divider()),
              
            ],
            onChanged: (value) {
              MenuItems.onChanged(context, value! as MenuItem);
              submitRequest();

            },
            dropdownStyleData: DropdownStyleData(
              width: 160,
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.redAccent,
              ),
              offset: const Offset(0, 8),
            ),
            menuItemStyleData: MenuItemStyleData(
              customHeights: [
                ...List<double>.filled(MenuItems.firstItems.length, 48),
                8,
              ],
              padding: const EdgeInsets.only(left: 16, right: 16),
            ),
          ),
       
    );
  }
}

class MenuItem {
  const MenuItem({
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData icon;
}

abstract class MenuItems {
  static const List<MenuItem> firstItems = [pdf, share];

  static const pdf = MenuItem(text: 'PDF', icon: Icons.print);
  static const share = MenuItem(text: 'EXCEL', icon: Icons.share);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.white, size: 22),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            item.text,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
  

  static void onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.pdf:
      print(context);
    format = 'PDF';
                break;
      case MenuItems.share:
      format = 'excel';
        //Do something
        break;
    }
    
  }
  
}