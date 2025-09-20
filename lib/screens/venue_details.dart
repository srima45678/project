import 'package:flutter/material.dart';
import 'package:project/screens/bookvenue.dart';

class VenueDetailsPage extends StatelessWidget {
  final String image, name, location, price, halls, capacity;

  const VenueDetailsPage({
    super.key,
    required this.image,
    required this.name,
    required this.location,
    required this.price,
    required this.halls,
    required this.capacity,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(image, width: double.infinity, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style:
                          const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.red),
                      const SizedBox(width: 4),
                      Text(location, style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text("💰 Price: $price",
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  Text("🏛️ Number of Halls: $halls",
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  Text("👥 Capacity: $capacity people",
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: 
                   ElevatedButton(
  style: ElevatedButton.styleFrom(
    minimumSize: const Size(double.infinity, 50),
    backgroundColor: const Color(0xFF8F5CFF),
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VenueBookingPage(),
      ),
    );
  },
  child: const Text("Book Now", style: TextStyle(fontSize: 18,)),
),

                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
