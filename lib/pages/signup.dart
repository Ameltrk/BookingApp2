// ignore_for_file: use_build_context_synchronously

// ignore: unused_import
import 'package:booking_app/pages/bottomnav.dart';
import 'package:booking_app/pages/home.dart';
import 'package:booking_app/pages/login.dart';
import 'package:booking_app/pages/verification.dart';
import 'package:booking_app/services/database.dart';
import 'package:booking_app/services/shared_perference.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool isLoading = false;
  bool obscurePassword = true;
  bool useEmail = true; // <-- Choix email / téléphone

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // --- Inscription Firebase ---
  Future<void> registration() async {
    if (nameController.text.isEmpty || passwordController.text.isEmpty) {
      _showError("Veuillez remplir tous les champs.");
      return;
    }

    if (useEmail && emailController.text.isEmpty) {
      _showError("Veuillez entrer une adresse e-mail.");
      return;
    }

    if (!useEmail && phoneController.text.isEmpty) {
      _showError("Veuillez entrer un numéro de téléphone.");
      return;
    }

    setState(() => isLoading = true);

    try {
      String id = randomAlphaNumeric(10);

      if (useEmail) {
        // --- Auth Firebase avec email/password ---
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
      }

      // --- Enregistrement Firestore ---
      Map<String, dynamic> userInfoMap = {
        "Id": id,
        "Name": nameController.text,
        "Email": useEmail ? emailController.text : "",
        "Phone": useEmail ? "" : phoneController.text,
        "AuthType": useEmail ? "email" : "phone",
      };

      await SharedPreferenceHelper().saveUserName(nameController.text);
      await SharedPreferenceHelper()
          .saveUserEmail(useEmail ? emailController.text : phoneController.text);
      await SharedPreferenceHelper().saveUserId(id);
      await DatabaseMethods().addUserInfo(userInfoMap, id);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text("Inscription réussie !"),
        ),
      );

      Navigator.pushReplacement(
        context,
         MaterialPageRoute(builder: (context) => VerificationPage(onComplete: () {  },)),

      );
    } on FirebaseAuthException catch (e) {
      setState(() => isLoading = false);
      String message;
      if (e.code == 'weak-password') {
        message = "Le mot de passe est trop faible.";
      } else if (e.code == "email-already-in-use") {
        message = "Un compte existe déjà avec cet email.";
      } else if (e.code == "invalid-email") {
        message = "Adresse email invalide.";
      } else {
        message = "Une erreur est survenue. Réessayez.";
      }
      _showError(message);
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(backgroundColor: Colors.redAccent, content: Text(msg)),
    );
  }

  // --- Interface ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D47A1),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : SafeArea( // ✅ Ajout du SafeArea pour la flèche comme sur Login
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    // --- Flèche retour (même style et position que Login)
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios,
                            color: Colors.white, size: 26),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 10),

                    // --- Logo + titre ---
                    Column(
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: const Center(
                            child: Text("LOGO",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Color(0xFF0D47A1))),
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text("choufDAR",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 5),
                        const Text("Créer un compte pour continuer",
                            style: TextStyle(color: Colors.white70)),
                      ],
                    ),

                    const SizedBox(height: 40),

                    // --- Formulaire ---
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 30),
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 8,
                              offset: Offset(0, 4))
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // --- Sélecteur Email / Téléphone ---
                          Container(
                            height: 45,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE3F2FD),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => setState(() => useEmail = true),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: useEmail
                                            ? const Color(0xFF0D47A1)
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Center(
                                        child: Text("Email",
                                            style: TextStyle(
                                                color: useEmail
                                                    ? Colors.white
                                                    : Colors.black54,
                                                fontWeight: FontWeight.w600)),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => setState(() => useEmail = false),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: !useEmail
                                            ? const Color(0xFF0D47A1)
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Center(
                                        child: Text("Téléphone",
                                            style: TextStyle(
                                                color: !useEmail
                                                    ? Colors.white
                                                    : Colors.black54,
                                                fontWeight: FontWeight.w600)),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 20),

                          // --- Nom complet ---
                          const Text("Nom complet",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16)),
                          const SizedBox(height: 8),
                          TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              prefixIcon:
                                  const Icon(Icons.person, color: Colors.blue),
                              hintText: "Entrez votre nom",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // --- Email ou Téléphone ---
                          useEmail
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Adresse e-mail",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16)),
                                    const SizedBox(height: 8),
                                    TextField(
                                      controller: emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(Icons.email,
                                            color: Colors.blue),
                                        hintText: "exemple@email.com",
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Numéro de téléphone",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16)),
                                    const SizedBox(height: 8),
                                    TextField(
                                      controller: phoneController,
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(Icons.phone,
                                            color: Colors.blue),
                                        hintText: "+213 555 123 456",
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                      ),
                                    ),
                                  ],
                                ),

                          const SizedBox(height: 20),

                          // --- Mot de passe ---
                          const Text("Mot de passe",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16)),
                          const SizedBox(height: 8),
                          TextField(
                            controller: passwordController,
                            obscureText: obscurePassword,
                            decoration: InputDecoration(
                              prefixIcon:
                                  const Icon(Icons.lock, color: Colors.blue),
                              suffixIcon: IconButton(
                                icon: Icon(
                                    obscurePassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.grey),
                                onPressed: () {
                                  setState(() {
                                    obscurePassword = !obscurePassword;
                                  });
                                },
                              ),
                              hintText: "Entrez un mot de passe",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                          ),

                          const SizedBox(height: 30),

                          // --- Bouton Créer un compte ---
                          GestureDetector(
                            onTap: registration,
                            child: Container(
                              height: 55,
                              decoration: BoxDecoration(
                                color: const Color(0xFF0D47A1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Center(
                                child: Text("Créer un compte",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Vous avez déjà un compte ? ",
                                  style: TextStyle(fontSize: 15)),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Login()),
                                  );
                                },
                                child: const Text("Se connecter",
                                    style: TextStyle(
                                        color: Color(0xFF0D47A1),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
    );
  }
}