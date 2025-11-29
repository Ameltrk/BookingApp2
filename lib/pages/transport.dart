import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:booking_app/pages/reservation_page.dart';

class TransportPage extends StatefulWidget {
  const TransportPage({super.key});

  @override
  State<TransportPage> createState() => _TransportPageState();
}

class _TransportPageState extends State<TransportPage>
    with SingleTickerProviderStateMixin { 
  late TabController _tabController; 
  String selectedCategory = "all";
  bool _isInitializing = true; 

  // Vérification Admin
  bool get _isAdmin {
    final user = FirebaseAuth.instance.currentUser;
    return user != null && user.email == "admin@gmail.com";
  }

  final categories = [
    {"id": "all", "label": "Tous"},
    {"id": "Économique", "label": "Économique"},
    {"id": "SUV", "label": "SUV"},
    {"id": "Luxe", "label": "Luxe"},
    {"id": "Van", "label": "Van"},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _checkAndPopulateDatabase();
  }

  Future<void> _checkAndPopulateDatabase() async {
    try {
      final firestore = FirebaseFirestore.instance;
      final snapshot = await firestore.collection('vehicles_v2').limit(1).get();

      if (snapshot.docs.isEmpty) {
        print("Base de données vide détectée. Injection automatique des données...");
        await _injectSampleData(firestore);
        print("Injection terminée !");
      } else {
        print("La base contient déjà des données. Chargement normal.");
      }
    } catch (e) {
      print("Erreur lors de l'initialisation auto: $e");
    } finally {
      if (mounted) {
        setState(() {
          _isInitializing = false; 
        });
      }
    }
  }

  Future<void> _injectSampleData(FirebaseFirestore firestore) async { 
    final List<Map<String, dynamic>> vehicules = [
      {
        "name": "Hyundai Accent",
        "category": "Économique",
        "image": "images/Hyundai_accent.jpg",
        "price": 4500,
        "passengers": 5,
        "transmission": "Automatique",
        "fuel": "Essence",
        "rating": 4.6,
        "reviews": 89,
        "available": true,
      },
      
    ];

    final List<Map<String, dynamic>> chauffeurs = [
      {
        "name": "Ahmed",
        "rating": 4.8,
        "reviews": 120,
        "duration": "Une journée",
        "description": "Chauffeur expérimenté, ponctuel.",
        "price": 3500
      },
      // ... autres données ...
    ];

    final batch = firestore.batch();
    for (var v in vehicules) {
      var docRef = firestore.collection("vehicles_v2").doc();
      batch.set(docRef, v);
    }
    for (var c in chauffeurs) {
      var docRef = firestore.collection("drivers_v2").doc();
      batch.set(docRef, c);
    }
    await batch.commit();
  }

  // --- LOGIQUE D'AJOUT (CORRIGÉE) ---
  void _showAddSelectionDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        height: 200,
        child: Column(
          children: [
            const Text("Que voulez-vous ajouter ?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.directions_car),
                  label: const Text("Véhicule"),
                  onPressed: () {
                    Navigator.pop(context);
                    _showAddVehicleForm(context);
                  },
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.person),
                  label: const Text("Chauffeur"),
                  onPressed: () {
                    Navigator.pop(context);
                    _showAddDriverForm(context);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _showAddVehicleForm(BuildContext context) {
    final nameCtrl = TextEditingController();
    final priceCtrl = TextEditingController();
    final passengersCtrl = TextEditingController();
    String category = 'Économique';
    String fuel = 'Essence';
    String transmission = 'Automatique';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Padding(
          padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Ajouter Véhicule", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: "Nom du véhicule")),
              TextField(controller: priceCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Prix (DA/Jour)")),
              TextField(controller: passengersCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Nombre de places")),
              const SizedBox(height: 10),
              DropdownButton<String>(
                value: category,
                isExpanded: true,
                items: ['Économique', 'SUV', 'Luxe', 'Van'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (v) => setState(() => category = v!),
              ),
              DropdownButton<String>(
                value: fuel,
                isExpanded: true,
                items: ['Essence', 'Diesel', 'Hybride'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (v) => setState(() => fuel = v!),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                   if (nameCtrl.text.isNotEmpty) {
                    await FirebaseFirestore.instance.collection('vehicles_v2').add({
                      "name": nameCtrl.text,
                      "price": int.tryParse(priceCtrl.text) ?? 0,
                      "passengers": int.tryParse(passengersCtrl.text) ?? 4,
                      "category": category,
                      "fuel": fuel,
                      "transmission": transmission,
                      "image": "images/Hyundai Accent.png",
                      "rating": 5.0,
                      "available": true
                    });
                    Navigator.pop(context);
                   }
                },
                child: const Text("Ajouter Véhicule"),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showAddDriverForm(BuildContext context) {
    final nameCtrl = TextEditingController();
    final priceCtrl = TextEditingController();
    final descCtrl = TextEditingController();

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
            const Text("Ajouter Chauffeur", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: "Nom du chauffeur")),
            TextField(controller: descCtrl, decoration: const InputDecoration(labelText: "Description")),
            TextField(controller: priceCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Prix (DA)")),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (nameCtrl.text.isNotEmpty) {
                  await FirebaseFirestore.instance.collection('drivers_v2').add({
                    "name": nameCtrl.text,
                    "description": descCtrl.text,
                    "price": int.tryParse(priceCtrl.text) ?? 0,
                    "rating": 5.0,
                    "reviews": 0,
                    "duration": "Une journée"
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text("Ajouter Chauffeur"),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      floatingActionButton: _isAdmin
          ? FloatingActionButton(
              backgroundColor: const Color(0xFF0A3D91),
              onPressed: () => _showAddSelectionDialog(context),
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
      body: _isInitializing 
        ? const Center(child: CircularProgressIndicator()) 
        : Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0A3D91), Color(0xFF002868)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Row(
               children: [
                 IconButton(
                 icon: const Icon(Icons.arrow_back, color: Colors.white),
                   onPressed: () {
                  Navigator.pop(context); 
                  },
                ),
               const SizedBox(width: 8),
                 const Text(
                 "Transport",
                  style: TextStyle(fontSize: 26, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 5),
              const Text(
             "Location de véhicules & services chauffeur",
             style: TextStyle(color: Colors.white70),
           ),
         ],
         ),
        ),

          TabBar( 
            controller: _tabController,
            labelColor: Colors.blue.shade800,
            indicatorColor: Colors.blue.shade800,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(icon: Icon(Icons.directions_car), text: "Véhicules"),
              Tab(icon: Icon(Icons.person), text: "Chauffeurs"),
            ],
          ),

          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                buildVehiclesTab(),
                buildDriverTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildVehiclesTab() {
    return Column(
      children: [
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            children: categories.map((cat) {
              bool active = selectedCategory == cat["id"];
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(cat["label"].toString()),
                  selected: active,
                  onSelected: (_) {
                    setState(() => selectedCategory = cat["id"].toString());
                  },
                ),
              );
            }).toList(),
          ),
        ),

        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('vehicles_v2')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

              final vehicles = snapshot.data!.docs
                  .map((doc) => {...doc.data() as Map<String, dynamic>, 'id': doc.id})
                  .where((v) => selectedCategory == "all" || v["category"] == selectedCategory)
                  .toList();

              if (vehicles.isEmpty) return const Center(child: Text("Aucun véhicule disponible"));

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: vehicles.length,
                itemBuilder: (context, index) => buildVehicleCard(vehicles[index]),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildVehicleCard(Map<String, dynamic> vehicle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                child: Image.asset(
                  vehicle["image"] ?? "",
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => Container(height: 160, color: Colors.grey[300], child: const Icon(Icons.car_rental)),
                ),
              ),
              Positioned(
                top: 10, left: 10,
                child: badge(vehicle["category"] ?? "", Colors.blue.shade800),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(vehicle["name"] ?? "Véhicule", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    spec(Icons.people, "${vehicle["passengers"]} places"),
                    spec(Icons.local_gas_station, vehicle["fuel"] ?? "Essence"),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${vehicle["price"]} DA /jour", style: TextStyle(fontSize: 16, color: Colors.blue.shade800, fontWeight: FontWeight.bold)),
                    ElevatedButton(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (c) => ReservationPage(item: vehicle, type: "vehicle"))),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade800),
                      child: const Text("Réserver", style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
 
  Widget buildDriverTab() {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('drivers_v2').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
              final drivers = snapshot.data!.docs.map((doc) => {...doc.data() as Map<String, dynamic>, 'id': doc.id}).toList();
              if (drivers.isEmpty) return const Center(child: Text("Aucun chauffeur disponible"));

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: drivers.length,
                itemBuilder: (context, index) => buildDriverCard(drivers[index]),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildDriverCard(Map<String, dynamic> service) {
    return Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(service["name"] ?? "", style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
          Text(service["description"] ?? "", style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${service["price"]} DA", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue.shade800)),
              OutlinedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (c) => ReservationPage(item: service, type: "driver"))),
                child: const Text("Demander"),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget badge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
      child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 12)),
    );
  }

  Widget spec(IconData icon, String text) {
    return Row(children: [Icon(icon, color: Colors.grey, size: 18), const SizedBox(width: 4), Text(text, style: const TextStyle(fontSize: 13))]);
  }
}