// // ignore_for_file: avoid_unnecessary_containers

// import 'package:booking_app/services/widget_support.dart';
// import 'package:flutter/material.dart';

// class Home extends StatefulWidget{

//   const Home ({super.key});

//   @override
//   State<Home> createState()=> _HomeState();
// }

// class _HomeState extends State<Home>{
//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 243, 242, 242),
//       body: SingleChildScrollView(
//         child: Container(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Stack(
//                 children: [
//                   ClipRRect(
//                     borderRadius:BorderRadius.only( 
//                       bottomLeft: Radius.circular(40),
//                       bottomRight: Radius.circular(40)) ,
                  
//                              child:  Image.asset(
//                     "images/home.jpg",
//                      width:MediaQuery.of(context).size.width,
//                      height: 280,
//                      fit:BoxFit.cover,
//                      ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.only(top: 40.0, left: 20.0),
//                      width:MediaQuery.of(context).size.width,
//                      height: 280,   
//                      decoration: BoxDecoration(color: Colors.black45, borderRadius:BorderRadius.only( 
//                       bottomLeft: Radius.circular(40),
//                       bottomRight: Radius.circular(40)) ,), 
        
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Icon(Icons.location_on, color: Colors.white,),
//                           SizedBox(width: 10.0),
//                           Text("Algeria, Alger", style: AppWidget.whitetextstyle(20.0),)
//                         ],
//                       ),
//                       SizedBox(height: 30.0, ),
//                       Text("Hey,  win rak hab troh ?", style:AppWidget.whitetextstyle(22.0)),
//                        SizedBox(height: 30.0, ),
//                       Container(
//                         padding: EdgeInsets.only(bottom: 5.0, top: 5.0),
//                         margin: EdgeInsets.only(right: 20.0),
//                         width: MediaQuery.of(context).size.width,
//                         decoration: BoxDecoration(color: const Color.fromARGB(104, 255, 255, 255),
//                          borderRadius:BorderRadius.circular(30) ),
//                         child: TextField(
//                           decoration: InputDecoration(
//                             border: InputBorder.none,prefixIcon: Icon(Icons.search, color: Colors.white,),hintText: "Search Places....", hintStyle: AppWidget.whitetextstyle(20.0)
//                           ),
//                         ),
        
//                       )
        
//                     ],
//                   ),             
        
//                   )
//                 ],
//               ),
//               SizedBox(height: 20.0,),
//               Padding(
//                 padding: const EdgeInsets.only(left:20.0),
//                 child: Text("The most relevent",style: AppWidget.headlinetextstyle(22.0)),
//               ),
//               SizedBox(height: 20.0,),
//               SizedBox(
//                 height: 330,
//                 child: ListView(
//                   scrollDirection: Axis.horizontal,
//                   children: [
//                     Container(
//                       margin:EdgeInsets.only(left:20.0,bottom: 5.0),
//                       child: Material(
//                         elevation: 2.0,
//                         borderRadius: BorderRadius.circular(30.0) ,
//                         child: Container(
//                           decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30.0) ),
                  
//                           child: Column(
//                             children: [
//                             ClipRRect(
//                               borderRadius: BorderRadius.circular(30),
//                               child: Image.asset(
//                                 "images/alger.jpg",
//                                  width: MediaQuery.of(context).size.width/1.2,),
//                             ),
//                             SizedBox(height:10.0,),
//                             Padding(
//                               padding: const EdgeInsets.only(left:10.0 ),
//                               child: Row(
//                                 children: [
//                                   Text("alger",style:AppWidget.headlinetextstyle(22.0)),
//                                   SizedBox(width: MediaQuery.of(context).size.width/3.5,),
//                                   Text("?DA", style: AppWidget.headlinetextstyle(25.0))
//                                 ],
//                               ),
//                             ),
//                             SizedBox(width:5.0,),
//                             Padding(
//                               padding: const EdgeInsets.only(left:10.0 ),
//                               child: Row(children: [
//                                 Icon(Icons.location_on,color: Colors.blue,size:30.0),
//                                 SizedBox(width:5.0,),
//                                 Text(" near babezouar ", style: AppWidget.normaltextstyle(18.0))
//                               ],),
//                             )
//                           ],),
//                         ),
//                       ),
//                     ),
        
        
//                     Container(
//                       margin:EdgeInsets.only(left:20.0,bottom: 5.0),
//                       child: Material(
//                         elevation: 2.0,
//                         borderRadius: BorderRadius.circular(30.0) ,
//                         child: Container(
//                           decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30.0) ),
                  
