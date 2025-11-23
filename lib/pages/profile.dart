import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// Importations ajoutées pour la navigation
import 'package:booking_app/pages/settings.dart';
import 'package:booking_app/pages/booking.dart';
// import 'votre_chemin/database.dart'; // Laissez cette ligne si vous utilisez DatabaseMethods

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final User? user = FirebaseAuth.instance.currentUser;
  late Future<DocumentSnapshot> _profileFuture;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    if (user != null) {
      _profileFuture = _firestore.collection("users").doc(user!.uid).get();
    }
  }

  String _getInitials(String fullName) {
    if (fullName.isEmpty) return '??';
    final parts = fullName.trim().split(' ');
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return parts[0][0].toUpperCase() + parts.last[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Scaffold(
        body: Center(
          child: Text("Veuillez vous connecter pour voir votre profil."),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: FutureBuilder<DocumentSnapshot>(
        future: _profileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Erreur de chargement du profil: ${snapshot.error}'),
            );
          }

          final Map<String, dynamic> userData =
              snapshot.data?.data() as Map<String, dynamic>? ?? {};
          final String fullName = userData['name'] ?? 'Utilisateur';
          final String email = user!.email ?? 'Non renseigné';
          final String phoneNumber = userData['phoneNumber'] ?? 'Non renseigné';
          final String memberSince = userData['memberSince'] ?? 'Date inconnue';
          final String initials = _getInitials(fullName);

          return SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(context, fullName, email, initials),
                _buildStatsCard(),
                const SizedBox(height: 20),
                _buildMenuSection(),
                const SizedBox(height: 20),
                _buildAccountInfoSection(phoneNumber, memberSince),
                const SizedBox(height: 30),
                _buildLogoutButton(context),
                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    String fullName,
    String email,
    String initials,
  ) {
    return Container(
      height: 250,
      decoration: const BoxDecoration(
        color: Color(0xFF1976D2),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 40.0, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Mon Profil',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.white,
                  child: Text(
                    initials,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1976D2),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fullName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      email,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.white54),
                      ),
                      child: const Text(
                        'Profil vérifié',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCard() {
    return Transform.translate(
      offset: const Offset(0, -30),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: _firestore
                      .collection("Bookings")
                      .where("userId", isEqualTo: user!.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    final count = snapshot.data?.docs.length.toString() ?? '0';
                    return _buildStatItem(count, 'Réservations');
                  },
                ),
                _buildDivider(),
                StreamBuilder<QuerySnapshot>(
                  stream: _firestore
                      .collection("Favorites")
                      .where("userId", isEqualTo: user!.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    final count = snapshot.data?.docs.length.toString() ?? '0';
                    return _buildStatItem(count, 'Favoris');
                  },
                ),
                _buildDivider(),
                _buildStatItem('12', 'Avis'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(height: 40, width: 1, color: Colors.grey[300]);
  }

  Widget _buildStatItem(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1976D2),
          ),
        ),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
      ],
    );
  }

  Widget _buildMenuSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          _buildMenuItem(Icons.calendar_today, 'Mes réservations', null),
          _buildMenuItem(Icons.favorite_border, 'Favoris', null),
          _buildMenuItem(Icons.home_work_outlined, 'Devenir hôte', null),
          _buildMenuItem(Icons.settings_outlined, 'Paramètres', null),
        ],
      ),
    );
  }

  // --- FONCTION CORRIGÉE AVEC LA LOGIQUE DE NAVIGATION ---
  Widget _buildMenuItem(IconData icon, String title, String? count) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.grey[700]),
          title: Text(title, style: const TextStyle(fontSize: 16)),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (count != null)
                Text(count, style: TextStyle(color: Colors.grey[600])),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
          onTap: () {
            // Logique de navigation
            if (title == 'Paramètres') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            } else if (title == 'Mes réservations') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BookingPage()),
              );
            }
            // Vous pouvez ajouter d'autres navigations ici (ex: 'Favoris')
          },
        ),
        Divider(height: 1, color: Colors.grey[200]),
      ],
    );
  }
  // -------------------------------------------------------

  Widget _buildAccountInfoSection(String phoneNumber, String memberSince) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Informations du compte',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow('Téléphone', phoneNumber),
                  const SizedBox(height: 10),
                  _buildInfoRow('Membre depuis', memberSince),
                  const SizedBox(height: 10),
                  _buildInfoRow('Langue', 'Français, العربية'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextButton.icon(
        onPressed: () async {
          await FirebaseAuth.instance.signOut();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Déconnexion réussie.')));
          // Vous devriez ajouter ici une navigation vers la page de connexion
        },
        icon: const Icon(Icons.logout, color: Colors.red),
        label: const Text(
          'Se déconnecter',
          style: TextStyle(
            color: Colors.red,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          minimumSize: const Size(double.infinity, 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Colors.red, width: 1),
          ),
        ),
      ),
    );
  }
}
