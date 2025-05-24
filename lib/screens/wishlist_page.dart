import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/car_model.dart';
import '../models/customer_model.dart';
import '../services/car_services.dart';
import 'car_details_page.dart';

class WishlistPage extends StatefulWidget {
  final Customer customer;

  const WishlistPage({required this.customer, super.key});

  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  Future<void> _removeFromWishlist(String wishlistId) async {
    try {
      await FirebaseFirestore.instance
          .collection('wishlists')
          .doc(wishlistId)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Removed from wishlist')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to remove from wishlist')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wishlist")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('wishlists')
            .where('customerId', isEqualTo: widget.customer.id)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Your wishlist is empty'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final doc = snapshot.data!.docs[index];
              return FutureBuilder<Car?>(
                future: CarService.getCarById(doc['carId']),
                builder: (context, carSnapshot) {
                  if (!carSnapshot.hasData) {
                    return const ListTile(title: Text('Loading...'));
                  }

                  final car = carSnapshot.data!;
                  return ListTile(
                    leading: car.imageURL.isNotEmpty
                        ? Image.network(car.imageURL, width: 50, height: 50)
                        : const Icon(Icons.directions_car),
                    title: Text(car.title),
                    subtitle: Text('\$${car.ratePerDay}/day'),
                    trailing: IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.red),
                      onPressed: () => _removeFromWishlist(doc.id),
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CarDetailsPage(
                          car: car,
                          customer: widget.customer,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}