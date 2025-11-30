import 'package:booking_app/pages/detail_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  String? selectedCategory;

  String searchQuery = "";
  DateTime? arrivalDate;
  DateTime? departureDate;

  final List<Map<String, dynamic>> categories = [
    {"id": "vacation", "label": "Vacances", "icon": Icons.beach_access},
    {"id": "business", "label": "Affaires", "icon": Icons.work},
    {"id": "family", "label": "Famille", "icon": Icons.people},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("choufDAR"),
        backgroundColor: const Color(0xFF1E3C72),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // -------------------- TITRE CENTRAL AVEC ICONE --------------------
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Trouvez votre séjour idéal ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E3C72),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      "🏖️", // <-- Emoji
                      style: TextStyle(fontSize: 24),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // -------------------- SEARCH UI --------------------
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Destination Input
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Où souhaitez-vous aller ?",
                        prefixIcon:
                            const Icon(Icons.location_on_outlined, color: Colors.grey),
                        filled: true,
                        fillColor: Colors.grey[50],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() => searchQuery = value.toLowerCase());
                      },
                    ),

                    const SizedBox(height: 12),

                    // Date Pickers
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              DateTime? date = await showDatePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100),
                              );
                              if (date != null) setState(() => arrivalDate = date);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 14, horizontal: 12),
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.calendar_today_outlined,
                                      size: 16, color: Colors.grey),
                                  const SizedBox(width: 8),
                                  Text(
                                    arrivalDate == null
                                        ? "Arrivée"
                                        : arrivalDate.toString().split(" ")[0],
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              DateTime? date = await showDatePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100),
                              );
                              if (date != null) setState(() => departureDate = date);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 14, horizontal: 12),
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.calendar_today_outlined,
                                      size: 16, color: Colors.grey),
                                  const SizedBox(width: 8),
                                  Text(
                                    departureDate == null
                                        ? "Départ"
                                        : departureDate.toString().split(" ")[0],
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Search Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1E3C72),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(Icons.search, size: 20),
                        label:
                            const Text("Rechercher", style: TextStyle(fontSize: 16)),
                        onPressed: () {
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // -------------------- Categories --------------------
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Catégories",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 12),

              SizedBox(
                height: 45,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: categories.map((category) {
                    final bool isSelected = selectedCategory == category["id"];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory =
                              isSelected ? null : category["id"];
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: isSelected ? const Color(0xFF1E3C72) : Colors.white,
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Row(
                          children: [
                            Icon(category["icon"],
                                size: 16,
                                color: isSelected ? Colors.white : Colors.black87),
                            const SizedBox(width: 6),
                            Text(
                              category["label"],
                              style: TextStyle(
                                  color: isSelected ? Colors.white : Colors.black87),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 30),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Recommandations",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),

              // StreamBuilder pour Firebase
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Place")
                    .orderBy("CreatedAt", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final docs = snapshot.data!.docs;
                  if (docs.isEmpty) {
                    return const Center(child: Text("Aucune propriété disponible."));
                  }

                  return SizedBox(
                    height: 320,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: docs.map((doc) {
                        final data = doc.data() as Map<String, dynamic>;
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailPage(placeData: data),
                              ),
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            margin: const EdgeInsets.only(right: 16),
                            child: Card(
                              elevation: 4,
                              clipBehavior: Clip.hardEdge,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  data["Image"] != null && data["Image"] != ""
                                      ? Image.network(
                                          data["Image"],
                                          height: 180,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        )
                                      : Container(
                                          height: 180,
                                          color: Colors.grey[300],
                                          child: const Center(
                                              child: Icon(Icons.image, size: 50)),
                                        ),
                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data["PlaceName"] ?? "",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        const SizedBox(height: 6),
                                        Row(
                                          children: [
                                            const Icon(Icons.location_on_outlined,
                                                size: 16, color: Colors.grey),
                                            const SizedBox(width: 4),
                                            Expanded(
                                              child: Text(
                                                data["PlaceAddress"] ?? "",
                                                style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 14),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          "${data["PlaceCharges"] ?? "-"} DA / nuit",
                                          style: const TextStyle(
                                              color: Color(0xFF1E3C72),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
