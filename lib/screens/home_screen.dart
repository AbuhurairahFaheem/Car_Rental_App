// import 'package:flutter/material.dart';
// import '../models/customer_model.dart';
// import '../models/car_model.dart';
// import '../services/car_services.dart';
// import 'explore_page.dart';
// import 'rented_page.dart';
// import 'wishlist_page.dart';
// import 'profile_page.dart';
// import 'searchpage.dart';
// import 'notification_page.dart';
// import 'login_page.dart';
// import 'car_details_page.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';

// class CarouselSliderWidget extends StatelessWidget {
//   final List<Map<String, dynamic>> carRecommendations;

//   const CarouselSliderWidget({required this.carRecommendations});

//   @override
//   Widget build(BuildContext context) {
//     return CarouselSlider(
//       options: CarouselOptions(
//         height: 220,
//         autoPlay: true,
//         enlargeCenterPage: true,
//         viewportFraction: 0.75,
//         autoPlayInterval: Duration(seconds: 3),
//         autoPlayCurve: Curves.fastOutSlowIn,
//         enableInfiniteScroll: true,
//       ),
//       items: carRecommendations.map((car) {
//         return Builder(
//           builder: (BuildContext context) {
//             return Container(
//               margin: const EdgeInsets.symmetric(horizontal: 8),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black26,
//                     blurRadius: 6,
//                     offset: Offset(0, 3),
//                   ),
//                 ],
//                 image: DecorationImage(
//                   image: AssetImage(car['image'] ?? 'assets/images/default_car.jpg'),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               child: Stack(
//                 children: [
//                   // dark overlay for text readability
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(16),
//                       gradient: LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
//                       ),
//                     ),
//                   ),
//                   // title and price text
//                   Positioned(
//                     left: 12,
//                     bottom: 12,
//                     right: 12,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           car['title'] ?? '',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                             shadows: [Shadow(blurRadius: 3, color: Colors.black)],
//                           ),
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           '\$${double.tryParse(car['ratePerDay'] ?? '0')?.toStringAsFixed(2) ?? '0.00'}/day',
//                           style: TextStyle(
//                             color: Colors.white70,
//                             fontSize: 14,
//                             shadows: [Shadow(blurRadius: 2, color: Colors.black)],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       }).toList(),
//     );
//   }
// }

// class HomeScreen extends StatefulWidget {
//   final Customer customer;

//   const HomeScreen({required this.customer, super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _selectedIndex = 2;
//   final PageController _pageController = PageController(initialPage: 2);

//   final List<Map<String, dynamic>> spotlightCars = [
//     {
//       'title': 'Sedan A',
//       'image': 'assets/images/car1.jpg',
//       'ratePerDay': 50.0,
//       'type': 'Sedan',
//     },
//     {
//       'title': 'SUV B',
//       'image': 'assets/images/car2.jpg',
//       'ratePerDay': 70.0,
//       'type': 'SUV',
//     },
//     {
//       'title': 'Sports C',
//       'image': 'assets/images/car3.jpg',
//       'ratePerDay': 90.0,
//       'type': 'Sports',
//     },
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//       _pageController.jumpToPage(index);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const SearchButton(),
//         actions: [
//           NotificationIcon(customerId: widget.customer.id),
//           ProfileAvatar(customer: widget.customer),
//         ],
//       ),
//       body: PageView(
//         controller: _pageController,
//         onPageChanged: (index) => setState(() => _selectedIndex = index),
//         children: [
//           ExplorePage(customer: widget.customer),
//           RentedPage(customer: widget.customer),
//           HomeContent(customer: widget.customer, spotlightCars: spotlightCars), //error: The argument type 'List<Map<String, dynamic>>' can't be assigned to the parameter type 'List<Map<String, String>>'.
//           WishlistPage(customer: widget.customer),
//           ProfilePage(customer: widget.customer),
//         ],
//       ),
//       bottomNavigationBar: _buildBottomNavigationBar(),
//     );
//   }

//   BottomNavigationBar _buildBottomNavigationBar() {
//     return BottomNavigationBar(
//       currentIndex: _selectedIndex,
//       onTap: _onItemTapped,
//       type: BottomNavigationBarType.fixed,
//       selectedItemColor: Colors.blueAccent,
//       unselectedItemColor: Colors.grey,
//       items: const [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.explore),
//           label: "Explore",
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.check_box),
//           label: "Rented",
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home),
//           label: "Home",
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.favorite),
//           label: "Wishlist",
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.person),
//           label: "Profile",
//         ),
//       ],
//     );
//   }
// }