//                           child: Column(
//                             children: [
//                             ClipRRect(
//                               borderRadius: BorderRadius.circular(30),
//                               child: Image.asset(
//                                 "images/apartment.jpg",
//                                  width: MediaQuery.of(context).size.width/1.2, fit: BoxFit.cover,height: 230,),
//                             ),
//                             SizedBox(height:10.0,),
//                             Padding(
//                               padding: const EdgeInsets.only(left:10.0 ),
//                               child: Row(
//                                 children: [
//                                   Text("Hotel Beach",style:AppWidget.headlinetextstyle(22.0)),
//                                   SizedBox(width: MediaQuery.of(context).size.width/3.5,),
//                                   Text("\$20", style: AppWidget.headlinetextstyle(25.0))
//                                 ],
//                               ),
//                             ),
//                             SizedBox(width:5.0,),
//                             Padding(
//                               padding: const EdgeInsets.only(left:10.0 ),
//                               child: Row(children: [
//                                 Icon(Icons.location_on,color: Colors.blue,size:30.0),
//                                 SizedBox(width:5.0,),
//                                 Text("Near Main Market, Delhi", style: AppWidget.normaltextstyle(18.0))
//                               ],),
//                             )
//                           ],),
//                         ),
//                       ),
//                     ),
        
        
        
        
//                      Container(
//                       margin:EdgeInsets.only(left:20.0,bottom: 5.0),
//                       child: Material(
//                         elevation: 2.0,
//                         borderRadius: BorderRadius.circular(30.0) ,
//                         child: Container(
//                           decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30.0) ),
                  
//                           child: Column(
//                             children: [
//                             ClipRRect(
//                               borderRadius: BorderRadius.circular(30),
//                               child: Image.asset(
//                                 "images/hotel3.jpg",
//                                  width: MediaQuery.of(context).size.width/1.2, fit: BoxFit.cover,height: 230,),
//                             ),
//                             SizedBox(height:10.0,),
//                             Padding(
//                               padding: const EdgeInsets.only(left:10.0 ),
//                               child: Row(
//                                 children: [
//                                   Text("Hotel Beach",style:AppWidget.headlinetextstyle(22.0)),
//                                   SizedBox(width: MediaQuery.of(context).size.width/3.5,),
//                                   Text("\$20", style: AppWidget.headlinetextstyle(25.0))
//                                 ],
//                               ),
//                             ),
//                             SizedBox(width:5.0,),
//                             Padding(
//                               padding: const EdgeInsets.only(left:20.0 ),
//                               child: Row(children: [
//                                 Icon(Icons.location_on,color: Colors.blue,size:30.0),
//                                 SizedBox(width:5.0,),
//                                 Text("Near Main Market, Delhi", style: AppWidget.normaltextstyle(18.0))
//                               ],),
//                             )
//                           ],
//                           ),
//                         ),
//                       ),
//                     )
                
//                   ],
//                 ),
//               ),
//               SizedBox(height:20.0),
//               Padding(
//                 padding: const EdgeInsets.only(left:20.0),
//                 child: Text("Discover new places",
//                  style: AppWidget.headlinetextstyle(22.0)
//                  ),
//               ),
//               SizedBox(height: 20.0,),



//               Container(
//                 margin: EdgeInsets.only(left: 20.0, bottom: 5.0),
//                 height: 280,
//                 child: ListView(
//                   scrollDirection: Axis.horizontal,
//                   children: [
//                     Container(
//                       margin: EdgeInsets.only(bottom: 5.0),
//                       child: Material(
//                       elevation: 2.0,
//                       borderRadius: BorderRadius.circular(30),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(30),
//                         child: Container(
//                           width: 180,
//                           color: Colors.white,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Image.asset(
//                                 "images/apartment.jpg",
//                                 height: 200,
//                                 width: double.infinity,
//                                 fit: BoxFit.cover,
//                               ),
//                               SizedBox(height: 10.0),
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 20.0),
//                                 child: Text("oran", style: AppWidget.headlinetextstyle(20.0)),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 20.0, bottom: 10.0),
//                                 child: Row(
//                                   children: [
//                                     Icon(Icons.hotel, color: Colors.blue),
//                                     SizedBox(width: 5.0),
//                                     Text("10 Hotels", style: AppWidget.normaltextstyle(17.0)),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                                         ),
//                     ),

