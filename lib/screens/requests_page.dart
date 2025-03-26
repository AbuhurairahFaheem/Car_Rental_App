import 'package:flutter/material.dart';

void main() {
  runApp(RequestsApp());
}

class RequestsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: RequestsPage());
  }
}

class RequestsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Requests'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RequestButton(title: 'Pending'),
            SizedBox(height: 20),
            RequestButton(title: 'Approved'),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // Set this to 1 if "Requests" is at index 1
        selectedItemColor: Colors.blue, // Highlight the selected page
        unselectedItemColor: Colors.grey, // Other icons grey
        backgroundColor: Colors.white, // Keep it visible
        type: BottomNavigationBarType.fixed, // Ensure all labels are visible
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Explore"),
          BottomNavigationBarItem(icon: Icon(Icons.check), label: "Rented"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Wishlist",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

class RequestButton extends StatelessWidget {
  final String title;

  RequestButton({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey,
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {},
        child: Text(title, style: TextStyle(fontSize: 18, color: Colors.white)),
      ),
    );
  }
}
