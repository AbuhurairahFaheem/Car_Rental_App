import 'package:flutter/material.dart';

class RentedPage extends StatelessWidget {
  final List<Map<String, String>> pendingRentals = [
    {'image': 'assets/images/car1.jpeg', 'name': 'Tesla Model S', 'status': 'Pending'},
  ];

  final List<Map<String, String>> liveRentals = [
    {'image': 'assets/images/car2.jpg', 'name': 'BMW X5', 'status': 'Live'},
  ];

  final List<Map<String, String>> completedRentals = [
    {'image': 'assets/images/car3.jpeg', 'name': 'Mercedes C-Class', 'status': 'Completed'},
  ];

  Widget _buildRentalSection(String title, List<Map<String, String>> rentals) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Column(
          children: rentals.map((car) {
            return Card(
              margin: EdgeInsets.only(bottom: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(car['image']!, width: 80, height: 60, fit: BoxFit.cover),
                ),
                title: Text(car['name']!, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                subtitle: Text(car['status']!, style: TextStyle(fontSize: 16, color: Colors.grey[700])),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Rented Cars")),
      body: Padding(
        padding: EdgeInsets.all(16),
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