// class SearchButton extends StatelessWidget {
//   const SearchButton({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         final customer = context.findAncestorStateOfType<_HomeScreenState>()?.widget.customer;
//         if (customer != null) {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => SearchPage(customer: customer),
//             ),
//           );
//         }
//       },
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 15),
//         decoration: BoxDecoration(
//           color: Colors.grey[100],
//           borderRadius: BorderRadius.circular(30),
//         ),
//         child: const Row(
//           children: [
//             Icon(Icons.search, color: Colors.black54),
//             SizedBox(width: 10),
//             Text("search cars", style: TextStyle(color: Colors.black54)),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class NotificationIcon extends StatelessWidget {
//   final String customerId;

//   const NotificationIcon({required this.customerId, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       icon: const Icon(Icons.notifications),
//       onPressed: () => Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => NotificationsPage(customerId: customerId),
//         ),
//       ),
//     );
//   }
// }

// class ProfileAvatar extends StatelessWidget {
//   final Customer customer;

//   const ProfileAvatar({required this.customer, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return PopupMenuButton<String>(
//       icon: CircleAvatar(
//         backgroundImage: customer.profileImageUrl.isNotEmpty
//             ? NetworkImage(customer.profileImageUrl)
//             : null,
//         child: customer.profileImageUrl.isEmpty
//             ? const Icon(Icons.person)
//             : null,
//       ),
//       onSelected: (value) {
//         if (value == 'profile') {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => ProfilePage(customer: customer),
//             ),
//           );
//         } else if (value == 'logout') {
//           _logout(context);
//         }
//       },
//       itemBuilder: (context) => [
//         const PopupMenuItem(value: 'profile', child: Text('Profile')),
//         const PopupMenuItem(value: 'logout', child: Text('Logout')),
//       ],
//     );
//   }

//   void _logout(BuildContext context) {
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (context) => const LoginScreen()),
//           (route) => false,
//     );
//   }
// }

// class HomeContent extends StatelessWidget {
//   final Customer customer;
//   final List<Map<String, dynamic>> spotlightCars;

//   HomeContent({
//     Key? key,
//     required this.customer,
//     required this.spotlightCars,
//   }) : super(key: key);

//   final List<Map<String, dynamic>> _categories = [
//     {'name': 'Sedan', 'icon': Icons.directions_car},
//     {'name': 'SUV', 'icon': Icons.airport_shuttle},
//     {'name': 'Sports', 'icon': Icons.sports_score},
//     {'name': 'Luxury', 'icon': Icons.star},
//     {'name': 'Electric', 'icon': Icons.electric_car},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             const SectionTitle(title: "Spotlight"),
//             CarouselSliderWidget(carRecommendations: spotlightCars),
//             const SizedBox(height: 20),
//             const SectionTitle(title: "Categories"),
//             _buildCategories(context),
//             const SizedBox(height: 20),
//             const SectionTitle(title: "Recommendations"),
//             _buildRecommendations(),
//           ],
//         ),
//       ),
//      // bottomNavigationBar: _buildBottomNavigationBar(context),
//     );
//   }

//   Widget _buildCategories(BuildContext context) {
//     return Wrap(
//       spacing: 10,
//       children: _categories.map((category) {   // error: Undefined name '_categories'.
//         return ActionChip(
//           label: Text(category['name']),
//           avatar: Icon(category['icon']),
//           onPressed: () => _showCarsByCategory(context, category['name']),
//         );
//       }).toList(),
//     );
//   }

//   void _showCarsByCategory(BuildContext context, String categoryName) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => _CategoryCarsPage(
//           categoryName: categoryName,
//           customer: customer,
//         ),
//       ),
//     );
//   }

//   Widget _buildRecommendations() {
//     return FutureBuilder<List<Car>>(
//       future: CarService.getRecommendedCars(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return const Center(child: Text("No recommendations available"));
//         }

