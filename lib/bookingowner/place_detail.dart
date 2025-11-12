// // ignore_for_file: use_build_context_synchronously, unused_local_variable, unused_import

// import 'dart:io';

// import 'package:booking_app/bookingowner/ouner_home.dart';
// import 'package:booking_app/services/database.dart';
// import 'package:booking_app/services/widget_support.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:random_string/random_string.dart';

// class PlaceDetail extends StatefulWidget {
//   const PlaceDetail({super.key});

//   @override
//   State<PlaceDetail> createState() => _PlaceDetailState();
// }

// class _PlaceDetailState extends State<PlaceDetail> {
//   bool isChecked = false,
//       isChecked1 = false,
//       isChecked2 = false,
//       isChecked3 = false;

//       File? selectedImage;
//       final ImagePicker _picker = ImagePicker();

//       TextEditingController placenamecontroller= TextEditingController();
//       TextEditingController placechargescontroller= TextEditingController();
//       TextEditingController placeaddresscontroller= TextEditingController();
//       TextEditingController placedesccontroller= TextEditingController();

//     Future getImage()async{
  
//       var image = await _picker.pickImage(source: ImageSource.gallery);
//       selectedImage = File(image!.path);
//       setState(() {
        
//       });
//     }



//  @override
//  Widget build(BuildContext context){
//   return Scaffold(
//     backgroundColor: Colors.blue,
//     body: Container(
      
//       margin:EdgeInsets.only(top: 40.0),
//       child: Column(
//       children: [
      
//       Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//         Text("Place Details",style: AppWidget.boldtextstyle(26.0),)
//       ],),
//       SizedBox(height: 20.0,),
//       Expanded(
//         child: Container(
//           padding: EdgeInsets.only(left: 20.0, right: 20),
//           decoration: BoxDecoration(color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(30),
//             topRight: Radius.circular(30))),
//             width: MediaQuery.of(context).size.width,
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: 20.0,),
//                 selectedImage!=null?
//                 SizedBox(
//                   height: 200,
//                   width: 200,
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(20.0),
//                     child: Image.file(
//                       selectedImage!,
//                       fit: BoxFit.cover,),
//                   ),

//                 ):
//                 GestureDetector(
//                   onTap: () {
//                     getImage();
//                   },
//                   child: Center(
//                     child: Container(
//                       height: 200,
//                       width: 200,
//                       decoration: BoxDecoration(
//                         borderRadius:BorderRadius.circular(20) ,
//                         border: Border.all(
//                           width: 2.0,
//                           color: Colors.black45
//                           )
//                           ),
//                       child: Icon
//                       (Icons.camera_alt,
//                        color: Colors.blue,
//                        size: 30,),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20.0,),
//                 Text("Place Name", style: AppWidget.normaltextstyle(20.0),),
//                 SizedBox(height: 5.0,),
//                 Container(
//                   padding: EdgeInsets.only(left: 20.0),
//                   decoration: BoxDecoration(color:  Color(0xFFececf8), borderRadius: BorderRadius.circular(10)),
//                   child: TextField(
//                     controller: placenamecontroller,
//                     decoration: InputDecoration(border: InputBorder.none,hintText: "Enter Place Name", hintStyle: AppWidget.normaltextstyle(18.0)),
//                   ),
//                 ),
              
//                 SizedBox(height: 20.0,),
//                 Text("Room charges", style: AppWidget.normaltextstyle(20.0),),
//                 SizedBox(height: 5.0,),
//                 Container(
//                   padding: EdgeInsets.only(left: 20.0),
//                   decoration: BoxDecoration(color:  Color(0xFFececf8), borderRadius: BorderRadius.circular(10)),
//                   child: TextField(
//                     controller: placechargescontroller,
//                     decoration: InputDecoration(
//                       border: InputBorder.none,
//                       hintText: "Enter Room Charges ",
//                       hintStyle: AppWidget.normaltextstyle(18.0)),
//                   ),
//                 ),
//                 SizedBox(height: 20.0,),
//                 Text("Place Address", style: AppWidget.normaltextstyle(20.0),),
//                 SizedBox(height: 5.0,),
//                 Container(
//                   padding: EdgeInsets.only(left: 20.0),
//                   decoration: BoxDecoration(color:  Color(0xFFececf8), borderRadius: BorderRadius.circular(10)),
//                   child: TextField(
//                     controller: placeaddresscontroller,
//                     decoration: InputDecoration(
//                       border: InputBorder.none,
//                       hintText: "Enter Place Address ",
//                       hintStyle: AppWidget.normaltextstyle(18.0)),
//                   ),
//                 ),
              
//                 SizedBox(height: 20.0,),
//                 Text(
//                   "What service you want to offer?",
//                   style: AppWidget.normaltextstyle(20.0),
//                 ),
//                 SizedBox(height: 5.0,),
//                 Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Checkbox(
//                       value: isChecked,
//                       onChanged: (bool? value){
//                       setState(() {
//                         isChecked = value!;
//                       });
//                     }
//                     ),
//                     Icon(
//                       Icons.wifi,
//                       color: const Color.fromARGB(255, 16, 98, 164), 
//                       size: 30.0,
//                     ),
//                     SizedBox(width: 10.0),
//                     Text("WiFi", style: AppWidget.normaltextstyle(23.0),),
              
