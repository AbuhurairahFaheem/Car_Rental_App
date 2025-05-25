import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/car_model.dart';

class CarService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final CollectionReference _carsCollection = _firestore.collection(
    'cars',
  );

  static Future<List<Car>> getAllCars() async {
    final snapshot = await _carsCollection.get();
    return snapshot.docs
        .map((doc) => Car.fromMap(doc.id, doc.data() as Map<String, dynamic>))
        .toList();
  }

  static Future<Car?> getCarById(String id) async {
    final doc = await _carsCollection.doc(id).get();
    if (doc.exists) {
      return Car.fromMap(doc.id, doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  static Future<List<Car>> getFeaturedCars() async {
    final snapshot =
        await _carsCollection.where('isFeatured', isEqualTo: true).get();
    return snapshot.docs
        .map((doc) => Car.fromMap(doc.id, doc.data() as Map<String, dynamic>))
        .toList();
  }

  static Future<List<Car>> getRecommendedCars() async {
    final snapshot =
        await _carsCollection.where('isRecommended', isEqualTo: true).get();
    return snapshot.docs
        .map((doc) => Car.fromMap(doc.id, doc.data() as Map<String, dynamic>))
        .toList();
  }

  static Future<List<Car>> getCarsByCategory(String categoryId) async {
    final snapshot =
        await _carsCollection.where('categoryId', isEqualTo: categoryId).get();
    return snapshot.docs
        .map((doc) => Car.fromMap(doc.id, doc.data() as Map<String, dynamic>))
        .toList();
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

//import 'package:cloud_firestore/cloud_firestore.dart';
// import '../models/car_model.dart';

// class CarService {
//   static final List<Car> _dummyCars = [
//     Car(
//       id: 'car1',
//       title: 'Toyota Corolla',
//       type: 'Sedan',
//       imageURL:
//           'https://wheelsbuster.com/wp-content/uploads/2024/05/Toyota-Corolla-Price-In-Pakistan.jpeg',
//       ratePerDay: 45.0,
//       isRecommended: true,
//       isAvailable: true,
//     ),
//     Car(
//       id: 'car2',
//       title: 'Honda Civic',
//       type: 'Sedan',
//       imageURL:
//           'https://www.edmunds.com/assets/m/cs/blta273833cf330f69f/674f4da31add862567c33334/2025-honda-civic-f34.jpg',
//       ratePerDay: 50.0,
//       isRecommended: true,
//       isAvailable: true,
//     ),
//     Car(
//       id: 'car3',
//       title: 'Suzuki Alto',
//       type: 'Hatchback',
//       imageURL:
//           'https://margallatribune.com/wp-content/uploads/2025/03/WhatsApp-Image-2025-02-28-at-3.41.04-PM.jpeg',
//       ratePerDay: 30.0,
//       isRecommended: false,
//       isAvailable: true,
//     ),
//     Car(
//       id: 'car4',
//       title: 'KIA Sportage',
//       type: 'SUV',
//       imageURL: 'https://i.ytimg.com/vi/xZaQ3XXcAx4/maxresdefault.jpg',
//       ratePerDay: 70.0,
//       isRecommended: true,
//       isAvailable: false,
//     ),
//   ];

//   static Future<List<Car>> getAllCars() async {
//     await Future.delayed(
//       const Duration(milliseconds: 300),
//     ); // simulate network delay
//     return _dummyCars;
//   }

//   static Future<Car?> getCarById(String id) async {
//     try {
//       return _dummyCars.firstWhere((car) => car.id == id);
//     } catch (e) {
//       return null;
//     }
//   }

//   static Future<List<Car>> getFeaturedCars() async {
//     return _dummyCars.where((car) => car.isRecommended).toList();
//   }

//   static Future<List<Car>> getRecommendedCars() async {
//     return _dummyCars.where((car) => car.isRecommended).toList();
//   }

//   static Future<List<Car>> getCarsByCategory(String categoryId) async {
//     // If you plan to support category filtering, ensure your model has a categoryId field.
//     return _dummyCars
//         .where((car) => car.type.toLowerCase() == categoryId.toLowerCase())
//         .toList();
//   }

//   static Future<void> addCar(Car car) async {
//     _dummyCars.add(car);
//   }

//   static Future<void> updateCar(Car car) async {
//     int index = _dummyCars.indexWhere((c) => c.id == car.id);
//     if (index != -1) {
//       _dummyCars[index] = car;
//     }
//   }

//   static Future<void> deleteCar(String id) async {
//     _dummyCars.removeWhere((car) => car.id == id);
//   }
// }
