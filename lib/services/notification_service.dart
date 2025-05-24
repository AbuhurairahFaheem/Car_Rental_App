import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationItem {
  final String id;
  final String title;
  final String body;
  final DateTime timestamp;
  final bool isRead;

  NotificationItem({
    required this.id,
    required this.title,
    required this.body,
    required this.timestamp,
    required this.isRead,
  });

  factory NotificationItem.fromMap(String id, Map<String, dynamic> data) {
    DateTime getTimestamp() {
      if (data['timestamp'] is Timestamp) {
        return (data['timestamp'] as Timestamp).toDate();
      } else if (data['timestamp'] is String) {
        return DateTime.tryParse(data['timestamp']) ?? DateTime.now();
      } else {
        return DateTime.now();
      }
    }

    return NotificationItem(
      id: id,
      title: data['title'] ?? '',
      body: data['body'] ?? data['message'] ?? '',
      timestamp: getTimestamp(),
      isRead: data['isRead'] ?? false,
    );
  }

}

class NotificationService {
  static final _notificationsRef = FirebaseFirestore.instance.collection('notifications');

  static Future<void> sendNotification({
    required String customerId,
    required String title,
    required String body,
  }) async {
    await _notificationsRef.add({
      'customerId': customerId,
      'title': title,
      'body': body,
      'timestamp': FieldValue.serverTimestamp(),
      'isRead': false,
    });
  }

  static Stream<List<NotificationItem>> getCustomerNotifications(String customerId) {
    return _notificationsRef
        .where('customerId', isEqualTo: customerId)
        .where('timestamp', isGreaterThan: Timestamp.fromMillisecondsSinceEpoch(0)) // ✅ ensures timestamp exists
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => NotificationItem.fromMap(doc.id, doc.data())).toList());
  }


  static Future<void> markAsRead(String notificationId) async {
    await _notificationsRef.doc(notificationId).update({'isRead': true});
  }
}
