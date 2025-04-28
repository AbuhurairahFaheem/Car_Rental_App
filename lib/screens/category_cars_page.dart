// import 'package:flutter/material.dart';

// class CategoryCarsPage extends StatelessWidget {
//   final String categoryName;

//   CategoryCarsPage({required this.categoryName});

//   final List<Map<String, String>> cars = [
//     {'image': 'assets/images/car1.jpeg', 'name': 'Tesla Model S', 'category': 'Electric', 'rate': '\$25/hr'},
//     {'image': 'assets/images/car2.jpg', 'name': 'BMW X5', 'category': 'SUV', 'rate': '\$30/hr'},
//     {'image': 'assets/images/car3.jpeg', 'name': 'Mercedes C-Class', 'category': 'Luxury', 'rate': '\$28/hr'},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final filteredCars = cars.where((car) => car['category'] == categoryName).toList();

//     return Scaffold(
//       appBar: AppBar(title: Text("$categoryName Cars")),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: filteredCars.isEmpty
//             ? Center(child: Text("No cars available in this category", style: TextStyle(fontSize: 18, color: Colors.grey)))
//             : ListView.builder(
//           itemCount: filteredCars.length,
//           itemBuilder: (context, index) {
//             final car = filteredCars[index];
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
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryCarsPage extends StatelessWidget {
  final String categoryId;

  CategoryCarsPage({required this.categoryId});

  Future<Map<String, dynamic>> fetchCategoryAndCars() async {
    final categorySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .doc(categoryId)
        .get();

    final categoryData = categorySnapshot.data();
    final categoryName = categoryData?['name'] ?? 'Category';

    final carsSnapshot = await FirebaseFirestore.instance
        .collection('cars')
        .where('category', isEqualTo: categoryId)
        .get();

    final cars = carsSnapshot.docs.map((doc) => doc.data()).toList();

    return {
      'name': categoryName,
      'cars': cars,
    };
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchCategoryAndCars(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData || snapshot.data!['cars'].isEmpty) {
          return Scaffold(
            appBar: AppBar(title: Text(snapshot.data?['name'] ?? "Cars")),
            body: const Center(child: Text("No cars in this category")),
          );
        }

        final categoryName = snapshot.data!['name'];
        final cars = snapshot.data!['cars'];

        return Scaffold(
          appBar: AppBar(title: Text("$categoryName Cars")),
          body: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: cars.length,
            itemBuilder: (context, index) {
              return CarCard(car: cars[index]);
            },
          ),
        );
      },
    );
  }
}

class CarCard extends StatelessWidget {
  final Map<String, dynamic> car;

  const CarCard({required this.car, super.key});

  Future<String> fetchCategoryName(String categoryId) async {
    try {
      final doc = await FirebaseFirestore.instance.collection('categories').doc(categoryId).get();
      if (doc.exists) {
        return doc['name'] ?? 'Unknown';
      }
    } catch (e) {
      debugPrint("❌ Error fetching category name: $e");
    }
    return 'Unknown';
  }

  @override
  Widget build(BuildContext context) {
    final String name = car['title'] ?? 'Unknown';
    final String image = car['imageURL'] ?? '';
    final String rate = car['ratePerHour']?.toString() ?? '0';
    final String categoryId = car['category'] ?? '';
    final bool available = car['available'] ?? true;
    final String createdBy = car['createdBy'] ?? 'Admin';
    final String createdAt = car['created_at'] ?? 'Unknown';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Car Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                image,
                width: 100,
                height: 70,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.broken_image, size: 70),
              ),
            ),
            const SizedBox(width: 12),

            // Car Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),

                  /// 🟡 Load category name from Firestore
                  FutureBuilder<String>(
                    future: fetchCategoryName(categoryId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text("Loading category...",
                            style: TextStyle(fontSize: 14));
                      }
                      return Text("Category: ${snapshot.data}",
                          style: const TextStyle(fontSize: 14));
                    },
                  ),

                  const SizedBox(height: 4),
                  Text("Rate: ₹$rate/hr",
                      style: const TextStyle(
                          fontSize: 14, color: Colors.green)),
                  const SizedBox(height: 4),
                  Text("Available: ${available ? 'Yes' : 'No'}",
                      style: TextStyle(
                          fontSize: 14,
                          color: available ? Colors.blue : Colors.red)),
                  const SizedBox(height: 4),
                  //Text("Added by: $createdBy", style: const TextStyle(fontSize: 12)),
                 // Text("Created: $createdAt",
                  //    style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
