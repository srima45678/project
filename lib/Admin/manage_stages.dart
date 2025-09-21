import 'package:flutter/material.dart';
import 'package:project/screens/stage_detail.dart';

class ManageStagesPage extends StatefulWidget {
  const ManageStagesPage({super.key});

  @override
  State<ManageStagesPage> createState() => _ManageStagesPageState();
}

class _ManageStagesPageState extends State<ManageStagesPage> {
  List<Map<String, dynamic>> stages = [
    {
      "name": "Grand Royal Stage",
      "location": "Ahmedabad, Gujarat",
      "price": 8000,
      "halls": 1,
      "capacity": 700,
      "image": "assets/images/stage1.jpeg",
    },
    {
      "name": "Crystal Hall Stage",
      "location": "Delhi, India",
      "price": 12000,
      "halls": 2,
      "capacity": 1000,
      "image": "assets/images/stage2.jpeg",
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

  void deleteStage(int index) {
    setState(() {
      stages.removeAt(index);
    });
  }

  void addStage(Map<String, dynamic> stage) {
    setState(() {
      stages.add(stage);
    });
  }

  void updateStage(int index, Map<String, dynamic> stage) {
    setState(() {
      stages[index] = stage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Stages"),
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
        itemCount: stages.length,
        itemBuilder: (context, index) {
          final stage = stages[index];
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
                        stage["image"],
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
                      Text(stage["name"], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text("📍 ${stage["location"]}"),
                      Text("💰 Price: ₹${stage["price"]}"),
                      Text("🏛️ Halls: ${stage["halls"]}"),
                      Text("👥 Capacity: ${stage["capacity"]}"),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                           onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StageDetailsPage(
                                    image: stage["image"],
                                    name: stage["name"],
                                    location: stage["location"],
                                    price: stage["price"].toString(),
                                    halls: stage["halls"].toString(),
                                    capacity: stage["capacity"].toString(),
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
                                onPressed: () => deleteStage(index),
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
    final stage = isUpdate
        ? stages[index]
        : {"name": "", "location": "", "price": 0, "halls": 0, "capacity": 0, "image": ""};

    final nameController = TextEditingController(text: stage["name"]);
    final locationController = TextEditingController(text: stage["location"]);
    final priceController = TextEditingController(text: stage["price"].toString());
    final hallsController = TextEditingController(text: stage["halls"].toString());
    final capacityController = TextEditingController(text: stage["capacity"].toString());
    final imageController = TextEditingController(text: stage["image"]);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isUpdate ? "Update Stage" : "Add Stage"),
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
              final newStage = {
                "name": nameController.text,
                "location": locationController.text,
                "price": int.tryParse(priceController.text) ?? 0,
                "halls": int.tryParse(hallsController.text) ?? 0,
                "capacity": int.tryParse(capacityController.text) ?? 0,
                "image": imageController.text,
              };

              if (isUpdate) {
                updateStage(index!, newStage);
              } else {
                addStage(newStage);
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
