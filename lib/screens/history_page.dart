// import 'package:flutter/material.dart';

// class HistoryPage extends StatelessWidget {
//   final List<Map<String, String>> carHistory = [
//     {"name": "Car 1", "status": "Approved"},
//     {"name": "Car 2", "status": "Pending"},
//     {"name": "Car 3", "status": "Approved"},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("History")),
//       body: Column(
//         children: [
//           SizedBox(height: 20),
//           Text(
//             "History",
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: carHistory.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(carHistory[index]["name"]!),
//                   trailing: Text(carHistory[index]["status"]!),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  final List<Map<String, String>> carHistory = [
    {"name": "Car 1", "status": "Approved"},
    {"name": "Car 2", "status": "Pending"},
    {"name": "Car 3", "status": "Approved"},
  ];

  HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody());
  }

  AppBar _buildAppBar() {
    return AppBar(title: const Text("History"));
  }

  Widget _buildBody() {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Text(
          "History",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Expanded(child: _buildHistoryList()),
      ],
    );
  }

  Widget _buildHistoryList() {
    return ListView.builder(
      itemCount: carHistory.length,
      itemBuilder: (context, index) {
        final item = carHistory[index];
        return HistoryItem(name: item["name"]!, status: item["status"]!);
      },
    );
  }
}

class HistoryItem extends StatelessWidget {
  final String name;
  final String status;

  const HistoryItem({required this.name, required this.status, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(name), trailing: Text(status));
  }
}
