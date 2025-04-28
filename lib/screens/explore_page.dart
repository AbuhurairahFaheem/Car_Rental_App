// import 'package:flutter/material.dart';
// import 'category_cars_page.dart';

// class ExplorePage extends StatelessWidget {
//   final List<Map<String, dynamic>> categories = [
//     {'name': 'SUV', 'icon': Icons.directions_car, 'color': Colors.blue},
//     {'name': 'Sedan', 'icon': Icons.directions_car_filled, 'color': Colors.green},
//     {'name': 'Luxury', 'icon': Icons.star, 'color': Colors.purple},
//     {'name': 'Electric', 'icon': Icons.electric_car, 'color': Colors.orange},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Explore Cars")),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: GridView.builder(
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             crossAxisSpacing: 10,
//             mainAxisSpacing: 10,
//             childAspectRatio: 1.2,
//           ),
//           itemCount: categories.length,
//           itemBuilder: (context, index) {
//             final category = categories[index];
//             return GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => CategoryCarsPage(categoryName: category['name']),
//                   ),
//                 );
//               },
//               child: Card(
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//                 color: category['color'],
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(category['icon'], size: 50, color: Colors.white),
//                     SizedBox(height: 10),
//                     Text(category['name'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
//                   ],
//                 ),
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
import 'category_cars_page.dart'; // Make sure this path is correct

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  Future<List<CategoryItem>> fetchCategories() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('categories').get();

      if (snapshot.docs.isEmpty) {
        debugPrint("⚠️ No categories found in Firestore.");
        return [];
      }

      return snapshot.docs.map((doc) {
        final data = doc.data();
        debugPrint("✅ Category data: $data");

        return CategoryItem(
          id: doc.id, // <-- add this line to include the Firestore document ID
          name: data['name'] ?? 'Unknown',
          icon: getIconFromString(data['icon'] ?? 'directions_car'),
          color: Color(int.parse(data['color'].toString())),
        );
      }).toList();

    } catch (e) {
      debugPrint("❌ Error fetching categories: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Explore Cars")),
      body: FutureBuilder<List<CategoryItem>>(
        future: fetchCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("An error occurred while fetching categories."));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No categories found."));
          }

          final categories = snapshot.data!;
          return _buildGrid(context, categories);
        },
      ),
    );
  }

  Widget _buildGrid(BuildContext context, List<CategoryItem> categories) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        itemCount: categories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.2,
        ),
        itemBuilder: (context, index) {
          return CategoryCard(
            item: categories[index],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CategoryCarsPage(categoryId: categories[index].id),

                ),
              );
            },
          );
        },
      ),
    );
  }
}

class CategoryItem {
  final String id; // <-- add this
  final String name;
  final IconData icon;
  final Color color;

  CategoryItem({required this.id, required this.name, required this.icon, required this.color});
}

class CategoryCard extends StatelessWidget {
  final CategoryItem item;
  final VoidCallback onTap;

  const CategoryCard({required this.item, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: item.color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(item.icon, size: 50, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              item.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

IconData getIconFromString(String iconName) {
  switch (iconName) {
    case 'directions_car':
      return Icons.directions_car;
    case 'star':
      return Icons.star;
    case 'electric_car':
      return Icons.electric_car;
    case 'directions_car_filled':
      return Icons.directions_car_filled;
    default:
      return Icons.directions_car;
  }
}
