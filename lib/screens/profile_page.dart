// import 'package:flutter/material.dart';
// import 'history_page.dart'; // Import HistoryPage

// class ProfilePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Profile", style: TextStyle(fontSize: 20))),

//       body: Column(
//         children: [
//           SizedBox(height: 20),
//           CircleAvatar(
//             radius: 50,
//             backgroundColor: const Color.fromARGB(255, 219, 221, 224),
//             backgroundImage: AssetImage("assets/images/profile.jpeg"),
//           ),

//           SizedBox(height: 10),
//           Text(
//             "User Name",
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 20),
//           CustomButton(title: "Personal Info", onTap: () {}),
//           CustomButton(
//             title: "History",
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => HistoryPage()),
//               );
//             },
//           ),
//           CustomButton(title: "Privacy Policy", onTap: () {}),
//           CustomButton(title: "About", onTap: () {}),
//         ],
//       ),
//     );
//   }
// }

// class CustomButton extends StatelessWidget {
//   final String title;
//   final VoidCallback onTap;

//   CustomButton({required this.title, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.grey[200],
//           padding: EdgeInsets.symmetric(vertical: 15),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//           minimumSize: Size(double.infinity, 50),
//         ),
//         onPressed: onTap,
//         child: Text(
//           title,
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: const Color.fromARGB(255, 0, 0, 0),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'history_page.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const ProfileAvatar(),
            const SizedBox(height: 10),
            const ProfileInfo(userName: "User Name"),
            const SizedBox(height: 20),
            ProfileActionButton(
              title: "Personal Info",
              onTap: () {
                // Navigate to Personal Info Page
              },
            ),
            ProfileActionButton(
              title: "History",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HistoryPage()),
                );
              },
            ),
            ProfileActionButton(
              title: "Privacy Policy",
              onTap: () {
                // Navigate to Privacy Policy Page
              },
            ),
            ProfileActionButton(
              title: "About",
              onTap: () {
                // Navigate to About Page
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Reusable Widget for Avatar
class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 50,
      backgroundImage: AssetImage("assets/images/profile.jpeg"),
    );
  }
}

// Reusable Widget for User Info
class ProfileInfo extends StatelessWidget {
  final String userName;

  const ProfileInfo({required this.userName, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      userName,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}

class ProfileActionButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const ProfileActionButton({
    required this.title,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[200],
            foregroundColor: Colors.black,
          ),
          onPressed: onTap,
          child: Text(title),
        ),
      ),
    );
  }
}
