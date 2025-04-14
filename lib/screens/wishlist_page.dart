// import 'package:flutter/material.dart';

// class WishlistPage extends StatefulWidget {
//   @override
//   _WishlistPageState createState() => _WishlistPageState();
// }

// class _WishlistPageState extends State<WishlistPage> {
//   List<Map<String, String>> wishlist = [
//     {'image': 'assets/images/car1.jpeg', 'name': 'Tesla Model S', 'rate': '\$25/hr'},
//     {'image': 'assets/images/car2.jpg', 'name': 'BMW X5', 'rate': '\$30/hr'},
//   ];

//   void _removeFromWishlist(int index) {
//     setState(() {
//       wishlist.removeAt(index);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Wishlist")),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: ListView.builder(
//           itemCount: wishlist.length,
//           itemBuilder: (context, index) {
//             final car = wishlist[index];
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
//                 trailing: IconButton(
//                   icon: Icon(Icons.favorite, color: Colors.red),
//                   onPressed: () => _removeFromWishlist(index),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  final List<Map<String, String>> _wishlist = [
    {
      'image': 'assets/images/car1.jpeg',
      'name': 'Tesla Model S',
      'rate': '\$25/hr',
    },
    {'image': 'assets/images/car2.jpg', 'name': 'BMW X5', 'rate': '\$30/hr'},
  ];

  void _removeFromWishlist(int index) {
    setState(() {
      _wishlist.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wishlist")),
      body: WishlistContent(wishlist: _wishlist, onRemove: _removeFromWishlist),
    );
  }
}

class WishlistContent extends StatelessWidget {
  final List<Map<String, String>> wishlist;
  final Function(int) onRemove;

  const WishlistContent({
    required this.wishlist,
    required this.onRemove,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: wishlist.length,
        itemBuilder: (context, index) {
          return WishlistItem(
            car: wishlist[index],
            onRemove: () => onRemove(index),
          );
        },
      ),
    );
  }
}

class WishlistItem extends StatelessWidget {
  final Map<String, String> car;
  final VoidCallback onRemove;

  const WishlistItem({required this.car, required this.onRemove, super.key});

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
        trailing: IconButton(
          icon: const Icon(Icons.favorite, color: Colors.red),
          onPressed: onRemove,
        ),
      ),
    );
  }
}
