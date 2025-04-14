// import 'package:flutter/material.dart';

// class NotificationsPage extends StatelessWidget {
//   const NotificationsPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Notifications")),
//       body: Center(
//         child: Text("No new notifications!", style: TextStyle(fontSize: 18, color: Colors.grey)),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: buildAppBar(), body: buildNotificationBody());
  }

  AppBar buildAppBar() {
    return AppBar(title: const Text("Notifications"));
  }

  Widget buildNotificationBody() {
    return const Center(
      child: Text(
        "No new notifications!",
        style: TextStyle(fontSize: 18, color: Colors.grey),
      ),
    );
  }
}
