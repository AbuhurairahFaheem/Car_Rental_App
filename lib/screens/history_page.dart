import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  final List<Map<String, String>> carHistory = [
    {"name": "Car 1", "status": "Approved"},
    {"name": "Car 2", "status": "Pending"},
    {"name": "Car 3", "status": "Approved"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("History")),
      body: Column(
        children: [
          SizedBox(height: 20),
          Text(
            "History",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: carHistory.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(carHistory[index]["name"]!),
                  trailing: Text(carHistory[index]["status"]!),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