//                   ],
//                 ),
//                 SizedBox(height: 5.0),
//                 Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Checkbox(
//                       value: isChecked1,
//                       onChanged: (bool? value){
//                       setState(() {
//                         isChecked1 = value!;
//                       });
//                     }
//                     ),
//                     Icon(
//                       Icons.tv,
//                       color: const Color.fromARGB(255, 16, 98, 164), 
//                       size: 30.0,
//                     ),
//                     SizedBox(width: 10.0),
//                     Text("HDTV", style: AppWidget.normaltextstyle(23.0),),
              
//                   ],
//                 ),
//                  SizedBox(height: 5.0),
//                 Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Checkbox(
//                       value: isChecked2,
//                       onChanged: (bool? value){
//                       setState(() {
//                         isChecked2 = value!;
//                       });
//                     }
//                     ),
//                     Icon(
//                       Icons.kitchen,
//                       color: const Color.fromARGB(255, 16, 98, 164), 
//                       size: 30.0,
//                     ),
//                     SizedBox(width: 10.0),
//                     Text("Kitchen", style: AppWidget.normaltextstyle(23.0),),
              
//                   ],
//                 ),
              
//                  SizedBox(height: 5.0),
//                 Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Checkbox(
//                       value: isChecked3,
//                       onChanged: (bool? value){
//                       setState(() {
//                         isChecked3 = value!;
//                       });
//                     }
//                     ),
//                     Icon(
//                       Icons.bathroom,
//                       color: const Color.fromARGB(255, 16, 98, 164), 
//                       size: 30.0,
//                     ),
//                     SizedBox(width: 10.0),
//                     Text("Bathroom", style: AppWidget.normaltextstyle(23.0),),
              
//                   ],
//                 ),
//                 SizedBox(height: 20.0,),
//                 Text(
//                   "What service you want to offer?",
//                   style: AppWidget.normaltextstyle(20.0),
//                 ),
                    
//                 SizedBox(height: 20.0,),
//               Text("Place Description", style: AppWidget.normaltextstyle(20.0),),
//               SizedBox(height: 5.0,),
//               Container(
//                 padding: EdgeInsets.only(left: 20.0),
//                 decoration: BoxDecoration(color:  Color(0xFFececf8), borderRadius: BorderRadius.circular(10)),
//                 child: TextField(
//                   controller: placedesccontroller,
//                   maxLines: 6,
//                   decoration: InputDecoration(
//                     border: InputBorder.none,
//                     hintText: "Enter About Place ",
//                     hintStyle: AppWidget.normaltextstyle(18.0)),
//                 ),
//               ),       
//               SizedBox(height: 20.0,),
//               GestureDetector(
//                 onTap: ()async {
//                   String addId= randomAlphaNumeric(10);

//                   Reference firebaseStorageRef = FirebaseStorage.instance.ref().child("blogImage").child(addId);
//                   // final UploadTask task = firebaseStorageRef.putFile(selectedImage!);
// //                   if (selectedImage == null) {
// //   // Skip upload or show a warning (depending on what you want)
// //   print("⚠️ No image selected — skipping upload for now.");
  
// //   // You can still continue your registration or save text data here.
// //   return; 
// // }

// final UploadTask task = firebaseStorageRef.putFile(selectedImage!);

//                   var downloadUrl = await(await task).ref.getDownloadURL();

//                   Map<String, dynamic> addPlace ={
//                     "Image": "",
//                     "PlaceName": placenamecontroller.text,
//                     "PlacesCharges": placechargescontroller.text,
//                     "PlaceAddress": placeaddresscontroller.text,
//                     "PlaceDescription":placedesccontroller.text,
//                     "Wi-Fi": isChecked ? "true" : "false",
//                     "HDTV": isChecked1 ? "true" : "false",
//                     "Kitchen": isChecked2 ? "true" : "false",
//                     "Bathroom": isChecked3 ? "true" : "false",
//                     "Id": addId,

//                   };
//                   await DatabaseMethods().addPlaceInfo(addPlace, addId);

//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       backgroundColor: Colors.green,
//                       content: Text(
//                         "Place details has been uploaded Successefully !",
//                         style: TextStyle(
//                           fontSize: 20.0,
//                           fontWeight: FontWeight.bold,
//                           )
                          
//                       ),
//                     ),
//                   );
//                   Navigator.push(context, MaterialPageRoute(builder: (context)=>OunerHome()));
//                 },
                
//                 child: Center(
//                   child: Container(
//                     height: 60,
//                     decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)),
//                     width: MediaQuery.of(context).size.width/1.5,
//                     child: Center(child: Text("Submit", style: AppWidget.boldtextstyle(26.0),)),
//                   ),
//                 ),
//               ),
              
//               SizedBox(height: 20.0,),
              
                
                
                      
//               ],),
//             ),
//         ),
//       )
//     ],),),
//   );
//  }
// }



