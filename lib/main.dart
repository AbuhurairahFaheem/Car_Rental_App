import 'package:flutter/material.dart';
import 'screens/home_screen.dart';  // Import the HomeScreen

void main() {
  runApp(CarRentalApp());
}

class CarRentalApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),  // Use HomeScreen here
    );
  }
}
