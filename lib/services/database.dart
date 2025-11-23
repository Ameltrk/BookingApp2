import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addUserInfo(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .set(userInfoMap);
  }

  Future addPlaceInfo(Map<String, dynamic> placeInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Place")
        .doc(id)
        .set(placeInfoMap);
  }

  Future<Stream<QuerySnapshot>> getAllPlaces() async {
    return FirebaseFirestore.instance
        .collection("Place")
        .orderBy("CreatedAt", descending: true)
        .snapshots();
  } //fetching all placess added by owner lel user t3na

  Future addChauffeurInfo(
    Map<String, dynamic> chauffeurInfoMap,
    String id,
  ) async {
    return await FirebaseFirestore.instance
        .collection("Chauffeur")
        .doc(id)
        .set(chauffeurInfoMap);
  }

  Future<Stream<QuerySnapshot>> getUserBookings(String userId) async {
    return FirebaseFirestore.instance
        .collection(
          "Bookings",
        ) // Assurez-vous que c'est le nom de votre collection
        .where("userId", isEqualTo: userId) // Filtre par l'utilisateur connecté
        .orderBy("startDate", descending: true) // Trie par date
        .snapshots();
  }

  // Dans database.dart

  // Récupère les données du profil de l'utilisateur
  Future<DocumentSnapshot> getUserInfo(String userId) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .get();
  }

  // Compte le nombre de réservations pour l'utilisateur
  Stream<QuerySnapshot> countUserBookings(String userId) {
    return FirebaseFirestore.instance
        .collection("Bookings")
        .where("userId", isEqualTo: userId)
        .snapshots();
  }

  // Compte le nombre de favoris pour l'utilisateur (Hypothèse d'une collection "Favorites")
  Stream<QuerySnapshot> countUserFavorites(String userId) {
    return FirebaseFirestore.instance
        .collection(
          "Favorites",
        ) // Assurez-vous que ce nom de collection est correct
        .where("userId", isEqualTo: userId)
        .snapshots();
  }

  // Future<Stream<QuerySnapshot>> getallHotels()async{
  //   return await FirebaseFirestore.instance.collection("Place").snapshots();
  // }
}
