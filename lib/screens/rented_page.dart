import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/booking_model.dart';
import '../models/car_model.dart';
import '../models/customer_model.dart';
import '../services/car_services.dart';
import 'car_details_page.dart';

class RentedPage extends StatefulWidget {
  final Customer customer;

  const RentedPage({required this.customer, super.key});

  @override
  _RentedPageState createState() => _RentedPageState();
}

class _RentedPageState extends State<RentedPage> {
  Widget _buildBookingList(String status) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('bookings')
          .where('customerId', isEqualTo: widget.customer.id)
          .where('status', isEqualTo: status)
          .orderBy('startDate')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No $status bookings'));
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final booking = snapshot.data!.docs[index];
            return FutureBuilder<Car?>(
              future: CarService.getCarById(booking['carId']),
              builder: (context, carSnapshot) {
                if (!carSnapshot.hasData) {
                  return const ListTile(title: Text('Loading...'));
                }

                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: carSnapshot.data!.imageURL.isNotEmpty
                        ? Image.network(
                      carSnapshot.data!.imageURL,
                      width: 50,
                      height: 50,
                    )
                        : const Icon(Icons.directions_car),
                    title: Text(carSnapshot.data!.title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Status: ${booking['status']}'),
                        Text('From: ${booking['startDate'].toDate().toString().split(' ')[0]}'),
                        Text('To: ${booking['endDate'].toDate().toString().split(' ')[0]}'),
                        Text('Total: \$${booking['totalPrice']}'),
                      ],
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CarDetailsPage(
                          car: carSnapshot.data!,
                          customer: widget.customer,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Bookings'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Upcoming'),
              Tab(text: 'Active'),
              Tab(text: 'Past'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildBookingList('upcoming'),
            _buildBookingList('active'),
            _buildBookingList('past'),
          ],
        ),
      ),
    );
  }
}