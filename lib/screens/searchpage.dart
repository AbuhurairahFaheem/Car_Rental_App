import 'package:flutter/material.dart';
import '../models/car_model.dart';
import '../models/customer_model.dart';
import '../services/car_services.dart';
import 'car_details_page.dart';

class SearchPage extends StatefulWidget {
  final Customer customer;

  const SearchPage({required this.customer, super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  late Future<List<Car>> _carsFuture;

  @override
  void initState() {
    super.initState();
    _carsFuture = CarService.getAllCars();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Cars"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: "Search for cars",
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    setState(() => _searchQuery = '');
                  },
                )
                    : null,
              ),
              onChanged: (value) => setState(() => _searchQuery = value.toLowerCase()),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List<Car>>(
                future: _carsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No cars available'));
                  }

                  final cars = snapshot.data!.where((car) {
                    if (_searchQuery.isEmpty) return true;
                    return car.title.toLowerCase().contains(_searchQuery) ||
                        car.type.toLowerCase().contains(_searchQuery);
                  }).toList();

                  if (cars.isEmpty) {
                    return const Center(child: Text('No matching cars found'));
                  }

                  return ListView.builder(
                    itemCount: cars.length,
                    itemBuilder: (context, index) {
                      final car = cars[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          leading: car.imageURL.isNotEmpty
                              ? Image.network(car.imageURL, width: 60, height: 60)
                              : const Icon(Icons.directions_car, size: 40),
                          title: Text(car.title),
                          subtitle: Text('${car.type} • \$${car.ratePerDay}/day'),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CarDetailsPage(
                                car: car,
                                customer: widget.customer,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}