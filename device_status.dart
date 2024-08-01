import 'dart:convert';
import 'package:detest/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DeviceStatus extends StatefulWidget {
  final String jobId;
  final String deviceId;
  final String deviceOnTime;
  final String deviceOffTime;
  final String timeZone;
  const DeviceStatus({
    super.key,
    required this.deviceId,
    required this.jobId,
    required this.deviceOffTime,
    required this.deviceOnTime,
    required this.timeZone,
  });

  @override
  State<DeviceStatus> createState() => _DeviceStatusState();
}

class _DeviceStatusState extends State<DeviceStatus> {
  // String isDeviceUpdated = 'waiting';
  late Future<String> deviceResponse;
  String deviceMessage = 'waiting';

  Future<String> deviceStatus() async {
    String deviceId = widget.deviceId;
    String jobId = widget.jobId;
    final response = await http.get(
      Uri.parse(
          'https://15eum5bibf.execute-api.us-east-1.amazonaws.com/jobUpdate?jobId=$jobId&deviceId=$deviceId'),
    );
    if (response.statusCode == 200) {
      setState(() {
        deviceMessage = jsonDecode(response.body);
      });
      return deviceMessage;
      // return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load api');
    }
  }

  Future<String> statusCode() async {
    int count = 0;
    String result = '';
    // print('=======count========$count');

    while (count < 3) {
      await Future<void>.delayed(const Duration(seconds: 5));
      result = await deviceStatus();
      // print('===========$result');
      if (result == 'updated') {
        break;
      }
      count++;
    }
    if (count >= 3) {
      setState(() {
        deviceMessage = 'fail';
      });
      result = deviceMessage;
    }
    return result;
  }

  @override
  void initState() {
    deviceResponse = statusCode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Device Id : ${widget.deviceId}',
            style: const TextStyle(
              fontSize: 18,
              color: buttonColor,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Time zone : ${widget.timeZone}',
            style: const TextStyle(
              fontSize: 18,
              color: buttonColor,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Device on time : ${widget.deviceOnTime}',
            style: const TextStyle(
              fontSize: 18,
              color: buttonColor,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Device off time : ${widget.deviceOffTime}',
            style: const TextStyle(
              fontSize: 18,
              color: buttonColor,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 10),
          FutureBuilder(
            future: deviceResponse,
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                if (deviceMessage == 'updated' || deviceMessage == 'fail') {
                  return Text(
                    'Device Status : $deviceMessage',
                    style: const TextStyle(
                      fontSize: 18,
                      color: buttonColor,
                      fontWeight: FontWeight.w900,
                    ),
                  );
                } else {
                  return const SizedBox(
                    width: 15,
                    height: 15,
                    child: CircularProgressIndicator(
                      color: Colors.green,
                    ),
                  );
                }
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const SizedBox(
                width: 15,
                height: 15,
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
