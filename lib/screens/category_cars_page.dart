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
  final String categoryName;

  CategoryCarsPage({required this.categoryName});

  Future<List<Map<String, dynamic>>> fetchCars() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('cars')
        .where('category', isEqualTo: categoryName)
        .get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("$categoryName Cars")),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchCars(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return const Center(child: CircularProgressIndicator());
          if (!snapshot.hasData || snapshot.data!.isEmpty)
            return const Center(child: Text("No cars in this category"));

          final cars = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: cars.length,
            itemBuilder: (context, index) {
              return CarCard(car: cars[index]);
            },
          );
        },
      ),
    );
  }
}

class CarCard extends StatelessWidget {
  final Map<String, dynamic> car;

  const CarCard({required this.car, super.key});

  @override
  Widget build(BuildContext context) {
    final String name = car['name'] ?? 'Unknown';
    final String image = car['image'] ?? '';
    final String rate = car['rate']?.toString() ?? '0';
    final String category = car['category'] ?? 'N/A';
    final bool available = car['available'] ?? true;
    final String createdBy = car['created_by'] ?? 'Admin';
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
                  Text("Category: $category",
                      style: const TextStyle(fontSize: 14)),
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
                  Text("Added by: $createdBy", style: const TextStyle(fontSize: 12)),
                  Text("Created: $createdAt",
                      style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
