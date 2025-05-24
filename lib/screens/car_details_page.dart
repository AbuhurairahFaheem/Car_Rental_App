import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/car_model.dart';
import '../models/customer_model.dart';
import '../services/car_services.dart';
import '../services/customer_services.dart';
import 'chat_screen.dart';

class CarDetailsPage extends StatelessWidget {
  final Car car;
  final Customer customer;

  const CarDetailsPage({
    required this.car,
    required this.customer,
    super.key,
  });

  Future<void> _addToWishlist(BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('wishlists').add({
        'carId': car.id,
        'customerId': customer.id,
        'createdAt': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Added to wishlist!')),
      );
    } catch (e) {
      print('Error adding to wishlist: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add to wishlist')),
      );
    }
  }

  Future<void> _createBooking(BuildContext context) async {
    // Implement booking creation logic
    // You'll need to add this to your BookingService
    try {
      // Example booking creation
      await FirebaseFirestore.instance.collection('bookings').add({
        'carId': car.id,
        'customerId': customer.id,
        'startDate': DateTime.now(),
        'endDate': DateTime.now().add(const Duration(days: 1)),
        'totalPrice': double.parse(car.ratePerDay),
        'status': 'upcoming',
        'createdAt': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Booking created successfully!')),
      );
    } catch (e) {
      print('Error creating booking: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to create booking')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(car.title),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarImage(imageUrl: car.imageURL),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    car.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Type: ${car.type}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Rate: \$${car.ratePerDay}/day",
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Available: ${car.isAvailable ? 'Yes' : 'No'}",
                    style: TextStyle(
                      fontSize: 16,
                      color: car.isAvailable ? Colors.blue : Colors.red,
                    ),
                  ),
                  const SizedBox(height: 20),
                  PrimaryButton(
                    label: "Rent Now",
                    onPressed: () => _createBooking(context),
                  ),
                  const SizedBox(height: 10),
                  PrimaryButton(
                    label: "Add to wishlist",
                    onPressed: () => _addToWishlist(context),
                  ),
                  const SizedBox(height: 10),
                  PrimaryButton(
                    label: "Chat About This Car",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(
                            customerId: 'support_customer_id', // Replace with actual support ID
                            currentUserId: customer.id,
                            currentUserName: customer.name,
                            initialCarId: car.id,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CarImage extends StatelessWidget {
  final String imageUrl;

  const CarImage({required this.imageUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: imageUrl.isNotEmpty
              ? NetworkImage(imageUrl)
              : const AssetImage('assets/default_car.jpg') as ImageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const PrimaryButton({
    required this.label,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}