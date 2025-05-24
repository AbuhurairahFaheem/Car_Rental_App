import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/customer_model.dart'; // Update import
import '../utils/hash_password.dart';
import '../utils/validators.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  bool _isLoading = false;

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final email = _emailController.text.trim();
      final pass = _passwordController.text.trim();

      // Check if email already exists
      final existing = await FirebaseFirestore.instance
          .collection('customers') // Changed collection name
          .where('email', isEqualTo: email)
          .get();

      if (existing.docs.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email is already in use')),
        );
        setState(() => _isLoading = false);
        return;
      }

      // Generate a Firestore auto-ID
      final docRef = FirebaseFirestore.instance.collection('customers').doc();
      final customerId = docRef.id;

      // Create Customer object
      final customer = Customer(
        id: customerId,
        name: _nameController.text.trim(),
        email: email,
        phoneNumber: _contactController.text.trim(),
        profileImageUrl: '', // Default empty, can be updated later
        password: hashPassword(pass),
      );

      // Write to Firestore using Customer's toMap()
      await docRef.set(customer.toMap());

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account created successfully!'))
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Signup failed: $e'))
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              // Full Name
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                ),
                validator: Validators.validateName,
              ),
              const SizedBox(height: 12),

              // Contact No.
              TextFormField(
                controller: _contactController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                ),
                keyboardType: TextInputType.phone,
                validator: Validators.validateContact,
              ),
              const SizedBox(height: 12),

              // Email
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: Validators.validateEmail,
              ),
              const SizedBox(height: 12),

              // Password
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
                validator: Validators.validatePassword,
              ),
              const SizedBox(height: 12),

              // Confirm Password
              TextFormField(
                controller: _confirmPassController,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                ),
                obscureText: true,
                validator: (val) => Validators.validateConfirmPassword(
                  val,
                  _passwordController.text,
                ),
              ),
              const SizedBox(height: 20),

              // Sign Up Button
              ElevatedButton(
                onPressed: _signUp,
                child: const Text('Sign Up'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}