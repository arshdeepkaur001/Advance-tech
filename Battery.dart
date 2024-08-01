import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:syncfusion_flutter_charts/charts.dart';

class Battery extends StatefulWidget {
  final String deviceId;

  const Battery({super.key, required this.deviceId});

  @override
  State<Battery> createState() => _MyHomePageState();
}

List<apiData> chartData = [];

class _MyHomePageState extends State<Battery> {
  late DateTime _startDate;
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now();
  late DateTime _endDate;
  List<dynamic> data = [];
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _startDate = DateTime.parse(DateTime.now().toString());
    _endDate = DateTime.parse(DateTime.now().toString());
  }

  Future<void> getAPIData(String deviceId, DateTime _startDate,
      TimeOfDay _startTime, DateTime _endDate, TimeOfDay _endTime) async {
    final response = await http.get(Uri.https(
      'API',
      '/default/battery_percentage_1',
      {
        'deviceid': deviceId,
        'start_timestamp': _startDate.day.toString() +
            "-" +
            _startDate.month.toString() +
            "-" +
            _startDate.year.toString() +
            "_" +
            _startTime.hour.toString() +
            "-" +
            _startTime.minute.toString(),
        'end_timestamp': _endDate.day.toString() +
            "-" +
            _endDate.month.toString() +
            "-" +
            _endDate.year.toString() +
            "_" +
            _endTime.hour.toString() +
            "-" +
            _endTime.minute.toString(),
      },
    ));

    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (dynamic i in data) {
        chartData.add(apiData.fromJson(i));
      }
      setState(() {});
    } else if (response.statusCode == 400 ||
        response.statusCode == 404 ||
        response.statusCode == 500) {
      setState(() {
        errorMessage = data['message'];
      });
    } else {
      throw Exception('Failed to load api');
    }
  }

  void updateData() async {
    await getAPIData(
        widget.deviceId, _startDate, _startTime, _endDate, _endTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Time Series graph for Battery Percentage for ' + widget.deviceId,
          style: TextStyle(
            fontSize: 20.0,
            letterSpacing: 1.0,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 123, 156, 125),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        onTap: () async {
                          final DateTime? selectedDate = await showDatePicker(
                            context: context,
                            initialDate: _startDate ?? DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                    primary: Color.fromARGB(255, 123, 156, 125),
                                    onPrimary: Colors.white,
                                    onSurface: Colors.purple,
                                  ),
                                  textButtonTheme: TextButtonThemeData(
                                    style: TextButton.styleFrom(
                                      elevation: 10,
                                      backgroundColor:
                                          Colors.black, // button text color
                                    ),
                                  ),
                                ),
                                // child: child!,
                                child: MediaQuery(
                                  data: MediaQuery.of(context)
                                      .copyWith(alwaysUse24HourFormat: true),
                                  child: child ?? Container(),
                                ),
                              );
                            },
                          );
                          if (selectedDate != null) {
                            setState(() {
                              _startDate = selectedDate;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Start Date',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                        ),
                        controller: TextEditingController(
                            text: _startDate != null
                                ? DateFormat('dd-MM-yyyy').format(_startDate)
                                : ''),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        onTap: () async {
                          final TimeOfDay? selectedTime = await showTimePicker(
                            context: context,
                            initialTime: _startTime,
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                    primary: Color.fromARGB(255, 123, 156, 125),
                                    onPrimary: Colors.white,
                                    onSurface: Colors.purple,
                                  ),
                                  textButtonTheme: TextButtonThemeData(
                                    style: TextButton.styleFrom(
                                      elevation: 10,
                                      backgroundColor: Colors.black,
                                    ),
                                  ),
                                ),
                                child: MediaQuery(
                                  data: MediaQuery.of(context)
                                      .copyWith(alwaysUse24HourFormat: true),
                                  child: child ?? Container(),
                                ),
                              );
                            },
                          );
                          if (selectedTime != null) {
                            setState(() {
                              _startTime = selectedTime;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Start Time',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                        ),
                        controller: TextEditingController(
                            text: _startTime != null
                                ? '${_startTime.format(context)}'
                                : ''),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: TextFormField(
                        onTap: () async {
                          final DateTime? selectedDate = await showDatePicker(
                            context: context,
                            initialDate: _endDate ?? DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                    primary: Color.fromARGB(255, 123, 156, 125),
                                    onPrimary: Colors.white,
                                    onSurface: Colors.purple,
                                  ),
                                  textButtonTheme: TextButtonThemeData(
                                    style: TextButton.styleFrom(
                                      elevation: 10,
                                      backgroundColor: Colors.black,
                                    ),
                                  ),
                                ),
                                child: MediaQuery(
                                  data: MediaQuery.of(context)
                                      .copyWith(alwaysUse24HourFormat: true),
                                  child: child ?? Container(),
                                ),
                              );
                            },
                          );
                          if (selectedDate != null) {
                            setState(() {
                              _endDate = selectedDate;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'End Date',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                        ),
                        controller: TextEditingController(
                            text: _endDate != null
                                ? DateFormat('dd-MM-yyyy').format(_endDate)
                                : ''),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        onTap: () async {
                          final TimeOfDay? selectedTime = await showTimePicker(
                            context: context,
                            initialTime: _endTime ?? TimeOfDay.now(),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                    primary: Color.fromARGB(255, 123, 156, 125),
                                    onPrimary: Colors.white,
                                    onSurface: Colors.purple,
                                  ),
                                  textButtonTheme: TextButtonThemeData(
                                    style: TextButton.styleFrom(
                                      elevation: 10,
                                      backgroundColor: Colors.black,
                                    ),
                                  ),
                                ),
                                child: MediaQuery(
                                  data: MediaQuery.of(context)
                                      .copyWith(alwaysUse24HourFormat: true),
                                  child: child ?? Container(),
                                ),
                              );
                            },
                          );
                          if (selectedTime != null) {
                            setState(() {
                              _endTime = selectedTime;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'End Time',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                        ),
                        controller: TextEditingController(
                            text: _startTime != null
                                ? '${_endTime.format(context)}'
                                : ''),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        updateData();
                      },
                      child: Text(
                        'Get Data',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 123, 156, 125),
                        minimumSize: Size(80, 0),
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32.0),
                if (errorMessage.isNotEmpty)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        height: 400,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            errorMessage,
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            semanticsLabel: errorMessage = "",
                          ),
                        ),
                      ),
                    ),
                  )
                else
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 400,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                blurRadius: 5.0,
                                spreadRadius: 1.0,
                                offset: Offset(0.0, 0.0),
                              ),
                            ],
                          ),
                          child: SfCartesianChart(
                            plotAreaBackgroundColor: Colors.white,
                            primaryXAxis: CategoryAxis(
                              title: AxisTitle(
                                text: 'Time',
                                textStyle:
                                    TextStyle(fontWeight: FontWeight.bold),
                              ),
                              labelRotation: 45,
                            ),
                            primaryYAxis: NumericAxis(
                              title: AxisTitle(
                                text: 'Battery(%)',
                                textStyle:
                                    TextStyle(fontWeight: FontWeight.bold),
                              ),
                              axisLine: AxisLine(width: 0),
                              majorGridLines: MajorGridLines(width: 0.5),
                            ),
                            tooltipBehavior: TooltipBehavior(
                              enable: true,
                              color: Colors.white,

                              builder: (dynamic data,
                                  dynamic point,
                                  dynamic series,
                                  int pointIndex,
                                  int seriesIndex) {
                                final apiData item = chartData[pointIndex];
                                return Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 245, 214, 250),
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.purple, blurRadius: 3)
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("TimeStamp: ${item.TimeStamp}"),
                                      Text(
                                          "BatteryPercentage: ${item.battery_percentage}"),
                                      // Text("Class: ${item.Class}"),
                                    ],
                                  ),
                                );
                              },
                              // customize the tooltip color
                            ),
                            title: ChartTitle(
                              text: 'Battery Percentage Graph',
                              textStyle: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            series: <ChartSeries<apiData, String>>[
                              LineSeries<apiData, String>(
                                markerSettings: const MarkerSettings(
                                  height: 3.0,
                                  width: 3.0,
                                  borderColor:
                                      Color.fromARGB(255, 123, 156, 125),
                                  isVisible: true,
                                ),
                                dataSource: chartData,
                                xValueMapper: (apiData sales, _) =>
                                    sales.TimeStamp,
                                yValueMapper: (apiData sales, _) =>
                                    double.parse(sales.battery_percentage),
                                dataLabelSettings:
                                    DataLabelSettings(isVisible: false),
                                enableTooltip: true,
                                animationDuration: 0,
                              )
                            ],
                            zoomPanBehavior: ZoomPanBehavior(
                              enablePinching: true,
                              enablePanning: true,
                              enableDoubleTapZooming: true,
                              enableMouseWheelZooming: true,
                              enableSelectionZooming: true,
                              selectionRectBorderWidth: 1.0,
                              selectionRectBorderColor: Colors.blue,
                              selectionRectColor:
                                  Colors.transparent.withOpacity(0.3),
                              zoomMode: ZoomMode.x,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class apiData {
  apiData(this.TimeStamp, this.battery_percentage);

  final String TimeStamp;
  final String battery_percentage;

  factory apiData.fromJson(dynamic parsedJson) {
    return apiData(
      parsedJson['TimeStamp'].toString(),
      parsedJson['battery_percentage'].toString(),
    );
  }
}
