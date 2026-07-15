import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../navigation/main_navigation.dart';
import 'services/google_auth_service.dart';
import 'widgets/auth_header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../admin/screens/admin_dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;

  Future<void> signIn() async {
    setState(() {
      isLoading = true;
    });

    try {
      final userCredential = await GoogleAuthService.signInWithGoogle();

      if (!mounted) return;

      if (userCredential != null) {
        final uid = userCredential.user!.uid;

        final doc = await FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .get();

        final role = doc.data()?["role"] ?? "user";

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Login Successful"),
          ),
        );

        if (role == "admin") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const AdminDashboard(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const MainNavigation(),
            ),
          );
        }
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 30,
          ),
          child: Column(
            children: [
              const SizedBox(height: 20),

              const AuthHeader(),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton.icon(
                  onPressed: isLoading ? null : signIn,
                  icon: isLoading
                      ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                      : const Icon(Icons.login),
                  label: Text(
                    isLoading
                        ? "Signing in..."
                        : "Continue with Google",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "By continuing you agree to our\nTerms & Conditions and Privacy Policy",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}