// ignore_for_file: use_build_context_synchronously

// import 'dart:io';
// import 'package:booking_app/bookingowner/ouner_home.dart';
// import 'package:booking_app/services/database.dart';
// import 'package:booking_app/services/widget_support.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:random_string/random_string.dart';

// class PlaceDetail extends StatefulWidget {
//   const PlaceDetail({super.key});

//   @override
//   State<PlaceDetail> createState() => _PlaceDetailState();
// }

// class _PlaceDetailState extends State<PlaceDetail> {
//   bool isChecked = false;
//   bool isChecked1 = false;
//   bool isChecked2 = false;
//   bool isChecked3 = false;

//   File? selectedImage;
//   final ImagePicker _picker = ImagePicker();

//   TextEditingController placenamecontroller = TextEditingController();
//   TextEditingController placechargescontroller = TextEditingController();
//   TextEditingController placeaddresscontroller = TextEditingController();
//   TextEditingController placedesccontroller = TextEditingController();

//   // 📸 Pick image from gallery
//   Future getImage() async {
//     var image = await _picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       setState(() {
//         selectedImage = File(image.path);
//       });
//     }
//   }

//   // 🚀 Upload data to Firestore
//   Future uploadPlaceDetails() async {
//     if (placenamecontroller.text.isEmpty ||
//         placechargescontroller.text.isEmpty ||
//         placeaddresscontroller.text.isEmpty ||
//         placedesccontroller.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           backgroundColor: Colors.redAccent,
//           content: Text(
//             "⚠️ Please fill all fields before submitting!",
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//         ),
//       );
//       return;
//     }

//     if (selectedImage == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           backgroundColor: Colors.orangeAccent,
//           content: Text(
//             "📸 Please select an image for your place!",
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//         ),
//       );
//       return;
//     }

//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => const Center(child: CircularProgressIndicator()),
//     );

//     try {
//       String addId = randomAlphaNumeric(10);

//       // Upload image to Firebase Storage
//       Reference firebaseStorageRef =
//           FirebaseStorage.instance.ref().child("placeImages").child(addId);

//       UploadTask uploadTask = firebaseStorageRef.putFile(selectedImage!);
//       TaskSnapshot snapshot = await uploadTask;
//       String downloadUrl = await snapshot.ref.getDownloadURL();

//       // Prepare place data
//       Map<String, dynamic> addPlace = {
//         "Id": addId,
//         "Image": downloadUrl,
//         "PlaceName": placenamecontroller.text,
//         "PlaceCharges": placechargescontroller.text,
//         "PlaceAddress": placeaddresscontroller.text,
//         "PlaceDescription": placedesccontroller.text,
//         "WiFi": isChecked,
//         "HDTV": isChecked1,
//         "Kitchen": isChecked2,
//         "Bathroom": isChecked3,
//         "CreatedAt": FieldValue.serverTimestamp(),
//       };

//       // Save to Firestore
//       await DatabaseMethods().addPlaceInfo(addPlace, addId);

//       Navigator.pop(context); // close loading
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           backgroundColor: Colors.green,
//           content: Text(
//             "✅ Place details uploaded successfully!",
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//         ),
//       );

//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const OunerHome()),
//       );
//     } catch (e) {
//       Navigator.pop(context);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           backgroundColor: Colors.red,
//           content: Text(
//             "❌ Upload failed: $e",
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue,
//       body: Container(
//         margin: const EdgeInsets.only(top: 40.0),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text("Place Details", style: AppWidget.boldtextstyle(26.0)),
//               ],
//             ),
//             const SizedBox(height: 20.0),
//             Expanded(
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(30),
//                     topRight: Radius.circular(30),
//                   ),
//                 ),
//                 width: MediaQuery.of(context).size.width,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const SizedBox(height: 20.0),

//                       // 📸 Image Picker
//                       selectedImage != null
//                           ? SizedBox(
//                               height: 200,
//                               width: 200,
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(20.0),
//                                 child: Image.file(
//                                   selectedImage!,
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             )
//                           : GestureDetector(
//                               onTap: getImage,
//                               child: Center(
//                                 child: Container(
//                                   height: 200,
//                                   width: 200,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(20),
//                                     border: Border.all(
//                                         width: 2.0, color: Colors.black45),
//                                   ),
//                                   child: const Icon(
//                                     Icons.camera_alt,
//                                     color: Colors.blue,
//                                     size: 30,
//                                   ),
//                                 ),
//                               ),
//                             ),

//                       const SizedBox(height: 20.0),
//                       Text("Place Name",
//                           style: AppWidget.normaltextstyle(20.0)),
//                       const SizedBox(height: 5.0),
//                       buildTextField(
//                           placenamecontroller, "Enter Place Name"),

//                       const SizedBox(height: 20.0),
//                       Text("Room Charges",
//                           style: AppWidget.normaltextstyle(20.0)),
//                       const SizedBox(height: 5.0),
//                       buildTextField(
//                           placechargescontroller, "Enter Room Charges"),

