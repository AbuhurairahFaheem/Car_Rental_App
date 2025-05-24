import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/car_model.dart';

class CarService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final CollectionReference _carsCollection = _firestore.collection('cars');

  static Future<List<Car>> getAllCars() async {
    final snapshot = await _carsCollection.get();
    return snapshot.docs.map((doc) => Car.fromMap(doc.id, doc.data() as Map<String, dynamic>)).toList();
  }

  static Future<Car?> getCarById(String id) async {
    final doc = await _carsCollection.doc(id).get();
    if (doc.exists) {
      return Car.fromMap(doc.id, doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  static Future<List<Car>> getFeaturedCars() async {
    final snapshot = await _carsCollection.where('isFeatured', isEqualTo: true).get();
    return snapshot.docs.map((doc) => Car.fromMap(doc.id, doc.data() as Map<String, dynamic>)).toList();
  }

  static Future<List<Car>> getRecommendedCars() async {
    final snapshot = await _carsCollection.where('isRecommended', isEqualTo: true).get();
    return snapshot.docs.map((doc) => Car.fromMap(doc.id, doc.data() as Map<String, dynamic>)).toList();
  }

  static Future<List<Car>> getCarsByCategory(String categoryId) async {
    final snapshot = await _carsCollection.where('categoryId', isEqualTo: categoryId).get();
    return snapshot.docs.map((doc) => Car.fromMap(doc.id, doc.data() as Map<String, dynamic>)).toList();
  }

  static Future<void> addCar(Car car) async {
    await _carsCollection.doc(car.id).set(car.toMap());
  }

  static Future<void> updateCar(Car car) async {
    await _carsCollection.doc(car.id).update(car.toMap());
  }

  static Future<void> deleteCar(String id) async {
    await _carsCollection.doc(id).delete();
  }

}