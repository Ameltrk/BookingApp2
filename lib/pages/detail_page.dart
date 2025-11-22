// // ignore_for_file: avoid_unnecessary_containers

// import 'package:booking_app/services/widget_support.dart';
// import 'package:flutter/material.dart';

// class DetailPage extends StatefulWidget {
//   const DetailPage({super.key});

//   @override
//   State<DetailPage> createState() => _DetailPageState();
// }

// class _DetailPageState extends State<DetailPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Stack(
//                 children: [
//                   SizedBox(
//                     width: MediaQuery.of(context).size.width,
//                     height: MediaQuery.of(context).size.height / 2.5,
//                     child: ClipRRect(
//                       borderRadius: const BorderRadius.only(
//                         bottomLeft: Radius.circular(50),
//                         bottomRight: Radius.circular(50),
//                       ),
//                       child: Image.asset(
//                         "images/hotel1.jpg",
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
        
//                   GestureDetector(
//                     onTap: (){
//                       Navigator.pop(context);
//                     },
//                     child: Container(
//                       padding: EdgeInsets.all(5),
//                       margin: EdgeInsets.only(top: 50.0 , left: 20.0),
//                       decoration: BoxDecoration(
//                           color:Colors.black ,
//                           borderRadius: BorderRadius.circular(60),
//                       ),
                    
//                       child: Icon(
//                         Icons.arrow_back,
//                          color: Colors.white,
//                           size: 30.0 ,
//                           ),
//                     ),
//                   )
        
//                 ],
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left:20.0, right:20.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(height:20.0),
//                     Text("Hotel Beach ", style:AppWidget.headlinetextstyle(22.0)),
//                     Text("\$20", style:AppWidget.normaltextstyle(27.0)), 
//                     Divider(thickness: 2.0,),
//                     SizedBox(height: 20.0,),
//                     Text("What this place offers ? ", 
//                     style: AppWidget.headlinetextstyle(22.0),),
//                     SizedBox(height: 5.0,),
        
        
//                     Row(
                     
//                       children: [
//                       Icon(Icons.wifi,
//                        color:Color(0xFF3A88C8),
//                        size:30.0  ),    
//                       SizedBox(width: 10.0),
//                       Text("WiFi", style: AppWidget.normaltextstyle(23.0),),
                     
        
//                     ],),
        
//                     SizedBox(height:20.0),
        
//                      Row(
                     
//                       children: [
//                       Icon(Icons.tv,
//                        color:Color(0xFF3A88C8),
//                        size:30.0  ),    
//                       SizedBox(width: 10.0),
//                       Text("HDTV", style: AppWidget.normaltextstyle(23.0),),
                     
//                     ],),
                      
                      
//                     SizedBox(height:20.0),
        
//                     Row(children: [
//                       Icon(Icons.kitchen, 
//                            color:Color(0xFF3A88C8),
//                            size:30.0  ),    
//                       SizedBox(width: 10.0),
//                       Text("Kitchen", style: AppWidget.normaltextstyle(23.0),),
//                        Spacer(),     
                      
//                     ],),
        
//                     SizedBox(height:20.0),
        
//                      Row(
                     
//                       children: [
//                       Icon(Icons.bathroom,
//                        color:Color(0xFF3A88C8),
//                         size:30.0 ),    
//                       SizedBox(width: 10.0),
//                       Text("Bathroom", style: AppWidget.normaltextstyle(23.0),),
                    
//                     ],),
//                    Divider(thickness: 2.0,),
//                    SizedBox(height: 5.0,),
//                    Text("About this place ", 
//                    style: AppWidget.headlinetextstyle(22.0) ),
//                    SizedBox(height: 5.0,),
//                    Text("orem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
//                    style: AppWidget.normaltextstyle(16.0),),
//                    SizedBox(height: 20.0,),
//                    Material(
//                     elevation: 2.0,
//                     borderRadius: BorderRadius.circular(20),
//                      child: Container(
//                       padding: EdgeInsets.all(8),
                      
//                       width: MediaQuery.of(context).size.width,
//                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
//                       child: Column(
                     
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                         SizedBox(height: 10.0,),
//                         Text("\$100 for 4 nights", style: AppWidget.headlinetextstyle(20.0),),
//                         SizedBox(height: 5.0,),
//                         Text("Check-in Date", style: AppWidget.normaltextstyle(20.0)),
//                         Divider(),
//                         Row(children: [
//                           Container(
//                             padding: EdgeInsets.all(5),
//                             decoration: BoxDecoration(color: Colors.blue,
//                              borderRadius:BorderRadius.circular(20.0), ),
//                              child: Icon(Icons.calendar_month,
//                                     color:Colors.white, 
//                                     size: 30.0)),
//                               SizedBox(width: 10.0,),
//                               Text("02, Apr 2025", style: AppWidget.normaltextstyle(20.0),)
                          
        
//                         ],),
        
