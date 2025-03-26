import 'package:flutter/material.dart';
import 'screens/login_page.dart'; // Import LoginScreen

void main() {
  runApp(const CarRentalApp());
}

class CarRentalApp extends StatelessWidget {
  const CarRentalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(), // Start from LoginScreen
    );
  }
}
