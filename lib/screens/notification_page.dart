import 'package:flutter/material.dart';
import '../services/notification_service.dart';
import '../models/customer_model.dart';

class NotificationsPage extends StatefulWidget {
  final String customerId;

  const NotificationsPage({required this.customerId, super.key});

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notifications")),
      body: StreamBuilder<List<NotificationItem>>(
        stream: NotificationService.getCustomerNotifications(widget.customerId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No notifications yet!",
                  style: TextStyle(fontSize: 18, color: Colors.grey)),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final notification = snapshot.data![index];
              return ListTile(
                title: Text(notification.title),
                subtitle: Text(notification.body),
                trailing: notification.isRead
                    ? null
                    : const Icon(Icons.circle, color: Colors.blue, size: 12),
                onTap: () => NotificationService.markAsRead(notification.id),
                onLongPress: () => NotificationService.markAsRead(notification.id),
              );
            },
          );
        },
      ),
    );
  }
}