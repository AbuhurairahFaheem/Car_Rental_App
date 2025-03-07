import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> carRecommendations = [
    {'image': 'assets/images/car1.jpeg', 'name': 'Tesla Model S', 'type': 'Electric', 'rate': '\$25/hr'},
    {'image': 'assets/images/car2.jpg', 'name': 'BMW X5', 'type': 'SUV', 'rate': '\$30/hr'},
    {'image': 'assets/images/car3.jpeg', 'name': 'Mercedes C-Class', 'type': 'Luxury', 'rate': '\$28/hr'},
  ];

  final List<String> categories = ["SUV", "Sedan", "Luxury", "Electric"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: TextField(
          decoration: InputDecoration(
            hintText: "Search cars...",
            prefixIcon: Icon(Icons.search, color: Colors.black54),
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
          ),
        ),
        actions: [CircleAvatar(backgroundImage: AssetImage('assets/profile.jpg')), SizedBox(width: 10)],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Spotlight", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            CarouselSlider(
              options: CarouselOptions(autoPlay: true, enlargeCenterPage: true),
              items: carRecommendations.map((car) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(image: AssetImage(car['image']!), fit: BoxFit.cover),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text("Categories", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: categories.map((category) {
                return Chip(
                  label: Text(category, style: TextStyle(fontSize: 16)),
                  backgroundColor: Colors.white,
                  elevation: 2,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text("Recommendations", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: carRecommendations.length,
              itemBuilder: (context, index) {
                final car = carRecommendations[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(car['image']!, width: 120, height: 80, fit: BoxFit.cover),
                        ),
                        SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(car['name']!, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            SizedBox(height: 5),
                            Text(car['type']!, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                            SizedBox(height: 5),
                            Text(car['rate']!, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green)),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
