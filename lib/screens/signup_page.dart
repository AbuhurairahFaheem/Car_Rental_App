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

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formData = SignUpFormData();

  void _signUp() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account created successfully!')),
      );
      Navigator.pop(context);
    }
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
