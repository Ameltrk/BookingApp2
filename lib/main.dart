// // ignore_for_file: deprecated_member_use, unused_import

// import 'package:booking_app/pages/bottomnav.dart';
// import 'package:booking_app/pages/login.dart';
// import 'package:booking_app/pages/signup.dart';
// import 'package:booking_app/pages/verification.dart';
// import 'package:booking_app/pages/landing_page.dart'; // Landing page
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'ChoufDAR',
//       debugShowCheckedModeBanner: false,

//       // ========================
//       // THEME CONFIGURATION
//       // ========================
//       theme: ThemeData(
//         primaryColor: const Color(0xFF1E3C72),
//         scaffoldBackgroundColor: Colors.white,

//         // AppBar
//         appBarTheme: const AppBarTheme(
//           backgroundColor: Color(0xFF1E3C72),
//           foregroundColor: Colors.white,
//           elevation: 0,
//         ),

//         // TextTheme (Flutter 3+)
//         textTheme: const TextTheme(
//           displayLarge: TextStyle(
//               fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
//           displayMedium: TextStyle(
//               fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
//           bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
//           bodyMedium: TextStyle(fontSize: 14, color: Colors.black54),
//         ),

//         // Input fields
//         inputDecorationTheme: InputDecorationTheme(
//           filled: true,
//           fillColor: const Color(0xFFececf8),
//           contentPadding:
//               const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: BorderSide.none,
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: const BorderSide(color: Color(0xFF1E3C72), width: 2),
//           ),
//         ),

//         // Buttons
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: const Color(0xFF1E3C72),
//             foregroundColor: Colors.white,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//             textStyle: const TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//             minimumSize: const Size(double.infinity, 55),
//           ),
//         ),

//         // Checkbox
//         checkboxTheme: CheckboxThemeData(
//           fillColor: MaterialStateProperty.all(const Color(0xFF1E3C72)),
//         ),
//       ),

//       // ========================
//       // INITIAL PAGE
//       // ========================
//       home: const LandingPage(), // <--- Start with LandingPage
//     );
//   }
// }



// ignore_for_file: deprecated_member_use, unused_import

import 'package:booking_app/bookingowner/place_detail.dart';
import 'package:booking_app/pages/bottomnav.dart';
import 'package:booking_app/pages/detail_page.dart';
import 'package:booking_app/pages/login.dart';
import 'package:booking_app/pages/signup.dart';
import 'package:booking_app/pages/verification.dart';
import 'package:booking_app/pages/landing_page.dart';
import 'package:booking_app/pages/home.dart'; // 👈 Added import
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChoufDAR',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primaryColor: const Color(0xFF1E3C72),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E3C72),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
          displayMedium: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
          bodyMedium: TextStyle(fontSize: 14, color: Colors.black54),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFececf8),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF1E3C72), width: 2),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1E3C72),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            minimumSize: const Size(double.infinity, 55),
          ),
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.all(const Color(0xFF1E3C72)),
        ),
      ),

      // // 👇 Start the app at HomePage
      home: const Home(),
      //  home: const LandingPage(),    
      //  home: const DetailPage(), hadi li fiha detail t3 chaque house
    //  home: const PlaceDetail()// hadi bsh yajouti owner placa
    );
  }
}
