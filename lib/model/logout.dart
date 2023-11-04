import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:universal_html/html.dart' as html;
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> clearLocalStorage() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}
String format = '';
class logoutBtn extends StatefulWidget {


  @override
  State<logoutBtn> createState() => _logoutBtnState();
}

class _logoutBtnState extends State<logoutBtn> {
Future<void> submitRequest() async  {
  
  }
  
  @override
  Widget build(BuildContext context) {
      VoidCallback? action;
    return  DropdownButtonHideUnderline(
          child: DropdownButton2(
            customButton: TextButton(
  onPressed:action,
  child: Row(
    children: [
     
      Icon(
        Icons.keyboard_arrow_down,
        color: Colors.grey[500],
      ),
    ],
  ),
)
,

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
                color: const Color.fromARGB(255, 255, 255, 255),
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
  static const List<MenuItem> firstItems = [logout, share];

  static const logout = MenuItem(text: 'Logout', icon: Icons.logout);
  static const share = MenuItem(text: 'EXCEL', icon: Icons.share);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Color.fromARGB(255, 255, 0, 0), size: 22),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            item.text,
            style: const TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ),
      ],
    );
  }

  static void onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.logout:
        AwesomeDialog(
          width: 650,
                      context: context,
                      keyboardAware: true,
                      dismissOnBackKeyPress: false,
                      dialogType: DialogType.warning,
                      animType: AnimType.bottomSlide,
                      btnCancelText: "NO",
                      btnOkText: "YES",
                      title: 'DO YOU WANT TO LOGOUT',
                      // padding: const EdgeInsets.all(5.0),
                      desc:
                          'You will be logged out of your account and returned to the login page.',
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {
                                clearLocalStorage();
 html.window.location.reload();
                      },
                    ).show();
                break;
      case MenuItems.share:
      
        break;
    }
  }
  
}