//                          SizedBox(height: 5.0,),
//                         Text("Check-out Date", style: AppWidget.normaltextstyle(20.0)),
//                         Divider(),
//                         Row(children: [
//                           Container(
//                             padding: EdgeInsets.all(5),
//                             decoration: BoxDecoration(color: Colors.blue,
//                              borderRadius:BorderRadius.circular(20.0), ),
//                              child: Icon(Icons.calendar_month,
//                                     color:Colors.white, 
//                                     size: 30.0)),
//                               SizedBox(width: 10.0,),
//                               Text("05, Apr 2025", style: AppWidget.normaltextstyle(20.0),)
        
//                         ],),
//                         SizedBox(height: 5.0,),
//                         Text("Number of Guests ", style: AppWidget.normaltextstyle(20.0),),
//                         SizedBox(height: 5.0,),
//                         Container(
//                           padding: EdgeInsets.only(left:20.0),
//                           decoration: BoxDecoration(color: const Color(0xFFececf8), borderRadius: BorderRadius.circular(10)),
//                           child: TextField(
//                             decoration: InputDecoration(
//                               border: InputBorder.none,hintText:"1",
//                               hintStyle: TextStyle(color: Colors.black, fontSize: 20,
//                                                    fontWeight:  
//                                                   FontWeight.w500),),
//                           ),),
//                           SizedBox(height: 20.0,),
//                           Container(
//                             height: 50,
//                             width:MediaQuery.of(context).size.width,
//                             decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10),),
//                             child: Center(child: Text("Book Now ",  style: AppWidget.whitetextstyle(22.0))),
//                           )
                        
                      
        
//                       ],)
//                      ),
//                    ),
//                    SizedBox(height: 30.0,),
//                   ],
//                 ),
//               ),
        
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



// ignore_for_file: avoid_unnecessary_containers

import 'package:booking_app/services/widget_support.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final Map<String, dynamic> placeData;

  const DetailPage({super.key, required this.placeData});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
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
                  height: MediaQuery.of(context).size.height / 2.5,
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
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.only(top: 50.0, left: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 30.0,
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

                  // PLACE NAME & CHARGES
                  Text(data["PlaceName"] ?? "", style: AppWidget.headlinetextstyle(22.0)),
                  const SizedBox(height: 5.0),
                  Text("\$${data["PlaceCharges"] ?? "N/A"}", style: AppWidget.normaltextstyle(27.0)),

                  const Divider(thickness: 2.0),
                  const SizedBox(height: 20.0),

                  // SERVICES OFFERED
                  Text("What this place offers?", style: AppWidget.headlinetextstyle(22.0)),
                  const SizedBox(height: 5.0),

                  if (data["WiFi"] == true)
                    buildServiceRow(Icons.wifi, "WiFi"),
                  if (data["HDTV"] == true)
                    buildServiceRow(Icons.tv, "HDTV"),
                  if (data["Kitchen"] == true)
                    buildServiceRow(Icons.kitchen, "Kitchen"),
                  if (data["Bathroom"] == true)
                    buildServiceRow(Icons.bathroom, "Bathroom"),

                  const Divider(thickness: 2.0),
                  const SizedBox(height: 5.0),

                  // PLACE DESCRIPTION
                  Text("About this place", style: AppWidget.headlinetextstyle(22.0)),
                  const SizedBox(height: 5.0),
                  Text(data["PlaceDescription"] ?? "No description available",
                      style: AppWidget.normaltextstyle(16.0)),

                  const SizedBox(height: 20.0),

                  // BOOKING CARD
                  Material(
                    elevation: 2.0,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("\$${data["PlaceCharges"] ?? "0"} for 4 nights", style: AppWidget.headlinetextstyle(20.0)),
                          const SizedBox(height: 5.0),
                          Text("Check-in Date", style: AppWidget.normaltextstyle(20.0)),
                          const Divider(),
                          Row(
                            children: const [
                              Icon(Icons.calendar_month, color: Colors.blue, size: 30),
                              SizedBox(width: 10),
                              Text("02, Apr 2025", style: TextStyle(fontSize: 20)),
                            ],
                          ),
                          const SizedBox(height: 5.0),
                          Text("Check-out Date", style: AppWidget.normaltextstyle(20.0)),
                          const Divider(),
                          Row(
                            children: const [
                              Icon(Icons.calendar_month, color: Colors.blue, size: 30),
                              SizedBox(width: 10),
                              Text("05, Apr 2025", style: TextStyle(fontSize: 20)),
                            ],
                          ),
                          const SizedBox(height: 5.0),
                          Text("Number of Guests", style: AppWidget.normaltextstyle(20.0)),
                          const SizedBox(height: 5.0),
                          Container(
                            padding: const EdgeInsets.only(left: 20.0),
                            decoration: BoxDecoration(
                                color: const Color(0xFFececf8), borderRadius: BorderRadius.circular(10)),
                            child: const TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "1",
                                hintStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)),
                            child: Center(
                                child: Text(
                              "Book Now",
                              style: AppWidget.whitetextstyle(22.0),
                            )),
                          ),
                        ],
                      ),
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

  Widget buildServiceRow(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF3A88C8), size: 30),
          const SizedBox(width: 10),
          Text(label, style: AppWidget.normaltextstyle(23.0)),
        ],
      ),
    );
  }
}
