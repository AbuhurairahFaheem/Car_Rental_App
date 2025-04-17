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


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formData = SignUpFormData();

  void _signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Create user with email and password
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: _formData.emailController.text.trim(),
          password: _formData.passwordController.text.trim(),
        );

        // Get the UID of the created user
        String uid = userCredential.user!.uid;

        // Store additional user info in Realtime Database
        DatabaseReference ref = FirebaseDatabase.instance.ref("users/$uid");

        await ref.set({
          "fullName": _formData.nameController.text.trim(),
          "contact": _formData.contactController.text.trim(),
          "email": _formData.emailController.text.trim(),
        });

        // Now start phone number verification process
        await _verifyPhoneNumber(uid); // Proceed to phone verification

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account created successfully!')),
        );
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        String message = 'Registration failed';
        if (e.code == 'email-already-in-use') {
          message = 'This email is already in use.';
        } else if (e.code == 'weak-password') {
          message = 'Password is too weak.';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  Future<void> _verifyPhoneNumber(String uid) async {
    String phoneNumber = _formData.contactController.text.trim();

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // If auto-verification happens, sign in the user directly
        await FirebaseAuth.instance.signInWithCredential(credential);
        // Link the phone to the user account
        await _linkPhoneToUser(uid, credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        print('Phone verification failed: ${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        // Store the verification ID for later use
        _showOTPDialog(verificationId, uid);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Timeout, handle appropriately
      },
    );
  }

  void _showOTPDialog(String verificationId, String uid) {
    final TextEditingController otpController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Enter OTP"),
          content: TextField(
            controller: otpController,
            decoration: InputDecoration(hintText: "Enter OTP sent to your phone"),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                // Get OTP entered by the user
                String smsCode = otpController.text.trim();

                // Create PhoneAuthCredential with verificationId and smsCode
                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                  verificationId: verificationId,
                  smsCode: smsCode,
                );

                // Sign in with the credential
                await FirebaseAuth.instance.signInWithCredential(credential);

                // Link phone number to Firebase account
                await _linkPhoneToUser(uid, credential);

                Navigator.pop(context);
              },
              child: Text('Verify'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _linkPhoneToUser(String uid, PhoneAuthCredential credential) async {
    User? user = FirebaseAuth.instance.currentUser;

    // Link the phone credential to the existing user
    await user!.linkWithCredential(credential);

    // Now you can update the phone number in the database too
    DatabaseReference ref = FirebaseDatabase.instance.ref("users/$uid");
    await ref.update({"phone": _formData.contactController.text.trim()});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign-up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: SignUpForm(
              formKey: _formKey,
              formData: _formData,
              onSubmit: _signUp,
              onNavigateToLogin: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
    );
  }
}

// Data Holder (Single Responsibility)
class SignUpFormData {
  final nameController = TextEditingController();
  final contactController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
}

// Form Widget (Open/Closed Principle)
class SignUpForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final SignUpFormData formData;
  final VoidCallback onSubmit;
  final VoidCallback onNavigateToLogin;

  const SignUpForm({
    super.key,
    required this.formKey,
    required this.formData,
    required this.onSubmit,
    required this.onNavigateToLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextField(
            label: 'Full Name',
            controller: formData.nameController,
            validator: Validators.validateName,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: 'Contact No.',
            controller: formData.contactController,
            keyboardType: TextInputType.phone,
            validator: Validators.validateContact,
          ),
          const SizedBox(height: 16),
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
          CustomTextField(
            label: 'Re-Enter Password',
            controller: formData.confirmPasswordController,
            obscureText: true,
            validator:
                (value) => Validators.validateConfirmPassword(
                  value,
                  formData.passwordController.text,
                ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: onSubmit, child: const Text('Sign-up')),
          const SizedBox(height: 8),
          TextButton(
            onPressed: onNavigateToLogin,
            child: const Text('Already have an account? Sign-in'),
          ),
        ],
      ),
    );
  }
}

// Reusable Input Field Widget (Liskov + Interface Segregation)
class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?) validator;

  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      validator: validator,
    );
  }
}

// Validator Utility Class (Single Responsibility)
class Validators {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your full name';
    return null;
  }

  static String? validateContact(String? value) {
    if (value == null || value.isEmpty)
      return 'Please enter your contact number';
    if (!RegExp(r'^\d{10,15}$').hasMatch(value))
      return 'Enter a valid contact number';
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your email';
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value))
      return 'Enter a valid email';
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your password';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) return 'Please re-enter your password';
    if (value != password) return 'Passwords do not match';
    return null;
  }
}
