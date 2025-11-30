
import 'package:booking_app/pages/wallet.dart';
import 'package:flutter/material.dart';
import '../services/booking_manager.dart';
import 'package:booking_app/services/widget_support.dart';

class DetailPage extends StatefulWidget {
  final Map<String, dynamic> placeData;

  const DetailPage({super.key, required this.placeData});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  DateTime? checkInDate;
  DateTime? checkOutDate;
  int guests = 1;
  String paymentMethod = "";

  static const Color primaryColor = Color(0xFF1E3C72);

  Future<void> pickCheckInDate() async {
    DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: checkInDate ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 2),
    );
    if (picked != null) {
      setState(() {
        checkInDate = picked;
        if (checkOutDate != null && checkOutDate!.isBefore(picked)) {
          checkOutDate = null;
        }
      });
    }
  }

  Future<void> pickCheckOutDate() async {
    if (checkInDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select check-in date first.")),
      );
      return;
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: checkOutDate ?? checkInDate!.add(const Duration(days: 1)),
      firstDate: checkInDate!.add(const Duration(days: 1)),
      lastDate: DateTime(checkInDate!.year + 2),
    );
    if (picked != null) {
      setState(() {
        checkOutDate = picked;
      });
    }
  }

  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2,'0')}/${date.month.toString().padLeft(2,'0')}/${date.year}";
  }

  Widget buildServiceRow(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Icon(icon, color: primaryColor, size: 28),
          const SizedBox(width: 10),
          Text(label, style: AppWidget.normaltextstyle(18.0)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.placeData;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE + BACK BUTTON
            Stack(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2.2,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                    child: data["Image"] != null && data["Image"].isNotEmpty
                        ? Image.network(data["Image"], fit: BoxFit.cover)
                        : Image.asset("images/hotel1.jpg", fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 20,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(60),
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20.0),

                  // PLACE NAME
                  Text(data["PlaceName"] ?? "", style: AppWidget.headlinetextstyle(24.0)),
                  const SizedBox(height: 5.0),

                  // PRICE
                  Text("${data["PlaceCharges"] ?? "N/A"} DA / nuit",
                      style: AppWidget.normaltextstyle(26.0).copyWith(color: primaryColor, fontWeight: FontWeight.bold)),

                  const Divider(thickness: 2.0),
                  const SizedBox(height: 15.0),

                  // PLACE DESCRIPTION
                  Text("À propos de ce séjour", style: AppWidget.headlinetextstyle(22.0)),
                  const SizedBox(height: 5.0),
                  Text(data["PlaceDescription"] ?? "Pas de description disponible",
                      style: AppWidget.normaltextstyle(16.0)),

                  const SizedBox(height: 20.0),

                  // SERVICES OFFERED
                  Text("Services proposés", style: AppWidget.headlinetextstyle(22.0)),
                  const SizedBox(height: 5.0),
                  if (data["WiFi"] == true) buildServiceRow(Icons.wifi, "WiFi"),
                  if (data["HDTV"] == true) buildServiceRow(Icons.tv, "HDTV"),
                  if (data["Kitchen"] == true) buildServiceRow(Icons.kitchen, "Cuisine"),
                  if (data["Bathroom"] == true) buildServiceRow(Icons.bathroom, "Salle de bain"),

                  const Divider(thickness: 2.0),
                  const SizedBox(height: 15.0),

                  // NUMBER OF GUESTS
                  Text("Nombre de voyageurs", style: AppWidget.normaltextstyle(20.0)),
                  const SizedBox(height: 5.0),
                  Container(
                    padding: const EdgeInsets.only(left: 20.0),
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (val) {
                        setState(() {
                          guests = int.tryParse(val) ?? 1;
                        });
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "1",
                        hintStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15.0),

                  // DATE PICKERS
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: pickCheckInDate,
                          icon: const Icon(Icons.calendar_today_outlined),
                          label: Text(checkInDate != null ? formatDate(checkInDate!) : "Check-in"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: pickCheckOutDate,
                          icon: const Icon(Icons.calendar_today_outlined),
                          label: Text(checkOutDate != null ? formatDate(checkOutDate!) : "Check-out"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15.0),

                  // PAYMENT METHOD
                  ElevatedButton.icon(
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const Wallet()),
                      );
                      if (result != null) {
                        setState(() {
                          paymentMethod = result;
                        });
                      }
                    },
                    icon: const Icon(Icons.payment),
                    label: Text(paymentMethod.isEmpty ? "Choisir le mode de paiement" : "Paiement: $paymentMethod"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),

                  const SizedBox(height: 20.0),

                  // BOOK NOW BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        if (checkInDate == null || checkOutDate == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Veuillez sélectionner les deux dates.")),
                          );
                          return;
                        }
                        if (paymentMethod.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Veuillez sélectionner un mode de paiement.")),
                          );
                          return;
                        }

                        BookingManager.instance.addBooking({
                          "PlaceName": data["PlaceName"] ?? "",
                          "PlaceCharges": data["PlaceCharges"] ?? 0,
                          "CheckIn": checkInDate!,
                          "CheckOut": checkOutDate!,
                          "Guests": guests,
                          "PaymentMethod": paymentMethod,
                          "PlaceDescription": data["PlaceDescription"] ?? "",
                          "Image": data["Image"] ?? "",
                          "WiFi": data["WiFi"] ?? false,
                          "HDTV": data["HDTV"] ?? false,
                          "Kitchen": data["Kitchen"] ?? false,
                          "Bathroom": data["Bathroom"] ?? false,
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Réservation ajoutée !")),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text("Réserver maintenant", style: AppWidget.whitetextstyle(20.0)),
                    ),
                  ),

                  const SizedBox(height: 30.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
