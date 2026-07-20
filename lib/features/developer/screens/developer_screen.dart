import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../models/developer_model.dart';
import '../services/developer_service.dart';
import '../utils/social_launcher.dart';
import '../widgets/contact_tile.dart';
import '../widgets/developer_header.dart';
import '../widgets/section_title.dart';
import '../widgets/social_tile.dart';

class DeveloperScreen extends StatelessWidget {
  const DeveloperScreen({super.key});
  Widget _skillChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: .15),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 18,
            color: AppColors.primary,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text("About Developer"),
      ),
      body: FutureBuilder<DeveloperModel?>(
        future: DeveloperService.loadDeveloper(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final developer = snapshot.data ??
              const DeveloperModel(
                name: "ARIF HOSSAIN",
                designation: "Flutter Developer",
                bio:
                "Passionate about building beautiful, modern and high-performance mobile applications using Flutter & Firebase.",
                email: "hossainarif8364@gmail.com",
                phone: "+91XXXXXXXXXX",
                location: "Kolkata, West Bengal, India",
                photo: "",
                instagram: "",
                facebook: "",
                linkedin: "",
                github: "",
                portfolio: "",
                version: "1.0.0",
              );

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DeveloperHeader(
                    developer: developer,
                  ),

                  const SizedBox(height: 30),
                  const SectionTitle(
                    title: "Tech Stack",
                  ),

                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: const [
                      Chip(label: Text("Flutter")),
                      Chip(label: Text("Firebase")),
                      Chip(label: Text("Dart")),
                      Chip(label: Text("Riverpod")),
                      Chip(label: Text("Cloud Firestore")),
                      Chip(label: Text("REST API")),
                      Chip(label: Text("Git")),
                      Chip(label: Text("GitHub")),
                    ],
                  ),


                  const SectionTitle(
                    title: "About Me",
                  ),

                  const SizedBox(height: 12),

                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.12),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(22),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [


                          CircleAvatar(
                            radius: 24,
                            backgroundColor: AppColors.primary,
                            child: const Icon(
                              Icons.format_quote_rounded,
                              color: Colors.white,
                            ),
                          ),

                          const SizedBox(height: 20),

                          Text(
                            developer.bio.isEmpty
                                ?"I'm Arif Hossain, a Software Developer and BCA student at Brainware University. I specialize in building modern Flutter applications with Firebase, focusing on clean design, smooth performance, and an excellent user experience."
                                : developer.bio,
                            style: const TextStyle(
                              fontSize: 15.5,
                              height: 1.8,
                              color: Colors.black87,
                            ),
                          ),

                          const SizedBox(height: 24),

                          Divider(
                            color: AppColors.primary.withValues(alpha: .15),
                          ),

                          const SizedBox(height: 18),

                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: [

                              _skillChip(Icons.flutter_dash, "Flutter"),

                              _skillChip(Icons.local_fire_department, "Firebase"),

                              _skillChip(Icons.storage_rounded, "Firestore"),

                              _skillChip(Icons.code_rounded, "Clean Architecture"),

                              _skillChip(Icons.phone_android_rounded, "Android"),

                              _skillChip(Icons.auto_awesome, "UI/UX"),

                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  const SectionTitle(
                    title: "Contact",
                  ),

                  ContactTile(
                    icon: Icons.email_outlined,
                    title: "Email",
                    subtitle: developer.email.isEmpty
                        ? "hossainarif8364@gmail.com"
                        : developer.email,
                    onTap: () => SocialLauncher.email(
                      developer.email.isEmpty
                          ? "hossainarif8364@gmail.com"
                          : developer.email,
                    ),
                  ),

                  ContactTile(
                    icon: Icons.phone_outlined,
                    title: "Phone",
                    subtitle: developer.phone.isEmpty
                        ? "+91 XXXXXXXXXX"
                        : developer.phone,
                    onTap: developer.phone.isEmpty
                        ? null
                        : () => SocialLauncher.phone(developer.phone),
                  ),

                  ContactTile(
                    icon: Icons.location_on_outlined,
                    title: "Location",
                    subtitle: developer.location.isEmpty
                        ? "Kolkata, West Bengal, India"
                        : developer.location,
                    onTap: () => SocialLauncher.map(
                      developer.location.isEmpty
                          ? "Kolkata, West Bengal, India"
                          : developer.location,
                    ),
                  ),

                  const SizedBox(height: 25),



                  const SizedBox(height: 30),

                  const SectionTitle(
                    title: "Connect With Me",
                  ),

                  SocialTile(
                    icon: const Icon(
                      Icons.camera_alt_rounded,
                      color: Colors.pink,
                      size: 30,
                    ),
                    title: "Instagram",
                    onTap: developer.instagram.isEmpty
                        ? null
                        : () => SocialLauncher.open(developer.instagram),
                  ),

                  SocialTile(
                    icon: const Icon(
                      Icons.facebook_rounded,
                      color: Colors.blue,
                      size: 30,
                    ),
                    title: "Facebook",
                    onTap: developer.facebook.isEmpty
                        ? null
                        : () => SocialLauncher.open(developer.facebook),
                  ),

                  SocialTile(
                    icon: const Icon(
                      Icons.work_rounded,
                      color: Colors.indigo,
                      size: 30,
                    ),
                    title: "LinkedIn",
                    onTap: developer.linkedin.isEmpty
                        ? null
                        : () => SocialLauncher.open(developer.linkedin),
                  ),

                  SocialTile(
                    icon: const Icon(
                      Icons.code_rounded,
                      color: Colors.black87,
                      size: 30,
                    ),
                    title: "GitHub",
                    onTap: developer.github.isEmpty
                        ? null
                        : () => SocialLauncher.open(developer.github),
                  ),

                  SocialTile(
                    icon: const Icon(
                      Icons.language_rounded,
                      color: Colors.green,
                      size: 30,
                    ),
                    title: "Portfolio",
                    onTap: developer.portfolio.isEmpty
                        ? null
                        : () => SocialLauncher.open(developer.portfolio),
                  ),

                  const SizedBox(height: 35),

                  Card(
                    color: AppColors.primary.withValues(alpha: 0.05),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              "BookVerse v1.0.0",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Made with ❤️ using Flutter & Firebase",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}