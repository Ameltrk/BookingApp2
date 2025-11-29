import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart'; 

class ReservationPage extends StatefulWidget { // statefulWidget elle a un état qui change
  final Map<String, dynamic> item; 
  final String type; 

  const ReservationPage({
    super.key, 
    required this.item, 
    required this.type
  });

  @override
  State<ReservationPage> createState() => _ReservationPageState(); // letat réel de la page
}

class _ReservationPageState extends State<ReservationPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  
  DateTime? _startDate;
  DateTime? _endDate;
  bool _isLoading = false; // pour désactiver le bouton pendant lenvoi

  // Calcul du prix (gere "4500" "4500 DA", etc.)
  double get totalPrice {
    String priceClean = widget.item['price'].toString().replaceAll(RegExp(r'[^0-9.]'), '');
    double pricePerDay = double.tryParse(priceClean) ?? 0.0;
    
    if (_startDate != null && _endDate != null) {
      int days = _endDate!.difference(_startDate!).inDays + 1;
      return pricePerDay * days;
    }
    return pricePerDay; 
  }

  Future<void> _selectDate(BuildContext context, bool isStart) async { // isStart savoir si cest la date de début ou de fin
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101), // limite les dates a partir daujourd’hui jusqu’en 2101
    );
    
    if (picked != null) { // met à jour la date choisie.
      setState(() {
        if (isStart) {
          _startDate = picked;
          if (_endDate != null && _endDate!.isBefore(_startDate!)) {
            _endDate = null;
          }
        } else {
          _endDate = picked;
        }
      });
    }
  }

  Future<void> _submitReservation() async { // pour envoyer la réservation vérifie si le formulaire est valide
    if (!_formKey.currentState!.validate()) return;
    
    if (widget.type == 'vehicle' && (_startDate == null || _endDate == null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez sélectionner les dates")),
      );
      return;
    }

    setState(() => _isLoading = true); // désactive le bouton pendant l’envo

    try {
      final user = FirebaseAuth.instance.currentUser; // récupère l’utilisateur connecté
      // On permet la résa même sans auth pour tester, sinon on remplace par : if (user == null) throw Exception...
      final userId = user?.uid ?? "invité"; // si pas connecté identifiant = invité

      await FirebaseFirestore.instance.collection('bookings').add({ // pour stocker toutes les réservations
        'item_id': widget.item['id'] ?? 'unknown', 
        'item_name': widget.item['name'],
        'type': widget.type,
        'image': widget.item['image'] ?? '',
        'user_id': userId,
        'phone': _phoneController.text,
        'start_date': _startDate != null ? DateFormat('yyyy-MM-dd').format(_startDate!) : null,
        'end_date': _endDate != null ? DateFormat('yyyy-MM-dd').format(_endDate!) : null,
        'total_price': totalPrice,
        'status': 'pending',
        'created_at': FieldValue.serverTimestamp(),
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Réservation envoyée avec succès !"), 
            backgroundColor: Colors.green
          )
        );
        Navigator.pop(context);  // mmessage de confirmation et retour à la page précédente
      }
    } catch (e) {
      print("Erreur: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Erreur lors de la réservation")),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // FONCTION CORRIGÉE POUR LIMAGE 
  Widget buildLocalImage() {
    String path = widget.item['image']?.toString() ?? "";
    
    // DEBUG le terminal pour voir ce chemin (jai oublié si ca marche)
    print("TENTATIVE CHARGEMENT IMAGE: '$path'");

    if (path.isEmpty) {
      return Container(height: 200, color: Colors.grey, child: const Center(child: Text("Pas d'image")));
    }

    // Correction automatique si le chemin na pas "images/" on l'ajoute
    if (!path.startsWith("images/") && !path.startsWith("http")) {
      path = "images/$path";
    }

    // Si c'est une URL internet (au cas ou makima discover page psq javais la flemme)
    if (path.startsWith("http")) {
      return Image.network(path, height: 200, width: double.infinity, fit: BoxFit.cover);
    }

    // cest une image locale (Asset)
    return Image.asset(
      path,
      height: 200,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        print("ERREUR : Impossible de trouver l'image à : $path");
        return Container(
          height: 200,
          color: Colors.grey[300],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.broken_image, color: Colors.red, size: 40),
              const SizedBox(height: 10),
              Text("Introuvable: $path", style: const TextStyle(fontSize: 12, color: Colors.red), textAlign: TextAlign.center),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Réserver ${widget.item['name']}"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // APPEL DE LA FONCTION IMAGE SÉCURISÉE
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: buildLocalImage(),
              ),
              
              const SizedBox(height: 20),
              
              Text(
                "${widget.item['price']} DA ${widget.type == 'vehicle' ? '/ jour' : ''}",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue.shade800),
              ),
              
              const SizedBox(height: 20),

              if (widget.type == 'vehicle') ...[
                const Text("Dates de location", style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => _selectDate(context, true),
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            _startDate == null ? "Début" : DateFormat('dd/MM/yyyy').format(_startDate!),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: InkWell(
                        onTap: () => _selectDate(context, false),
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            _endDate == null ? "Fin" : DateFormat('dd/MM/yyyy').format(_endDate!),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],

              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Votre numéro de téléphone",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  prefixIcon: const Icon(Icons.phone),
                ),
                validator: (value) => value!.isEmpty ? "Requis" : null,
              ),

              const SizedBox(height: 30),

              if (widget.type == 'vehicle' && _startDate != null && _endDate != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total estimé:", style: TextStyle(fontSize: 18)),
                      Text("${totalPrice.toStringAsFixed(0)} DA", 
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
                    ],
                  ),
                ),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton( // bouton cha
                  onPressed: _isLoading ? null : _submitReservation,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0D47A1),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: _isLoading 
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("CONFIRMER LA RÉSERVATION", 
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 