//                       const SizedBox(height: 20.0),
//                       Text("Place Address",
//                           style: AppWidget.normaltextstyle(20.0)),
//                       const SizedBox(height: 5.0),
//                       buildTextField(
//                           placeaddresscontroller, "Enter Place Address"),

//                       const SizedBox(height: 20.0),
//                       Text("Services Offered",
//                           style: AppWidget.normaltextstyle(20.0)),
//                       const SizedBox(height: 5.0),

//                       // 🧾 Services checkboxes
//                       buildServiceCheckbox(
//                           "WiFi", Icons.wifi, isChecked, (val) {
//                         setState(() => isChecked = val!);
//                       }),
//                       buildServiceCheckbox(
//                           "HDTV", Icons.tv, isChecked1, (val) {
//                         setState(() => isChecked1 = val!);
//                       }),
//                       buildServiceCheckbox(
//                           "Kitchen", Icons.kitchen, isChecked2, (val) {
//                         setState(() => isChecked2 = val!);
//                       }),
//                       buildServiceCheckbox(
//                           "Bathroom", Icons.bathroom, isChecked3, (val) {
//                         setState(() => isChecked3 = val!);
//                       }),

//                       const SizedBox(height: 20.0),
//                       Text("Place Description",
//                           style: AppWidget.normaltextstyle(20.0)),
//                       const SizedBox(height: 5.0),
//                       Container(
//                         padding: const EdgeInsets.only(left: 20.0),
//                         decoration: BoxDecoration(
//                           color: const Color(0xFFececf8),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: TextField(
//                           controller: placedesccontroller,
//                           maxLines: 6,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                             hintText: "Enter About Place",
//                             hintStyle: AppWidget.normaltextstyle(18.0),
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 20.0),

//                       // ✅ Submit Button
//                       GestureDetector(
//                         onTap: uploadPlaceDetails,
//                         child: Center(
//                           child: Container(
//                             height: 60,
//                             decoration: BoxDecoration(
//                               color: Colors.blue,
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             width: MediaQuery.of(context).size.width / 1.5,
//                             child: Center(
//                               child: Text(
//                                 "Submit",
//                                 style: AppWidget.boldtextstyle(26.0),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 20.0),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // 🔧 Reusable widgets
//   Widget buildTextField(TextEditingController controller, String hint) {
//     return Container(
//       padding: const EdgeInsets.only(left: 20.0),
//       decoration: BoxDecoration(
//         color: const Color(0xFFececf8),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: TextField(
//         controller: controller,
//         decoration: InputDecoration(
//           border: InputBorder.none,
//           hintText: hint,
//           hintStyle: AppWidget.normaltextstyle(18.0),
//         ),
//       ),
//     );
//   }

//   Widget buildServiceCheckbox(
//       String label, IconData icon, bool value, Function(bool?) onChanged) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Checkbox(value: value, onChanged: onChanged),
//         Icon(icon, color: const Color.fromARGB(255, 16, 98, 164), size: 30.0),
//         const SizedBox(width: 10.0),
//         Text(label, style: AppWidget.normaltextstyle(23.0)),
//       ],
//     );
//   }
// }






































// import 'dart:io'; 
// import 'package:booking_app/bookingowner/ouner_home.dart';
// import 'package:booking_app/services/database.dart';
// import 'package:booking_app/services/widget_support.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart'; 
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:random_string/random_string.dart';

// class PlaceDetail extends StatefulWidget {
//   const PlaceDetail({super.key});

//   @override
//   State<PlaceDetail> createState() => _PlaceDetailState();
// }

// class _PlaceDetailState extends State<PlaceDetail> {
//   bool isChecked = false;
//   bool isChecked1 = false;
//   bool isChecked2 = false;
//   bool isChecked3 = false;

//   File? selectedImage;
//   final ImagePicker _picker = ImagePicker();

//   TextEditingController placenamecontroller = TextEditingController();
//   TextEditingController placechargescontroller = TextEditingController();
//   TextEditingController placeaddresscontroller = TextEditingController();
//   TextEditingController placedesccontroller = TextEditingController();

//   // 📸 Pick image from gallery
//   Future getImage() async {
//     var image = await _picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       setState(() {
//         selectedImage = File(image.path);
//       });
//     }
//   }

//   // 🚀 Upload data to Firestore
//   Future uploadPlaceDetails() async {
//     if (placenamecontroller.text.isEmpty ||
//         placechargescontroller.text.isEmpty ||
//         placeaddresscontroller.text.isEmpty ||
//         placedesccontroller.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           backgroundColor: Colors.redAccent,
//           content: Text(
//             "⚠️ Please fill all fields before submitting!",
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//         ),
//       );
//       return;
//     }

//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => const Center(child: CircularProgressIndicator()),
//     );

//     try {
//       String addId = randomAlphaNumeric(10);
//       String downloadUrl = "";

//       // Only upload if user selected an image
//       if (selectedImage != null) {
//         Reference firebaseStorageRef =
//             FirebaseStorage.instance.ref().child("placeImages").child(addId);

