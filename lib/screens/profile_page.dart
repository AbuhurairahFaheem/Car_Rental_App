// // import 'package:flutter/material.dart';
// // import 'history_page.dart'; // Import HistoryPage
//
// // class ProfilePage extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text("Profile", style: TextStyle(fontSize: 20))),
//
// //       body: Column(
// //         children: [
// //           SizedBox(height: 20),
// //           CircleAvatar(
// //             radius: 50,
// //             backgroundColor: const Color.fromARGB(255, 219, 221, 224),
// //             backgroundImage: AssetImage("assets/images/profile.jpeg"),
// //           ),
//
// //           SizedBox(height: 10),
// //           Text(
// //             "User Name",
// //             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// //           ),
// //           SizedBox(height: 20),
// //           CustomButton(title: "Personal Info", onTap: () {}),
// //           CustomButton(
// //             title: "History",
// //             onTap: () {
// //               Navigator.push(
// //                 context,
// //                 MaterialPageRoute(builder: (context) => HistoryPage()),
// //               );
// //             },
// //           ),
// //           CustomButton(title: "Privacy Policy", onTap: () {}),
// //           CustomButton(title: "About", onTap: () {}),
// //         ],
// //       ),
// //     );
// //   }
// // }
//
// // class CustomButton extends StatelessWidget {
// //   final String title;
// //   final VoidCallback onTap;
//
// //   CustomButton({required this.title, required this.onTap});
//
// //   @override
// //   Widget build(BuildContext context) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
// //       child: ElevatedButton(
// //         style: ElevatedButton.styleFrom(
// //           backgroundColor: Colors.grey[200],
// //           padding: EdgeInsets.symmetric(vertical: 15),
// //           shape: RoundedRectangleBorder(
// //             borderRadius: BorderRadius.circular(10),
// //           ),
// //           minimumSize: Size(double.infinity, 50),
// //         ),
// //         onPressed: onTap,
// //         child: Text(
// //           title,
// //           style: TextStyle(
// //             fontSize: 18,
// //             fontWeight: FontWeight.bold,
// //             color: const Color.fromARGB(255, 0, 0, 0),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// // import 'package:flutter/material.dart';
// // import 'history_page.dart';
//
// // class ProfilePage extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text("Profile")),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           children: [
// //             const SizedBox(height: 20),
// //             const ProfileAvatar(),
// //             const SizedBox(height: 10),
// //             const ProfileInfo(userName: "User Name"),
// //             const SizedBox(height: 20),
// //             ProfileActionButton(
// //               title: "Personal Info",
// //               onTap: () {
// //                 // Navigate to Personal Info Page
// //               },
// //             ),
// //             ProfileActionButton(
// //               title: "History",
// //               onTap: () {
// //                 Navigator.push(
// //                   context,
// //                   MaterialPageRoute(builder: (context) => HistoryPage()),
// //                 );
// //               },
// //             ),
// //             ProfileActionButton(
// //             title: "Settings",
// //             onTap: () {
// //     Navigator.push(
// //       context,
// //       MaterialPageRoute(builder: (_) => SettingsPage()),
// //     );
// //   },
// // ),
// //             ProfileActionButton(
// //               title: "Privacy Policy",
// //               onTap: () {
// //                 // Navigate to Privacy Policy Page
// //               },
// //             ),
// //             ProfileActionButton(
// //               title: "About",
// //               onTap: () {
// //                 // Navigate to About Page
// //               },
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// // // Reusable Widget for Avatar
// // class ProfileAvatar extends StatelessWidget {
// //   const ProfileAvatar({super.key});
//
// //   @override
// //   Widget build(BuildContext context) {
// //     return const CircleAvatar(
// //       radius: 50,
// //       backgroundImage: AssetImage("assets/images/profile.jpeg"),
// //     );
// //   }
// // }
//
// // // Reusable Widget for User Info
// // class ProfileInfo extends StatelessWidget {
// //   final String userName;
//
// //   const ProfileInfo({required this.userName, super.key});
//
// //   @override
// //   Widget build(BuildContext context) {
// //     return Text(
// //       userName,
// //       style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// //     );
// //   }
// // }
//
// // class ProfileActionButton extends StatelessWidget {
// //   final String title;
// //   final VoidCallback onTap;
//
// //   const ProfileActionButton({
// //     required this.title,
// //     required this.onTap,
// //     super.key,
// //   });
//
// //   @override
// //   Widget build(BuildContext context) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(vertical: 6.0),
// //       child: SizedBox(
// //         width: double.infinity,
// //         child: ElevatedButton(
// //           style: ElevatedButton.styleFrom(
// //             backgroundColor: Colors.grey[200],
// //             foregroundColor: Colors.black,
// //           ),
// //           onPressed: onTap,
// //           child: Text(title),
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// // lib/screens/profile_page.dart
//
// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// // import '../utils/hash_password.dart';
// // import 'history_page.dart';
//
// // class ProfilePage extends StatefulWidget {
// //   const ProfilePage({super.key});
// //   @override
// //   _ProfilePageState createState() => _ProfilePageState();
// // }
//
// // class _ProfilePageState extends State<ProfilePage> {
// //   String? _userId;
// //   bool _loading = true;
//
// //   @override
// //   void initState() {
// //     super.initState();
// //     _loadUserId();
// //   }
//
// //   Future<void> _loadUserId() async {
// //     final prefs = await SharedPreferences.getInstance();
// //     final uid = prefs.getString('user_uid');
// //     setState(() {
// //       _userId = uid;
// //       _loading = false;
// //     });
// //   }
//
// //   @override
// //   Widget build(BuildContext context) {
// //     if (_loading)
// //       return const Scaffold(body: Center(child: CircularProgressIndicator()));
// //     if (_userId == null)
// //       return const Scaffold(body: Center(child: Text("Not logged in")));
// //     return Scaffold(
// //       appBar: AppBar(title: const Text("Profile")),
// //       body: SingleChildScrollView(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           children: [
// //             const SizedBox(height: 20),
// //             const ProfileAvatar(),
// //             const SizedBox(height: 10),
// //             const ProfileInfo(userName: "User Name"),
// //             const SizedBox(height: 20),
// //             ProfileActionButton(title: "Personal Info", onTap: () {}),
// //             ProfileActionButton(
// //               title: "History",
// //               onTap:
// //                   () => Navigator.push(
// //                     context,
// //                     MaterialPageRoute(builder: (_) => HistoryPage()),
// //                   ),
// //             ),
// //             ProfileActionButton(
// //               title: "Settings",
// //               onTap:
// //                   () => Navigator.push(
// //                     context,
// //                     MaterialPageRoute(
// //                       builder: (_) => SettingsPage(userId: _userId!),
// //                     ),
// //                   ),
// //             ),
// //             ProfileActionButton(title: "Privacy Policy", onTap: () {}),
// //             ProfileActionButton(title: "About", onTap: () {}),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// // class ProfileAvatar extends StatelessWidget {
// //   const ProfileAvatar({super.key});
// //   @override
// //   Widget build(BuildContext context) {
// //     return const CircleAvatar(
// //       radius: 50,
// //       backgroundImage: AssetImage("assets/images/profile.jpeg"),
// //     );
// //   }
// // }
//
// // class ProfileInfo extends StatelessWidget {
// //   final String userName;
// //   const ProfileInfo({required this.userName, super.key});
// //   @override
// //   Widget build(BuildContext context) {
// //     return Text(
// //       userName,
// //       style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// //     );
// //   }
// // }
//
// // class ProfileActionButton extends StatelessWidget {
// //   final String title;
// //   final VoidCallback onTap;
// //   const ProfileActionButton({
// //     required this.title,
// //     required this.onTap,
// //     super.key,
// //   });
// //   @override
// //   Widget build(BuildContext context) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(vertical: 6.0),
// //       child: SizedBox(
// //         width: double.infinity,
// //         child: ElevatedButton(
// //           style: ElevatedButton.styleFrom(
// //             backgroundColor: Colors.grey[200],
// //             foregroundColor: Colors.black,
// //           ),
// //           onPressed: onTap,
// //           child: Text(title),
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// // class SettingsPage extends StatefulWidget {
// //   final String userId;
// //   const SettingsPage({required this.userId, super.key});
// //   @override
// //   State<SettingsPage> createState() => _SettingsPageState();
// // }
//
// // class _SettingsPageState extends State<SettingsPage> {
// //   String currentEmail = '';
// //   String currentPhone = '';
// //   String? currentHashedPassword;
// //   bool _loading = true;
//
// //   @override
// //   void initState() {
// //     super.initState();
// //     _loadUserData();
// //   }
//
// //   Future<void> _loadUserData() async {
// //     final doc =
// //         await FirebaseFirestore.instance
// //             .collection('users')
// //             .doc(widget.userId)
// //             .get();
// //     if (doc.exists) {
// //       final data = doc.data()!;
// //       setState(() {
// //         currentEmail = data['email'] ?? '';
// //         currentPhone = data['contact'] ?? '';
// //         currentHashedPassword = data['password'];
// //         _loading = false;
// //       });
// //     } else {
// //       setState(() => _loading = false);
// //       ScaffoldMessenger.of(
// //         context,
// //       ).showSnackBar(const SnackBar(content: Text('User data not found')));
// //     }
// //   }
//
// //   Future<void> _changePassword() async {
// //     final oldController = TextEditingController();
// //     final newController = TextEditingController();
// //     final confirmController = TextEditingController();
//
// //     await showDialog(
// //       context: context,
// //       builder:
// //           (_) => AlertDialog(
// //             title: const Text("Change Password"),
// //             content: Column(
// //               mainAxisSize: MainAxisSize.min,
// //               children: [
// //                 TextField(
// //                   controller: oldController,
// //                   obscureText: true,
// //                   decoration: const InputDecoration(labelText: "Old Password"),
// //                 ),
// //                 TextField(
// //                   controller: newController,
// //                   obscureText: true,
// //                   decoration: const InputDecoration(labelText: "New Password"),
// //                 ),
// //                 TextField(
// //                   controller: confirmController,
// //                   obscureText: true,
// //                   decoration: const InputDecoration(
// //                     labelText: "Confirm Password",
// //                   ),
// //                 ),
// //               ],
// //             ),
// //             actions: [
// //               TextButton(
// //                 onPressed: () => Navigator.pop(context),
// //                 child: const Text("Cancel"),
// //               ),
// //               ElevatedButton(
// //                 onPressed: () async {
// //                   final old = oldController.text.trim();
// //                   final newP = newController.text.trim();
// //                   final confirm = confirmController.text.trim();
//
// //                   if (hashPassword(old) != currentHashedPassword) {
// //                     ScaffoldMessenger.of(context).showSnackBar(
// //                       const SnackBar(
// //                         content: Text("Old password is incorrect"),
// //                       ),
// //                     );
// //                   } else if (newP != confirm) {
// //                     ScaffoldMessenger.of(context).showSnackBar(
// //                       const SnackBar(content: Text("Passwords do not match")),
// //                     );
// //                   } else {
// //                     await FirebaseFirestore.instance
// //                         .collection('users')
// //                         .doc(widget.userId)
// //                         .update({'password': hashPassword(newP)});
// //                     ScaffoldMessenger.of(context).showSnackBar(
// //                       const SnackBar(content: Text("Password updated")),
// //                     );
// //                     Navigator.pop(context);
// //                   }
// //                 },
// //                 child: const Text("Update"),
// //               ),
// //             ],
// //           ),
// //     );
// //   }
//
// //   Future<void> _changePhoneNumber() async {
// //     final newPhoneController = TextEditingController();
//
// //     await showDialog(
// //       context: context,
// //       builder:
// //           (_) => AlertDialog(
// //             title: const Text("Change Phone Number"),
// //             content: Column(
// //               mainAxisSize: MainAxisSize.min,
// //               children: [
// //                 Text("Current: $currentPhone"),
// //                 TextField(
// //                   controller: newPhoneController,
// //                   decoration: const InputDecoration(
// //                     labelText: "New Phone Number",
// //                   ),
// //                 ),
// //               ],
// //             ),
// //             actions: [
// //               TextButton(
// //                 onPressed: () => Navigator.pop(context),
// //                 child: const Text("Cancel"),
// //               ),
// //               ElevatedButton(
// //                 onPressed: () async {
// //                   final newPhone = newPhoneController.text.trim();
// //                   if (newPhone.isEmpty) return;
// //                   await FirebaseFirestore.instance
// //                       .collection('users')
// //                       .doc(widget.userId)
// //                       .update({'contact': newPhone});
// //                   setState(() => currentPhone = newPhone);
// //                   ScaffoldMessenger.of(context).showSnackBar(
// //                     const SnackBar(content: Text("Phone number updated")),
// //                   );
// //                   Navigator.pop(context);
// //                 },
// //                 child: const Text("Update"),
// //               ),
// //             ],
// //           ),
// //     );
// //   }
//
// //   Future<void> _changeEmail() async {
// //     final newEmailController = TextEditingController();
//
// //     await showDialog(
// //       context: context,
// //       builder:
// //           (_) => AlertDialog(
// //             title: const Text("Change Email"),
// //             content: Column(
// //               mainAxisSize: MainAxisSize.min,
// //               children: [
// //                 Text("Current: $currentEmail"),
// //                 TextField(
// //                   controller: newEmailController,
// //                   decoration: const InputDecoration(labelText: "New Email"),
// //                 ),
// //               ],
// //             ),
// //             actions: [
// //               TextButton(
// //                 onPressed: () => Navigator.pop(context),
// //                 child: const Text("Cancel"),
// //               ),
// //               ElevatedButton(
// //                 onPressed: () async {
// //                   final newEmail = newEmailController.text.trim();
// //                   if (newEmail.isEmpty) return;
// //                   await FirebaseFirestore.instance
// //                       .collection('users')
// //                       .doc(widget.userId)
// //                       .update({'email': newEmail});
// //                   setState(() => currentEmail = newEmail);
// //                   ScaffoldMessenger.of(context).showSnackBar(
// //                     const SnackBar(content: Text("Email updated")),
// //                   );
// //                   Navigator.pop(context);
// //                 },
// //                 child: const Text("Update"),
// //               ),
// //             ],
// //           ),
// //     );
// //   }
//
// //   @override
// //   Widget build(BuildContext context) {
// //     if (_loading)
// //       return const Scaffold(body: Center(child: CircularProgressIndicator()));
// //     return Scaffold(
// //       appBar: AppBar(title: const Text("Settings")),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           children: [
// //             ProfileActionButton(
// //               title: "Change Password",
// //               onTap: _changePassword,
// //             ),
// //             ProfileActionButton(
// //               title: "Change Phone Number",
// //               onTap: _changePhoneNumber,
// //             ),
// //             ProfileActionButton(title: "Change Email", onTap: _changeEmail),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../utils/hash_password.dart';
// import 'history_page.dart';
//
// /// ─────────────────────────────────────────────────────────────────────────────
// ///                              PROFILE PAGE
// /// ─────────────────────────────────────────────────────────────────────────────
// class ProfilePage extends StatefulWidget {
//   const ProfilePage({super.key});
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }
//
// class _ProfilePageState extends State<ProfilePage> {
//   String? _userId;
//   bool _loading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadUserId();
//   }
//
//   Future<void> _loadUserId() async {
//     final prefs = await SharedPreferences.getInstance();
//     final uid = prefs.getString('user_uid');
//     setState(() {
//       _userId = uid;
//       _loading = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (_loading) {
//       return const Scaffold(body: Center(child: CircularProgressIndicator()));
//     }
//     if (_userId == null) {
//       return const Scaffold(body: Center(child: Text("Not logged in")));
//     }
//
//     return Scaffold(
//       appBar: AppBar(title: const Text("Profile")),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             const SizedBox(height: 20),
//             const ProfileAvatar(),
//             const SizedBox(height: 10),
//             const ProfileInfo(
//               userName: "User Name",
//             ), // You can fetch real name if desired
//             const SizedBox(height: 20),
//
//             // PERSONAL INFO
//             ProfileActionButton(
//               title: "Personal Info",
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => PersonalInfoPage(userId: _userId!),
//                   ),
//                 );
//               },
//             ),
//
//             // HISTORY
//             ProfileActionButton(
//               title: "History",
//               onTap:
//                   () => Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (_) => HistoryPage()),
//                   ),
//             ),
//
//             // SETTINGS
//             ProfileActionButton(
//               title: "Settings",
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => SettingsPage(userId: _userId!),
//                   ),
//                 );
//               },
//             ),
//
//             // PRIVACY POLICY
//             ProfileActionButton(title: "Privacy Policy", onTap: () {}),
//
//             // ABOUT
//             ProfileActionButton(title: "About", onTap: () {}),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// /// Reusable avatar widget
// class ProfileAvatar extends StatelessWidget {
//   const ProfileAvatar({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return const CircleAvatar(
//       radius: 50,
//       backgroundImage: AssetImage("assets/images/profile.jpeg"),
//     );
//   }
// }
//
// /// Reusable name display
// class ProfileInfo extends StatelessWidget {
//   final String userName;
//   const ProfileInfo({required this.userName, super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       userName,
//       style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//     );
//   }
// }
//
// /// Reusable button style
// class ProfileActionButton extends StatelessWidget {
//   final String title;
//   final VoidCallback onTap;
//   const ProfileActionButton({
//     required this.title,
//     required this.onTap,
//     super.key,
//   });
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6.0),
//       child: SizedBox(
//         width: double.infinity,
//         child: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.grey[200],
//             foregroundColor: Colors.black,
//           ),
//           onPressed: onTap,
//           child: Text(title),
//         ),
//       ),
//     );
//   }
// }
//
// /// ─────────────────────────────────────────────────────────────────────────────
// ///                           SETTINGS PAGE
// /// ─────────────────────────────────────────────────────────────────────────────
// class SettingsPage extends StatefulWidget {
//   final String userId;
//   const SettingsPage({required this.userId, super.key});
//   @override
//   State<SettingsPage> createState() => _SettingsPageState();
// }
//
// class _SettingsPageState extends State<SettingsPage> {
//   bool _loading = true;
//   String? _currentEmail, _currentPhone, _currentHashed;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadCurrentData();
//   }
//
//   Future<void> _loadCurrentData() async {
//     final doc =
//         await FirebaseFirestore.instance
//             .collection('users')
//             .doc(widget.userId)
//             .get();
//     if (doc.exists) {
//       final data = doc.data()!;
//       setState(() {
//         _currentEmail = data['email'] as String?;
//         _currentPhone = data['contact'] as String?;
//         _currentHashed = data['password'] as String?;
//         _loading = false;
//       });
//     } else {
//       setState(() => _loading = false);
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text('User data not found')));
//     }
//   }
//
//   Future<void> _changePassword() async {
//     final oldController = TextEditingController();
//     final newController = TextEditingController();
//     final confirmController = TextEditingController();
//
//     await showDialog(
//       context: context,
//       builder:
//           (_) => AlertDialog(
//             title: const Text("Change Password"),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextField(
//                   controller: oldController,
//                   obscureText: true,
//                   decoration: const InputDecoration(labelText: "Old Password"),
//                 ),
//                 TextField(
//                   controller: newController,
//                   obscureText: true,
//                   decoration: const InputDecoration(labelText: "New Password"),
//                 ),
//                 TextField(
//                   controller: confirmController,
//                   obscureText: true,
//                   decoration: const InputDecoration(
//                     labelText: "Confirm Password",
//                   ),
//                 ),
//               ],
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text("Cancel"),
//               ),
//               ElevatedButton(
//                 onPressed: () async {
//                   final old = oldController.text.trim();
//                   final np = newController.text.trim();
//                   final cp = confirmController.text.trim();
//
//                   if (_currentHashed == null ||
//                       hashPassword(old) != _currentHashed) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                         content: Text("Old password is incorrect"),
//                       ),
//                     );
//                     return;
//                   }
//                   if (np != cp) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                         content: Text("New passwords do not match"),
//                       ),
//                     );
//                     return;
//                   }
//
//                   await FirebaseFirestore.instance
//                       .collection('users')
//                       .doc(widget.userId)
//                       .update({'password': hashPassword(np)});
//
//                   Navigator.pop(context);
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text("Password updated")),
//                   );
//                 },
//                 child: const Text("Update"),
//               ),
//             ],
//           ),
//     );
//   }
//
//   Future<void> _changePhoneNumber() async {
//     final controller = TextEditingController();
//
//     await showDialog(
//       context: context,
//       builder:
//           (_) => AlertDialog(
//             title: const Text("Change Phone Number"),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text("Current: ${_currentPhone ?? 'N/A'}"),
//                 TextField(
//                   controller: controller,
//                   decoration: const InputDecoration(
//                     labelText: "New Phone Number",
//                   ),
//                 ),
//               ],
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text("Cancel"),
//               ),
//               ElevatedButton(
//                 onPressed: () async {
//                   final np = controller.text.trim();
//                   if (np.isEmpty) return;
//                   await FirebaseFirestore.instance
//                       .collection('users')
//                       .doc(widget.userId)
//                       .update({'contact': np});
//                   setState(() => _currentPhone = np);
//                   Navigator.pop(context);
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text("Phone number updated")),
//                   );
//                 },
//                 child: const Text("Update"),
//               ),
//             ],
//           ),
//     );
//   }
//
//   Future<void> _changeEmail() async {
//     final controller = TextEditingController();
//
//     await showDialog(
//       context: context,
//       builder:
//           (_) => AlertDialog(
//             title: const Text("Change Email"),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text("Current: ${_currentEmail ?? 'N/A'}"),
//                 TextField(
//                   controller: controller,
//                   decoration: const InputDecoration(labelText: "New Email"),
//                 ),
//               ],
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text("Cancel"),
//               ),
//               ElevatedButton(
//                 onPressed: () async {
//                   final ne = controller.text.trim();
//                   if (ne.isEmpty) return;
//                   await FirebaseFirestore.instance
//                       .collection('users')
//                       .doc(widget.userId)
//                       .update({'email': ne});
//                   setState(() => _currentEmail = ne);
//                   Navigator.pop(context);
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text("Email updated")),
//                   );
//                 },
//                 child: const Text("Update"),
//               ),
//             ],
//           ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (_loading) {
//       return const Scaffold(body: Center(child: CircularProgressIndicator()));
//     }
//     return Scaffold(
//       appBar: AppBar(title: const Text("Settings")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             ProfileActionButton(
//               title: "Change Password",
//               onTap: _changePassword,
//             ),
//             ProfileActionButton(
//               title: "Change Phone Number",
//               onTap: _changePhoneNumber,
//             ),
//             ProfileActionButton(title: "Change Email", onTap: _changeEmail),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // /// ─────────────────────────────────────────────────────────────────────────────
// // ///                        PERSONAL INFO PAGE
// // /// ─────────────────────────────────────────────────────────────────────────────
// // class PersonalInfoPage extends StatefulWidget {
// //   final String userId;
// //   const PersonalInfoPage({required this.userId, super.key});
// //   @override
// //   _PersonalInfoPageState createState() => _PersonalInfoPageState();
// // }
//
// // class _PersonalInfoPageState extends State<PersonalInfoPage> {
// //   bool _loading = true;
// //   String? _fullName, _email, _contact, _joiningDate;
//
// //   @override
// //   void initState() {
// //     super.initState();
// //     _loadInfo();
// //   }
//
// //   Future<void> _loadInfo() async {
// //     final doc = await FirebaseFirestore.instance
// //         .collection('users')
// //         .doc(widget.userId)
// //         .get();
// //     if (doc.exists) {
// //       final data = doc.data()!;
// //       final ts = data['createdAt'] as Timestamp?;
// //       String dateStr = '';
// //       if (ts != null) {
// //         final dt = ts.toDate();
// //         dateStr = "${dt.day}/${dt.month}/${dt.year}";
// //       }
// //       setState(() {
// //         _fullName    = data['fullName'] ?? '';
// //         _email       = data['email']    ?? '';
// //         _contact     = data['contact']  ?? '';
// //         _joiningDate = dateStr;
// //         _loading     = false;
// //       });
// //     } else {
// //       setState(() => _loading = false);
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text('User not found')),
// //       );
// //     }
// //   }
//
// //   @override
// //   Widget build(BuildContext context) {
// //     if (_loading) {
// //       return const Scaffold(body: Center(child: CircularProgressIndicator()));
// //     }
// //     return Scaffold(
// //       appBar: AppBar(title: const Text("Personal Info")),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Text("User Name: ${_fullName ?? 'N/A'}", style: const TextStyle(fontSize: 18)),
// //             const SizedBox(height: 10),
// //             Text("Email ID: ${_email ?? 'N/A'}", style: const TextStyle(fontSize: 18)),
// //             const SizedBox(height: 10),
// //             Text("Contact Number: ${_contact ?? 'N/A'}", style: const TextStyle(fontSize: 18)),
// //             const SizedBox(height: 10),
// //             Text("Joining Date: ${_joiningDate ?? 'N/A'}", style: const TextStyle(fontSize: 18)),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// // lib/screens/personal_info_page.dart
//
// class PersonalInfoPage extends StatefulWidget {
//   final String userId;
//   const PersonalInfoPage({required this.userId, super.key});
//
//   @override
//   _PersonalInfoPageState createState() => _PersonalInfoPageState();
// }
//
// class _PersonalInfoPageState extends State<PersonalInfoPage> {
//   bool _loading = true;
//   String? _fullName, _email, _contact, _joiningDate;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadInfo();
//   }
//
//   Future<void> _loadInfo() async {
//     final doc =
//         await FirebaseFirestore.instance
//             .collection('users')
//             .doc(widget.userId)
//             .get();
//
//     if (doc.exists) {
//       final data = doc.data()!;
//       final ts = data['createdAt'] as Timestamp?;
//       String dateStr = '';
//       if (ts != null) {
//         final dt = ts.toDate();
//         dateStr = "${dt.day}/${dt.month}/${dt.year}";
//       }
//       setState(() {
//         _fullName = data['fullName'] ?? '—';
//         _email = data['email'] ?? '—';
//         _contact = data['contact'] ?? '—';
//         _joiningDate = dateStr.isNotEmpty ? dateStr : '—';
//         _loading = false;
//       });
//     } else {
//       setState(() => _loading = false);
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text('User not found')));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (_loading) {
//       return const Scaffold(body: Center(child: CircularProgressIndicator()));
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Personal Info"),
//         backgroundColor: Colors.indigo,
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           InfoCard(icon: Icons.person, label: "User Name", value: _fullName!),
//           InfoCard(icon: Icons.email, label: "Email ID", value: _email!),
//           InfoCard(
//             icon: Icons.phone,
//             label: "Contact Number",
//             value: _contact!,
//           ),
//           InfoCard(
//             icon: Icons.calendar_today,
//             label: "Joining Date",
//             value: _joiningDate!,
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// /// A reusable card widget for displaying a single piece of info.
// class InfoCard extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final String value;
//
//   const InfoCard({
//     required this.icon,
//     required this.label,
//     required this.value,
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//         child: Row(
//           children: [
//             CircleAvatar(
//               backgroundColor: Colors.indigo.withOpacity(0.1),
//               child: Icon(icon, color: Colors.indigo),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     label.toUpperCase(),
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Colors.grey[700],
//                       letterSpacing: 1.2,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     value,
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black87,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/customer_model.dart';
import '../services/customer_services.dart';
import 'history_page.dart';
import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  final Customer customer;

  const ProfilePage({required this.customer, super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 24),
            _buildProfileActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey[200],
          backgroundImage: widget.customer.profileImageUrl.isNotEmpty
              ? CachedNetworkImageProvider(widget.customer.profileImageUrl)
              : const AssetImage("assets/images/profile.jpeg") as ImageProvider,
        ),
        const SizedBox(height: 16),
        Text(
          widget.customer.name,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          widget.customer.email,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.phone, size: 16, color: Colors.grey[600]),
            const SizedBox(width: 4),
            Text(
              widget.customer.phoneNumber,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProfileActions() {
    return Column(
      children: [
        _buildProfileButton(
          icon: Icons.person_outline,
          label: "Personal Information",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PersonalInfoPage(customer: widget.customer),
              ),
            );
          },
        ),
        _buildProfileButton(
          icon: Icons.history,
          label: "Booking History",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HistoryPage(),
              ),
            );
          },
        ),
        _buildProfileButton(
          icon: Icons.settings,
          label: "Settings",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SettingsPage(customer: widget.customer),
              ),
            );
          },
        ),
        _buildProfileButton(
          icon: Icons.privacy_tip_outlined,
          label: "Privacy Policy",
          onTap: () {},
        ),
        _buildProfileButton(
          icon: Icons.info_outline,
          label: "About",
          onTap: () {},
        ),
        const SizedBox(height: 16),
        _buildLogoutButton(),
      ],
    );
  }

  Widget _buildProfileButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(label),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  Widget _buildLogoutButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red[50],
          foregroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        onPressed: _logout,
        child: const Text("Log Out"),
      ),
    );
  }

  Future<void> _logout() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Logout"),
        content: const Text("Are you sure you want to log out?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Logout"),
          ),
        ],
      ),
    );

    if (shouldLogout == true) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('customer_id');

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
            (route) => false,
      );
    }
  }
}

