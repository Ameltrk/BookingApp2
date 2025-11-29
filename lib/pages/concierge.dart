import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ConciergePage extends StatefulWidget {
  const ConciergePage({super.key});

  @override
  State<ConciergePage> createState() => _ConciergePageState();
}

class _ConciergePageState extends State<ConciergePage> {
  bool _isInitializing = true;
  String _selectedCategory = "all";

  // Vérification Admin
  bool get _isAdmin {
    final user = FirebaseAuth.instance.currentUser;
    return user != null && user.email == "admin@gmail.com";
  }

  final List<Map<String, dynamic>> _categories = [
    {"id": "all", "label": "Tous", "icon": Icons.auto_awesome},
    {"id": "Restaurant", "label": "Restaurant", "icon": Icons.restaurant},
    {"id": "Tour", "label": "Tours", "icon": Icons.calendar_today},
    {"id": "Shopping", "label": "Shopping", "icon": Icons.shopping_bag},
    {"id": "Événement", "label": "Autres", "icon": Icons.work},
  ];

  @override
  void initState() {
    super.initState();
    _checkAndPopulateDatabase();
  }

  Future<void> _checkAndPopulateDatabase() async {
    try {
      final firestore = FirebaseFirestore.instance;
      final snapshot = await firestore.collection('concierge_services_v1').limit(1).get();

      if (snapshot.docs.isEmpty) {
        print("Base Conciergerie vide. Injection des données React...");
        await _injectSampleData(firestore);
      }
    } catch (e) {
      print("Erreur init concierge: $e");
    } finally {
      if (mounted) setState(() => _isInitializing = false);
    }
  }

  Future<void> _injectSampleData(FirebaseFirestore firestore) async {
    final List<Map<String, dynamic>> services = [
      {
        "category": "Restaurant",
        "name": "Réservation Restaurant",
        "description": "Nous réservons votre table dans les meilleurs restaurants d'Alger",
        "image": "images/Réservation Restaurant.png",
        "price": "Gratuit",
        "duration": "24h à l'avance",
        "rating": 4.9,
        "reviews": 234,
        "popular": true,
      },
      // ... autres données si besoin ...
    ];

    final batch = firestore.batch();
    for (var item in services) {
      var docRef = firestore.collection("concierge_services_v1").doc();
      batch.set(docRef, item);
    }
    await batch.commit();
  }

