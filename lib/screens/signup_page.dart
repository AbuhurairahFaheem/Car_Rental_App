// import 'package:flutter/material.dart';

// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key});

//   @override
//   _SignUpScreenState createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _contactController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPasswordController = TextEditingController();

//   void _signUp() {
//     if (_formKey.currentState!.validate()) {
//       // TODO: Implement actual sign-up logic
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Account created successfully!')),
//       );

//       Navigator.pop(context); // Navigate back to login screen
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Sign-up')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Center(
//           child: SingleChildScrollView(
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   TextFormField(
//                     controller: _nameController,
//                     decoration: InputDecoration(
//                       labelText: 'Full Name',
//                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your full name';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 16),
//                   TextFormField(
//                     controller: _contactController,
//                     decoration: InputDecoration(
//                       labelText: 'Contact No.',
//                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//                     ),
//                     keyboardType: TextInputType.phone,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your contact number';
//                       } else if (!RegExp(r'^\d{10,15}$').hasMatch(value)) {
//                         return 'Enter a valid contact number';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 16),
//                   TextFormField(
//                     controller: _emailController,
//                     decoration: InputDecoration(
//                       labelText: 'Email',
//                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//                     ),
//                     keyboardType: TextInputType.emailAddress,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your email';
//                       } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//                         return 'Enter a valid email';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 16),
//                   TextFormField(
//                     controller: _passwordController,
//                     decoration: InputDecoration(
//                       labelText: 'Password',
//                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//                     ),
//                     obscureText: true,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your password';
//                       } else if (value.length < 6) {
//                         return 'Password must be at least 6 characters';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 16),
//                   TextFormField(
//                     controller: _confirmPasswordController,
//                     decoration: InputDecoration(
//                       labelText: 'Re-Enter Password',
//                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//                     ),
//                     obscureText: true,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please re-enter your password';
//                       } else if (value != _passwordController.text) {
//                         return 'Passwords do not match';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: _signUp,
//                     child: const Text('Sign-up'),
//                   ),
//                   const SizedBox(height: 8),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: const Text('Already have an account? Sign-in'),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/user_models.dart';
import '../widgets/custom_text_field.dart';
import '../utils/validators.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final contactController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Step 1: Create Firebase Auth user
        final authResult = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        final uid = authResult.user!.uid;

        // Step 2: Create UserModel object
        final user = UserModel(
          uid: uid,
          fullName: nameController.text.trim(),
          contact: contactController.text.trim(),
          email: emailController.text.trim(),
        );

        // Step 3: Save to Firebase Realtime DB
        await FirebaseDatabase.instance.ref("users/$uid").set(user.toJson());

        // Step 4: Start phone verification
        await _verifyPhoneNumber(uid);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account created!')),
        );
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        String message = 'Registration failed';
        if (e.code == 'email-already-in-use') {
          message = 'Email is already in use';
        } else if (e.code == 'weak-password') {
          message = 'Weak password';
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
      }
    }
  }

  Future<void> _verifyPhoneNumber(String uid) async {
    final phone = contactController.text.trim();

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);
        await _linkPhone(uid, credential);
      },
      verificationFailed: (e) => print('Phone verify error: ${e.message}'),
      codeSent: (verificationId, _) => _showOtpDialog(verificationId, uid),
      codeAutoRetrievalTimeout: (_) {},
    );
  }

  void _showOtpDialog(String verificationId, String uid) {
    final otpController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Enter OTP"),
        content: TextField(controller: otpController),
        actions: [
          TextButton(
            onPressed: () async {
              final smsCode = otpController.text.trim();
              final credential = PhoneAuthProvider.credential(
                verificationId: verificationId,
                smsCode: smsCode,
              );
              await FirebaseAuth.instance.signInWithCredential(credential);
              await _linkPhone(uid, credential);
              Navigator.pop(context);
            },
            child: const Text("Verify"),
          ),
        ],
      ),
    );
  }

  Future<void> _linkPhone(String uid, PhoneAuthCredential credential) async {
    await FirebaseAuth.instance.currentUser?.linkWithCredential(credential);
    await FirebaseDatabase.instance
        .ref("users/$uid")
        .update({'phone': contactController.text.trim()});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              CustomTextField(label: 'Full Name', controller: nameController, validator: Validators.validateName),
              const SizedBox(height: 12),
              CustomTextField(label: 'Contact No.', controller: contactController, keyboardType: TextInputType.phone, validator: Validators.validateContact),
              const SizedBox(height: 12),
              CustomTextField(label: 'Email', controller: emailController, keyboardType: TextInputType.emailAddress, validator: Validators.validateEmail),
              const SizedBox(height: 12),
              CustomTextField(label: 'Password', controller: passwordController, obscureText: true, validator: Validators.validatePassword),
              const SizedBox(height: 12),
              CustomTextField(
                label: 'Confirm Password',
                controller: confirmPasswordController,
                obscureText: true,
                validator: (value) => Validators.validateConfirmPassword(value, passwordController.text),
              ),
              const SizedBox(height: 16),
              ElevatedButton(onPressed: _signUp, child: const Text('Sign Up')),
            ],
          ),
        ),
      ),
    );
  }
}
