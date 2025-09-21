import 'package:flutter/material.dart';
// import 'package:project/Admin/venue_details.dart';
import 'package:project/screens/venue_details.dart';

class ManageVenuesPage extends StatefulWidget {
  const ManageVenuesPage({super.key});

  @override
  State<ManageVenuesPage> createState() => _ManageVenuesPageState();
}

class _ManageVenuesPageState extends State<ManageVenuesPage> {
  List<Map<String, dynamic>> venues = [
    {
      "name": "Kwality Durbar Banquet",
      "location": "Surat, Gujarat",
      "price": 5000,
      "halls": 2,
      "capacity": 500,
      "image": "assets/images/venue1.jpeg",
    },
    {
      "name": "Heritage Garden",
      "location": "Patna, Bihar",
      "price": 7000,
      "halls": 3,
      "capacity": 300,
      "image": "assets/images/venue2.jpeg",
    },
  ];

  final Set<int> favoriteIndices = {};

  void toggleFavorite(int index) {
    setState(() {
      if (favoriteIndices.contains(index)) {
        favoriteIndices.remove(index);
      } else {
        favoriteIndices.add(index);
      }
    });
  }

  void deleteVenue(int index) {
    setState(() {
      venues.removeAt(index);
    });
  }

  void addVenue(Map<String, dynamic> venue) {
    setState(() {
      venues.add(venue);
    });
  }

  void updateVenue(int index, Map<String, dynamic> venue) {
    setState(() {
      venues[index] = venue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Venues"),
        backgroundColor: const Color(0xFF8F5CFF),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showAddOrUpdateDialog(context, null);
            },
          )
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: venues.length,
        itemBuilder: (context, index) {
          final venue = venues[index];
          final isFavorite = favoriteIndices.contains(index);

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                      child: Image.asset(
                        venue["image"],
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () => toggleFavorite(index),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.85),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(venue["name"], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text("📍 ${venue["location"]}"),
                      Text("💰 Price: ₹${venue["price"]}"),
                      Text("🏛️ Halls: ${venue["halls"]}"),
                      Text("👥 Capacity: ${venue["capacity"]}"),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VenueDetailsPage(
                                    image: venue["image"],
                                    name: venue["name"],
                                    location: venue["location"],
                                    price: venue["price"].toString(),
                                    halls: venue["halls"].toString(),
                                    capacity: venue["capacity"].toString(),
                                  ),
                                ),
                              );
                            },
                            child: const Text("Show Details"),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () => showAddOrUpdateDialog(context, index),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => deleteVenue(index),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void showAddOrUpdateDialog(BuildContext context, int? index) {
    final isUpdate = index != null;
    final venue = isUpdate ? venues[index] : {"name": "", "location": "", "price": 0, "halls": 0, "capacity": 0, "image": ""};

    final nameController = TextEditingController(text: venue["name"]);
    final locationController = TextEditingController(text: venue["location"]);
    final priceController = TextEditingController(text: venue["price"].toString());
    final hallsController = TextEditingController(text: venue["halls"].toString());
    final capacityController = TextEditingController(text: venue["capacity"].toString());
    final imageController = TextEditingController(text: venue["image"]);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isUpdate ? "Update Venue" : "Add Venue"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: nameController, decoration: const InputDecoration(labelText: "Name")),
              TextField(controller: locationController, decoration: const InputDecoration(labelText: "Location")),
              TextField(controller: priceController, decoration: const InputDecoration(labelText: "Price"), keyboardType: TextInputType.number),
              TextField(controller: hallsController, decoration: const InputDecoration(labelText: "Halls"), keyboardType: TextInputType.number),
              TextField(controller: capacityController, decoration: const InputDecoration(labelText: "Capacity"), keyboardType: TextInputType.number),
              TextField(controller: imageController, decoration: const InputDecoration(labelText: "Image Path")),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              final newVenue = {
                "name": nameController.text,
                "location": locationController.text,
                "price": int.tryParse(priceController.text) ?? 0,
                "halls": int.tryParse(hallsController.text) ?? 0,
                "capacity": int.tryParse(capacityController.text) ?? 0,
                "image": imageController.text,
              };

              if (isUpdate) {
                updateVenue(index!, newVenue);
              } else {
                addVenue(newVenue);
              }

              Navigator.pop(context);
            },
            child: Text(isUpdate ? "Update" : "Add"),
          ),
        ],
      ),
    );
  }
}
