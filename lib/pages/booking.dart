// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart'; // Importation nécessaire pour l'ID utilisateur
// // Assurez-vous que ce chemin est correct pour votre classe DatabaseMethods
// // import 'votre_chemin/database.dart';

// // ----------------------------------------------------------------------
// // NOTE IMPORTANTE :
// // Vous devez avoir un utilisateur connecté pour que FirebaseAuth.instance.currentUser ne soit pas null.
// // ----------------------------------------------------------------------

// // Définition d'un modèle simple pour les données de réservation
// class BookingModel {
//   final String id;
//   final String title;
//   final DateTime startDate;
//   final DateTime endDate;
//   final int guestCount;
//   final double price;
//   final String status; // 'incoming' ou 'past'

//   BookingModel.fromFirestore(DocumentSnapshot doc)
//     : id = doc.id,
//       title = doc['title'] ?? 'Lieu Inconnu',
//       startDate = (doc['startDate'] as Timestamp).toDate(),
//       endDate = (doc['endDate'] as Timestamp).toDate(),
//       guestCount = doc['guestCount'] ?? 0,
//       price = doc['price']?.toDouble() ?? 0.0,
//       status = doc['status'] ?? 'incoming';
// }

// // Widget personnalisé pour les cartes "Incoming" et "Past" Bookings (Cliquable)
// class BookingTile extends StatelessWidget {
//   final String title;
//   final IconData icon;
//   final Color color;
//   final VoidCallback? onTap;

//   const BookingTile({
//     super.key,
//     required this.title,
//     required this.icon,
//     required this.color,
//     this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Card(
//         elevation: 4,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//         child: InkWell(
//           onTap: onTap,
//           borderRadius: BorderRadius.circular(15),
//           child: Container(
//             padding: const EdgeInsets.all(15),
//             height: 180,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     color: color.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Icon(icon, size: 40, color: color),
//                 ),
//                 const SizedBox(height: 20),
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Widget pour afficher un élément de réservation détaillé
// class BookingItemCard extends StatelessWidget {
//   final BookingModel booking;

//   const BookingItemCard({super.key, required this.booking});

//   @override
//   Widget build(BuildContext context) {
//     String formatDate(DateTime date) {
//       return "${date.day}, ${['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'][date.month - 1]} ${date.year}";
//     }

//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       margin: const EdgeInsets.only(top: 20),
//       child: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Image du lieu (Placeholder)
//             ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: Container(
//                 width: 100,
//                 height: 100,
//                 color: Colors.grey.shade300,
//                 child: const Center(
//                   child: Icon(Icons.image, size: 40, color: Colors.grey),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 15),
//             // Détails de la réservation
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     booking.title,
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   // Dates
//                   Row(
//                     children: [
//                       const Icon(
//                         Icons.calendar_today,
//                         size: 16,
//                         color: Colors.grey,
//                       ),
//                       const SizedBox(width: 5),
//                       Flexible(
//                         child: Text(
//                           '${formatDate(booking.startDate)} to ${formatDate(booking.endDate)}',
//                           style: const TextStyle(
//                             fontSize: 14,
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 8),
//                   // Invités et Prix
//                   Row(
//                     children: [
//                       const Icon(Icons.people, size: 16, color: Colors.grey),
//                       const SizedBox(width: 5),
//                       Text(
//                         '${booking.guestCount}',
//                         style: const TextStyle(
//                           fontSize: 14,
//                           color: Colors.grey,
//                         ),
//                       ),
//                       const SizedBox(width: 15),
//                       const Icon(
//                         Icons.attach_money,
//                         size: 16,
//                         color: Colors.green,
//                       ),
//                       const SizedBox(width: 5),
//                       Text(
//                         '\$${booking.price.toStringAsFixed(2)}',
//                         style: const TextStyle(
//                           fontSize: 14,
//                           color: Colors.green,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Widget principal de la page de réservation (Utilise FirebaseAuth pour l'ID utilisateur)
// class BookingPage extends StatefulWidget {
//   const BookingPage({super.key});

//   @override
//   State<BookingPage> createState() => _BookingPageState();
// }

// class _BookingPageState extends State<BookingPage> {
//   String _currentFilter = 'incoming';

//   @override
//   Widget build(BuildContext context) {
//     // Vérification de l'utilisateur connecté
//     final User? user = FirebaseAuth.instance.currentUser;

//     if (user == null) {
//       return const Scaffold(
//         body: Center(
//           child: Text("Veuillez vous connecter pour voir vos réservations."),
//         ),
//       );
//     }

