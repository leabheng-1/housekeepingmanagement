import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/widget/app_color.dart';
import 'package:housekeepingmanagement/widget/color_extensions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
bool loading = false;
class ApiResponse {
  final bool success;
  final Map<String, dynamic> data;
  final String message;

  ApiResponse(
      {required this.success, required this.data, required this.message});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      success: json['success'],
      data: json['data'],
      message: json['message'],
    );
  }
}

class GuestChart extends StatefulWidget {
  GuestChart({super.key});

  List<Color> get availableColors => const <Color>[
        AppColors.contentColorPurple,
        AppColors.contentColorYellow,
        AppColors.contentColorBlue,
        AppColors.contentColorOrange,
        AppColors.contentColorPink,
        AppColors.contentColorRed,
      ];

  final Color barBackgroundColor =
      const Color.fromARGB(255, 255, 255, 255).darken().withOpacity(0.3);
  final Color barColor = AppColors.contentColorWhite;
  final Color touchedBarColor = AppColors.contentColorGreen;

  @override
  State<StatefulWidget> createState() => GuestChartState();
}

class GuestChartState extends State<GuestChart> {
  ApiResponse? globalApiResponse;

  @override
  void initState() {
    loading = true;
    super.initState();
    fetchDataAndSetGlobal();
  }

  Future<void> fetchDataAndSetGlobal() async {
    final apiUrl = Uri.parse('http://localhost:8000/api/dashboard/guest_today');

    try {
      final response = await http.get(apiUrl);
        
      if (response.statusCode == 200) {
        loading = false;
        final jsonData = json.decode(response.body);
        setState(() {
          globalApiResponse = ApiResponse.fromJson(jsonData);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {}
  }

  final Duration animDuration = const Duration(milliseconds: 250);
  int touchedIndex = -1;
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return loading
          ? Align(
  alignment: Alignment.center,
  child: CircularProgressIndicator(),
)
: SizedBox(
      width: 350,
      height: 250,
      child: AspectRatio(
        aspectRatio: 1,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'GUESTS',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            'This Week',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.legend_toggle,
                            size: 40,
                            color: Colors.white,
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 38,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: BarChart(
                        mainBarData(),
                        swapAnimationDuration: animDuration,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color? barColor,
    double width = 25,
    List<int> showTooltips = const [],
  }) {
    barColor ??= widget.barColor;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched ? widget.touchedBarColor : barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(color: widget.touchedBarColor.darken(80))
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 20,
            color: widget.barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups(Map<String, dynamic> data) {
    return List.generate(7, (i) {
      switch (i) {
        case 0:
          return makeGroupData(0, data['Monday'] ?? 0,
              isTouched: i == touchedIndex);
        case 1:
          return makeGroupData(1, data['Tuesday'] ?? 0,
              isTouched: i == touchedIndex);
        case 2:
          return makeGroupData(2, data['Wednesday'] ?? 0,
              isTouched: i == touchedIndex);
        case 3:
          return makeGroupData(3, data['Thursday'] ?? 0,
              isTouched: i == touchedIndex);
        case 4:
          return makeGroupData(4, data['Friday'] ?? 0,
              isTouched: i == touchedIndex);
        case 5:
          return makeGroupData(5, data['Saturday'] ?? 0,
              isTouched: i == touchedIndex);
        case 6:
          return makeGroupData(6, data['Sunday'] ?? 0,
              isTouched: i == touchedIndex);
        default:
          throw Error();
      }
    });
  }

  BarChartData mainBarData() {
    final data = globalApiResponse!.data;
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.blueGrey,
          tooltipHorizontalAlignment: FLHorizontalAlignment.right,
          tooltipMargin: -10,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String weekDay;
            switch (group.x) {
              case 0:
                weekDay = 'Monday';
                break;
              case 1:
                weekDay = 'Tuesday';
                break;
              case 2:
                weekDay = 'Wednesday';
                break;
              case 3:
                weekDay = 'Thursday';
                break;
              case 4:
                weekDay = 'Friday';
                break;
              case 5:
                weekDay = 'Saturday';
                break;
              case 6:
                weekDay = 'Sunday';
                break;
              default:
                throw Error();
            }
            return BarTooltipItem(
              '$weekDay\n',
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: (rod.toY - 1).toString(),
                  style: TextStyle(
                    color: widget.touchedBarColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(data),
      gridData: const FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('M', style: style);
        break;
      case 1:
        text = const Text('T', style: style);
        break;
      case 2:
        text = const Text('W', style: style);
        break;
      case 3:
        text = const Text('T', style: style);
        break;
      case 4:
        text = const Text('F', style: style);
        break;
      case 5:
        text = const Text('S', style: style);
        break;
      case 6:
        text = const Text('S', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(
      animDuration + const Duration(milliseconds: 50),
    );
    if (isPlaying) {
      await refreshState();
    }
  }
}
