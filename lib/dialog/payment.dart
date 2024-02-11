import 'dart:html';

import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/frontdesk/widget/Empty.dart';
import 'package:housekeepingmanagement/frontdesk/widget/formatSystem.dart';
import 'package:housekeepingmanagement/system_widget/btn.dart';
import 'package:housekeepingmanagement/widget/inputbox.dart';
import 'package:housekeepingmanagement/widget/legend.dart';
import 'package:housekeepingmanagement/system_widget/system_icon.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class paymentdialogpage extends StatefulWidget {
  final Function(String Items, bool isChecked , String ItemExtra) onDialogClosed;
  final String payment_id ;
  final bool is_view;
  paymentdialogpage({required this.onDialogClosed ,  this.payment_id = '' , this.is_view = false  });

  @override
  _paymentdialogpageState createState() => _paymentdialogpageState();
}

class _paymentdialogpageState extends State<paymentdialogpage> {
  Map<String, dynamic> bookingsData = {};
    List<Map<String, dynamic>> listitem = [];
  bool isLoading = true;
  Future<void> fetchData() async {
    final response = await http
        .get(Uri.parse('http://localhost:8000/api/payment/all/${widget.payment_id}'));

    if (response.statusCode == 200) {
    isLoading = false;
      Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        bookingsData = data['data'];
        print(bookingsData);
       


  List<String> itemStrings = data['data']['item_extra_charge'].toString().split(', ');
  for (var itemString in itemStrings) {
    List<String> parts = itemString.toString().split(' = ');
    if (parts.length == 2) {
      List<String> finalParts = parts[1].toString().split(' | ');
      String name = parts[0].toString();
      double price = double.tryParse(finalParts[0].toString()) ?? 0.0;
      double total = double.tryParse(finalParts[1].toString()) ?? 0.0;
      listitem.add({"name": name.toString(),"qty" : total ,"price": price   });
    }
  }
  print(listitem);


      });
    } else {
      throw Exception('Failed to load data');
    }
  }
    @override
  void initState() {
    super.initState();
    fetchData();
    if (widget.is_view) {
        isLoading = true;
    }else{
        isLoading = false;
    }
   
  }

  Key dropdownKey = UniqueKey();
  TextEditingController textController = TextEditingController();
  bool isChecked = false;
List<Map<String, dynamic>> items = [
  {'name': 'Fanta', 'price': 0.75},
  {'name': 'Sprite', 'price': 0.75},
  {'name': 'Pepsi', 'price': 0.75},
  {'name': 'Coca-Cola', 'price': 0.75},
  {'name': 'Samurai', 'price': 0.75},
  {'name': 'Pure Water', 'price': 0.30},
  // Add more items as needed
];
  int _value = 1;

  void _increment() {
    setState(() {
      _value = _value + 1;
   
    });
 
  }

  void _decrement() {
    setState(() {
      if (_value > 1) {
        _value = _value - 1;
       
      }
      
    });
  
  }
String concatenateNames(List<Map<String, dynamic>> items) {
  List<String> itemStrings = items.map((item) {
    String name = item["name"].toString();
    String price = item["price"].toString();
     String qty = item["qty"].toString();
    return '$name = $price | $qty';
  }).toList();

  return itemStrings.join(', ').toString();
}
double calculateTotalPrice(List<Map<String, dynamic>> items) {
  double totalPrice = 0.0;

  for (var item in items) {
    if (item.containsKey("price")) {
      totalPrice +=  double.parse(item["price"].toString()) * double.parse(item["qty"].toString()) ;
    }
  }

  return totalPrice;
}
Future<void> editItem(int index) async {
    // Create a TextEditingController for each field to be edited
    TextEditingController nameController =
        TextEditingController(text: listitem[index]['name']);
    TextEditingController priceController =
        TextEditingController(text: listitem[index]['price'].toString());
TextEditingController qtyController = TextEditingController(text: listitem[index]['qty'].toString());
TextEditingController totalAllController = TextEditingController(text:(double.parse(listitem[index]['qty'].toString()) * double.parse(listitem[index]['price'].toString()) ).toString() );
    await showDialog(
      context: context,
      
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Item Extra Charge'),
          content: Container(
            height: 100,
            
            child: Row(
              children:[
                 CustomTextField(
                      width: 510/3,
                      controller: nameController,
                      labelText: 'Item Extra Charge',
                    ),
                     SizedBox(width: 15,),
                   CustomTextField(
                      width: 510/3,
                      controller: qtyController,
                      labelText: 'qty',
                      onChanged: (value) {
                      totalAllController.text = (double.parse(value) * double.parse(priceController.text)).toString();
                      },
                    ),
                    SizedBox(width: 15,),
                     CustomTextField(
                      width: 510/3,
                      controller: priceController,
                      labelText: 'Price',
                      onChanged: (value) {
                            totalAllController.text = (double.parse(value) * double.parse(qtyController.text)).toString();
                      },
                    ),
                      SizedBox(width: 15,),
                     CustomTextField(
                      width: 510/3,
                      enabled: false,
                      controller: totalAllController,
                      labelText: 'Total',
                    ),
                    
             
              ]
              
            )
          ),
          actions: [
                   BtnAction(
   background: Color.fromARGB(52, 0, 0, 0),
  icon: iconController.closeIcon,
  textColor: Colors.white,
  color: Colors.red,
  label: "Cancel",
  action: () {
   
       Navigator.of(context).pop();
  },
),        BtnAction(
   background: Color.fromARGB(52, 0, 0, 0),
  icon: iconController.saveIcon,
  textColor: Colors.white,
  color: Color.fromARGB(255, 54, 63, 244),
  label: "Update",
  action: () {
 setState(() {
 
                  listitem[index]['name'] = nameController.text;
                  listitem[index]['price'] = double.parse(priceController.text).toString();
                  listitem[index]['qty'] = double.parse(qtyController.text).toString();
  
              
 });
                Navigator.of(context).pop(); // Close the dialog
  },
),

          ],
        );
      },
    );
  }

 Map<String, dynamic>  newItem = {};

