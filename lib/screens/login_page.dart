// import 'package:flutter/material.dart';
// import 'home_screen.dart'; // Import HomeScreen
// import 'signup_page.dart'; // Import SignUpScreen

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   void _login() {
//     if (_formKey.currentState!.validate()) {
//       String email = _emailController.text.trim();
//       String password = _passwordController.text.trim();

//       // TODO: Replace this with actual authentication logic
//       if (email == "user@example.com" && password == "password123") {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => HomeScreen()),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Invalid email or password')),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Login')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 TextFormField(
//                   controller: _emailController,
//                   decoration: InputDecoration(
//                     labelText: 'Email',
//                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//                   ),
//                   keyboardType: TextInputType.emailAddress,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your email';
//                     } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//                       return 'Enter a valid email';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: _passwordController,
//                   decoration: InputDecoration(
//                     labelText: 'Password',
//                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//                   ),
//                   obscureText: true,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your password';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: _login,
//                   child: const Text('Login'),
//                 ),
//                 const SizedBox(height: 8),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => const SignUpScreen()),
//                     );
//                   },
//                   child: const Text("Don't have an account? Sign-up"),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'signup_page.dart';
import '../models/customer_model.dart'; // Updated import
import '../utils/hash_password.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final LoginFormData _formData = LoginFormData();

  void _login() async {
    if (_formKey.currentState!.validate()) {
      final email = _formData.emailController.text.trim();
      final password = _formData.passwordController.text.trim();

      try {
        // Query Firestore for customer with matching email
        final querySnapshot = await FirebaseFirestore.instance
            .collection('customers') // Changed collection name
            .where('email', isEqualTo: email)
            .where('password', isEqualTo: hashPassword(password))
            .get();

        if (querySnapshot.docs.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid email or password.')),
          );
          return;
        }

        // Retrieve customer data
        final doc = querySnapshot.docs.first;
        final customer = Customer.fromMap(doc.data(), doc.id);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('customer_id', customer.id);

        // Navigate to home screen with customer data
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomeScreen(customer: customer)),
        );
      } catch (e) {
        print('Login error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login failed. Please try again later.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: LoginForm(
            formKey: _formKey,
            formData: _formData,
            onLoginPressed: _login,
            onSignUpNavigate: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SignUpScreen()),
              );
            },
          ),
        ),
      ),
    );
  }
}

// Rest of the LoginFormData, LoginForm, and CustomTextField classes remain the same

class LoginFormData {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
}

//UI
class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final LoginFormData formData;
  final VoidCallback onLoginPressed;
  final VoidCallback onSignUpNavigate;

  const LoginForm({
    super.key,
    required this.formKey,
    required this.formData,
    required this.onLoginPressed,
    required this.onSignUpNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextField(
            label: 'Email',
            controller: formData.emailController,
            keyboardType: TextInputType.emailAddress,
            validator: Validators.validateEmail,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: 'Password',
            controller: formData.passwordController,
            obscureText: true,
            validator: Validators.validatePassword,
          ),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: onLoginPressed, child: const Text('Login')),
          const SizedBox(height: 8),
          TextButton(
            onPressed: onSignUpNavigate,
            child: const Text("Don't have an account? Sign-up"),
          ),
        ],
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?) validator;

  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.validator,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      validator: validator,
    );
  }
}

class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your email';
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value))
      return 'Enter a valid email';
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your password';
    return null;
  }
}