//                  Container(
//                    margin: EdgeInsets.only(left: 20.0, bottom: 5.0),
//                    child: Material(
//                       elevation: 2.0,
//                       borderRadius: BorderRadius.circular(30),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(30),
//                         child: Container(
//                           width: 180,
//                           color: Colors.white,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Image.asset(
//                                 "images/alger.jpg",
//                                 height: 200,
//                                 width: double.infinity,
//                                 fit: BoxFit.cover,
//                               ),
//                               SizedBox(height: 10.0),
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 20.0),
//                                 child: Text("telemcan", style: AppWidget.headlinetextstyle(20.0)),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 20.0, bottom: 10.0),
//                                 child: Row(
//                                   children: [
//                                     Icon(Icons.hotel, color: Colors.blue),
//                                     SizedBox(width: 5.0),
//                                     Text("8 Hotels", style: AppWidget.normaltextstyle(17.0)),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                  ),


//                  Container(
//                    margin: EdgeInsets.only(left: 20.0, bottom: 5.0),
//                    child: Material(
//                       elevation: 2.0,
//                       borderRadius: BorderRadius.circular(30),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(30),
//                         child: Container(
//                           width: 180,
//                           color: Colors.white,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Image.asset(
//                                 "images/alger.jpg",
//                                 height: 200,
//                                 width: double.infinity,
//                                 fit: BoxFit.cover,
//                               ),
//                               SizedBox(height: 10.0),
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 20.0),
//                                 child: Text("New York", style: AppWidget.headlinetextstyle(20.0)),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 20.0, bottom: 10.0),
//                                 child: Row(
//                                   children: [
//                                     Icon(Icons.hotel, color: Colors.blue),
//                                     SizedBox(width: 5.0),
//                                     Text("20 Hotels", style: AppWidget.normaltextstyle(17.0)),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                  ),

//                  Container(
//                    margin: EdgeInsets.only(left: 20.0, bottom: 5.0),
//                    child: Material(
//                       elevation: 2.0,
//                       borderRadius: BorderRadius.circular(30),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(30),
//                         child: Container(
//                           width: 180,
//                           color: Colors.white,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Image.asset(
//                                 "images/alger.jpg",
//                                 height: 200,
//                                 width: double.infinity,
//                                 fit: BoxFit.cover,
//                               ),
//                               SizedBox(height: 10.0),
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 20.0),
//                                 child: Text("Bali", style: AppWidget.headlinetextstyle(20.0)),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 20.0, bottom: 10.0),
//                                 child: Row(
//                                   children: [
//                                     Icon(Icons.hotel, color: Colors.blue),
//                                     SizedBox(width: 5.0),
//                                     Text("7 Hotels", style: AppWidget.normaltextstyle(17.0)),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                  ),


                 

//                 ],),
//                ),



//                SizedBox(height: 50.0,)


              
        
              
//         ],
//         ),
//         ),
//       ),
//     );

//   }
// }



// import 'package:flutter/material.dart';

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomePageState();
// }

// class _HomePageState extends State<Home> {
//   String? selectedCategory;

//   final List<Map<String, dynamic>> categories = [
//     {"id": "vacation", "label": "Vacances", "icon": Icons.beach_access},
//     {"id": "business", "label": "Affaires", "icon": Icons.work},
//     {"id": "family", "label": "Famille", "icon": Icons.people},
//   ];

//   final List<Map<String, dynamic>> properties = [
//     {
//       "id": "1",
//       "image": "https://images.unsplash.com/photo-1594873604892-b599f847e859",
//       "title": "Appartement Moderne Centre Ville",
//       "location": "Alger Centre, Alger",
//       "price": 8500,
//       "rating": 4.8,
//       "reviews": 42,
//       "category": "Appartement",
//     },
//     {
//       "id": "2",
//       "image": "https://images.unsplash.com/photo-1731336478850-6bce7235e320",
//       "title": "Hôtel de Luxe Vue Mer",
//       "location": "Sidi Fredj, Tipaza",
//       "price": 15000,
//       "rating": 4.9,
//       "reviews": 128,
//       "category": "Hôtel",
//     },
//     {
//       "id": "3",
//       "image": "https://images.unsplash.com/photo-1610123172763-1f587473048f",
//       "title": "Studio Cosy Pour Affaires",
//       "location": "Hydra, Alger",
//       "price": 6000,
//       "rating": 4.7,
//       "reviews": 35,
//       "category": "Studio",
//     },
//     {
//       "id": "4",
//       "image": "https://images.unsplash.com/photo-1627232343290-b992cf13fddf",
//       "title": "Resort Familial Plage",
//       "location": "Zéralda, Alger",
//       "price": 12000,
//       "rating": 4.6,
//       "reviews": 89,
//       "category": "Resort",
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         title: const Text("choufDAR"),
//         backgroundColor: const Color(0xFF1E3C72),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 "Trouvez votre séjour idéal",
//                 style: TextStyle(fontSize: 18, color: Colors.black54),
//               ),
//               const SizedBox(height: 20),

