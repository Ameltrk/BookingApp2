// ignore_for_file: use_build_context_synchronously

// ignore: unused_import
import 'package:booking_app/pages/bottomnav.dart';
// ignore: unused_import
import 'package:booking_app/pages/home.dart';
import 'package:booking_app/pages/signup.dart';
import 'package:booking_app/pages/verification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = "", password = "";
  bool obscurePassword = true;
  bool isLoading = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> userLogin() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      setState(() => isLoading = true);

      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text("Connexion réussie !",
                style: TextStyle(fontSize: 16, color: Colors.white)),
          ),
        );

        Navigator.pushReplacement(
          context,
          // MaterialPageRoute(builder: (context) => const Bottomnav()),
           MaterialPageRoute(builder: (context) => VerificationPage(onComplete: () {  },)),


        );
      } on FirebaseAuthException catch (e) {
        setState(() => isLoading = false);
        String message;
        if (e.code == 'user-not-found') {
          message = "Aucun utilisateur trouvé pour cet email.";
        } else if (e.code == 'wrong-password') {
          message = "Mot de passe incorrect.";
        } else if (e.code == 'invalid-email') {
          message = "Adresse email invalide.";
        } else {
          message = "Erreur lors de la connexion.";
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.redAccent, content: Text(message)),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text("Veuillez remplir tous les champs."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D47A1), // Fond bleu
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: [
                      // 🔙 Bouton retour
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios,
                              color: Colors.white, size: 26),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Signup()),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 20),

                      // --- Logo & titre ---
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
                              child: Text(
                                "LOGO",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Color(0xFF0D47A1),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            "choufDAR",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            "Bienvenue à nouveau !",
                            style: TextStyle(
                                color: Colors.white70, fontSize: 16),
                          ),
                        ],
                      ),

                      const SizedBox(height: 50),

                      // --- Formulaire de connexion ---
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
                            const Text("Adresse email",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16)),
                            const SizedBox(height: 8),
                            TextField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email,
                                    color: Colors.blue.shade700),
                                hintText: "exemple@email.com",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                            ),
                            const SizedBox(height: 20),

                            const Text("Mot de passe",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16)),
                            const SizedBox(height: 8),
                            TextField(
                              controller: passwordController,
                              obscureText: obscurePassword,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock,
                                    color: Colors.blue.shade700),
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
                                hintText: "Entrez votre mot de passe",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                            ),

                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: const Text("Mot de passe oublié ?",
                                      style: TextStyle(color: Colors.grey)),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            // 🔵 Bouton Se connecter
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  email = emailController.text.trim();
                                  password = passwordController.text.trim();
                                });
                                userLogin();
                              },
                              child: Container(
                                height: 55,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF0D47A1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Center(
                                  child: Text("Se connecter",
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
                                const Text("Pas encore de compte ? ",
                                    style: TextStyle(fontSize: 15)),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Signup()),
                                    );
                                  },
                                  child: const Text("Créer un compte",
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

                      const SizedBox(height: 60),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
