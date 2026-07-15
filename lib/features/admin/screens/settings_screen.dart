import 'package:flutter/material.dart';

import '../models/setting_model.dart';
import '../services/admin_settings_service.dart';
import '../widgets/save_settings_button.dart';
import '../widgets/setting_section.dart';
import '../widgets/setting_text_field.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() =>
      _SettingsScreenState();
}

class _SettingsScreenState
    extends State<SettingsScreen> {

  final appName = TextEditingController();
  final logo = TextEditingController();
  final banner = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final website = TextEditingController();

  final facebook = TextEditingController();
  final instagram = TextEditingController();
  final youtube = TextEditingController();

  final membership = TextEditingController();
  final borrowDays = TextEditingController();
  final fine = TextEditingController();

  bool loading = true;

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    final data =
    await AdminSettingsService.loadSettings();

    if (data != null) {
      appName.text = data.appName;
      logo.text = data.logo;
      banner.text = data.banner;
      email.text = data.supportEmail;
      phone.text = data.supportPhone;
      website.text = data.website;

      facebook.text = data.facebook;
      instagram.text = data.instagram;
      youtube.text = data.youtube;

      membership.text =
          data.membershipPrice.toString();

      borrowDays.text =
          data.borrowDays.toString();

      fine.text =
          data.finePerDay.toString();
    }

    setState(() {
      loading = false;
    });
  }



  Future<void> saveSettings() async {
    final model = SettingModel(
      appName: appName.text,
      logo: logo.text,
      banner: banner.text,
      supportEmail: email.text,
      supportPhone: phone.text,
      website: website.text,
      facebook: facebook.text,
      instagram: instagram.text,
      youtube: youtube.text,
      membershipPrice:
      int.tryParse(membership.text) ?? 0,
      borrowDays:
      int.tryParse(borrowDays.text) ?? 0,
      finePerDay:
      int.tryParse(fine.text) ?? 0,
    );

    await AdminSettingsService.saveSettings(model);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Settings Saved Successfully"),
      ),
    );
  }

  @override
  void dispose() {
    appName.dispose();
    logo.dispose();
    banner.dispose();
    email.dispose();
    phone.dispose();
    website.dispose();
    facebook.dispose();
    instagram.dispose();
    youtube.dispose();
    membership.dispose();
    borrowDays.dispose();
    fine.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if (loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Settings"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [

            SettingSection(
              title: "General",
              child: Column(
                children: [

                  SettingTextField(
                    controller: appName,
                    label: "App Name",
                  ),

                  SettingTextField(
                    controller: logo,
                    label: "Logo URL",
                  ),

                  SettingTextField(
                    controller: banner,
                    label: "Banner URL",
                  ),

                  const SizedBox(height: 12),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: saveSettings,
                      icon: const Icon(Icons.save),
                      label: const Text("Save General"),
                    ),
                  ),
                ],
              ),
            ),

            SettingSection(
              title: "Support",
              child: Column(
                children: [
                  SettingTextField(
                    controller: email,
                    label: "Support Email",
                  ),
                  SettingTextField(
                    controller: phone,
                    label: "Support Phone",
                  ),
                  SettingTextField(
                    controller: website,
                    label: "Website",
                  ),
                  const SizedBox(height: 12),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: saveSettings,
                      icon: const Icon(Icons.save),
                      label: const Text("Save Support"),
                    ),
                  ),
                ],
              ),
            ),

            SettingSection(
              title: "Social Links",
              child: Column(
                children: [
                  SettingTextField(
                    controller: facebook,
                    label: "Facebook",
                  ),
                  SettingTextField(
                    controller: instagram,
                    label: "Instagram",
                  ),
                  SettingTextField(
                    controller: youtube,
                    label: "YouTube",
                  ),
                  const SizedBox(height: 12),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: saveSettings,
                      icon: const Icon(Icons.save),
                      label: const Text("Save Social Links"),
                    ),
                  ),
                ],
              ),
            ),

            SettingSection(
              title: "Library Settings",
              child: Column(
                children: [
                  SettingTextField(
                    controller: membership,
                    label: "Membership Price",
                  ),
                  SettingTextField(
                    controller: borrowDays,
                    label: "Borrow Days",
                  ),
                  SettingTextField(
                    controller: fine,
                    label: "Fine Per Day",
                  ),
                  const SizedBox(height: 12),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: saveSettings,
                      icon: const Icon(Icons.save),
                      label: const Text("Save Library"),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            const SizedBox(height: 30),

          ],
        ),
      ),
    );
  }
}