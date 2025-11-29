import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:booking_app/pages/transport.dart';
import 'package:booking_app/pages/concierge.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  bool _isInitializing = true;
  
  // Vérification si c'est l'admin
  bool get _isAdmin {
    final user = FirebaseAuth.instance.currentUser;
    return user != null && user.email == "admin@gmail.com";
  }

  @override
  void initState() {
    super.initState();
    _checkAndPopulateDatabase();
  }

  Future<void> _checkAndPopulateDatabase() async {
    try {
      final firestore = FirebaseFirestore.instance;
      final snapshot = await firestore.collection('recommendations_v1').limit(1).get();

      if (snapshot.docs.isEmpty) {
        print("Base Découvrir vide. Injection des données...");
        await _injectSampleData(firestore);
        print("Injection Découvrir terminée !");
      }
    } catch (e) {
      print("Erreur init discover: $e");
    } finally {
      if (mounted) {
        setState(() => _isInitializing = false);
      }
    }
  }

  Future<void> _injectSampleData(FirebaseFirestore firestore) async {
    final List<Map<String, dynamic>> recommendations = [
      {
        "type": "restaurant",
        "name": "Restaurant El Djazair",
        "category": "Cuisine Traditionnelle",
        "image": "images/Restaurant El Djazair.png", 
        "location": "Didouche Mourad, Alger",
        "rating": 4.7,
        "reviews": 234,
        "price": "\$\$",
      },
      {
        "type": "cafe",
        "name": "Café Panoramique",
        "category": "Café & Desserts",
        "image": "images/Café Panoramique.png",
        "location": "Ben Aknoun, Alger",
        "rating": 4.5,
        "reviews": 156,
        "price": "\$",
      },
      {
        "type": "transport",
        "name": "Location de Voitures",
        "category": "Transport",
        "image": "images/Location de Voitures.png",
        "location": "Aéroport Houari Boumediene",
        "rating": 4.8,
        "reviews": 89,
        "price": "4500 DA/j",
      },
      {
        "type": "activity",
        "name": "Jardin d'Essai",
        "category": "Loisirs & Nature",
        "image": "images/Jardin d'Essai.png",
        "location": "El Hamma, Alger",
        "rating": 4.6,
        "reviews": 412,
        "price": "Gratuit",
      },
    ];

    try {
      final batch = firestore.batch();
      for (var item in recommendations) {
        var docRef = firestore.collection("recommendations_v1").doc();
        batch.set(docRef, item);
      }
      await batch.commit();
    } catch (e) {
      print("Erreur lors de l'injection des données: $e");
    }
  }

  // Fonction pour ajouter une nouvelle découverte (CORRIGÉE)
  void _showAddDialog(BuildContext context) {
    final nameController = TextEditingController();
    final locationController = TextEditingController();
    final priceController = TextEditingController();
    final categoryController = TextEditingController();
    String selectedType = 'restaurant';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Ajouter une découverte", 
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
            ),
            const SizedBox(height: 15),
            TextField(
              controller: nameController, 
              decoration: const InputDecoration(labelText: "Nom du lieu")
            ),
            TextField(
              controller: categoryController, 
              decoration: const InputDecoration(labelText: "Catégorie (ex: Cuisine Traditionnelle)")
            ),
            TextField(
              controller: locationController, 
              decoration: const InputDecoration(labelText: "Localisation")
            ),
            TextField(
              controller: priceController, 
              decoration: const InputDecoration(labelText: "Prix (ex: \$\$)")
            ),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: selectedType,
              isExpanded: true,
              items: ['restaurant', 'cafe', 'activity', 'transport'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value, 
                  child: Text(value.toUpperCase())
                );
              }).toList(),
              onChanged: (val) => setState(() => selectedType = val!),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (nameController.text.isNotEmpty) {
                  await FirebaseFirestore.instance.collection('recommendations_v1').add({
                    "name": nameController.text,
                    "category": categoryController.text,
                    "location": locationController.text,
                    "price": priceController.text,
                    "type": selectedType,
                    "image": "images/Restaurant El Djazair.png",
                    "rating": 5.0,
                    "reviews": 0,
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text("Ajouter"),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      floatingActionButton: _isAdmin 
          ? FloatingActionButton(
              backgroundColor: const Color(0xFF1D4ED8),
              onPressed: () => _showAddDialog(context),
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
      body: _isInitializing
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  _buildQuickServices(context),
                  _buildRecommendationsList(),
                  _buildTipsSection(),
                ],
              ),
            ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1D4ED8), Color(0xFF1E3A8A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Découvrir",
            style: TextStyle(
              fontSize: 28, 
              fontWeight: FontWeight.bold, 
              color: Colors.white
            ),
          ),
          SizedBox(height: 4),
          Text(
            "Les meilleurs endroits près de vous",
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickServices(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Services rapides", 
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: _buildServiceButton(
                  icon: Icons.directions_car,
                  label: "Transport",
                  onTap: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => const TransportPage())
                    );
                  },
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: _buildServiceButton(
                  icon: Icons.cleaning_services,
                  label: "Conciergerie",
                  onTap: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => const ConciergePage())
                    );
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildServiceButton({
    required IconData icon, 
    required String label, 
    required VoidCallback onTap
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.blue.shade100, width: 2),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.shade50, 
              blurRadius: 5, 
              offset: const Offset(0, 2)
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: 32, color: const Color(0xFF1D4ED8)),
            const SizedBox(height: 8),
            Text(
              label, 
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Recommandations locales", 
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
          ),
        ),
        const SizedBox(height: 10),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('recommendations_v1')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "Erreur: ${snapshot.error}",
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(20),
                child: Text("Aucune recommandation disponible"),
              );
            }

            final places = snapshot.data!.docs;

            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: places.length,
              itemBuilder: (context, index) {
                final place = places[index].data() as Map<String, dynamic>;
                return _buildPlaceCard(place);
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildPlaceCard(Map<String, dynamic> place) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SizedBox(
        height: 120,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(16),
              ),
              child: Image.asset(
                place['image'] ?? "",
                width: 120,
                height: 120,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 120,
                  color: Colors.grey[300],
                  child: const Icon(Icons.image, color: Colors.grey),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        place['category'] ?? "",
                        style: const TextStyle(
                          fontSize: 10, 
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      place['name'] ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16, 
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 14, color: Colors.grey),
                        const SizedBox(width: 2),
                        Expanded(
                          child: Text(
                            place['location'] ?? "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.star, size: 14, color: Colors.amber),
                            const SizedBox(width: 4),
                            Text(
                              "${place['rating']} (${place['reviews']})",
                              style: const TextStyle(
                                fontSize: 12, 
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                        Text(
                          place['price'] ?? "",
                          style: const TextStyle(
                            fontSize: 12, 
                            color: Color(0xFF1D4ED8), 
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTipsSection() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Conseils de voyage", 
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.amber.shade50, Colors.orange.shade50],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(color: Colors.amber.shade200),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "💡 Bon à savoir", 
                  style: TextStyle(
                    color: Colors.amber.shade900, 
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 8),
                _buildTipItem("Les taxis sont disponibles 24/7 dans le centre-ville"),
                _buildTipItem("La plupart des restaurants acceptent les cartes CIB"),
                _buildTipItem("Essayez le couscous le vendredi - c'est une tradition!"),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTipItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        "• $text", 
        style: TextStyle(fontSize: 13, color: Colors.amber.shade900),
      ),
    );
  }
}