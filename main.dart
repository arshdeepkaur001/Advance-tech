import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Digital-entomologist',
      theme: ThemeData.light(),
      initialRoute: '/home', // Set initial route
      routes: {
        '/home': (context) => Homepage(), // Homepage route
        // '/login': (context) => Login(), // Login page route
        '/dashboard': (context) => HomeScreen(
              email: 'arshdeepkaur9926@gmail.com',
            ), // HomeScreen route
        // '/config': (context) => ConfigScreen(), // ConfigScreen route
        // '/configure_image': (context) => ConfigureImage(), // ConfigureImage route
      },
    );
  }
}
