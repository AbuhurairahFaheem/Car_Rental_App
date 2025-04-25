// lib/models/user_models.dart

class UserModel {
  final String uid;
  final String fullName;
  final String contact;
  final String email;
  final String password; // ← newly added

  UserModel({
    required this.uid,
    required this.fullName,
    required this.contact,
    required this.email,
    required this.password,
  });

  /// Convert to JSON for Firestore writes
  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'contact': contact,
      'email': email,
      'password': password,
    };
  }

  /// Construct from Firestore data
  factory UserModel.fromJson(String uid, Map<String, dynamic> json) {
    return UserModel(
      uid: uid,
      fullName: json['fullName'] ?? '',
      contact: json['contact'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
    );
  }

  /// Same as fromJson; alias for other code
  factory UserModel.fromMap(String uid, Map data) {
    return UserModel(
      uid: uid,
      fullName: data['fullName'] ?? '',
      contact: data['contact'] ?? '',
      email: data['email'] ?? '',
      password: data['password'] ?? '',
    );
  }

  /// Same as toJson; alias for other code
  Map<String, dynamic> toMap() => toJson();
}
