import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home_screen.dart';
import 'login_page.dart';
import '../models/user_models.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 2)); // Show splash briefly
    final prefs = await SharedPreferences.getInstance();
    final savedUid = prefs.getString('user_uid');

    if (savedUid != null) {
      final doc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(savedUid)
              .get();

      if (doc.exists) {
        final data = doc.data()!;
        final user = UserModel(
          uid: savedUid,
          fullName: data['fullName'] ?? '',
          contact: data['contact'] ?? '',
          email: data['email'] ?? '',
          password: data['password'] ?? '', // Add password here too
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomeScreen(user: user)),
        );
        return;
      }
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // match your app style
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Center(
            child: Column(
              children: const [
                Text(
                  'KarGo',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    color: Colors.blueAccent,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '- rent a car',
                  style: TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ],
      ),
    );
  }
}
