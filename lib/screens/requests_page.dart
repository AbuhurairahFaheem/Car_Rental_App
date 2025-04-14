// import 'package:flutter/material.dart';

// void main() {
//   runApp(RequestsApp());
// }

// class RequestsApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(debugShowCheckedModeBanner: false, home: RequestsPage());
//   }
// }

// class RequestsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('My Requests'), centerTitle: true),
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             RequestButton(title: 'Pending'),
//             SizedBox(height: 20),
//             RequestButton(title: 'Approved'),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: 1, // Set this to 1 if "Requests" is at index 1
//         selectedItemColor: Colors.blue, // Highlight the selected page
//         unselectedItemColor: Colors.grey, // Other icons grey
//         backgroundColor: Colors.white, // Keep it visible
//         type: BottomNavigationBarType.fixed, // Ensure all labels are visible
//         items: [
//           BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Explore"),
//           BottomNavigationBarItem(icon: Icon(Icons.check), label: "Rented"),
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.favorite),
//             label: "Wishlist",
//           ),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
//         ],
//       ),
//     );
//   }
// }

// class RequestButton extends StatelessWidget {
//   final String title;

//   RequestButton({required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 40),
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.grey,
//           padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//         onPressed: () {},
//         child: Text(title, style: TextStyle(fontSize: 18, color: Colors.white)),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

void main() {
  runApp(const RequestsApp());
}

class RequestsApp extends StatelessWidget {
  const RequestsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RequestsPage(),
    );
  }
}

class RequestsPage extends StatelessWidget {
  const RequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Requests'), centerTitle: true),
      body: const Center(child: RequestButtons()),
      bottomNavigationBar: const CustomBottomNavigationBar(currentIndex: 1),
    );
  }
}

class RequestButtons extends StatelessWidget {
  const RequestButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        RequestButton(title: 'Pending'),
        SizedBox(height: 20),
        RequestButton(title: 'Approved'),
      ],
    );
  }
}

class RequestButton extends StatelessWidget {
  final String title;

  const RequestButton({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {},
        child: Text(
          title,
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavigationBar({required this.currentIndex, super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Explore"),
        BottomNavigationBarItem(icon: Icon(Icons.check), label: "Rented"),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Wishlist"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
    );
  }
}