//               // Search Bar
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black12,
//                       blurRadius: 5,
//                       offset: const Offset(0, 2),
//                     )
//                   ],
//                 ),
//                 padding: const EdgeInsets.all(12),
//                 child: Column(
//                   children: [
//                     TextField(
//                       decoration: InputDecoration(
//                         prefixIcon: const Icon(Icons.location_on_outlined),
//                         hintText: "Où souhaitez-vous aller ?",
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: TextField(
//                             decoration: InputDecoration(
//                               prefixIcon: const Icon(Icons.calendar_today),
//                               hintText: "Arrivée",
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 8),
//                         Expanded(
//                           child: TextField(
//                             decoration: InputDecoration(
//                               prefixIcon: const Icon(Icons.calendar_today),
//                               hintText: "Départ",
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 10),
//                     ElevatedButton.icon(
//                       onPressed: () {},
//                       icon: const Icon(Icons.search),
//                       label: const Text("Rechercher"),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF1E3C72),
//                         minimumSize: const Size(double.infinity, 48),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 30),

//               // Categories
//               const Text(
//                 "Catégories",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 10),
//               SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   children: categories.map((cat) {
//                     final isSelected = selectedCategory == cat["id"];
//                     return Padding(
//                       padding: const EdgeInsets.only(right: 8),
//                       child: ChoiceChip(
//                         label: Text(cat["label"]),
//                         avatar: Icon(cat["icon"],
//                             color: isSelected
//                                 ? Colors.white
//                                 : const Color(0xFF1E3C72)),
//                         selected: isSelected,
//                         onSelected: (_) {
//                           setState(() {
//                             selectedCategory =
//                                 isSelected ? null : cat["id"] as String;
//                           });
//                         },
//                         selectedColor: const Color(0xFF1E3C72),
//                         labelStyle: TextStyle(
//                             color: isSelected ? Colors.white : Colors.black),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),

//               const SizedBox(height: 30),

//               // Property Cards
//               const Text(
//                 "Recommandations",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 10),
//               Column(
//                 children: properties.map((property) {
//                   return Card(
//                     margin: const EdgeInsets.only(bottom: 16),
//                     clipBehavior: Clip.hardEdge,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Image.network(
//                           property["image"],
//                           height: 180,
//                           width: double.infinity,
//                           fit: BoxFit.cover,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(12),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(property["title"],
//                                   style: const TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 16)),
//                               const SizedBox(height: 5),
//                               Row(
//                                 children: [
//                                   const Icon(Icons.location_on_outlined,
//                                       size: 16, color: Colors.grey),
//                                   const SizedBox(width: 4),
//                                   Text(property["location"],
//                                       style: const TextStyle(
//                                           color: Colors.grey, fontSize: 13)),
//                                 ],
//                               ),
//                               const SizedBox(height: 8),
//                               Text(
//                                 "${property["price"]} DA / nuit",
//                                 style: const TextStyle(
//                                     color: Color(0xFF1E3C72),
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }





import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: unused_import
import 'package:booking_app/services/database.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  String? selectedCategory;

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Trouvez votre séjour idéal",
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
              const SizedBox(height: 20),

              // Search & Categories can remain same...
              // ...

              const SizedBox(height: 30),
              const Text(
                "Recommandations",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              // 🔹 StreamBuilder for dynamic properties
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

                  return Column(
                    children: docs.map((doc) {
                      final data = doc.data() as Map<String, dynamic>;
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
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
                                    child: const Center(child: Icon(Icons.image, size: 50)),
                                  ),
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data["PlaceName"] ?? "",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 16)),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on_outlined, size: 16, color: Colors.grey),
                                      const SizedBox(width: 4),
                                      Text(data["PlaceAddress"] ?? "",
                                          style: const TextStyle(color: Colors.grey, fontSize: 13)),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "${data["PlaceCharges"] ?? "-"} DA / nuit",
                                    style: const TextStyle(
                                        color: Color(0xFF1E3C72), fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }).toList(),
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
