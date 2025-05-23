import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/customer_model.dart';

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

  /// 🔁 Stream chat messages for a customer
  static Stream<List<ChatMessage>> getCustomerChats(String customerId) {
    return _customersRef
        .doc(customerId)
        .collection('chats')
        .orderBy('timestamp')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => ChatMessage.fromMap(doc.data()))
        .toList());
  }

  /// ➕ Send message to a customer
  static Future<void> sendMessageToCustomer({
    required String customerId,
    required String message,
    required String sender, // 'admin' or 'customer'
  }) async {
    await _customersRef.doc(customerId).collection('chats').add({
      'message': message,
      'sender': sender,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
