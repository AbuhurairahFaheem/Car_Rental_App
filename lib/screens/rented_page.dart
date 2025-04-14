// import 'package:flutter/material.dart';

// class RentedPage extends StatelessWidget {
//   final List<Map<String, String>> pendingRentals = [
//     {'image': 'assets/images/car1.jpeg', 'name': 'Tesla Model S', 'status': 'Pending'},
//   ];

//   final List<Map<String, String>> liveRentals = [
//     {'image': 'assets/images/car2.jpg', 'name': 'BMW X5', 'status': 'Live'},
//   ];

//   final List<Map<String, String>> completedRentals = [
//     {'image': 'assets/images/car3.jpeg', 'name': 'Mercedes C-Class', 'status': 'Completed'},
//   ];

//   Widget _buildRentalSection(String title, List<Map<String, String>> rentals) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//         SizedBox(height: 10),
//         Column(
//           children: rentals.map((car) {
//             return Card(
//               margin: EdgeInsets.only(bottom: 10),
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//               child: ListTile(
//                 leading: ClipRRect(
//                   borderRadius: BorderRadius.circular(8),
//                   child: Image.asset(car['image']!, width: 80, height: 60, fit: BoxFit.cover),
//                 ),
//                 title: Text(car['name']!, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                 subtitle: Text(car['status']!, style: TextStyle(fontSize: 16, color: Colors.grey[700])),
//               ),
//             );
//           }).toList(),
//         ),
//         SizedBox(height: 20),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Rented Cars")),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildRentalSection("Pending Rentals", pendingRentals),
//               _buildRentalSection("Live Rentals", liveRentals),
//               _buildRentalSection("Completed Rentals", completedRentals),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class RentalCar {
  final String image;
  final String name;
  final String status;

  RentalCar({required this.image, required this.name, required this.status});
}

class RentedPage extends StatelessWidget {
  final List<RentalCar> pendingRentals = [
    RentalCar(
      image: 'assets/images/car1.jpeg',
      name: 'Tesla Model S',
      status: 'Pending',
    ),
  ];

  final List<RentalCar> liveRentals = [
    RentalCar(image: 'assets/images/car2.jpg', name: 'BMW X5', status: 'Live'),
  ];

  final List<RentalCar> completedRentals = [
    RentalCar(
      image: 'assets/images/car3.jpeg',
      name: 'Mercedes C-Class',
      status: 'Completed',
    ),
  ];

  RentedPage({super.key});

  Widget _buildRentalSection(String title, List<RentalCar> rentals) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Column(children: rentals.map((car) => RentalCard(car: car)).toList()),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Rented Cars")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRentalSection("Pending Rentals", pendingRentals),
              _buildRentalSection("Live Rentals", liveRentals),
              _buildRentalSection("Completed Rentals", completedRentals),
            ],
          ),
        ),
      ),
    );
  }
}

class RentalCard extends StatelessWidget {
  final RentalCar car;

  const RentalCard({required this.car, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            car.image,
            width: 80,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          car.name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          car.status,
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
      ),
    );
  }
}
