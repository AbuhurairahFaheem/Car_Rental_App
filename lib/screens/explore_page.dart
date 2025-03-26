import 'package:flutter/material.dart';
import 'category_cars_page.dart';

class ExplorePage extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {'name': 'SUV', 'icon': Icons.directions_car, 'color': Colors.blue},
    {'name': 'Sedan', 'icon': Icons.directions_car_filled, 'color': Colors.green},
    {'name': 'Luxury', 'icon': Icons.star, 'color': Colors.purple},
    {'name': 'Electric', 'icon': Icons.electric_car, 'color': Colors.orange},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Explore Cars")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.2,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryCarsPage(categoryName: category['name']),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                color: category['color'],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(category['icon'], size: 50, color: Colors.white),
                    SizedBox(height: 10),
                    Text(category['name'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