//         UploadTask uploadTask = firebaseStorageRef.putFile(selectedImage!);
//         TaskSnapshot snapshot = await uploadTask;
//         downloadUrl = await snapshot.ref.getDownloadURL();
//       }

//       // Prepare place data
//       Map<String, dynamic> addPlace = {
//         "Id": addId,
//         "Image": downloadUrl, // empty if no image selected
//         "PlaceName": placenamecontroller.text,
//         "PlaceCharges": placechargescontroller.text,
//         "PlaceAddress": placeaddresscontroller.text,
//         "PlaceDescription": placedesccontroller.text,
//         "WiFi": isChecked,
//         "HDTV": isChecked1,
//         "Kitchen": isChecked2,
//         "Bathroom": isChecked3,
//         "CreatedAt": FieldValue.serverTimestamp(),
//       };

//       // Save to Firestore
//       await DatabaseMethods().addPlaceInfo(addPlace, addId);

//       Navigator.pop(context); // close loading
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           backgroundColor: Colors.green,
//           content: Text(
//             "✅ Place details uploaded successfully!",
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//         ),
//       );

//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const OunerHome()),
//       );
//     } catch (e) {
//       Navigator.pop(context);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           backgroundColor: Colors.red,
//           content: Text(
//             "❌ Upload failed: $e",
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue,
//       body: Container(
//         margin: const EdgeInsets.only(top: 40.0),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text("Place Details", style: AppWidget.boldtextstyle(26.0)),
//               ],
//             ),
//             const SizedBox(height: 20.0),
//             Expanded(
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(30),
//                     topRight: Radius.circular(30),
//                   ),
//                 ),
//                 width: MediaQuery.of(context).size.width,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const SizedBox(height: 20.0),

//                       // 📸 Image Picker
//                       selectedImage != null
//                           ? SizedBox(
//                               height: 200,
//                               width: 200,
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(20.0),
//                                 child: Image.file(
//                                   selectedImage!,
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             )
//                           : GestureDetector(
//                               onTap: getImage,
//                               child: Center(
//                                 child: Container(
//                                   height: 200,
//                                   width: 200,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(20),
//                                     border: Border.all(
//                                         width: 2.0, color: Colors.black45),
//                                   ),
//                                   child: const Icon(
//                                     Icons.camera_alt,
//                                     color: Colors.blue,
//                                     size: 30,
//                                   ),
//                                 ),
//                               ),
//                             ),

//                       const SizedBox(height: 20.0),
//                       Text("Place Name",
//                           style: AppWidget.normaltextstyle(20.0)),
//                       const SizedBox(height: 5.0),
//                       buildTextField(
//                           placenamecontroller, "Enter Place Name"),

//                       const SizedBox(height: 20.0),
//                       Text("Room Charges",
//                           style: AppWidget.normaltextstyle(20.0)),
//                       const SizedBox(height: 5.0),
//                       buildTextField(
//                           placechargescontroller, "Enter Room Charges"),

//                       const SizedBox(height: 20.0),
//                       Text("Place Address",
//                           style: AppWidget.normaltextstyle(20.0)),
//                       const SizedBox(height: 5.0),
//                       buildTextField(
//                           placeaddresscontroller, "Enter Place Address"),

//                       const SizedBox(height: 20.0),
//                       Text("Services Offered",
//                           style: AppWidget.normaltextstyle(20.0)),
//                       const SizedBox(height: 5.0),

//                       // 🧾 Services checkboxes
//                       buildServiceCheckbox(
//                           "WiFi", Icons.wifi, isChecked, (val) {
//                         setState(() => isChecked = val!);
//                       }),
//                       buildServiceCheckbox(
//                           "HDTV", Icons.tv, isChecked1, (val) {
//                         setState(() => isChecked1 = val!);
//                       }),
//                       buildServiceCheckbox(
//                           "Kitchen", Icons.kitchen, isChecked2, (val) {
//                         setState(() => isChecked2 = val!);
//                       }),
//                       buildServiceCheckbox(
//                           "Bathroom", Icons.bathroom, isChecked3, (val) {
//                         setState(() => isChecked3 = val!);
//                       }),

//                       const SizedBox(height: 20.0),
//                       Text("Place Description",
//                           style: AppWidget.normaltextstyle(20.0)),
//                       const SizedBox(height: 5.0),
//                       Container(
//                         padding: const EdgeInsets.only(left: 20.0),
//                         decoration: BoxDecoration(
//                           color: const Color(0xFFececf8),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: TextField(
//                           controller: placedesccontroller,
//                           maxLines: 6,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                             hintText: "Enter About Place",
//                             hintStyle: AppWidget.normaltextstyle(18.0),
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 20.0),

