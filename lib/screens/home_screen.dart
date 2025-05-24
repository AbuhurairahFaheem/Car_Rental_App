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
import '../models/customer_model.dart';
import '../models/car_model.dart';
import '../services/car_services.dart';
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

class HomeScreen extends StatefulWidget {
  final Customer customer;

  const HomeScreen({required this.customer, super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 2;
  final PageController _pageController = PageController(initialPage: 2);
  final List<Map<String, dynamic>> _categories = [
    {'name': 'Sedan', 'icon': Icons.directions_car},
    {'name': 'SUV', 'icon': Icons.airport_shuttle},
    {'name': 'Sports', 'icon': Icons.sports_score},
    {'name': 'Luxury', 'icon': Icons.star},
    {'name': 'Electric', 'icon': Icons.electric_car},
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
  HomeContent(customer: widget.customer),
  WishlistPage(customer: widget.customer),
  ProfilePage(customer: widget.customer),
  ],
  ),
  bottomNavigationBar: BottomNavigationBar(
  currentIndex: _selectedIndex,
  onTap: _onItemTapped,
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
  const SearchButton({super.key});

  @override
  Widget build(BuildContext context) {
  return GestureDetector(
  onTap: () {
  final customer = context.findAncestorStateOfType<_HomeScreenState>()?.widget.customer;
  if (customer != null) {
  Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => SearchPage(customer: customer)),
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
  Text("Search cars...", style: TextStyle(color: Colors.black54)),
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
  onPressed: () => Navigator.push(
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
  backgroundImage: customer.profileImageUrl.isNotEmpty
  ? NetworkImage(customer.profileImageUrl)
      : null,
  child: customer.profileImageUrl.isEmpty
  ? const Icon(Icons.person)
      : null,
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
  itemBuilder: (context) => [
  const PopupMenuItem(value: 'profile', child: Text('Profile')),
  const PopupMenuItem(value: 'logout', child: Text('Logout')),
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

  const HomeContent({required this.customer, super.key});

  @override
  Widget build(BuildContext context) {
  return SingleChildScrollView(
  padding: const EdgeInsets.all(16),
  child: Column(
  children: [
  const SectionTitle(title: "Featured Cars"),
  _buildFeaturedCars(),
  const SizedBox(height: 20),
  const SectionTitle(title: "Categories"),
  _buildCategories(context),
  const SizedBox(height: 20),
  const SectionTitle(title: "Recommendations"),
  _buildRecommendations(),
  ],
  ),
  );
  }

  Widget _buildFeaturedCars() {
  return FutureBuilder<List<Car>>(
  future: CarService.getFeaturedCars(),
  builder: (context, snapshot) {
  if (snapshot.connectionState == ConnectionState.waiting) {
  return const Center(child: CircularProgressIndicator());
  }
  if (!snapshot.hasData || snapshot.data!.isEmpty) {
  return const Center(child: Text("No featured cars available"));
  }

  return SizedBox(
  height: 200,
  child: ListView.builder(
  scrollDirection: Axis.horizontal,
  itemCount: snapshot.data!.length,
  itemBuilder: (context, index) {
  final car = snapshot.data![index];
  return GestureDetector(
  onTap: () => Navigator.push(
  context,
  MaterialPageRoute(
  builder: (context) => CarDetailsPage(
  car: car,
  customer: customer,
  ),
  ),
  ),
  child: Container(
  width: 150,
  margin: const EdgeInsets.only(right: 10),
  child: Column(
  children: [
  Expanded(
  child: car.imageURL.isNotEmpty
  ? Image.network(car.imageURL, fit: BoxFit.cover)
      : const Icon(Icons.directions_car, size: 50),
  ),
  Text(car.title),
  Text('\$${car.ratePerDay}/day'),
  ],
  ),
  ),
  );
  },
  ),
  );
  },
  );
  }

  Widget _buildCategories(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {'name': 'Sedan', 'icon': Icons.directions_car},
      {'name': 'SUV', 'icon': Icons.airport_shuttle},
      {'name': 'Sports', 'icon': Icons.sports_score},
      {'name': 'Luxury', 'icon': Icons.star},
      {'name': 'Electric', 'icon': Icons.electric_car},
    ];

  return Wrap(
  spacing: 10,
  children: categories.map((category) {
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
  builder: (context) => _CategoryCarsPage(
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
  leading: car.imageURL.isNotEmpty
  ? Image.network(car.imageURL, width: 50, height: 50)
      : const Icon(Icons.directions_car),
  title: Text(car.title),
  subtitle: Text('\$${car.ratePerDay}/day'),
  onTap: () => Navigator.push(
  context,
  MaterialPageRoute(
  builder: (context) => CarDetailsPage(
  car: car,
  customer: customer,
  ),
  ),
  ),
  );
  },
  );
  },
  );
  }
  }

  class _CategoryCarsPage extends StatelessWidget {
  final String categoryName;
  final Customer customer;

  const _CategoryCarsPage({
  required this.categoryName,
  required this.customer,
  });

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

  final cars = snapshot.data!.where((car) => car.type == categoryName).toList();

  if (cars.isEmpty) {
  return Center(child: Text("No $categoryName cars available"));
  }

  return ListView.builder(
  itemCount: cars.length,
  itemBuilder: (context, index) {
  final car = cars[index];
  return ListTile(
  leading: car.imageURL.isNotEmpty
  ? Image.network(car.imageURL, width: 50, height: 50)
      : const Icon(Icons.directions_car),
  title: Text(car.title),
  subtitle: Text('\$${car.ratePerDay}/day'),
  onTap: () => Navigator.push(
  context,
  MaterialPageRoute(
  builder: (context) => CarDetailsPage(car: car, customer: customer),
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

  class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
  return Padding(
  padding: const EdgeInsets.symmetric(vertical: 8),
  child: Text(
  title,
  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  ),
  );
  }
  }