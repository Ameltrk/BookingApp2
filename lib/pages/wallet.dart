import 'package:flutter/material.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletPageState();
}

class _WalletPageState extends State<Wallet> {
  String selectedMethod = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wallet / Payment Methods"),
        backgroundColor: const Color(0xFF1E3A8A),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          buildPaymentCard(
            "Dahabia Card",
            "Pay using your Dahabia Card",
            "images/dahabia_logo.png", // Add your Dahabia logo here
          ),
          buildPaymentCard(
            "Cash on Delivery",
            "Pay when you arrive",
            "images/cash_icon.png",
          ),
        ],
      ),
    );
  }

  Widget buildPaymentCard(String title, String subtitle, String imageAsset) {
    bool isSelected = selectedMethod == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMethod = title;
        });
        // Return selected payment method to DetailPage
        Navigator.pop(context, title);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: ListTile(
          leading: Image.asset(imageAsset, width: 50, height: 50),
          title: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          subtitle: Text(subtitle),
          trailing: isSelected
              ? const Icon(Icons.check_circle, color: Colors.green, size: 30)
              : const Icon(Icons.radio_button_off, size: 30),
        ),
      ),
    );
  }
}
