import 'package:cloud_firestore/cloud_firestore.dart';

class Car {
  final String id;
  final String title;
  final String type;
  final String imageURL;
  final String ratePerDay;
  final bool isRecommended;
  final bool isAvailable;

  Car({
    required this.id,
    required this.title,
    required this.type,
    required this.imageURL,
    required this.ratePerDay,
    required this.isRecommended,
    required this.isAvailable,
  });

  factory Car.fromMap(String id, Map<String, dynamic> data) {
    return Car(
      id: id,
      title: data['title'] ?? '',
      type: data['type'] ?? '',
      imageURL: data['imageURL'] ?? '',
      ratePerDay: data['ratePerDay'] ?? '',
      isRecommended: data['recommendation'] ?? false,
      isAvailable: data['isAvailable'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'type': type,
      'imageURL': imageURL,
      'ratePerDay': ratePerDay,
      'recommendation': isRecommended,
    };
  }

  Future<void> save() async {
    await FirebaseFirestore.instance.collection('cars').doc(id).set(toMap());
  }

  Future<void> delete() async {
    await FirebaseFirestore.instance.collection('cars').doc(id).delete();
  }
}