//     final String currentUserId = user.uid;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'BOOKING',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         foregroundColor: Colors.black,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Section des cartes "Incoming" et "Past"
//             Row(
//               children: [
//                 BookingTile(
//                   title: 'Incoming Bookings',
//                   icon: Icons.calendar_month,
//                   color: _currentFilter == 'incoming'
//                       ? Colors.white
//                       : Colors.green, // Ajout d'un effet visuel
//                   onTap: () {
//                     setState(() {
//                       _currentFilter = 'incoming';
//                     });
//                   },
//                 ),
//                 const SizedBox(width: 16),
//                 BookingTile(
//                   title: 'Past Bookings',
//                   icon: Icons.history,
//                   color: _currentFilter == 'past'
//                       ? Colors.white
//                       : Colors.orange, // Ajout d'un effet visuel
//                   onTap: () {
//                     setState(() {
//                       _currentFilter = 'past';
//                     });
//                   },
//                 ),
//               ],
//             ),

//             const SizedBox(height: 20),

//             // Récupération des données de Firebase pour l'utilisateur connecté
//             StreamBuilder<QuerySnapshot>(
//               stream: FirebaseFirestore.instance
//                   .collection("bookings")
//                   .where("userId", isEqualTo: currentUserId)
//                   .orderBy("startDate", descending: true)
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//                 if (snapshot.hasError) {
//                   return Center(
//                     child: Text(
//                       'Erreur de chargement des données: ${snapshot.error}',
//                     ),
//                   );
//                 }
//                 if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                   return const Center(
//                     child: Text('Aucune réservation trouvée.'),
//                   );
//                 }

//                 // Conversion et filtrage des réservations
//                 final allBookings = snapshot.data!.docs
//                     .map((doc) => BookingModel.fromFirestore(doc))
//                     .toList();

//                 final filteredBookings = allBookings.where((booking) {
//                   // Logique de filtrage basée sur le statut
//                   return booking.status == _currentFilter;
//                 }).toList();

//                 if (filteredBookings.isEmpty) {
//                   return Center(
//                     child: Text(
//                       'Aucune réservation ${_currentFilter == 'incoming' ? 'à venir' : 'passée'} pour le moment.',
//                     ),
//                   );
//                 }

//                 // Affichage de la liste
//                 return ListView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: filteredBookings.length,
//                   itemBuilder: (context, index) {
//                     return BookingItemCard(booking: filteredBookings[index]);
//                   },
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import '../services/booking_manager.dart';
import 'detail_page.dart';

class BookingDashboardPage extends StatefulWidget {
  const BookingDashboardPage({super.key});

  @override
  State<BookingDashboardPage> createState() => _BookingDashboardPageState();
}

class _BookingDashboardPageState extends State<BookingDashboardPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // Load saved bookings
    BookingManager.instance.loadBookings().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    DateTime now = DateTime.now();

    // Filter bookings dynamically
    List<Map<String, dynamic>> upcomingBookings = BookingManager.instance.bookings
        .where((b) => (b["CheckOut"] as DateTime).isAfter(now))
        .toList();

    List<Map<String, dynamic>> pastBookings = BookingManager.instance.bookings
        .where((b) => (b["CheckOut"] as DateTime).isBefore(now))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Bookings"),
        backgroundColor: const Color(0xFF1E3A8A),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey.shade300,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(icon: Icon(Icons.calendar_today), text: "Upcoming"),
            Tab(icon: Icon(Icons.history), text: "Past"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          bookingsList(upcomingBookings, "No upcoming bookings."),
          bookingsList(pastBookings, "No past bookings."),
        ],
      ),
    );
  }

  Widget bookingsList(List<Map<String, dynamic>> list, String emptyMessage) {
    if (list.isEmpty) {
      return Center(child: Text(emptyMessage, style: const TextStyle(fontSize: 18)));
    }

    // Sort upcoming by nearest Check-in, past by most recent Check-out
    list.sort((a, b) {
      DateTime dateA = a["CheckIn"] ?? a["CheckOut"];
      DateTime dateB = b["CheckIn"] ?? b["CheckOut"];
      return dateA.compareTo(dateB);
    });

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final booking = list[index];
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: ListTile(
            leading: booking["Image"] != null
                ? Image.network(booking["Image"], width: 60, height: 60, fit: BoxFit.cover)
                : null,
            title: Text(
              booking["PlaceName"],
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              "Check-in: ${formatDate(booking["CheckIn"])}\n"
              "Check-out: ${formatDate(booking["CheckOut"])}\n"
              "Guests: ${booking["Guests"] ?? 1}\n"
              "Charges: \$${booking["PlaceCharges"]}\n"
              "Payment: ${booking["PaymentMethod"] ?? "N/A"}",
              style: const TextStyle(fontSize: 16),
            ),
            isThreeLine: true,
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => DetailPage(placeData: booking)),
              );
            },
          ),
        );
      },
    );
  }

  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2,'0')}, ${date.month}, ${date.year}";
  }
}