//                       // ✅ Submit Button
//                       GestureDetector(
//                         onTap: uploadPlaceDetails,
//                         child: Center(
//                           child: Container(
//                             height: 60,
//                             decoration: BoxDecoration(
//                               color: Colors.blue,
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             width: MediaQuery.of(context).size.width / 1.5,
//                             child: Center(
//                               child: Text(
//                                 "Submit",
//                                 style: AppWidget.boldtextstyle(26.0),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 20.0),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // 🔧 Reusable widgets
//   Widget buildTextField(TextEditingController controller, String hint) {
//     return Container(
//       padding: const EdgeInsets.only(left: 20.0),
//       decoration: BoxDecoration(
//         color: const Color(0xFFececf8),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: TextField(
//         controller: controller,
//         decoration: InputDecoration(
//           border: InputBorder.none,
//           hintText: hint,
//           hintStyle: AppWidget.normaltextstyle(18.0),
//         ),
//       ),
//     );
//   }

//   Widget buildServiceCheckbox(
//       String label, IconData icon, bool value, Function(bool?) onChanged) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Checkbox(value: value, onChanged: onChanged),
//         Icon(icon, color: const Color.fromARGB(255, 16, 98, 164), size: 30.0),
//         const SizedBox(width: 10.0),
//         Text(label, style: AppWidget.normaltextstyle(23.0)),
//       ],
//     );
//   }
// }






// import 'dart:io';
// import 'package:booking_app/bookingowner/ouner_home.dart';
// import 'package:booking_app/services/database.dart';
// import 'package:booking_app/services/widget_support.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:random_string/random_string.dart';

// class PlaceDetail extends StatefulWidget {
//   const PlaceDetail({super.key});

//   @override
//   State<PlaceDetail> createState() => _PlaceDetailState();
// }

// class _PlaceDetailState extends State<PlaceDetail> {
//   bool isChecked = false;
//   bool isChecked1 = false;
//   bool isChecked2 = false;
//   bool isChecked3 = false;

//   File? selectedImage;
//   final ImagePicker _picker = ImagePicker();
//   TextEditingController placenamecontroller = TextEditingController();
//   TextEditingController placechargescontroller = TextEditingController();
//   TextEditingController placeaddresscontroller = TextEditingController();
//   TextEditingController placedesccontroller = TextEditingController();
//   TextEditingController externalImageController = TextEditingController();

//   // Pick image from gallery
//   Future getImage() async {
//     var image = await _picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       setState(() {
//         selectedImage = File(image.path);
//       });
//     }
//   }

//   // Upload data
//   Future uploadPlaceDetails() async {
//     if (placenamecontroller.text.isEmpty ||
//         placechargescontroller.text.isEmpty ||
//         placeaddresscontroller.text.isEmpty ||
//         placedesccontroller.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           backgroundColor: Colors.redAccent,
//           content: Text("⚠️ Please fill all fields before submitting!",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//         ),
//       );
//       return;
//     }

//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => const Center(child: CircularProgressIndicator()),
//     );

//     try {
//       String addId = randomAlphaNumeric(10);
//       String downloadUrl = "";

//       // Use selected image if exists
//       if (selectedImage != null) {
//         Reference firebaseStorageRef =
//             FirebaseStorage.instance.ref().child("placeImages").child(addId);
//         UploadTask uploadTask = firebaseStorageRef.putFile(selectedImage!);
//         TaskSnapshot snapshot = await uploadTask;
//         downloadUrl = await snapshot.ref.getDownloadURL();
//       } 
//       // Otherwise use external URL if provided
//       else if (externalImageController.text.isNotEmpty) {
//         downloadUrl = externalImageController.text.trim();
//       }

//       // Prepare place data
//       Map<String, dynamic> addPlace = {
//         "Id": addId,
//         "Image": downloadUrl,
//         "PlaceName": placenamecontroller.text,
//         "PlaceCharges": placechargescontroller.text,
//         "PlaceAddress": placeaddresscontroller.text,
//         "PlaceDescription": placedesccontroller.text,
//         "WiFi": isChecked,
//         "HDTV": isChecked1,
//         "Kitchen": isChecked2,
//         "Bathroom": isChecked3,
//         "CreatedAt": FieldValue.serverTimestamp(),
//       };

//       await DatabaseMethods().addPlaceInfo(addPlace, addId);

//       Navigator.pop(context); // close loading
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           backgroundColor: Colors.green,
//           content: Text("✅ Place details uploaded successfully!",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//         ),
//       );

//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (context) => const OunerHome()));
//     } catch (e) {
//       Navigator.pop(context);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           backgroundColor: Colors.red,
//           content: Text("❌ Upload failed: $e",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue,
//       body: Container(
//         margin: const EdgeInsets.only(top: 40.0),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text("Place Details", style: AppWidget.boldtextstyle(26.0)),
//               ],
//             ),
//             const SizedBox(height: 20.0),
//             Expanded(
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(30),
//                     topRight: Radius.circular(30),
//                   ),
//                 ),
//                 width: MediaQuery.of(context).size.width,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const SizedBox(height: 20.0),

//                       // Image picker or preview
//                       selectedImage != null
//                           ? SizedBox(
//                               height: 200,
//                               width: 200,
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(20.0),
//                                 child: Image.file(
//                                   selectedImage!,
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             )
//                           : GestureDetector(
//                               onTap: getImage,
//                               child: Center(
//                                 child: Container(
//                                   height: 200,
//                                   width: 200,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(20),
//                                     border: Border.all(
//                                         width: 2.0, color: Colors.black45),
//                                   ),
//                                   child: const Icon(
//                                     Icons.camera_alt,
//                                     color: Colors.blue,
//                                     size: 30,
//                                   ),
//                                 ),
//                               ),
//                             ),

