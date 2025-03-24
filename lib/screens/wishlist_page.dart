import 'package:flutter/material.dart';

class WishlistPage extends StatefulWidget {
  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  List<Map<String, String>> wishlist = [
    {'image': 'assets/images/car1.jpeg', 'name': 'Tesla Model S', 'rate': '\$25/hr'},
    {'image': 'assets/images/car2.jpg', 'name': 'BMW X5', 'rate': '\$30/hr'},
  ];

  void _removeFromWishlist(int index) {
    setState(() {
      wishlist.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Wishlist")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: wishlist.length,
          itemBuilder: (context, index) {
            final car = wishlist[index];
            return Card(
              margin: EdgeInsets.only(bottom: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(car['image']!, width: 80, height: 60, fit: BoxFit.cover),
                ),
                title: Text(car['name']!, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                subtitle: Text(car['rate']!, style: TextStyle(fontSize: 16, color: Colors.green)),
                trailing: IconButton(
                  icon: Icon(Icons.favorite, color: Colors.red),
                  onPressed: () => _removeFromWishlist(index),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
