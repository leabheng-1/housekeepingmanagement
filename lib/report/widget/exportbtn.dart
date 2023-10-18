
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/system_widget/btn.dart';
import 'package:url_launcher/url_launcher.dart';
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
  }
  
  @override
  Widget build(BuildContext context) {
    return  DropdownButtonHideUnderline(
          child: DropdownButton2(
            customButton: BtnAction(
    icon: Icons.star,
    textColor: Colors.white,
    color: Colors.blue,
    label: "Export", background: Colors.white,
  ),
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
        print('object');
        format = 'PDF';
                break;
      case MenuItems.share:
      format = 'excel';
        //Do something
        break;
    }
  }
  
}