  // --- FORMULAIRE D'AJOUT CONCIERGERIE (CORRIGÉ) ---
  void _showAddServiceDialog(BuildContext context) {
    final nameController = TextEditingController();
    final descController = TextEditingController();
    final priceController = TextEditingController();
    final durationController = TextEditingController();
    String category = 'Restaurant';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder( 
        builder: (context, setModalState) {
          return Padding(
            padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Ajouter Service", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 15),
                TextField(controller: nameController, decoration: const InputDecoration(labelText: "Nom du service")),
                TextField(controller: descController, decoration: const InputDecoration(labelText: "Description")),
                TextField(controller: priceController, decoration: const InputDecoration(labelText: "Prix")),
                TextField(controller: durationController, decoration: const InputDecoration(labelText: "Durée")),
                const SizedBox(height: 10),
                DropdownButton<String>(
                  value: category,
                  isExpanded: true,
                  items: ['Restaurant', 'Tour', 'Shopping', 'Événement', 'Ménage', 'Concierge'].map((String value) {
                    return DropdownMenuItem<String>(value: value, child: Text(value));
                  }).toList(),
                  onChanged: (val) => setModalState(() => category = val!),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (nameController.text.isNotEmpty) {
                      await FirebaseFirestore.instance.collection('concierge_services_v1').add({
                        "name": nameController.text,
                        "description": descController.text,
                        "price": priceController.text,
                        "duration": durationController.text,
                        "category": category,
                        "image": "images/Concierge Personnel.png", 
                        "rating": 5.0,
                        "popular": false,
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Sauvegarder"),
                )
              ],
            ),
          );
        }
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
              onPressed: () => _showAddServiceDialog(context),
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
                  _buildCategoryFilter(),
                  _buildContentBody(),
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
          bottomLeft: Radius.circular(32), 
          bottomRight: Radius.circular(32),
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Conciergerie",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 4),
          Text(
            "Services personnalisés pour votre séjour",
            style: TextStyle(color: Color(0xFFEFF6FF)), 
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final cat = _categories[index];
          final isSelected = _selectedCategory == cat['id'];

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategory = cat['id'];
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF1D4ED8) : Colors.white,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: isSelected ? const Color(0xFF1D4ED8) : Colors.grey.shade300,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    cat['icon'],
                    size: 18,
                    color: isSelected ? Colors.white : Colors.grey.shade700,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    cat['label'],
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContentBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPopularBanner(),
          const SizedBox(height: 20),
          _buildServicesList(),
          const SizedBox(height: 24),
          _buildCustomRequestCard(),
          const SizedBox(height: 24),
          _buildInfoSection(),
        ],
      ),
    );
  }

  Widget _buildPopularBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.amber, Colors.orange], 
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.auto_awesome, color: Colors.white, size: 20),
              SizedBox(width: 8),
              Text(
                "Services populaires",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "Profitez de nos services les plus demandés pour un séjour inoubliable",
            style: TextStyle(color: Colors.amber[50], fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('concierge_services_v1').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

        final allDocs = snapshot.data!.docs;
        final filteredDocs = allDocs.where((doc) {
          final data = doc.data() as Map<String, dynamic>;
          if (_selectedCategory == 'all') return true;
          return data['category'] == _selectedCategory;
        }).toList();

        if (filteredDocs.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text("Aucun service dans cette catégorie."),
            ),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: filteredDocs.length,
          itemBuilder: (context, index) {
            return _buildServiceCard(filteredDocs[index].data() as Map<String, dynamic>);
          },
        );
      },
    );
  }

  Widget _buildServiceCard(Map<String, dynamic> service) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 1))],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        service['image'] ?? "",
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover,
                        errorBuilder: (c, e, s) => Container(
                          width: 90, height: 90, color: Colors.grey[200], child: const Icon(Icons.broken_image),
                        ),
                      ),
                    ),
                    if (service['popular'] == true)
                      Positioned(
                        top: -4,
                        right: -4,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.amber,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.star, color: Colors.white, size: 10),
                        ),
                      )
                  ],
                ),
                const SizedBox(width: 16),
                
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        margin: const EdgeInsets.only(bottom: 6),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          service['category'] ?? "",
                          style: TextStyle(fontSize: 10, color: Colors.grey[800], fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              service['name'] ?? "",
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        service['description'] ?? "",
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.access_time, size: 12, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text(service['duration'] ?? "", style: TextStyle(fontSize: 11, color: Colors.grey[600])),
                          const SizedBox(width: 12),
                          const Icon(Icons.star, size: 12, color: Colors.amber),
                          const SizedBox(width: 2),
                          Text(
                            "${service['rating']}",
                            style: TextStyle(fontSize: 11, color: Colors.grey[600], fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  service['price'] ?? "",
                  style: const TextStyle(color: Color(0xFF1D4ED8), fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Action demander
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1D4ED8),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    minimumSize: const Size(0, 32),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  ),
                  child: const Text("Demander", style: TextStyle(fontSize: 12)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCustomRequestCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF), 
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF93C5FD), style: BorderStyle.solid, width: 2), 
      ),
      child: Column(
        children: [
          const Icon(Icons.work, size: 48, color: Color(0xFF1D4ED8)),
          const SizedBox(height: 12),
          const Text(
            "Besoin d'autre chose ?",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A)),
          ),
          const SizedBox(height: 8),
          const Text(
            "Demandez un service personnalisé et nous ferons de notre mieux pour vous aider",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: Color(0xFF1E40AF)),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1D4ED8),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text("Demande personnalisée"),
          )
        ],
      ),
    );
  }

  Widget _buildInfoSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Comment ça marche ?", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 16),
          _buildStep(1, "Choisissez votre service"),
          _buildStep(2, "Confirmez les détails et le paiement"),
          _buildStep(3, "Profitez de votre service"),
        ],
      ),
    );
  }

  Widget _buildStep(int number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFFDBEAFE),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              "$number",
              style: const TextStyle(color: Color(0xFF1D4ED8), fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 13, color: Colors.black87))),
        ],
      ),
    );
  }
}