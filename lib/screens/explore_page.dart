import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/car_model.dart';
import '../models/customer_model.dart';
import '../services/car_services.dart';
import 'category_cars_page.dart';
import 'car_details_page.dart';
import 'searchpage.dart';

import 'package:flutter/material.dart';
import '../models/car_model.dart';
import '../models/customer_model.dart';
import '../services/car_services.dart';
import 'car_details_page.dart';

class ExplorePage extends StatefulWidget {
  final Customer customer;

  const ExplorePage({required this.customer, super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  late Future<List<Car>> _recommendedCarsFuture;
  late Future<List<Car>> _recentlyAddedCarsFuture;
  final List<Map<String, dynamic>> _categories = [
    {'name': 'Sedan', 'icon': Icons.directions_car},
    {'name': 'SUV', 'icon': Icons.airport_shuttle},
    {'name': 'Sports', 'icon': Icons.sports_score},
    {'name': 'Luxury', 'icon': Icons.star},
    {'name': 'Electric', 'icon': Icons.electric_car},
  ];


  @override
  void initState() {
  super.initState();
  _loadData();
  }

  void _loadData() {
  _recommendedCarsFuture = CarService.getRecommendedCars();
  _recentlyAddedCarsFuture = CarService.getAllCars();
  }

  Future<void> _refreshData() async {
  setState(_loadData);
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
  appBar: AppBar(
  title: const Text("Explore Cars"),
  actions: [
  IconButton(
  icon: const Icon(Icons.search),
  onPressed: () => Navigator.push(
  context,
  MaterialPageRoute(
  builder: (context) => SearchPage(customer: widget.customer),
  ),
  ),
  ),
  ],
  ),
  body: RefreshIndicator(
  onRefresh: _refreshData,
  child: SingleChildScrollView(
  padding: const EdgeInsets.all(16),
  child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  _buildCategoriesSection(),
  const SizedBox(height: 24),
  _buildRecommendedCarsSection(),
  const SizedBox(height: 24),
  _buildRecentlyAddedSection(),
  ],
  ),
  ),
  ),
  );
  }

  Widget _buildCategoriesSection() {
  return Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  const Text(
  "Categories",
  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  ),
  const SizedBox(height: 16),
  SizedBox(
  height: 100,
  child: ListView.builder(
  scrollDirection: Axis.horizontal,
  itemCount: _categories.length,
  itemBuilder: (context, index) {
  return _buildCategoryItem(_categories[index]);
  },
  ),
  ),
  ],
  );
  }

  Widget _buildCategoryItem(Map<String, dynamic> category) {
  return GestureDetector(
  onTap: () => _showCarsByCategory(category['name']),
  child: Container(
  width: 80,
  margin: const EdgeInsets.only(right: 12),
  child: Column(
  children: [
  Container(
  padding: const EdgeInsets.all(12),
  decoration: BoxDecoration(
  color: Colors.blue.withOpacity(0.2),
  shape: BoxShape.circle,
  ),
  child: Icon(category['icon'], color: Colors.blue),
  ),
  const SizedBox(height: 8),
  Text(
  category['name'],
  textAlign: TextAlign.center,
  maxLines: 2,
  overflow: TextOverflow.ellipsis,
  ),
  ],
  ),
  ),
  );
  }

  void _showCarsByCategory(String categoryName) {
  Navigator.push(
  context,
  MaterialPageRoute(
  builder: (context) => _CategoryCarsPage(
  categoryName: categoryName,
  customer: widget.customer,
  ),
  ),
  );
  }

  Widget _buildRecommendedCarsSection() {
  return Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  const Text(
  "Recommended For You",
  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  ),
  const SizedBox(height: 16),
  FutureBuilder<List<Car>>(
  future: _recommendedCarsFuture,
  builder: (context, snapshot) {
  if (snapshot.connectionState == ConnectionState.waiting) {
  return const Center(child: CircularProgressIndicator());
  }
  if (!snapshot.hasData || snapshot.data!.isEmpty) {
  return const Center(child: Text("No recommended cars"));
  }

  return SizedBox(
  height: 220,
  child: ListView.builder(
  scrollDirection: Axis.horizontal,
  itemCount: snapshot.data!.length,
  itemBuilder: (context, index) {
  return _buildCarCard(snapshot.data![index]);
  },
  ),
  );
  },
  ),
  ],
  );
  }

  Widget _buildRecentlyAddedSection() {
  return Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  const Text(
  "Recently Added",
  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  ),
  const SizedBox(height: 16),
  FutureBuilder<List<Car>>(
  future: _recentlyAddedCarsFuture,
  builder: (context, snapshot) {
  if (snapshot.connectionState == ConnectionState.waiting) {
  return const Center(child: CircularProgressIndicator());
  }
  if (!snapshot.hasData || snapshot.data!.isEmpty) {
  return const Center(child: Text("No recently added cars"));
  }

  return GridView.builder(
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  crossAxisCount: 2,
  crossAxisSpacing: 12,
  mainAxisSpacing: 12,
  childAspectRatio: 0.8,
  ),
  itemCount: snapshot.data!.length,
  itemBuilder: (context, index) {
  return _buildCarCard(snapshot.data![index]);
  },
  );
  },
  ),
  ],
  );
  }

  Widget _buildCarCard(Car car) {
  return GestureDetector(
  onTap: () => Navigator.push(
  context,
  MaterialPageRoute(
  builder: (context) => CarDetailsPage(car: car, customer: widget.customer),
  ),
  ),
  child: Card(
  child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  Expanded(
  child: car.imageURL.isNotEmpty
  ? Image.network(
  car.imageURL,
  width: double.infinity,
  fit: BoxFit.cover,
  )
      : const Icon(Icons.directions_car, size: 50),
  ),
  Padding(
  padding: const EdgeInsets.all(8),
  child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  Text(
  car.title,
  style: const TextStyle(fontWeight: FontWeight.bold),
  maxLines: 1,
  overflow: TextOverflow.ellipsis,
  ),
  Text(
  car.type,
  style: TextStyle(color: Colors.grey[600]),
  ),
  Text(
  '\$${car.ratePerDay}/day',
  style: const TextStyle(
  fontWeight: FontWeight.bold,
  color: Colors.blue,
  ),
  ),
  ],
  ),
  ),
  ],
  ),
  ),
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