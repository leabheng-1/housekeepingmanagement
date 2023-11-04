import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:housekeepingmanagement/model/footer.dart';
import 'package:housekeepingmanagement/model/logout.dart';
import 'package:housekeepingmanagement/system_widget/system_icon.dart';
import 'package:housekeepingmanagement/controller/main_controller.dart';
import 'package:housekeepingmanagement/dashboard/dashboard.dart';
import 'package:housekeepingmanagement/dashboard/frontdesk.dart';
import 'package:housekeepingmanagement/dashboard/guest_in_house.dart';
import 'package:housekeepingmanagement/dashboard/house_keeping.dart';
import 'package:housekeepingmanagement/dashboard/report.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
int _selectedIndex = 0; // Initialize to a default value (0 in this case)
 bool isImageEnlarged = false; // Add this variable to manage image size

  void toggleImageSize() {
    setState(() {
      isImageEnlarged = !isImageEnlarged;
    });
  }
Future<void> getname() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? storedName = prefs.getString('name');

  if (storedName != null) {
    // Use the storedName
    print("Stored Name: $storedName");
  } else {
    // Handle the case where the "name" was not found in local storage
    print("Name not found in local storage");
  }
}

Future<void> _loadSelectedIndex() async {
  final prefs = await SharedPreferences.getInstance();
  setState(() {
    _selectedIndex = prefs.getInt('selectedIndex') ?? 0;
  });
}
  bool showNavigationBar = false;
  late List<Widget> list = [
    Dashboard(),
    FrontDesk(),
    Housekeeping(),
    GuestInHouse(),
    Report()
  ];
  final List<String> _destinations = [
    'DashBoard',
    'Front Desk',
    'Housekeeping',
    'Guest In House',
    'Report'
  ];
    
final MainController controller = Get.put(MainController());

  Widget _buildNavigationRail() {
      
    return Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.only(  // Top-left corner radius
      topRight: Radius.circular(20.0), 
      bottomRight: Radius.circular(20.0), // Bottom-right corner radius
      
    ),
    color: Colors.white
  ),
  child: NavigationRail(
    backgroundColor: Colors.transparent,
    minWidth:60,
  
    extended: controller.isExpanded.value,
    labelType: NavigationRailLabelType.none,
    selectedIndex: _selectedIndex,
    leading: Column(
      children: [
        
    CircleAvatar(
  radius: isImageEnlarged ? 50 : 20,
  backgroundImage: AssetImage("assets/images/logo.jpg"),
),
 SizedBox(height: 50,),
    ],),
    onDestinationSelected: (int index) async {
      final prefs = await SharedPreferences.getInstance();
      getname();
      setState(() {
        _selectedIndex = index; // Update the selected index
      });
      // Save the selected index to local storage
      prefs.setInt('selectedIndex', _selectedIndex);
    },
     
    destinations: const <NavigationRailDestination>[
      NavigationRailDestination(
        icon: Icon(Icons.grid_view),
        selectedIcon: Icon(Icons.grid_view),
        label: Text('Dashboard'),
      ),
      NavigationRailDestination(
        icon:ImageIcon(AssetImage('assets/images/front-desk.jpg')),
      
        selectedIcon: ImageIcon(AssetImage('assets/images/front-desk-active.png')),
        label: Text('FrontDesk'),
      ),
      NavigationRailDestination(
        icon:ImageIcon(AssetImage('assets/images/housekeeping.png')),
        selectedIcon: ImageIcon(AssetImage('assets/images/housekeeping-active.png')),
        label: Text(" Housekeeping"),
        
      ),
      NavigationRailDestination(
        icon:ImageIcon(AssetImage('assets/images/guestinhouse.png')),
        selectedIcon: ImageIcon(AssetImage('assets/images/guestinhouse-active.png')),
        label: Text(" Guest In-House"),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.assessment_outlined),
        selectedIcon: Icon(Icons.assessment_outlined),
        label: Text("Report"),
      ),
    ],

  
  ),
  
);


  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.grey[300],
        body: 
        Row(
          children: [
            Row(
              children: [
                _buildNavigationRail(),
              ],
            ),
           
            Expanded(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 15, right: 15),
                    child: Container(
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween, // Aligns children to the start and end of the row
                        children: [
                          Row(
                            children: [
                              const SizedBox(width: 10),
                              IconButton(
                                icon: const Icon(Icons.menu),
                                onPressed: () {
                                  controller
                                      .isExpanded(!controller.isExpanded.value);
                                      toggleImageSize();
                                },
                              ),
                              SizedBox(
width: 20,
                              ),
                              Text(
                                _destinations[_selectedIndex],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.account_circle_outlined,
                                  size: 40,
                                  color: Colors.grey[600],
                                ),
                                logoutBtn(),
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Admin",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Receptionist",
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: list[_selectedIndex],
                  ),
                  Container(
  margin: EdgeInsets.only(left:5,right:5),
  alignment: Alignment.bottomCenter,
  padding:EdgeInsets.all(15),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(30.0),
      topRight: Radius.circular(30.0),
    ),
  ),
  child:footer()
  
   
)

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
