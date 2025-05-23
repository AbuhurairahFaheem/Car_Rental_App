import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/car_model.dart';

class CarService {
  static final _carsRef = FirebaseFirestore.instance.collection('cars');

  static Future<List<Car>> getAllCars() async {
    final snapshot = await _carsRef.get();
    return snapshot.docs.map((doc) => Car.fromMap(doc.id, doc.data())).toList();
  }

  static Future<Car?> getCarById(String id) async {
    final doc = await _carsRef.doc(id).get();
    if (doc.exists) return Car.fromMap(doc.id, doc.data()!);
    return null;
  }

  static Future<void> addCar(Car car) async {
    await _carsRef.doc(car.id).set(car.toMap());
  }

  static Future<void> updateCar(Car car) async {
    await _carsRef.doc(car.id).update(car.toMap());
  }

  static Future<void> deleteCar(String id) async {
    await _carsRef.doc(id).delete();
  }
}