//                       const SizedBox(height: 10),
//                       Text("Or enter external image URL:",
//                           style: AppWidget.normaltextstyle(18)),
//                       buildTextField(externalImageController, "Image URL"),

//                       const SizedBox(height: 20.0),
//                       Text("Place Name", style: AppWidget.normaltextstyle(20.0)),
//                       const SizedBox(height: 5.0),
//                       buildTextField(placenamecontroller, "Enter Place Name"),

//                       const SizedBox(height: 20.0),
//                       Text("Room Charges",
//                           style: AppWidget.normaltextstyle(20.0)),
//                       const SizedBox(height: 5.0),
//                       buildTextField(placechargescontroller, "Enter Room Charges"),

//                       const SizedBox(height: 20.0),
//                       Text("Place Address",
//                           style: AppWidget.normaltextstyle(20.0)),
//                       const SizedBox(height: 5.0),
//                       buildTextField(placeaddresscontroller, "Enter Place Address"),

//                       const SizedBox(height: 20.0),
//                       Text("Services Offered",
//                           style: AppWidget.normaltextstyle(20.0)),
//                       const SizedBox(height: 5.0),

//                       buildServiceCheckbox("WiFi", Icons.wifi, isChecked,
//                           (val) => setState(() => isChecked = val!)),
//                       buildServiceCheckbox("HDTV", Icons.tv, isChecked1,
//                           (val) => setState(() => isChecked1 = val!)),
//                       buildServiceCheckbox("Kitchen", Icons.kitchen, isChecked2,
//                           (val) => setState(() => isChecked2 = val!)),
//                       buildServiceCheckbox("Bathroom", Icons.bathroom, isChecked3,
//                           (val) => setState(() => isChecked3 = val!)),

//                       const SizedBox(height: 20.0),
//                       Text("Place Description",
//                           style: AppWidget.normaltextstyle(20.0)),
//                       const SizedBox(height: 5.0),
//                       Container(
//                         padding: const EdgeInsets.only(left: 20.0),
//                         decoration: BoxDecoration(
//                           color: const Color(0xFFececf8),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: TextField(
//                           controller: placedesccontroller,
//                           maxLines: 6,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                             hintText: "Enter About Place",
//                             hintStyle: AppWidget.normaltextstyle(18.0),
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 20.0),

//                       // Submit Button
//                       GestureDetector(
//                         onTap: uploadPlaceDetails,
//                         child: Center(
//                           child: Container(
//                             height: 60,
//                             decoration: BoxDecoration(
//                               color: Colors.blue,
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             width: MediaQuery.of(context).size.width / 1.5,
//                             child: Center(
//                               child: Text(
//                                 "Submit",
//                                 style: AppWidget.boldtextstyle(26.0),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 20.0),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildTextField(TextEditingController controller, String hint) {
//     return Container(
//       padding: const EdgeInsets.only(left: 20.0),
//       decoration: BoxDecoration(
//         color: const Color(0xFFececf8),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: TextField(
//         controller: controller,
//         decoration: InputDecoration(
//           border: InputBorder.none,
//           hintText: hint,
//           hintStyle: AppWidget.normaltextstyle(18.0),
//         ),
//       ),
//     );
//   }

//   Widget buildServiceCheckbox(
//       String label, IconData icon, bool value, Function(bool?) onChanged) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Checkbox(value: value, onChanged: onChanged),
//         Icon(icon, color: const Color.fromARGB(255, 16, 98, 164), size: 30.0),
//         const SizedBox(width: 10.0),
//         Text(label, style: AppWidget.normaltextstyle(23.0)),
//       ],
//     );
//   }
// }
import 'dart:io';
import 'package:booking_app/bookingowner/ouner_home.dart';
import 'package:booking_app/services/database.dart';
import 'package:booking_app/services/widget_support.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:cloudinary_public/cloudinary_public.dart';

class PlaceDetail extends StatefulWidget {
  const PlaceDetail({super.key});

  @override
  State<PlaceDetail> createState() => _PlaceDetailState();
}

class _PlaceDetailState extends State<PlaceDetail> {
  bool isChecked = false;
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;

  File? selectedImage;
  final ImagePicker _picker = ImagePicker();

  TextEditingController placenamecontroller = TextEditingController();
  TextEditingController placechargescontroller = TextEditingController();
  TextEditingController placeaddresscontroller = TextEditingController();
  TextEditingController placedesccontroller = TextEditingController();
  TextEditingController externalImageController = TextEditingController();

  final cloudinary = CloudinaryPublic('dzoggzlah', 'choufDARimages', cache: false);

