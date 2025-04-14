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

class CategoryCarsPage extends StatelessWidget {
  final String categoryName;

  CategoryCarsPage({required this.categoryName});

  final List<Map<String, String>> cars = [
    {
      'image': 'assets/images/car1.jpeg',
      'name': 'Tesla Model S',
      'category': 'Electric',
      'rate': '\$25/hr',
    },
    {
      'image': 'assets/images/car2.jpg',
      'name': 'BMW X5',
      'category': 'SUV',
      'rate': '\$30/hr',
    },
    {
      'image': 'assets/images/car3.jpeg',
      'name': 'Mercedes C-Class',
      'category': 'Luxury',
      'rate': '\$28/hr',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredCars =
        cars.where((car) => car['category'] == categoryName).toList();

    return Scaffold(
      appBar: AppBar(title: Text("$categoryName Cars")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child:
            filteredCars.isEmpty
                ? const Center(
                  child: Text(
                    "No cars available in this category",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                )
                : ListView.builder(
                  itemCount: filteredCars.length,
                  itemBuilder: (context, index) {
                    return CarCard(car: filteredCars[index]);
                  },
                ),
      ),
    );
  }
}

class CarCard extends StatelessWidget {
  final Map<String, String> car;

  const CarCard({required this.car, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            car['image']!,
            width: 80,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          car['name']!,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          car['rate']!,
          style: const TextStyle(fontSize: 16, color: Colors.green),
        ),
        onTap: () {
          // Optional: Navigate to CarDetailsPage
        },
      ),
    );
  }
}
