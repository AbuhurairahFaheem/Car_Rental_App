// import 'package:flutter/material.dart';
// import 'screens/login_page.dart'; // Import LoginScreen

// void main() {
//   runApp(const CarRentalApp());
// }

// class CarRentalApp extends StatelessWidget {
//   const CarRentalApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: const LoginScreen(), // Start from LoginScreen
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'screens/login_page.dart'; // Import LoginScreen
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // initialize Firebase
  //FirebaseAuth.instance.setSettings(appVerificationDisabledForTesting: true);
  runApp(const CarRentalApp());
}

class CarRentalApp extends StatelessWidget {
  const CarRentalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(), // Start from LoginScreen

      theme: ThemeData(
        // You can define basic colors and other properties here without text styles
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