//         return ListView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: snapshot.data!.length,
//           itemBuilder: (context, index) {
//             final car = snapshot.data![index];
//             return ListTile(
//               leading: car.imageURL.isNotEmpty
//                   ? Image.network(car.imageURL, width: 50, height: 50)
//                   : const Icon(Icons.directions_car),
//               title: Text(car.title),
//               subtitle: Text('\$${car.ratePerDay}/day'),
//               onTap: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => CarDetailsPage(
//                     car: car,
//                     customer: customer,
//                   ),
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }

// class _CategoryCarsPage extends StatelessWidget {
//   final String categoryName;
//   final Customer customer;

//   const _CategoryCarsPage({
//     required this.categoryName,
//     required this.customer,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(categoryName)),
//       body: FutureBuilder<List<Car>>(
//         future: CarService.getAllCars(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (!snapshot.hasData) {
//             return const Center(child: Text("Error loading cars"));
//           }

//           final cars = snapshot.data!.where((car) => car.type == categoryName).toList();

//           if (cars.isEmpty) {
//             return Center(child: Text("No $categoryName cars available"));
//           }

//           return ListView.builder(
//             itemCount: cars.length,
//             itemBuilder: (context, index) {
//               final car = cars[index];
//               return ListTile(
//                 leading: car.imageURL.isNotEmpty
//                     ? Image.network(car.imageURL, width: 50, height: 50)
//                     : const Icon(Icons.directions_car),
//                 title: Text(car.title),
//                 subtitle: Text('\$${car.ratePerDay}/day'),
//                 onTap: () => Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => CarDetailsPage(car: car, customer: customer),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//       //bottomNavigationBar: _buildBottomNavigationBar(context),
//     );
//   }
// }

// class SectionTitle extends StatelessWidget {
//   final String title;

//   const SectionTitle({required this.title, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Text(
//         title,
//         style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//       ),
//     );
//   }
// }

// Widget _buildBottomNavigationBar(BuildContext context) {
//   return BottomNavigationBar(
//     currentIndex: 2, // Home is selected
//     type: BottomNavigationBarType.fixed,
//     selectedItemColor: Colors.blueAccent,
//     unselectedItemColor: Colors.grey,
//     onTap: (index) => _onItemTapped(context, index),
//     items: const [
//       BottomNavigationBarItem(
//         icon: Icon(Icons.explore),
//         label: "Explore",
//       ),
//       BottomNavigationBarItem(
//         icon: Icon(Icons.check_box),
//         label: "Rented",
//       ),
//       BottomNavigationBarItem(
//         icon: Icon(Icons.home),
//         label: "Home",
//       ),
//       BottomNavigationBarItem(
//         icon: Icon(Icons.favorite),
//         label: "Wishlist",
//       ),
//       BottomNavigationBarItem(
//         icon: Icon(Icons.person),
//         label: "Profile",
//       ),
//     ],
//   );
// }
//
// void _onItemTapped(BuildContext context, int index) {
//   if (index == 2) return; // Already on home
//
//   Navigator.pushReplacement(
//     context,
//     MaterialPageRoute(
//       builder: (context) => _getPageForIndex(index),
//     ),
//   );
// }
//
// Widget _getPageForIndex(int index) {
//   switch (index) {
//     case 0:
//       return ExplorePage(customer: customer);
//     case 1:
//       return RentedPage(customer: customer);
//     case 3:
//       return WishlistPage(customer: customer);
//     case 4:
//       return ProfilePage(customer: customer);
//     default:
//       return HomeScreen(customer: customer);
//   }
// }

// Widget _buildSpotlightCars() {
//   return SizedBox(
//     height: 200,
//     child: ListView.builder(
//       scrollDirection: Axis.horizontal,
//       itemCount: spotlightCars.length,
//       itemBuilder: (context, index) {
//         final car = spotlightCars[index];
//         return Container(
//           width: 150,
//           margin: const EdgeInsets.only(right: 10),
//           child: Column(
//             children: [
//               Expanded(
//                 child: Image.asset(
//                   car['image'] ?? 'assets/images/default_car.jpg',
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               Text(car['title'] ?? ''),
//               Text('\$${car['ratePerDay']}/day'),
//             ],
//           ),
//         );
//       },
//     ),
//   );
// }

