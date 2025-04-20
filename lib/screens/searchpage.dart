// import 'package:flutter/material.dart';
// import 'car_details_page.dart';

// class SearchPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Search Cars"),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             TextField(
//               decoration: InputDecoration(
//                 labelText: "Search for cars",
//                 border: OutlineInputBorder(),
//                 prefixIcon: Icon(Icons.search),
//               ),
//             ),
//             SizedBox(height: 10),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: 10,
//                 itemBuilder: (context, index) {
//                   return Card(
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                     elevation: 5,
//                     margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                     child: ListTile(
//                       leading: Icon(Icons.directions_car, color: Colors.blueAccent, size: 40),
//                       title: Text("Car #$index", style: TextStyle(fontWeight: FontWeight.bold)),
//                       subtitle: Text("Available for rent"),
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => CarDetailsPage(
//                               carImage: "assets/images/car1.jpeg", // Replace with actual data
//                               carName: "Car #$index",
//                               carType: "Sedan", // Example
//                               carRate: "\$20/hr", // Example
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'car_details_page.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Cars"),
        backgroundColor: Colors.blueAccent,
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: SearchContent(),
      ),
    );
  }
}

class SearchContent extends StatelessWidget {
  const SearchContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SearchBar(),
        SizedBox(height: 10),
        Expanded(child: SearchResultsList()),
      ],
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        labelText: "Search for cars",
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.search),
      ),
    );
  }
}

class SearchResultsList extends StatelessWidget {
  const SearchResultsList({super.key});

  Future<List<Map<String, dynamic>>> fetchCars() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('cars')
          .get(); // You can add filters here for searching
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print("Error fetching cars: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchCars(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No cars found"));
        }

        final carList = snapshot.data!;

        return ListView.builder(
          itemCount: carList.length,
          itemBuilder: (context, index) {
            return CarListItem(car: carList[index]);
          },
        );
      },
    );
  }
}

class CarListItem extends StatelessWidget {
  final Map<String, dynamic> car;

  const CarListItem({required this.car, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        leading: car['image'] != null
            ? Image.network(
          car['image'],
          width: 40,
          height: 40,
          fit: BoxFit.cover,
        )
            : const Icon(
          Icons.directions_car,
          color: Colors.blueAccent,
          size: 40,
        ),
        title: Text(
          car['name'] ?? "Car Name",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(car['type'] ?? "Car Type"),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CarDetailsPage(
                car: car, // Pass the entire car object to the details page
              ),
            ),
          );
        },
      ),
    );
  }
}
