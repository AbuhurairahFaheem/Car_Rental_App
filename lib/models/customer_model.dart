import 'package:cloud_firestore/cloud_firestore.dart';

class Customer {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String profileImageUrl;

  Customer({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.profileImageUrl,
  });

  factory Customer.fromMap(Map<String, dynamic> data, String docId) {
    return Customer(
      id: docId,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      profileImageUrl: data['profileImageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'profileImageUrl': profileImageUrl,
    };
  }

  Future<void> save() async {
    await FirebaseFirestore.instance.collection('customers').doc(id).set(toMap());
  }

  /// 🔄 Send chat message
  Future<void> sendMessage(String message, String sender) async {
    await FirebaseFirestore.instance
        .collection('customers')
        .doc(id)
        .collection('chats')
        .add({
      'message': message,
      'sender': sender, // 'customer' or 'admin'
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  /// 🔁 Get chat messages as a stream (chronological)
  Stream<List<ChatMessage>> getChatMessages() {
    return FirebaseFirestore.instance
        .collection('customers')
        .doc(id)
        .collection('chats')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => ChatMessage.fromMap(doc.data()))
        .toList());
  }
}

class ChatMessage {
  final String message;
  final String sender;
  final DateTime timestamp;

  ChatMessage({
    required this.message,
    required this.sender,
    required this.timestamp,
  });

  factory ChatMessage.fromMap(Map<String, dynamic> data) {
    return ChatMessage(
      message: data['message'] ?? '',
      sender: data['sender'] ?? '',
      timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}

// usage example
// customers/
//       customerId/
//                  name: "Ali"
//                  email: "ali@example.com"
//                  phoneNumber: "+923001234567"
//                   profileImageUrl: "https://example.com/image.jpg"
//                    chats/  <-- subcollection
//                              autoId1/
//                                      message: "Hello"
//                                      sender: "customer"
//                                      timestamp: <Timestamp>
