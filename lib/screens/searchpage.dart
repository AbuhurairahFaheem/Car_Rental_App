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
      body: const Padding(padding: EdgeInsets.all(8.0), child: SearchContent()),
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

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return CarListItem(index: index);
      },
    );
  }
}

class CarListItem extends StatelessWidget {
  final int index;

  const CarListItem({required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        leading: const Icon(
          Icons.directions_car,
          color: Colors.blueAccent,
          size: 40,
        ),
        title: Text(
          "Car #$index",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: const Text("Available for rent"),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => CarDetailsPage(
                    carImage:
                        "assets/images/car1.jpeg", // Replace with actual data
                    carName: "Car #$index",
                    carType: "Sedan", // Example
                    carRate: "\$20/hr", // Example
                  ),
            ),
          );
        },
      ),
    );
  }
}
