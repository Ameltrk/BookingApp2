// settings.dart

import 'package:flutter/material.dart';
import 'package:booking_app/pages/edit_profile.dart'; // Assurez-vous que le chemin est correct

// Widget hypothétique pour la page de changement de mot de passe
class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Changer le mot de passe')),
      body: const Center(
        child: Text('Formulaire de changement de mot de passe ici'),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
        backgroundColor: const Color(0xFF1976D2),
      ),
      body: ListView(
        children: [
          // Section 1: Paramètres du Compte
          _buildSectionTitle(context, 'Compte'),

          // CORRECTION : La navigation est gérée dans _buildSettingItem, donc onTap est vide
          _buildSettingItem(context, Icons.person, 'Modifier le profil', () {}),

          // Ajout de la navigation pour l'exemple de "Changer le mot de passe"
          _buildSettingItem(context, Icons.lock, 'Changer le mot de passe', () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ChangePasswordPage(),
              ),
            );
          }),

          const Divider(),

          // Section 2: Préférences
          _buildSectionTitle(context, 'Préférences'),
          _buildSettingItem(context, Icons.language, 'Langue', () {
            // TODO: Afficher un sélecteur de langue
          }),
          _buildSettingItem(context, Icons.notifications, 'Notifications', () {
            // TODO: Basculer les notifications
          }),

          const Divider(),

          // Section 3: Informations Légales
          _buildSectionTitle(context, 'Informations'),
          _buildSettingItem(
            context,
            Icons.description,
            'Conditions d\'utilisation',
            () {
              // TODO: Ouvrir le lien
            },
          ),
          _buildSettingItem(
            context,
            Icons.security,
            'Politique de confidentialité',
            () {
              // TODO: Ouvrir le lien
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 16.0, bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  // FONCTION _buildSettingItem CORRIGÉE
  Widget _buildSettingItem(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[700]),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        // Logique spécifique pour "Modifier le profil"
        if (title == 'Modifier le profil') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const EditProfilePage()),
          );
        }
        // Logique spécifique pour "Changer le mot de passe"
        // Si vous ne voulez pas gérer la navigation ici, vous pouvez la laisser dans le 'else'
        // J'ai choisi de la laisser dans le 'else' pour cet exemple
        else {
          onTap(); // Exécute la fonction passée en argument (comme la navigation pour le mot de passe)
        }
      },
    );
  }
}