//   BottomNavigationBar _buildBottomNavigationBar(BuildContext context) {
//     return BottomNavigationBar(
//       currentIndex: 0, // Explore is selected
//       type: BottomNavigationBarType.fixed,
//       selectedItemColor: Colors.blueAccent,
//       unselectedItemColor: Colors.grey,
//       onTap: (index) => _onItemTapped(context, index),
//       items: const [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.explore),
//           label: "Explore",
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.check_box),
//           label: "Rented",
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home),
//           label: "Home",
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.favorite),
//           label: "Wishlist",
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.person),
//           label: "Profile",
//         ),
//       ],
//     );
//   }
//
//   void _onItemTapped(BuildContext context, int index) {
//     if (index == 0) return; // Already on explore
//
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => _getPageForIndex(index),
//       ),
//     );
//   }
//
//   Widget _getPageForIndex(int index) {
//     switch (index) {
//       case 1:
//         return RentedPage(customer: customer);
//       case 2:
//         return HomeScreen(customer: customer);
//       case 3:
//         return WishlistPage(customer: customer);
//       case 4:
//         return ProfilePage(customer: customer);
//       default:
//         return ExplorePage(customer: customer);
//     }
//   }

import 'package:flutter/material.dart';
import '../models/customer_model.dart';
import '../models/car_model.dart';
import '../services/car_services.dart';
import 'explore_page.dart';
import 'rented_page.dart';
import 'wishlist_page.dart';
import 'profile_page.dart';
import 'searchpage.dart';
import 'notification_page.dart';
import 'login_page.dart';
import 'car_details_page.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselSliderWidget extends StatelessWidget {
  final List<Map<String, String>> carRecommendations;

  const CarouselSliderWidget({required this.carRecommendations, super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 220,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.75,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
      ),
      items:
          carRecommendations.map((car) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                    image: DecorationImage(
                      image: AssetImage(
                        car['image'] ?? 'assets/images/default_car.jpg',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 12,
                        bottom: 12,
                        right: 12,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              car['title'] ?? '',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                shadows: [
                                  Shadow(blurRadius: 3, color: Colors.black),
                                ],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '\$${car['ratePerDay'] ?? '0.00'}/day',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                                shadows: [
                                  Shadow(blurRadius: 2, color: Colors.black),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }).toList(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final Customer customer;

  const HomeScreen({required this.customer, super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 2;
  final PageController _pageController = PageController(initialPage: 2);

  final List<Map<String, String>> spotlightCars = [
    {
      'title': 'Merceded',
      'image': 'assets/images/car7.jpg',
      'ratePerDay': '250.00',
      'type': 'Sedan',
    },
    {
      'title': 'Fortuner',
      'image': 'assets/images/car2.jpg',
      'ratePerDay': '100.0',
      'type': 'SUV',
    },
    {
      'title': 'Honda Civic',
      'image': 'assets/images/car4.jpg',
      'ratePerDay': '90.0',
      'type': 'Sedan',
    },
    {
      'title': 'Land cruiser',
      'image': 'assets/images/car5.jpeg',
      'ratePerDay': '100.0',
      'type': 'SUV',
    },
    {
      'title': 'MG ZS EV',
      'image': 'assets/images/car6.jpeg',
      'ratePerDay': '120.0',
      'type': 'Electric',
    },
    {
      'title': 'Chevrolet Camaro',
      'image': 'assets/images/car8.jpg',
      'ratePerDay': '120.0',
      'type': 'Sports',
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const SearchButton(),
        actions: [
          NotificationIcon(customerId: widget.customer.id),
          ProfileAvatar(customer: widget.customer),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) => setState(() => _selectedIndex = index),
        children: [
          ExplorePage(customer: widget.customer),
          RentedPage(customer: widget.customer),
          HomeContent(customer: widget.customer, spotlightCars: spotlightCars),
          WishlistPage(customer: widget.customer),
          ProfilePage(customer: widget.customer),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blueAccent,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Explore"),
        BottomNavigationBarItem(icon: Icon(Icons.check_box), label: "Rented"),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Wishlist"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
    );
  }
}

class SearchButton extends StatelessWidget {
  const SearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final customer =
            context
                .findAncestorStateOfType<_HomeScreenState>()
                ?.widget
                .customer;
        if (customer != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchPage(customer: customer),
            ),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Row(
          children: [
            Icon(Icons.search, color: Colors.black54),
            SizedBox(width: 10),
            Text("search cars", style: TextStyle(color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}

class NotificationIcon extends StatelessWidget {
  final String customerId;

  const NotificationIcon({required this.customerId, super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.notifications),
      onPressed:
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NotificationsPage(customerId: customerId),
            ),
          ),
    );
  }
}

class ProfileAvatar extends StatelessWidget {
  final Customer customer;

  const ProfileAvatar({required this.customer, super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: CircleAvatar(
        backgroundImage:
            customer.profileImageUrl.isNotEmpty
                ? NetworkImage(customer.profileImageUrl)
                : null,
        child:
            customer.profileImageUrl.isEmpty ? const Icon(Icons.person) : null,
      ),
      onSelected: (value) {
        if (value == 'profile') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfilePage(customer: customer),
            ),
          );
        } else if (value == 'logout') {
          _logout(context);
        }
      },
      itemBuilder:
          (context) => const [
            PopupMenuItem(value: 'profile', child: Text('Profile')),
            PopupMenuItem(value: 'logout', child: Text('Logout')),
          ],
    );
  }

  void _logout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }
}

class HomeContent extends StatelessWidget {
  final Customer customer;
  final List<Map<String, String>> spotlightCars;

  HomeContent({super.key, required this.customer, required this.spotlightCars});

  final List<Map<String, dynamic>> _categories = const [
    {'name': 'Sedan', 'icon': Icons.directions_car},
    {'name': 'SUV', 'icon': Icons.airport_shuttle},
    {'name': 'Sports', 'icon': Icons.sports_score},
    {'name': 'Luxury', 'icon': Icons.star},
    {'name': 'Electric', 'icon': Icons.electric_car},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SectionTitle(title: "Spotlight"),
            CarouselSliderWidget(carRecommendations: spotlightCars),
            const SizedBox(height: 20),
            const SectionTitle(title: "Categories"),
            _buildCategories(context),
            const SizedBox(height: 20),
            const SectionTitle(title: "Recommendations"),
            _buildRecommendations(),
          ],
        ),
      ),
    );
  }

  Widget _buildCategories(BuildContext context) {
    return Wrap(
      spacing: 10,
      children:
          _categories.map((category) {
            return ActionChip(
              label: Text(category['name']),
              avatar: Icon(category['icon']),
              onPressed: () => _showCarsByCategory(context, category['name']),
            );
          }).toList(),
    );
  }

  void _showCarsByCategory(BuildContext context, String categoryName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => _CategoryCarsPage(
              categoryName: categoryName,
              customer: customer,
            ),
      ),
    );
  }

  Widget _buildRecommendations() {
    return FutureBuilder<List<Car>>(
      future: CarService.getRecommendedCars(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No recommendations available"));
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final car = snapshot.data![index];
            return ListTile(
              leading:
                  car.imageURL.isNotEmpty
                      ? Image.network(car.imageURL, width: 50, height: 50)
                      : const Icon(Icons.directions_car),
              title: Text(car.title),
              subtitle: Text('\$${car.ratePerDay}/day'),
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              CarDetailsPage(car: car, customer: customer),
                    ),
                  ),
            );
          },
        );
      },
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _CategoryCarsPage extends StatelessWidget {
  final String categoryName;
  final Customer customer;

  const _CategoryCarsPage({required this.categoryName, required this.customer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(categoryName)),
      body: FutureBuilder<List<Car>>(
        future: CarService.getAllCars(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return const Center(child: Text("Error loading cars"));
          }

          final cars =
              snapshot.data!.where((car) => car.type == categoryName).toList();

          if (cars.isEmpty) {
            return Center(child: Text("No cars available in this category."));
          }

          return ListView.builder(
            itemCount: cars.length,
            itemBuilder: (context, index) {
              final car = cars[index];
              return ListTile(
                leading:
                    car.imageURL.isNotEmpty
                        ? Image.network(car.imageURL, width: 50, height: 50)
                        : const Icon(Icons.directions_car),
                title: Text(car.title),
                subtitle: Text('\$${car.ratePerDay}/day'),
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                CarDetailsPage(car: car, customer: customer),
                      ),
                    ),
              );
            },
          );
        },
      ),
    );
  }
}