// List<Map<String, dynamic>> listitem = listitem ?? [];

String valueName = '';
double getPrice(String itemName) {
  var item = items.firstWhere(
    (element) => element['name'] == itemName,
    orElse: () => {'price': null}, // Provide a default value or action
  );
  return item['price'];
}
double getqty(String itemName) {
  var item = items.firstWhere(
    (element) => element['name'] == itemName,
    orElse: () => {'qty': 1}, // Provide a default value or action
  );
  return item['qty'] ?? '1';
}
  void removeItem(int index) {
    setState(() {
      listitem.removeAt(index);
    });
  }
double priceItem = 0;
TextEditingController priceItemController = TextEditingController();
TextEditingController ItemController = TextEditingController();
TextEditingController qtyItemController = TextEditingController(text: '1');
TextEditingController totalController = TextEditingController();
// Extracting names using map







  @override
  Widget build(BuildContext context) {
    List<String> itemNames = items.map((item) => item['name'].toString()).toList();
    return AlertDialog(
      title: Text('Extra Charge'),
      content:
       Container(
  margin: EdgeInsets.only(top: 20),
  child:
       Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Expanded(
            
            child:buildLabelAndContent('Extra Charge Information', [
              Container(
                height: 700,
                child: 
               (isLoading) 
          ? 
          Container(
            width: 800,
            child: Center(
              child: CircularProgressIndicator(),
            ) ,
          )
         
          :
                Column(
                  children: [

                
               widget.is_view ? Row() : Row(
                children: [
                  CustomDropdownButton(
                       key: dropdownKey,
            width: 400,
            labelText: 'Item Extra Charge',
            items: itemNames,
            selectedValue:ItemController.text ,
            hintText: 'Item Extra Charge',
            onChanged: (value) {
              valueName = value!;
                ItemController.text = value!;
                priceItemController.text =  getPrice(value).toString();
                totalController.text = (getPrice(value) * double.parse(qtyItemController.text)).toString();
                 qtyItemController.text = qtyItemController.text;

                    newItem = {'name': value, 'price': priceItemController.text.replaceAll('\$', '') , 'qty' :  qtyItemController.text  };
            },
          ),
          SizedBox(
            width: 15,
          ),
          CustomTextField(
          width: 100,
          controller: qtyItemController,
          labelText: 'QTY',
          onChanged: (text) {
            totalController.text = (getPrice(valueName) * double.parse(qtyItemController.text)).toString();
             newItem = {'name': valueName, 'price': getPrice(valueName).toString()  , 'qty' : text  };
          },
        ),
         SizedBox(
            width: 15,
          ),
          Stack(
      children: [
        CustomTextField(
          width: 200,
          controller: priceItemController,
          labelText: 'Price',
          enabled: isChecked,
          isCurrency: true,
          onChanged: (text) {
           totalController.text = (double.parse(text.replaceAll('\$', '')) * double.parse(qtyItemController.text)).toString();
             newItem = {'name': valueName, 'price': text  , 'qty' : qtyItemController.text   };
          },
        ),
        
        Positioned(
          right: 5,
          top: 15,
          child: Container(
            margin: EdgeInsets.only(top: 16.0),
            padding: EdgeInsets.only(left: 10),
            child: Checkbox(
              value: isChecked,
              onChanged: (value) {
          
                setState(() {
                  isChecked = value ?? false;
                });
              },
            ),
          ),
        ),
       
        
      ],
    ),
     SizedBox(
            width: 15,
          ),
     CustomTextField(
          width: 200,
          controller: totalController,
          labelText: 'Total',
          enabled: false,
          isCurrency: true,
          onChanged: (text) {
           
          },
        ),
    SizedBox(width: 15,),
    Container(
  margin: EdgeInsets.only(top: 25.0), // Set the top margin
  child: BtnAction(
   background: Color.fromARGB(52, 0, 0, 0),
  icon: iconController.addIcon,
  textColor: Colors.white,
  color: Color.fromARGB(255, 54, 130, 244),
  label: "Add Item",
  action: () {
      setState(() {
listitem.add(newItem);
priceItemController.text = '';
ItemController.text = ''; 
qtyItemController.text = '1';
totalController.text = '';
  dropdownKey = UniqueKey();
      });
  },
) , // Replace YourWidget with the actual widget you want to include in the Container
)
    
                ],
              ),
              SizedBox(
                height: 8,
              ),
      Row(
        children: [
 Container(
  width: 985,
  height: 1,
      decoration: BoxDecoration(
        color: Color.fromARGB(118, 0, 0, 0), // Set background color
        borderRadius: BorderRadius.circular(10.0), // Set border radius
      ),
      padding: EdgeInsets.all(16.0), // Set padding
      ),
        

        ],
      )      ,  
             
 Column(
  children: [
   SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: listitem.length <= 0 ? EmptyStateWidget() : DataTable(
               columnSpacing: 175,
       headingRowColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            // Set the background color based on the MaterialState
            if (states.contains(MaterialState.hovered)) {
              return Color.fromARGB(119, 234, 234, 234); // Color when hovered
            }
            return Color.fromARGB(119, 234, 234, 234); // Default color
          },
        ),
        columns: [
          DataColumn(label: Text('Name')),
          DataColumn(label: Text('QTY')),
          DataColumn(label: Text('Price')),
          DataColumn(label: Text('Total')),
          DataColumn(label: Text('Action')),
        ],
        rows: listitem.asMap().entries.map(
          (entry) {
            final index = entry.key;
            final item = entry.value;

            return  DataRow(
              cells: [
                DataCell(Text(item['name'])),
                 DataCell(Text(item['qty'].toString())),
                DataCell(Text('\$${item['price'].toString()}')),
                DataCell(Text('\$${ ( double.parse(item['price'].toString()) * double.parse(item['qty'].toString()) ).toString()  }')),
                DataCell(
                  Row(
                    children: [ 
                   Container(
                    width: 35,
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    color: Colors.blue, // Set your desired background color
  ),
  child: IconButton(
    icon: Icon(Icons.edit, color: Colors.white , size: 15,), // Set your desired icon color
    onPressed: () => editItem(index),
  ),
),
SizedBox(width: 10,),
  Container(
                    width: 35,
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    color: Color.fromARGB(255, 255, 62, 62), // Set your desired background color
  ),
  child: IconButton(
    icon: Icon(Icons.delete, color: Colors.white , size: 15,), // Set your desired icon color
    onPressed: () => removeItem(index),
  ),
)


                  ],
                  )
                 
                  
                ),
              ],
            );
          },
        ).toList(),
      ),
    ),
    SizedBox(height:15,),
 Container(
  height: 50,
  decoration: BoxDecoration(
    color: Color.fromARGB(121, 171, 171, 171), // Set the background color to red
    borderRadius: BorderRadius.circular(10.0), // Set the border radius to 10.0
  ),
  child: Row(
    children: [
      Expanded(
        child: Container(
          margin: EdgeInsets.only(right: 20.0),
          child: Text(
            'Total :  ${ formatCurrency(calculateTotalPrice(listitem).toString()) }',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    ],
  ),
)



  ],
 )
,
 
      ],
                )          )  ,            ], () {
               
            }
        
            )
            
           )
           
           ,
        ],
        
      ),
  
       ), 
      actions: <Widget>[
        BtnAction(
   background: Color.fromARGB(52, 0, 0, 0),
  icon: iconController.closeIcon,
  textColor: Colors.white,
  color: Colors.red,
  label: "Cancel",
  action: () {
   
       Navigator.of(context).pop();
  },
),  
widget.is_view ? Row() :
      BtnAction(
   background: Color.fromARGB(52, 0, 0, 0),
  icon: iconController.saveIcon,
  textColor: Colors.white,
  color: Color.fromARGB(255, 54, 63, 244),
  label: "Update",
  action: () {
 setState(() {
  Future.delayed(const Duration(milliseconds: 500), () {
         widget.onDialogClosed(calculateTotalPrice(listitem).toString(),true,concatenateNames(listitem).toString());
                });
 });
                Navigator.of(context).pop(); // Close the dialog
  },
),
      ],
    );
  }
}
