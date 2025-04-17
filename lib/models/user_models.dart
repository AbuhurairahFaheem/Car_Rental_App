class UserModel {
  final String uid;
  final String fullName;
  final String contact;
  final String email;

  UserModel({
    required this.uid,
    required this.fullName,
    required this.contact,
    required this.email,
  });

  // Convert to JSON for Firebase
  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'contact': contact,
      'email': email,
    };
  }

  // Create UserModel from Firebase data
  factory UserModel.fromJson(String uid, Map<String, dynamic> json) {
    return UserModel(
      uid: uid,
      fullName: json['fullName'] ?? '',
      contact: json['contact'] ?? '',
      email: json['email'] ?? '',
    );
  }

  // fromMap constructor (same as fromJson here)
  factory UserModel.fromMap(String uid, Map data) {
    return UserModel(
      uid: uid,
      fullName: data['fullName'] ?? '',
      contact: data['contact'] ?? '',
      email: data['email'] ?? '',
    );
  }

  // Convert to Map (same as toJson here)
  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'contact': contact,
      'email': email,
    };
  }
}