  // Pick image from gallery
  Future getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  // Upload place details to Firestore
  Future uploadPlaceDetails() async {
    if (placenamecontroller.text.isEmpty ||
        placechargescontroller.text.isEmpty ||
        placeaddresscontroller.text.isEmpty ||
        placedesccontroller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text("⚠️ Please fill all fields before submitting!",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      String addId = randomAlphaNumeric(10);
      String? imageUrl;

      // If local image is selected, upload to Cloudinary
      if (selectedImage != null) {
        CloudinaryResponse response =
            await cloudinary.uploadFile(CloudinaryFile.fromFile(selectedImage!.path, resourceType: CloudinaryResourceType.Image));
        imageUrl = response.secureUrl;
      }
      // If external URL is provided, use it
      else if (externalImageController.text.isNotEmpty) {
        imageUrl = externalImageController.text;
      }

      // Prepare place data
      Map<String, dynamic> addPlace = {
        "Id": addId,
        "Image": imageUrl ?? "", // Can be empty if no image provided
        "PlaceName": placenamecontroller.text,
        "PlaceCharges": placechargescontroller.text,
        "PlaceAddress": placeaddresscontroller.text,
        "PlaceDescription": placedesccontroller.text,
        "WiFi": isChecked,
        "HDTV": isChecked1,
        "Kitchen": isChecked2,
        "Bathroom": isChecked3,
        "CreatedAt": FieldValue.serverTimestamp(),
      };

      // Save to Firestore
      await DatabaseMethods().addPlaceInfo(addPlace, addId);

      Navigator.pop(context); // close loading
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text("✅ Place details uploaded successfully!",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OunerHome()),
      );
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("❌ Upload failed: $e",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        margin: const EdgeInsets.only(top: 40.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Place Details", style: AppWidget.boldtextstyle(26.0)),
              ],
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20.0),
                      // Image Picker
                      selectedImage != null
                          ? SizedBox(
                              height: 200,
                              width: 200,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image.file(selectedImage!, fit: BoxFit.cover),
                              ),
                            )
                          : GestureDetector(
                              onTap: getImage,
                              child: Center(
                                child: Container(
                                  height: 200,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(width: 2.0, color: Colors.black45),
                                  ),
                                  child: const Icon(Icons.camera_alt, color: Colors.blue, size: 30),
                                ),
                              ),
                            ),
                      const SizedBox(height: 10),
                      Text("Or enter External Image URL", style: AppWidget.normaltextstyle(18)),
                      const SizedBox(height: 5),
                      buildTextField(externalImageController, "https://example.com/image.jpg"),
                      const SizedBox(height: 20.0),
                      Text("Place Name", style: AppWidget.normaltextstyle(20.0)),
                      const SizedBox(height: 5.0),
                      buildTextField(placenamecontroller, "Enter Place Name"),
                      const SizedBox(height: 20.0),
                      Text("Room Charges", style: AppWidget.normaltextstyle(20.0)),
                      const SizedBox(height: 5.0),
                      buildTextField(placechargescontroller, "Enter Room Charges"),
                      const SizedBox(height: 20.0),
                      Text("Place Address", style: AppWidget.normaltextstyle(20.0)),
                      const SizedBox(height: 5.0),
                      buildTextField(placeaddresscontroller, "Enter Place Address"),
                      const SizedBox(height: 20.0),
                      Text("Services Offered", style: AppWidget.normaltextstyle(20.0)),
                      const SizedBox(height: 5.0),
                      buildServiceCheckbox("WiFi", Icons.wifi, isChecked, (val) => setState(() => isChecked = val!)),
                      buildServiceCheckbox("HDTV", Icons.tv, isChecked1, (val) => setState(() => isChecked1 = val!)),
                      buildServiceCheckbox("Kitchen", Icons.kitchen, isChecked2, (val) => setState(() => isChecked2 = val!)),
                      buildServiceCheckbox("Bathroom", Icons.bathroom, isChecked3, (val) => setState(() => isChecked3 = val!)),
                      const SizedBox(height: 20.0),
                      Text("Place Description", style: AppWidget.normaltextstyle(20.0)),
                      const SizedBox(height: 5.0),
                      Container(
                        padding: const EdgeInsets.only(left: 20.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFececf8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: placedesccontroller,
                          maxLines: 6,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter About Place",
                            hintStyle: AppWidget.normaltextstyle(18.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      GestureDetector(
                        onTap: uploadPlaceDetails,
                        child: Center(
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)),
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: Center(
                              child: Text("Submit", style: AppWidget.boldtextstyle(26.0)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String hint) {
    return Container(
      padding: const EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(color: const Color(0xFFececf8), borderRadius: BorderRadius.circular(10)),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(border: InputBorder.none, hintText: hint, hintStyle: AppWidget.normaltextstyle(18.0)),
      ),
    );
  }

  Widget buildServiceCheckbox(String label, IconData icon, bool value, Function(bool?) onChanged) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(value: value, onChanged: onChanged),
        Icon(icon, color: const Color.fromARGB(255, 16, 98, 164), size: 30.0),
        const SizedBox(width: 10.0),
        Text(label, style: AppWidget.normaltextstyle(23.0)),
      ],
    );
  }
}
