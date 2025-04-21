// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'searchpage.dart';
// import 'car_details_page.dart';
// import 'notification_page.dart';
// import 'rented_page.dart';
// import 'wishlist_page.dart';
// import 'profile_page.dart';
// import 'explore_page.dart';
// import 'category_cars_page.dart';

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _selectedIndex = 2; // ✅ Default to Home
//   final PageController _pageController = PageController(initialPage: 2);

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//       _pageController.jumpToPage(index); // ✅ Ensure correct navigation
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: GestureDetector(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => SearchPage()),
//             );
//           },
//           child: Container(
//             height: 45,
//             decoration: BoxDecoration(
//               //ye ha profile button
//               color: Colors.grey[100],
//               borderRadius: BorderRadius.circular(30),
//             ),
//             padding: EdgeInsets.symmetric(horizontal: 15),
//             child: Row(
//               children: [
//                 Icon(Icons.search, color: Colors.black54),
//                 SizedBox(width: 10),
//                 Text(
//                   "Search cars...",
//                   style: TextStyle(color: Colors.black54, fontSize: 16),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: Stack(
//               children: [
//                 Icon(Icons.notifications, color: Colors.black54, size: 28),
//                 Positioned(
//                   right: 0,
//                   top: 0,
//                   child: Container(
//                     padding: EdgeInsets.all(4),
//                     decoration: BoxDecoration(
//                       color: Colors.red,
//                       shape: BoxShape.circle,
//                     ),
//                     child: Text(
//                       '3',
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => NotificationsPage()),
//               );
//             },
//           ),
//           SizedBox(width: 10),
//           CircleAvatar(
//             radius: 20,
//             backgroundImage: AssetImage(
//               "assets/images/profile.jpeg",
//             ), // ✅ Default Image
//             backgroundColor: Colors.grey[200], // ✅ Fallback Color
//           ),

//           SizedBox(width: 10),
//         ],
//       ),

//       // 📄 PageView for switching between pages
//       body: PageView(
//         controller: _pageController,
//         onPageChanged: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//         children: [
//           ExplorePage(), // ✅ Index 0: Explore
//           RentedPage(), // ✅ Index 1: Rented
//           HomeContent(), // ✅ Index 2: Home
//           WishlistPage(), // ✅ Index 3: Wishlist
//           ProfilePage(), // ✅ Index 4: Profile
//         ],
//       ),

//       // 🔽 Bottom Navigation Bar
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         selectedItemColor: Colors.blueAccent,
//         unselectedItemColor: Colors.grey,
//         showUnselectedLabels: true,
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.explore),
//             label: "Explore",
//           ), // Placeholder
//           BottomNavigationBarItem(
//             icon: Icon(Icons.check_box),
//             label: "Rented",
//           ), // ✅ Rented Page
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: "Home",
//           ), // Home Page
//           BottomNavigationBarItem(
//             icon: Icon(Icons.favorite),
//             label: "Wishlist",
//           ), // ✅ Wishlist Page
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: "Profile",
//           ), // Profile Page
//         ],
//       ),
//     );
//   }
// }

// // 🎯 Extracted Home Content for readability
// class HomeContent extends StatelessWidget {
//   final List<Map<String, String>> carRecommendations = [
//     {
//       'image': 'assets/images/car1.jpeg',
//       'name': 'Tesla Model S',
//       'type': 'Electric',
//       'rate': '\$25/hr',
//     },
//     {
//       'image': 'assets/images/car2.jpg',
//       'name': 'BMW X5',
//       'type': 'SUV',
//       'rate': '\$30/hr',
//     },
//     {
//       'image': 'assets/images/car3.jpeg',
//       'name': 'Mercedes C-Class',
//       'type': 'Luxury',
//       'rate': '\$28/hr',
//     },
//   ];

//   final List<String> categories = ["SUV", "Sedan", "Luxury", "Electric"];

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Spotlight",
//             style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 10),
//           CarouselSlider(
//             options: CarouselOptions(autoPlay: true, enlargeCenterPage: true),
//             items:
//                 carRecommendations.map((car) {
//                   return Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15),
//                       image: DecorationImage(
//                         image: AssetImage(car['image']!),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   );
//                 }).toList(),
//           ),
//           SizedBox(height: 20),
//           Text(
//             "Categories",
//             style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 10),
//           Wrap(
//             spacing: 10,
//             children:
//                 categories.map((category) {
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder:
//                               (context) =>
//                                   CategoryCarsPage(categoryName: category),
//                         ),
//                       );
//                     },
//                     child: Chip(
//                       label: Text(category, style: TextStyle(fontSize: 16)),
//                       backgroundColor: Colors.white,
//                       elevation: 2,
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 15,
//                         vertical: 10,
//                       ),
//                     ),
//                   );
//                 }).toList(),
//           ),

//           SizedBox(height: 20),
//           Text(
//             "Recommendations",
//             style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 10),
//           ListView.builder(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: carRecommendations.length,
//             itemBuilder: (context, index) {
//               final car = carRecommendations[index];
//               return InkWell(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder:
//                           (context) => CarDetailsPage(
//                             carImage: car['image']!,
//                             carName: car['name']!,
//                             carType: car['type']!,
//                             carRate: car['rate']!,
//                           ),
//                     ),
//                   );
//                 },
//                 child: Card(
//                   margin: EdgeInsets.only(bottom: 15),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: Row(
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(10),
//                           child: Image.asset(
//                             car['image']!,
//                             width: 120,
//                             height: 80,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         SizedBox(width: 15),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               car['name']!,
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             SizedBox(height: 5),
//                             Text(
//                               car['type']!,
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.grey[700],
//                               ),
//                             ),
//                             SizedBox(height: 5),
//                             Text(
//                               car['rate']!,
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.green,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'searchpage.dart';
import 'login_page.dart';
import 'car_details_page.dart';
import 'notification_page.dart';
import 'rented_page.dart';
import 'wishlist_page.dart';
import 'profile_page.dart';
import 'explore_page.dart';
import 'category_cars_page.dart';
import '../models/user_models.dart';

