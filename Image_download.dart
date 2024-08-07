import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Pictures extends StatefulWidget {
  final String deviceId;
  const Pictures({super.key, required this.deviceId});
  @override
  _PicturesState createState() => _PicturesState();
}

class _PicturesState extends State<Pictures> {
  
  List<String> imageUrls = [];
  int batchSize = 10;
  int currentPage = 0;
  DateTime selectedDate = DateTime.now();

  bool isLoading = true;

  var _startDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Image Data for ' + widget.deviceId,
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
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              onTap: () => _selectDate(context),
              decoration: InputDecoration(
                labelText: 'Select Date',
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
              controller: TextEditingController(
                  text: selectedDate != null
                      ? DateFormat('dd-MM-yyyy').format(selectedDate)
                      : ''),
            ),
            Expanded(
              child: isLoading
                  ? FutureBuilder<List<String>>(
                      future: fetchImages(widget.deviceId, selectedDate),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Text('Loading...');
                        } else {
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Image.network(snapshot.data![index]);
                            },
                          );
                        }
                      },
                    )
                  : ListView.builder(
                      itemCount: imageUrls.length,
                      itemBuilder: (context, index) {
                        return Image.network(imageUrls[index]);
                      },
                    ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 123, 156, 125)),
                  onPressed: currentPage > 0 ? moveToPreviousPage : null,
                  child: Text('Previous'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 123, 156, 125)),
                  onPressed: moveToNextPage,
                  child: Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1990),
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
                backgroundColor: Colors.black, // button text color
              ),
            ),
          ),
          // child: child!,
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child ?? Container(),
          ),
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      final newImages = await fetchImages(widget.deviceId, picked);
      setState(() {
        selectedDate = picked;
        imageUrls = newImages;
      });
    }
  }

  Future<List<String>> fetchImages(String device, DateTime date) async {
    final formattedDate = DateFormat('dd-MM-yyyy').format(date);
    final response = await http.get(Uri.parse(
        'API=$device&date=${formattedDate.toString()}'));
    List<String> currentBatch = [];

    if (response.statusCode == 200) {
      final bodyJson = json.decode(response.body);
      final images = json.decode(bodyJson['body'])['images'];

      // Extract image URLs
      for (int i = currentPage * batchSize;
          i < (currentPage + 1) * batchSize && i < images.length;
          i++) {
        currentBatch.add(images[i]);
      }

      // Update the list of image URLs
      imageUrls = currentBatch;
    } else {
      throw Exception('Failed to load images');
    }

    // Show loading text for a short duration
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        isLoading = false;
      });
    });

    return imageUrls;
  }

  void moveToNextPage() {
    setState(() {
      currentPage++;
      isLoading = true;
    });
  }

  void moveToPreviousPage() {
    setState(() {
      currentPage--;
      isLoading = true;
    });
  }

 
  // }
}
