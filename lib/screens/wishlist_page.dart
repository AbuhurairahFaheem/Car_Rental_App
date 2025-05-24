import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/car_model.dart';
import '../models/customer_model.dart';
import '../services/car_services.dart';
import 'car_details_page.dart';
import 'home_screen.dart';
import 'rented_page.dart';
import 'wishlist_page.dart';
import 'profile_page.dart';
import 'explore_page.dart';

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

  // Widget _buildBottomNavigationBar(BuildContext context) {
  //   return BottomNavigationBar(
  //     currentIndex: 2, // Home is selected
  //     type: BottomNavigationBarType.fixed,
  //     selectedItemColor: Colors.blueAccent,
  //     unselectedItemColor: Colors.grey,
  //     onTap: (index) => _onItemTapped(context, index),
  //     items: const [
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.explore),
  //         label: "Explore",
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.check_box),
  //         label: "Rented",
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.home),
  //         label: "Home",
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.favorite),
  //         label: "Wishlist",
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.person),
  //         label: "Profile",
  //       ),
  //     ],
  //   );
  // }
  //
  // void _onItemTapped(BuildContext context, int index) {
  //   if (index == 2) return; // Already on home
  //
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => _getPageForIndex(index),
  //     ),
  //   );
  // }
  //
  // Widget _getPageForIndex(int index) {
  //   switch (index) {
  //     case 0:
  //       return ExplorePage(customer: widget.customer);
  //     case 1:
  //       return RentedPage(customer: widget.customer);
  //     case 3:
  //       return WishlistPage(customer: widget.customer);
  //     case 4:
  //       return ProfilePage(customer: widget.customer);
  //     default:
  //       return HomeScreen(customer: widget.customer);
  //   }
  // }


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

      //bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }
}