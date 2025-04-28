// import 'package:flutter/material.dart';

// class WishlistPage extends StatefulWidget {
//   @override
//   _WishlistPageState createState() => _WishlistPageState();
// }

// class _WishlistPageState extends State<WishlistPage> {
//   List<Map<String, String>> wishlist = [
//     {'image': 'assets/images/car1.jpeg', 'name': 'Tesla Model S', 'rate': '\$25/hr'},
//     {'image': 'assets/images/car2.jpg', 'name': 'BMW X5', 'rate': '\$30/hr'},
//   ];

//   void _removeFromWishlist(int index) {
//     setState(() {
//       wishlist.removeAt(index);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Wishlist")),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: ListView.builder(
//           itemCount: wishlist.length,
//           itemBuilder: (context, index) {
//             final car = wishlist[index];
//             return Card(
//               margin: EdgeInsets.only(bottom: 10),
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//               child: ListTile(
//                 leading: ClipRRect(
//                   borderRadius: BorderRadius.circular(8),
//                   child: Image.asset(car['image']!, width: 80, height: 60, fit: BoxFit.cover),
//                 ),
//                 title: Text(car['name']!, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                 subtitle: Text(car['rate']!, style: TextStyle(fontSize: 16, color: Colors.green)),
//                 trailing: IconButton(
//                   icon: Icon(Icons.favorite, color: Colors.red),
//                   onPressed: () => _removeFromWishlist(index),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  late Future<List<Map<String, dynamic>>> _wishlistFuture;

  @override
  void initState() {
    super.initState();
    _wishlistFuture = fetchWishlist();
  }

  Future<List<Map<String, dynamic>>> fetchWishlist() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return [];

    final wishlistSnapshot = await FirebaseFirestore.instance
        .collection('wishlist')
        .where('userID', isEqualTo: user.uid)
        .get();

    List<Map<String, dynamic>> wishlist = [];

    for (var doc in wishlistSnapshot.docs) {
      final carId = doc['carID'];
      final carDoc = await FirebaseFirestore.instance.collection('cars').doc(carId).get();

      if (carDoc.exists) {
        wishlist.add({
          'wishlistId': doc.id, // wishlist entry ID (for removal)
          'carId': carId,
          'image': carDoc['imageUrl'] ?? '',   // <- Correct field name here
          'name': carDoc['title'] ?? 'Unknown',
          'rate': carDoc['pricePerDay']?.toString() ?? '0',
        });
      }
    }
    return wishlist;
  }

  Future<void> removeFromWishlist(String wishlistId) async {
    try {
      await FirebaseFirestore.instance.collection('wishlist').doc(wishlistId).delete();
      setState(() {
        _wishlistFuture = fetchWishlist(); // Refresh the wishlist after removal
      });
    } catch (e) {
      print('Error removing from wishlist: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to remove from wishlist')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wishlist")),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _wishlistFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No cars in wishlist'));
          }

          final wishlist = snapshot.data!;

          return WishlistContent(
            wishlist: wishlist,
            onRemove: (index) {
              removeFromWishlist(wishlist[index]['wishlistId']);
            },
          );
        },
      ),
    );
  }
}

class WishlistContent extends StatelessWidget {
  final List<Map<String, dynamic>> wishlist;
  final Function(int) onRemove;

  const WishlistContent({
    required this.wishlist,
    required this.onRemove,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: wishlist.length,
        itemBuilder: (context, index) {
          return WishlistItem(
            car: wishlist[index],
            onRemove: () => onRemove(index),
          );
        },
      ),
    );
  }
}

class WishlistItem extends StatelessWidget {
  final Map<String, dynamic> car;
  final VoidCallback onRemove;

  const WishlistItem({required this.car, required this.onRemove, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: car['image'].toString().startsWith('http')
              ? Image.network(
            car['image'],
            width: 80,
            height: 60,
            fit: BoxFit.cover,
          )
              : Image.asset(
            car['image'],
            width: 80,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          car['name'] ?? '',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          "₹${car['rate']}/hr",
          style: const TextStyle(fontSize: 16, color: Colors.green),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.favorite, color: Colors.red),
          onPressed: onRemove,
        ),
      ),
    );
  }
}
