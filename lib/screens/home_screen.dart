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
import 'searchpage.dart';
import 'car_details_page.dart';
import 'notification_page.dart';
import 'rented_page.dart';
import 'wishlist_page.dart';
import 'profile_page.dart';
import 'explore_page.dart';
import 'category_cars_page.dart';

// Main Home Screen class
class HomeScreen extends StatefulWidget {
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
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Explore"),
          BottomNavigationBarItem(icon: Icon(Icons.check_box), label: "Rented"),
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

// Search Button Widget
class SearchButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchPage()),
        );
      },
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            Icon(Icons.search, color: Colors.black54),
            SizedBox(width: 10),
            Text(
              "Search cars...",
              style: TextStyle(color: Colors.black54, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

// Notification Icon Widget
class NotificationIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Stack(
        children: [
          Icon(Icons.notifications, color: Colors.black54, size: 28),
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Text(
                '3',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NotificationsPage()),
        );
      },
    );
  }
}

// Profile Avatar Widget
class ProfileAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      backgroundImage: AssetImage("assets/images/profile.jpeg"),
      backgroundColor: Colors.grey[200],
    );
  }
}

// Home Content Widget
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

  final List<String> categories = ["SUV", "Sedan", "Luxury", "Electric"];

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
          CategoriesWrap(categories: categories),
          SectionTitle(title: "Recommendations"),
          RecommendationsList(carRecommendations: carRecommendations),
        ],
      ),
    );
  }
}

// Section Title Widget
class SectionTitle extends StatelessWidget {
  final String title;
  SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    );
  }
}

// Carousel Slider Widget
class CarouselSliderWidget extends StatelessWidget {
  final List<Map<String, String>> carRecommendations;
  CarouselSliderWidget({required this.carRecommendations});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(autoPlay: true, enlargeCenterPage: true),
      items:
          carRecommendations.map((car) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage(car['image']!),
                  fit: BoxFit.cover,
                ),
              ),
            );
          }).toList(),
    );
  }
}

// Categories Wrap Widget
class CategoriesWrap extends StatelessWidget {
  final List<String> categories;
  CategoriesWrap({required this.categories});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children:
          categories.map((category) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => CategoryCarsPage(categoryName: category),
                  ),
                );
              },
              child: Chip(
                label: Text(category, style: TextStyle(fontSize: 16)),
                backgroundColor: Colors.white,
                elevation: 2,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              ),
            );
          }).toList(),
    );
  }
}

// Recommendations List Widget
class RecommendationsList extends StatelessWidget {
  final List<Map<String, String>> carRecommendations;
  RecommendationsList({required this.carRecommendations});

  @override
  Widget build(BuildContext context) {
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
                builder:
                    (context) => CarDetailsPage(
                      carImage: car['image']!,
                      carName: car['name']!,
                      carType: car['type']!,
                      carRate: car['rate']!,
                    ),
              ),
            );
          },
          child: CarRecommendationCard(car: car),
        );
      },
    );
  }
}

// Car Recommendation Card Widget
class CarRecommendationCard extends StatelessWidget {
  final Map<String, String> car;
  CarRecommendationCard({required this.car});

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
              child: Image.asset(
                car['image']!,
                width: 120,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  car['name']!,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  car['type']!,
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
                SizedBox(height: 5),
                Text(
                  car['rate']!,
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
