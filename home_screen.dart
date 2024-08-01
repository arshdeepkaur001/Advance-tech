//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
import 'dart:convert';
import 'package:detest/Image_download.dart';
import 'package:detest/Inferenced_Data copy.dart';
import 'package:detest/country/Spain.dart';
import 'package:detest/country/UkData.dart';
import 'package:detest/country/UsaData.dart';
import 'package:detest/country/_France.dart';
import 'package:detest/country/lab.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'config_screen.dart';
import 'constant.dart';
import 'package:detest/weatherData.dart';
import 'package:detest/insectCount.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:intl/intl.dart';
import 'filteredData.dart';
import 'package:detest/Battery.dart';
import 'birdNet.dart';

class HomeScreen extends StatefulWidget {
  final String email;

  const HomeScreen({super.key, required this.email});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<String> response;
  late TextEditingController _serialId;
  late TextEditingController _securityKey;
  late TextEditingController _searchController;
  late TextEditingController dateController;
  late TextEditingController timeinput;
  late String result;
  void selectedCountry = "";
  late int sleepDuration = 0;
  bool _hovering = false;
  bool condition = false;
  @override
  void initState() {
    response = getData(widget.email);
    _serialId = TextEditingController();
    _securityKey = TextEditingController();
    dateController = TextEditingController();
    timeinput = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _serialId.dispose();
    _securityKey.dispose();
    super.dispose();
  }

