import 'package:flutter/material.dart';
import 'birdNet.dart';
import 'home_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(600); // Adjust the height as needed

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      child: AppBar(
        backgroundColor: Colors.transparent, // Make app bar transparent
        elevation: 0, // Remove the shadow
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start, // Align logo to the right
          children: <Widget>[
            // Syngenta logo placed on the right side
            Padding(
              padding: EdgeInsets.only(
                right: 10.0,
                top: 20.0,
                bottom: 15.0, // Add bottom padding
              ),
              child: Image.asset(
                'images/awadhLogo.png', // Add path to Syngenta logo image
                height: 165, // Adjust the height of the logo
                width: 165, // Adjust the width of the logo
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Homepage extends StatelessWidget {
  final TextEditingController textEditingController = TextEditingController();

  Homepage({Key? key}) : super(key: key);

  void _openBirdNetDialog(BuildContext context) {
    String enteredDeviceId = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Color.fromARGB(
                  255, 252, 251, 247), // Set background color here
            ),
            child: Container(
              width: MediaQuery.of(context).size.width *
                  0.6, // Cover 50% of the screen width
              height: MediaQuery.of(context).size.height * 0.7,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.all(60.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Please enter the device Id you want to search bird data for.',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 121, 116, 116),
                            ),
                          ),
                          SizedBox(height: 60),
                          Container(
                            margin: EdgeInsets.only(bottom: 30),
                            child: TextField(
                              onChanged: (value) {
                                enteredDeviceId = value;
                              },
                              decoration: InputDecoration(
                                hintText: 'S01',
                                border: OutlineInputBorder(),
                                filled: true,
                                fillColor: Colors.grey[200],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 150, 147, 147),
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (enteredDeviceId.isEmpty) {
                                        enteredDeviceId =
                                            'S01'; // Default value
                                      }
                                      Navigator.of(context).pop();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => birdNet(
                                              deviceId: enteredDeviceId),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary:
                                          Color.fromARGB(255, 123, 156, 125),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    child: Text('Next'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                        ),
                        image: DecorationImage(
                          image: AssetImage(
                              'images/bird2.jpg'), // Replace with your image path
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(), // Using CustomAppBar as the app bar
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width *
                  9 /
                  16, // Set the height based on aspect ratio
              child: AspectRatio(
                aspectRatio: 16 / 9, // Adjust this aspect ratio as needed
                child: VideoPlayerWidget(videoPath: 'videos/biodiversity.mp4'),
              ),
            ),
            SizedBox(height: 100), // Adjust this value as needed
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.all(40.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.transparent, // Light background color
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Biodiversity Conservation',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[900], // Adjust color as needed
                              fontFamily: 'Pacifico', // Fancy font
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.all(
                                10.0), // Adjust the padding as needed
                            child: Text(
                              'We should preserve every scrap of biodiversity as priceless while we learn to use it and come to understand what it means to humanity.',
                              style: GoogleFonts.openSans(
                                fontSize: 20,
                                color: Color.fromARGB(
                                    255, 71, 69, 69), // Adjust color as needed
                              ),
                            ),
                          ),
                          SizedBox(height: 40),
                          Column(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  _openBirdNetDialog(context);
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty
                                      .all<Color>(Color.fromARGB(255, 123, 156,
                                          125)), // Adjust the color as needed
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10.0), // Adjust the border radius as needed
                                    ),
                                  ),
                                  elevation: MaterialStateProperty.all<double>(
                                      5), // Adjust the elevation as needed
                                  textStyle:
                                      MaterialStateProperty.all<TextStyle>(
                                    TextStyle(
                                      color: Colors
                                          .white, // Adjust the text color as needed
                                      //fontStyle: FontStyle.italic,
                                      fontSize: 20,
                                    ),
                                  ),
                                  padding: MaterialStateProperty.all<
                                      EdgeInsetsGeometry>(
                                    EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical:
                                            15), // Adjust the padding as needed
                                  ),
                                ),
                                child: Text("BirdNet"),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 30),
                  Expanded(
                    flex: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: VideoPlayerWidget(videoPath: 'videos/bird.mp4'),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 100), // Add spacing between the rows
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child:
                          VideoPlayerWidget(videoPath: 'videos/butterfly.mp4'),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.transparent, // Light background color
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Insect Data',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[900], // Adjust color as needed
                              fontFamily: 'Pacifico', // Fancy font
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Insects play a vital role in maintaining biodiversity and ecosystem balance. They are incredibly diverse, with over a million species identified and many more yet to be discovered. Pollinating insects, such as bees, butterflies, and beetles, facilitate the reproduction of flowering plants, including many food crops essential for human survival. ',
                            style: GoogleFonts.openSans(
                              fontSize: 20,
                              color: Colors.grey[600], // Adjust color as needed
                            ),
                          ),
                          SizedBox(height: 10),
                          SizedBox(height: 40),
                          Column(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomeScreen(
                                        email: 'milanpreetkaur502@gmail.com',
                                      ), // Navigate to HomeScreen
                                    ),
                                  );
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Color.fromARGB(255, 123, 156, 125),
                                  ), // Adjust the color as needed
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  elevation: MaterialStateProperty.all<double>(
                                      5), // Adjust the elevation as needed
                                  textStyle:
                                      MaterialStateProperty.all<TextStyle>(
                                    TextStyle(
                                      color: Colors
                                          .white, // Adjust the text color as needed
                                      fontSize: 20,
                                    ),
                                  ),
                                  padding: MaterialStateProperty.all<
                                      EdgeInsetsGeometry>(
                                    EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical:
                                            15), // Adjust the padding as needed
                                  ),
                                ),
                                child: Text("Dashboard"),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 100), // Adjust this value as needed
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.transparent, // Light background color
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Biodiversity Conservation',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[900], // Adjust color as needed
                              fontFamily: 'Pacifico', // Fancy font
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'We should preserve every scrap of biodiversity as priceless while we learn to use it and come to understand what it means to humanity.',
                            style: GoogleFonts.openSans(
                              fontSize: 30,
                              color: Colors.grey[600], // Adjust color as needed
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: VideoPlayerWidget(videoPath: 'videos/clouds.mp4'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoPath;

  const VideoPlayerWidget({required this.videoPath, Key? key})
      : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        _controller.setLooping(true); // Set the video to loop
        _controller.setVolume(0.0); // Mute the video
        setState(() {}); // Update the state after initialization
        _controller.play(); // Start playing the video
      });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: Listener(
        onPointerDown: (_) {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        child: VideoPlayer(_controller),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
