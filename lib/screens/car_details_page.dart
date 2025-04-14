// import 'package:flutter/material.dart';

// class CarDetailsPage extends StatelessWidget {
//   final String carImage;
//   final String carName;
//   final String carType;
//   final String carRate;

//   CarDetailsPage({
//     required this.carImage,
//     required this.carName,
//     required this.carType,
//     required this.carRate,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       appBar: AppBar(
//         title: Text(carName),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Car Image
//             Container(
//               width: double.infinity,
//               height: 250,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage(carImage),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     carName,
//                     style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     "Category: $carType",
//                     style: TextStyle(fontSize: 16, color: Colors.grey[700]),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     "Rate: $carRate",
//                     style: TextStyle(fontSize: 18, color: Colors.green, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                     ),
//                     onPressed: () {
//                       // Implement Rent Now functionality
//                     },
//                     child: Text("Rent Now", style: TextStyle(fontSize: 18)),
//                   ),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                     ),
//                     onPressed: () {
//                       // Implement Rent Now functionality
//                     },
//                     child: Text("Add to wishlist", style: TextStyle(fontSize: 18)),
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

class CarDetailsPage extends StatelessWidget {
  final String carImage;
  final String carName;
  final String carType;
  final String carRate;

  const CarDetailsPage({
    required this.carImage,
    required this.carName,
    required this.carType,
    required this.carRate,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: Text(carName), backgroundColor: Colors.blueAccent),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarImage(imagePath: carImage),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CarDetailsInfo(
                name: carName,
                type: carType,
                rate: carRate,
                onRentPressed: () {
                  // Add your logic here
                },
                onWishlistPressed: () {
                  // Add your logic here
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CarImage extends StatelessWidget {
  final String imagePath;

  const CarImage({required this.imagePath, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
      ),
    );
  }
}

class CarDetailsInfo extends StatelessWidget {
  final String name;
  final String type;
  final String rate;
  final VoidCallback onRentPressed;
  final VoidCallback onWishlistPressed;

  const CarDetailsInfo({
    required this.name,
    required this.type,
    required this.rate,
    required this.onRentPressed,
    required this.onWishlistPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          "Category: $type",
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
        const SizedBox(height: 10),
        Text(
          "Rate: $rate",
          style: const TextStyle(
            fontSize: 18,
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        PrimaryButton(label: "Rent Now", onPressed: onRentPressed),
        const SizedBox(height: 10),
        PrimaryButton(label: "Add to wishlist", onPressed: onWishlistPressed),
      ],
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const PrimaryButton({
    required this.label,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: onPressed,
      child: Text(label, style: const TextStyle(fontSize: 18)),
    );
  }
}