class PersonalInfoPage extends StatelessWidget {
  final Customer customer;

  const PersonalInfoPage({required this.customer, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Personal Information"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildInfoCard(
            icon: Icons.person,
            title: "Full Name",
            value: customer.name,
          ),
          _buildInfoCard(
            icon: Icons.email,
            title: "Email",
            value: customer.email,
          ),
          _buildInfoCard(
            icon: Icons.phone,
            title: "Phone Number",
            value: customer.phoneNumber,
          ),
          _buildInfoCard(
            icon: Icons.calendar_today,
            title: "Member Since",
            value: "2025", // You can add registration date to Customer model
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, color: Colors.blue),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  final Customer customer;

  const SettingsPage({required this.customer, super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSettingOption(
            icon: Icons.lock_outline,
            title: "Change Password",
            onTap: _changePassword,
          ),
          _buildSettingOption(
            icon: Icons.phone,
            title: "Change Phone Number",
            onTap: _changePhoneNumber,
          ),
          _buildSettingOption(
            icon: Icons.email,
            title: "Change Email",
            onTap: _changeEmail,
          ),
          _buildSettingOption(
            icon: Icons.photo_camera,
            title: "Change Profile Picture",
            onTap: _changeProfilePicture,
          ),
        ],
      ),
    );
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _confirmDialog({
    required String title,
    required String content,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            child: Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: Text("Confirm"),
            onPressed: () {
              Navigator.pop(context);
              onConfirm();
            },
          ),
        ],
      ),
    );
  }


  Widget _buildSettingOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  Future<void> _changePassword() async {
    final controller = TextEditingController();
    final newPassword = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Change Password"),
        content: TextField(
          controller: controller,
          obscureText: true,
          decoration: InputDecoration(labelText: "New Password"),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
          ElevatedButton(onPressed: () => Navigator.pop(context, controller.text), child: Text("Change")),
        ],
      ),
    );

    if (newPassword != null && newPassword.isNotEmpty) {
      _showSnackbar("Password updated");
      // TODO: Call backend to update password
    }
  }

  Future<void> _changePhoneNumber() async {
    final controller = TextEditingController();
    final newPhone = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Change Phone Number"),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(labelText: "New Phone Number"),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
          ElevatedButton(onPressed: () => Navigator.pop(context, controller.text), child: Text("Change")),
        ],
      ),
    );

    if (newPhone != null && newPhone.isNotEmpty) {
      _showSnackbar("Phone number updated");
      // TODO: Call backend to update phone number
    }
  }

  Future<void> _changeEmail() async {
    final controller = TextEditingController();
    final newEmail = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Change Email"),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(labelText: "New Email Address"),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
          ElevatedButton(onPressed: () => Navigator.pop(context, controller.text), child: Text("Change")),
        ],
      ),
    );

    if (newEmail != null && newEmail.isNotEmpty) {
      _showSnackbar("Email updated");
      // TODO: Call backend to update email
    }
  }

  Future<void> _changeProfilePicture() async {
    _confirmDialog(
      title: "Change Profile Picture",
      content: "This will open your gallery or camera to choose a new photo.",
      onConfirm: () {
        _showSnackbar("Profile picture updated");
        // TODO: Use ImagePicker or similar to upload new profile image
      },
    );
  }

}