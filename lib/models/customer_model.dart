import 'package:cloud_firestore/cloud_firestore.dart';

class Customer {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String profileImageUrl;
  final String password;


  Customer({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.profileImageUrl,
    required this.password,
  });

  factory Customer.fromMap(Map<String, dynamic> data, String docId) {
    return Customer(
      id: docId,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      profileImageUrl: data['profileImageUrl'] ?? '',
      password:data['password'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'profileImageUrl': profileImageUrl,
      'password' : password,
    };
  }



  /// 🔁 Send a chat message
  Future<void> sendMessage(String message, String sender) async {
    await FirebaseFirestore.instance
        .collection('customers')
        .doc(id)
        .collection('chats')
        .add({
      'message': message,
      'sender': sender,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  /// 🔄 Stream chat messages in order
  Stream<List<ChatMessage>> getChatMessages() {
    return FirebaseFirestore.instance
        .collection('customers')
        .doc(id)
        .collection('chats')
        .orderBy('timestamp')
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => ChatMessage.fromMap(doc.data(),doc.id)).toList());
  }

}

class ChatMessage {
  final String id;
  final String message;
  final String sender;
  final String senderName;
  final DateTime timestamp;
  final String? carId;
  final bool isSystem;

  ChatMessage({
    required this.id,
    required this.message,
    required this.sender,
    required this.senderName,
    required this.timestamp,
    this.carId,
    this.isSystem = false,
  });

  factory ChatMessage.fromMap(Map<String, dynamic> data, String id) {
    return ChatMessage(
      id: id,
      message: data['message'] ?? '',
      sender: data['sender'] ?? '',
      senderName: data['senderName'] ?? 'Unknown',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      carId: data['carId'],
      isSystem: data['isSystem'] ?? false,
    );
  }
}
