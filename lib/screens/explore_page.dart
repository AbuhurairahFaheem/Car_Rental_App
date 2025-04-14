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
import 'category_cars_page.dart';

class ExplorePage extends StatelessWidget {
  final List<CategoryItem> categories = [
    CategoryItem(name: 'SUV', icon: Icons.directions_car, color: Colors.blue),
    CategoryItem(
      name: 'Sedan',
      icon: Icons.directions_car_filled,
      color: Colors.green,
    ),
    CategoryItem(name: 'Luxury', icon: Icons.star, color: Colors.purple),
    CategoryItem(
      name: 'Electric',
      icon: Icons.electric_car,
      color: Colors.orange,
    ),
  ];

  ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildGrid(context));
  }

  AppBar _buildAppBar() {
    return AppBar(title: const Text("Explore Cars"));
  }

  Widget _buildGrid(BuildContext context) {
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
                  builder:
                      (_) => CategoryCarsPage(
                        categoryName: categories[index].name,
                      ),
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
  final String name;
  final IconData icon;
  final Color color;

  CategoryItem({required this.name, required this.icon, required this.color});
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