  Future<void> _filter(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: const Center(
                child: Text(
              'Select a Country',
              style: TextStyle(color: buttonColor),
            )),
            content: SizedBox(
              height: 400,
              width: 400,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SpainScreen()),
                          );
                        });
                      },
                      icon: const Icon(
                        Icons.logout,
                        color: backgroundColor,
                      ),
                      label: const Text(
                        'Spain',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                          // elevation: 10,
                          backgroundColor: Color.fromARGB(164, 14, 211, 7)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => franceScreen()),
                          );
                        });
                      },
                      icon: const Icon(
                        Icons.logout,
                        color: backgroundColor,
                      ),
                      label: const Text(
                        'France',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                          // elevation: 10,
                          backgroundColor: Color.fromARGB(164, 14, 211, 7)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UK_Screen()),
                          );
                        });
                      },
                      icon: const Icon(
                        Icons.logout,
                        color: backgroundColor,
                      ),
                      label: const Text(
                        'UK',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                          // elevation: 10,
                          backgroundColor: Color.fromARGB(164, 14, 211, 7)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => USA_Screen()),
                          );
                        });
                      },
                      icon: const Icon(
                        Icons.logout,
                        color: backgroundColor,
                      ),
                      label: const Text(
                        'USA',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                          // elevation: 10,
                          backgroundColor: Color.fromARGB(164, 14, 211, 7)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LabScreen()),
                          );
                        });
                      },
                      icon: const Icon(
                        Icons.logout,
                        color: backgroundColor,
                      ),
                      label: const Text(
                        'Lab',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                          // elevation: 10,
                          backgroundColor: Color.fromARGB(164, 14, 211, 7)),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                textColor: Colors.white,
                color: Colors.red,
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ]);
      },
    );
  }

  Future RegistrationUser() async {
    var APIURL = Uri.parse("API");
    Map mapeddate = {
      'device_id': _serialId.text,
      'serial_id': _securityKey.text,
      'email': widget.email
    };
    String requestBody = jsonEncode(mapeddate);
    // print("JSON DATA: ${requestBody}");
    http.Response response = await http.post(APIURL, body: requestBody);
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(data.toString()),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      throw Exception('Failed to load api');
    }
  }

  Future<String> fetchBatteryPercentage(String deviceId) async {
    final apiUrl = Uri.parse('API=$deviceId');

    try {
      final response = await http.get(apiUrl);
      if (response.body.isNotEmpty) {
        final List<dynamic> dataList = jsonDecode(response.body);
        if (dataList.isNotEmpty) {
          final double batteryPercentage = dataList.first;
          return batteryPercentage.toString();
        } else {
          throw Exception('Battery percentage data is empty');
        }
      } else {
        throw Exception('Empty response received from the API');
      }
    } catch (e) {
      print('Error fetching battery percentage: $e');
      return '--';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: buttonColor,
        title: Row(
          children: [
            const Icon(
              Icons.dashboard,
              size: 35,
            ),
            const SizedBox(
              width: 10,
            ),
            Text('Biodiversity Sensor Console'),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(left: 2),
            padding: EdgeInsets.only(left: 30),
            child: FloatingActionButton.extended(
                heroTag: 'btn3',
                backgroundColor: buttonColor,
                onPressed: () => _filter(context),
                label: const Text('Countries')),
          ),
          // FloatingActionButton.extended(
          //     heroTag: 'btn3',
          //     backgroundColor: buttonColor,
          //     onPressed: () => _dialogBuilder(context),
          //     label: const Text('Register a new Device +')),
        ],
      ),
      body: FutureBuilder<String>(
        future: response,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == '200') {
              return ListView(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    child: Container(
                      height: 50,
                      decoration: const BoxDecoration(
                        color: buttonColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 0),
                        child: Table(
                          columnWidths: const {
                            0: FractionColumnWidth(0.07),
                            1: FractionColumnWidth(0.15),
                            2: FractionColumnWidth(0.15),
                            3: FractionColumnWidth(0.15),
                            4: FractionColumnWidth(0.15),
                            5: FractionColumnWidth(0.15),
                            6: FractionColumnWidth(0.18),
                          },
                          children: const <TableRow>[
                            TableRow(children: <Widget>[
                              Center(
                                child: Text(
                                  'S.NO',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: backgroundColor,
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  'DEVICE ID',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: backgroundColor,
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  'BOOT STATUS',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: backgroundColor,
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  'Weather Data',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: backgroundColor,
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  'Insect Count',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: backgroundColor,
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  'Image',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: backgroundColor,
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  'Battery',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: backgroundColor,
                                  ),
                                ),
                              ),
                            ]),
                          ],
                        ),
                      ),
                    ),
                  ),
                  for (int i = 0; i < deviceData.length; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      child: Container(
                        height: 50,
                        decoration: const BoxDecoration(
                          color: buttonColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 0),
                          child: Table(
                            columnWidths: const {
                              0: FractionColumnWidth(0.07),
                              1: FractionColumnWidth(0.15),
                              2: FractionColumnWidth(0.15),
                              3: FractionColumnWidth(0.15),
                              4: FractionColumnWidth(0.15),
                              5: FractionColumnWidth(0.15),
                              6: FractionColumnWidth(0.18),
                            },
                            children: [
                              TableRow(children: [
                                SizedBox(
                                  height: 40,
                                  child: Center(
                                    child: Text(
                                      '${i + 1}',
                                      style: const TextStyle(
                                          fontSize: 16, color: backgroundColor),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                  child: Center(
                                    child: Text(
                                      deviceData[i].deviceId,
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                  child: Center(
                                    child: Tooltip(
                                      message:
                                          'Last Active: ${deviceData[i].lastActive}',
                                      child: Text(
                                        deviceData[i].status,
                                        style: const TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                  child: Center(
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => Weather(
                                              deviceId: deviceData[i].deviceId,
                                            ),
                                          ),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.cloud,
                                        color: backgroundColor,
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white10,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                  child: Center(
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => Inference(
                                              deviceId: deviceData[i].deviceId,
                                            ),
                                          ),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.insert_chart,
                                        color: backgroundColor,
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white10,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                  child: Center(
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => Pictures(
                                              deviceId: deviceData[i].deviceId,
                                            ),
                                          ),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.image,
                                        color: backgroundColor,
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white10,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                  child: Center(
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => Battery(
                                              deviceId: deviceData[i].deviceId,
                                            ),
                                          ),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.battery_6_bar,
                                        color: backgroundColor,
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white10,
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              );
            }
            return Container();
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.green,
            ),
          );
        },
      ),
    );
  }
}