class HomeScreen extends StatefulWidget {
  final UserModel user;

  const HomeScreen({super.key, required this.user});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 2;
  final PageController _pageController = PageController(initialPage: 2);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: SearchButton(),
        actions: [NotificationIcon(), ProfileAvatar()],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          ExplorePage(),
          RentedPage(),
          HomeContent(),
          WishlistPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Explore"),
          BottomNavigationBarItem(icon: Icon(Icons.check_box), label: "Rented"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Wishlist"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

class SearchButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
      },
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: const [
            Icon(Icons.search, color: Colors.black54),
            SizedBox(width: 10),
            Text("Search cars...", style: TextStyle(color: Colors.black54, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class NotificationIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Stack(
        children: [
          const Icon(Icons.notifications, color: Colors.black54, size: 28),
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
              child: const Text(
                '',
                style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationsPage()));
      },
    );
  }
}

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: CircleAvatar(
        radius: 20,
        backgroundImage: AssetImage("assets/images/profile.jpeg"),
        backgroundColor: Colors.grey[200],
      ),
      onSelected: (value) async {
        if (value == 'profile') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ProfilePage()),
          );
        } else if (value == 'logout') {
          final shouldLogout = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Confirm Logout'),
              content: const Text('Are you sure you want to log out?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text('Logout'),
                ),
              ],
            ),
          );

          if (shouldLogout == true) {
            await _logout(context);
          }
        }
      },
      itemBuilder: (BuildContext context) => [
        const PopupMenuItem(
          value: 'profile',
          child: Text('See Profile Info'),
        ),
        const PopupMenuItem(
          value: 'logout',
          child: Text('Log Out'),
        ),
      ],
    );
  }

  Future<void> _logout(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('user_uid'); // remove saved login

      // Navigate to login screen, clearing navigation stack
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
            (route) => false,
      );
    } catch (e) {
      print('Logout Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logout failed. Please try again.')),
      );
    }
  }
}

class HomeContent extends StatelessWidget {
  final List<Map<String, String>> carRecommendations = [
    {
      'image': 'assets/images/car1.jpeg',
      'name': 'Tesla Model S',
      'type': 'Electric',
      'rate': '\$25/hr',
    },
    {
      'image': 'assets/images/car2.jpg',
      'name': 'BMW X5',
      'type': 'SUV',
      'rate': '\$30/hr',
    },
    {
      'image': 'assets/images/car3.jpeg',
      'name': 'Mercedes C-Class',
      'type': 'Luxury',
      'rate': '\$28/hr',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: "Spotlight"),
          CarouselSliderWidget(carRecommendations: carRecommendations),
          SectionTitle(title: "Categories"),
          CategoriesWrap(),
          SectionTitle(title: "Recommendations"),
          RecommendationsList(), // This works now!
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
    );
  }
}

class CarouselSliderWidget extends StatelessWidget {
  final List<Map<String, String>> carRecommendations;

  const CarouselSliderWidget({required this.carRecommendations});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(autoPlay: true, enlargeCenterPage: true),
      items: carRecommendations.map((car) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: AssetImage(car['image'] ?? 'assets/images/default_car.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        );
      }).toList(),
    );
  }
}

class CategoriesWrap extends StatelessWidget {
  Future<List<String>> fetchCategories() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('categories').get();
      return snapshot.docs.map((doc) => doc['name'] as String).toList();
    } catch (e) {
      print("Error fetching categories: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: fetchCategories(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No categories found"));
        }

        final categories = snapshot.data!;

        return Wrap(
          spacing: 10,
          children: categories.map((category) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CategoryCarsPage(categoryName: category)),
                );
              },
              child: Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(30),
                child: Chip(
                  label: Text(category, style: TextStyle(fontSize: 16)),
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class RecommendationsList extends StatelessWidget {
  Future<List<Map<String, dynamic>>> fetchCarRecommendations() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('cars')
          .where('recommendation', isEqualTo: true)
          .get();

      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print("Error fetching car recommendations: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchCarRecommendations(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No recommendations available"));
        }

        final carRecommendations = snapshot.data!;

        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: carRecommendations.length,
          itemBuilder: (context, index) {
            final car = carRecommendations[index];
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CarDetailsPage(car: car), // ✅ assumes CarDetailsPage takes a 'car' map
                  ),
                );
              },
              child: CarRecommendationCard(
                car: {
                  'image': car['imageURL'] ?? '',
                  'name': car['title'] ?? '',
                  'type': car['type'] ?? '',
                  'rate': car['ratePerDay'] ?? '',
                },
              ),
            );
          },
        );
      },
    );
  }
}



class CarRecommendationCard extends StatelessWidget {
  final Map<String, dynamic> car;

  const CarRecommendationCard({required this.car});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                car['imageURL'] ?? '',
                width: 120,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.broken_image, size: 80),
              ),
            ),
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  car['title'] ?? '',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  car['type'] ?? '',
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
                SizedBox(height: 5),
                Text(
                  car['ratePerDay'] ?? '',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
