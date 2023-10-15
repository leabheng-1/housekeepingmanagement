import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:housekeepingmanagement/dashboard/report.dart';
import 'package:housekeepingmanagement/report/data/DataModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class chart_bar_report extends StatefulWidget {
  @override
  State<chart_bar_report> createState() => _ReportState();
}

class _ReportState extends State<chart_bar_report> {
  List<DataModel> _list = List<DataModel>.empty(growable: true);
Future<void> fetchMonthlyChargeData() async {
  try {
    final response = await http.get(Uri.parse("http://127.0.0.1:8000/api/report/monthlyCharge"));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      // Extract the "data" list from the JSON
      List<dynamic> dataList = jsonData['data'];

      // Clear the existing data in _list
      _list.clear();

      // Iterate through the JSON data and add it to _list with index
      for (int i = 0; i < dataList.length; i++) {
        
        _list.add(DataModel(
         
          key: i.toString(),
          value: dataList[i]['total_charge'].toString(),
          
        ));
         print(dataList[i]['total_charge'].toString());
      }

      setState(() {}); // Update the UI with the fetched data
    } else {
      // Handle the case where the request was not successful
      print("Failed to fetch data. Status code: ${response.statusCode}");
    }
  } catch (e) {
    // Handle any exceptions
    print("Error: $e");
  }
}

  @override
  void initState() {
    super.initState();
    fetchMonthlyChargeData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: Container(
            color: Colors.white,
            height: 400,
            width: 200,
          ),
          flex: 2),
          Expanded(child: Container(
            color: Colors.white,
            height: 100,
            width: 200,
            child: BarChart(
              BarChartData(
                backgroundColor: Colors.white,
                barGroups: _chartGroups(),
                borderData: FlBorderData(
                    border: const Border(bottom: BorderSide(), left: BorderSide())),
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(sideTitles: _bottomTitles),
                  leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval:1000,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toString(),
                            style: const TextStyle(fontSize:10),
                          );
                        },
                      )),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
              ),
            ),
          ),
          flex: 3),
        ],
      ),
    );
  }

  List<BarChartGroupData> _chartGroups() {
    
    List<BarChartGroupData> list =
        List<BarChartGroupData>.empty(growable: true);
    for (int i = 0; i < _list.length; i++) {
      list.add(BarChartGroupData(x: i, barRods: [
        BarChartRodData(
          width: 40,
          borderRadius: BorderRadius.all(Radius.circular(0)),
            toY: double.parse(_list[i].value!), color: Colors.deepOrange)
      ]));
    }
    return list;
  }

  SideTitles get _bottomTitles => SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          String text = '';
          switch (value.toInt()) {
            case 0:
              text = 'Mon';
              break;
            case 1:
              text = 'Tue';
              break;
            case 2:
              text = 'Wed';
              break;
            case 3:
              text = 'Thu';
              break;
            case 4:
              text = 'Fri';
              break;
            case 5:
              text = 'Sat';
              break;
            case 6:
              text = 'Sun';
              break;
            case 7:
              text = 'Sun';
              break;
            case 8:
              text = 'Sun';
              break;
            case 9:
              text = 'Sun';
              break;
            case 10:
              text = 'Sun';
              break;
            case 11:
              text = 'Sun';
              break;          
          }

          return Text(
            text,
            style: TextStyle(fontSize: 16),
          );
        },
      );
}
