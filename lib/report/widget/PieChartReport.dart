
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/report/widget/indicator.dart';
import 'package:housekeepingmanagement/widget/app_color.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PieChartreport extends StatefulWidget {
  const PieChartreport({super.key});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}


class PieChart2State extends State{
  bool success = false;
  int singleRoom = 0;
  int twinRoom = 0;
  int noShow = 0;
  int cancel = 0;
  int total = 0;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/report/monthlyGuestCount'));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        success = data['success'];
        if (data['data'] != null && data['data'].isNotEmpty) {
          singleRoom = data['data'][0]['guest'][0]['Single Room'];
          twinRoom = data['data'][0]['guest'][1]['Twin Room'];
          noShow = data['data'][0]['noShowCount'];
          cancel = data['data'][0]['cancelCount'];
          total = singleRoom +twinRoom+noShow+cancel;
        }
        setState(() {}); // Update the UI with the fetched data.
      } else {
        print("Failed to load data");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
 int touchedIndex = -1;
  

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 18,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 0,
                  sections: showingSections(),
                ),
              ),
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              
              Indicator(
                color: AppColors.contentColorBlue,
                text: 'Single Room',
                isSquare: false,
                
                
              ),
              SizedBox(
                width: 10,
              ),
              Indicator(
                color: AppColors.contentColorYellow,
                text: 'Twin Room',
                 isSquare: false,
              ),
              SizedBox(
                width: 10,
              ),
              Indicator(
                color: AppColors.contentColorPurple,
                text: 'No Show',
                isSquare: false,
              ),
              SizedBox(
                width: 10,
              ),
              Indicator(
                color: AppColors.contentColorGreen,
                text: 'Cancel',
                isSquare: false,
              ),
              SizedBox(
                height: 18,
              ),
            ],
          ),
          const SizedBox(
            width: 28,
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 80.0 : 70.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
          
            color: Color.fromARGB(255, 28, 148, 228),
            value: ((singleRoom / total) * 100).toDouble(),
            title: ((singleRoom / total) * 100).toStringAsFixed(2) +'%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: AppColors.contentColorYellow,
            value: ((twinRoom / total) * 100).toDouble(),
            title: ((twinRoom / total) * 100).toStringAsFixed(2) +'%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: AppColors.contentColorPurple,
            value: ((noShow / total) * 100).toDouble(),
            title: ((noShow / total) * 100).toStringAsFixed(2) +'%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: AppColors.contentColorGreen,
            value: ((cancel / total) * 100).toDouble(),
            title: ((cancel / total) * 100).toStringAsFixed(2) +'%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.mainTextColor1,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }}


