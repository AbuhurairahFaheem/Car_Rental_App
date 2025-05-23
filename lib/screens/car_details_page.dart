// import 'package:flutter/material.dart';

// class CarDetailsPage extends StatelessWidget {
//   final String carImage;
//   final String carName;
//   final String carType;
//   final String carRate;

//   CarDetailsPage({
//     required this.carImage,
//     required this.carName,
//     required this.carType,
//     required this.carRate,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       appBar: AppBar(
//         title: Text(carName),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Car Image
//             Container(
//               width: double.infinity,
//               height: 250,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage(carImage),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     carName,
//                     style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     "Category: $carType",
//                     style: TextStyle(fontSize: 16, color: Colors.grey[700]),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     "Rate: $carRate",
//                     style: TextStyle(fontSize: 18, color: Colors.green, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                     ),
//                     onPressed: () {
//                       // Implement Rent Now functionality
//                     },
//                     child: Text("Rent Now", style: TextStyle(fontSize: 18)),
//                   ),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                     ),
//                     onPressed: () {
//                       // Implement Rent Now functionality
//                     },
//                     child: Text("Add to wishlist", style: TextStyle(fontSize: 18)),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CarDetailsPage extends StatelessWidget {
  final Map<String, dynamic> car;

  const CarDetailsPage({required this.car, super.key});

  void addToWishlist(BuildContext context, String carDocId) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please log in to add to wishlist')),
        );
        return;
      }

      await FirebaseFirestore.instance.collection('wishlists').add({
        'carID': carDocId,
        'userID': user.uid,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Show success dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Success'),
          content: const Text('Car has been added to your wishlist!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      print('Error adding to wishlist: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add to wishlist')),
      );
    }
  }

  Future<String> getCategoryName(String categoryId) async {
    try {
      final doc = await FirebaseFirestore.instance.collection('categories').doc(categoryId).get();
      if (doc.exists) {
        return doc.data()?['name'] ?? 'Unknown';
      } else {
        return 'Unknown';
      }
    } catch (e) {
      print("Error fetching category name: $e");
      return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    final String name = car['title'] ?? 'No name';
    final String image = car['imageURL'] ?? '';
    final String categoryId = car['category'] ?? '';
    final String rate = car['pricePerDay']?.toString() ?? '0';
    final bool available = car['available'] ?? true;
    final String createdBy = car['createdBy'] ?? 'N/A';
    final String createdAt = car['created_at'] ?? 'N/A';

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: Text(name), backgroundColor: Colors.blueAccent),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarImage(imagePath: image),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FutureBuilder<String>(
                future: getCategoryName(categoryId),
                builder: (context, snapshot) {
                  final categoryName = snapshot.data ?? 'Loading...';
                  return CarDetailsInfo(
                    name: name,
                    type: categoryName,
                    rate: rate,
                    available: available,
                    createdBy: createdBy,
                    createdAt: createdAt,
                    onRentPressed: () {
                      // Implement Rent functionality
                    },
                    onWishlistPressed: () {
                      addToWishlist(context, car['id']); // car['id'] must be document id
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ... CarImage, CarDetailsInfo, and PrimaryButton classes remain unchanged ...


class CarImage extends StatelessWidget {
  final String imagePath;

  const CarImage({required this.imagePath, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: imagePath.startsWith('http')
              ? NetworkImage(imagePath)
              : AssetImage(imagePath) as ImageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class CarDetailsInfo extends StatelessWidget {
  final String name;
  final String type;
  final String rate;
  final bool available;
  final String createdBy;
  final String createdAt;
  final VoidCallback onRentPressed;
  final VoidCallback onWishlistPressed;

  const CarDetailsInfo({
    required this.name,
    required this.type,
    required this.rate,
    required this.available,
    required this.createdBy,
    required this.createdAt,
    required this.onRentPressed,
    required this.onWishlistPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Text("Category: $type", style: TextStyle(fontSize: 16, color: Colors.grey[700])),
        const SizedBox(height: 10),
        Text("Rate: ₹$rate/hr", style: const TextStyle(fontSize: 18, color: Colors.green)),
        const SizedBox(height: 10),
        Text("Available: ${available ? 'Yes' : 'No'}", style: TextStyle(fontSize: 16, color: available ? Colors.blue : Colors.red)),
        const SizedBox(height: 10),
        Text("Added by: $createdBy", style: const TextStyle(fontSize: 14)),
        Text("Created at: $createdAt", style: const TextStyle(fontSize: 14, color: Colors.grey)),
        const SizedBox(height: 20),
        PrimaryButton(label: "Rent Now", onPressed: onRentPressed),
        const SizedBox(height: 10),
        PrimaryButton(label: "Add to wishlist", onPressed: onWishlistPressed),
      ],
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const PrimaryButton({required this.label, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: onPressed,
      child: Text(label, style: const TextStyle(fontSize: 18)),
    );
  }
}
