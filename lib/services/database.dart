import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addUserInfo(Map<String, dynamic> userInfoMap, String id)async{
    return await FirebaseFirestore.instance
    .collection("users")
    .doc(id)
    .set(userInfoMap);
  }
  
  Future addPlaceInfo(Map<String, dynamic> placeInfoMap, String id)async{
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
}  //fetching all placess added by owner lel user t3na
  
   Future addChauffeurInfo(Map<String, dynamic> chauffeurInfoMap, String id)async{
    return await FirebaseFirestore.instance
    .collection("Chauffeur")
    .doc(id)
    .set(chauffeurInfoMap);
  }

  
  // Future<Stream<QuerySnapshot>> getallHotels()async{
  //   return await FirebaseFirestore.instance.collection("Place").snapshots();
  // }
}



