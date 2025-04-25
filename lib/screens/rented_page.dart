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
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RentedPage extends StatefulWidget {
  const RentedPage({super.key});

  @override
  State<RentedPage> createState() => _RentedPageState();
}

class _RentedPageState extends State<RentedPage> {
  List<RentalCar> pending = [];
  List<RentalCar> live = [];
  List<RentalCar> completed = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRentalData();
  }

  Future<void> fetchRentalData() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('requests').get();

      final cars =
          snapshot.docs.map((doc) {
            final data = doc.data();
            return RentalCar(
              image: data['image'] ?? '',
              name: data['name'] ?? '',
              status: data['status'] ?? 'Pending',
            );
          }).toList();

      setState(() {
        pending = cars.where((car) => car.status == 'Pending').toList();
        live = cars.where((car) => car.status == 'Live').toList();
        completed = cars.where((car) => car.status == 'Completed').toList();
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching rentals: $e");
      setState(() => isLoading = false);
    }
  }

  Widget _buildRentalSection(String title, List<RentalCar> rentals) {
    if (rentals.isEmpty) return const SizedBox.shrink();
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
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildRentalSection("Pending Rentals", pending),
                      _buildRentalSection("Live Rentals", live),
                      _buildRentalSection("Completed Rentals", completed),
                    ],
                  ),
                ),
              ),
    );
  }
}

// RentalCar Model (OOP encapsulated)
class RentalCar {
  final String image;
  final String name;
  final String status;

  RentalCar({required this.image, required this.name, required this.status});
}

// Card Widget to display car info
class RentalCard extends StatelessWidget {
  final RentalCar car;

  const RentalCard({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading:
            car.image.isNotEmpty
                ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    car.image,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(Icons.car_rental),
                  ),
                )
                : const Icon(Icons.car_rental, size: 40),
        title: Text(car.name),
        subtitle: Text(car.status),
      ),
    );
  }
}

// class RentalCar {
//   final String image;
//   final String name;
//   final String status;

//   RentalCar({required this.image, required this.name, required this.status});
// }

// class RentedPage extends StatelessWidget {
//   final List<RentalCar> pendingRentals = [
//     RentalCar(
//       image: 'assets/images/car1.jpeg',
//       name: 'Tesla Model S',
//       status: 'Pending',
//     ),
//   ];

//   final List<RentalCar> liveRentals = [
//     RentalCar(image: 'assets/images/car2.jpg', name: 'BMW X5', status: 'Live'),
//   ];

//   final List<RentalCar> completedRentals = [
//     RentalCar(
//       image: 'assets/images/car3.jpeg',
//       name: 'Mercedes C-Class',
//       status: 'Completed',
//     ),
//   ];

//   RentedPage({super.key});

//   Widget _buildRentalSection(String title, List<RentalCar> rentals) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 10),
//         Column(children: rentals.map((car) => RentalCard(car: car)).toList()),
//         const SizedBox(height: 20),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Rented Cars")),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
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

// class RentalCard extends StatelessWidget {
//   final RentalCar car;

//   const RentalCard({required this.car, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 10),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       child: ListTile(
//         leading: ClipRRect(
//           borderRadius: BorderRadius.circular(8),
//           child: Image.asset(
//             car.image,
//             width: 80,
//             height: 60,
//             fit: BoxFit.cover,
//           ),
//         ),
//         title: Text(
//           car.name,
//           style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         subtitle: Text(
//           car.status,
//           style: TextStyle(fontSize: 16, color: Colors.grey[700]),
//         ),
//       ),
//     );
//   }
// }
