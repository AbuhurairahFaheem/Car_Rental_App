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

  // Convert from Firebase snapshot
  factory UserModel.fromJson(String uid, Map<String, dynamic> json) {
    return UserModel(
      uid: uid,
      fullName: json['fullName'],
      contact: json['contact'],
      email: json['email'],
    );
  }
}
