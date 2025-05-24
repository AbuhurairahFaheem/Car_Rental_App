import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/customer_model.dart';
import '../models/car_model.dart';
import 'car_services.dart';


class CustomerService {
  static final _customersRef = FirebaseFirestore.instance.collection('customers');

  static Future<List<Customer>> getAllCustomers() async {
    final snapshot = await _customersRef.get();
    return snapshot.docs.map((doc) => Customer.fromMap(doc.data(), doc.id)).toList();
  }

  static Future<Customer?> getCustomerById(String id) async {
    final doc = await _customersRef.doc(id).get();
    if (doc.exists) {
      return Customer.fromMap(doc.data()!, doc.id);
    }
    return null;
  }

  static Future<void> addCustomer(Customer customer) async {
    await _customersRef.doc(customer.id).set(customer.toMap());
  }

  static Future<void> updateCustomer(Customer customer) async {
    await _customersRef.doc(customer.id).update(customer.toMap());
  }

  static Future<void> deleteCustomer(String id) async {
    await _customersRef.doc(id).delete();
  }

  static Future<void> sendMessageToCustomer({
    required String customerId,
    required String message,
    required String sender,
  }) async {
    await _customersRef.doc(customerId).collection('chats').add({
      'message': message,
      'sender': sender,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  static Stream<List<ChatMessage>> getCustomerChats(String customerId) {
    return _customersRef
        .doc(customerId)
        .collection('chats')
        .orderBy('timestamp')
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => ChatMessage.fromMap(doc.data(),doc.id)).toList());
  }

  // Add these methods to your CustomerService class

  static Future<void> sendInitialCarMessage({
    required String customerId,
    required String carId,
    required String carName,
    required String senderId,
    required String senderName,
  }) async {
    final carDetails = await CarService.getCarById(carId);
    if (carDetails == null) return;

    final message = """
  Hi! I'm interested in this car:
  
  *${carDetails.title}*
  Type: ${carDetails.type}
  Rate: \$${carDetails.ratePerDay}/day
  
  Can you provide more details?
  """;

    await _customersRef.doc(customerId).collection('chats').add({
      'message': message,
      'sender': senderId,
      'senderName': senderName,
      'carId': carId,
      'timestamp': FieldValue.serverTimestamp(),
      'isSystem': false,
    });
  }

  static Stream<List<ChatMessage>> getChatMessages(String customerId) {
    return _customersRef
        .doc(customerId)
        .collection('chats')
        .orderBy('timestamp')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => ChatMessage.fromMap(doc.data(), doc.id))
        .toList());
  }

  static Future<void> sendMessage({
    required String customerId,
    required String message,
    required String senderId,
    required String senderName,
  }) async {
    await _customersRef.doc(customerId).collection('chats').add({
      'message': message,
      'sender': senderId,
      'senderName': senderName,
      'timestamp': FieldValue.serverTimestamp(),
      'isSystem': false,
    });
  }
}
