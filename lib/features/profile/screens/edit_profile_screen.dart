import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/profile_service.dart';
import '../widgets/editable_profile_avatar.dart';
import '../widgets/profile_textfield.dart';
import '../widgets/save_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController =
  TextEditingController();

  final TextEditingController _emailController =
  TextEditingController();

  final TextEditingController _phoneController =
  TextEditingController();

  File? _image;

  String? _photoUrl;

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final doc = await ProfileService.getUserProfile();

    final data = doc.data() as Map<String, dynamic>;

    _nameController.text = data["name"] ?? "";
    _emailController.text = data["email"] ?? "";
    _phoneController.text = data["phone"] ?? "";
    _photoUrl = data["photoUrl"];

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (picked == null) return;

    setState(() {
      _image = File(picked.path);
    });
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _loading = true;
    });

    try {
      await ProfileService.updateProfile(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        image: _image,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Profile updated successfully."),
        ),
      );

      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }

    if (mounted) {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  EditableProfileAvatar(
                    image: _image,
                    imageUrl: _photoUrl,
                    onTap: _loading ? () {} : _pickImage,
                  ),

                  if (_loading)
                    Container(
                      height: 140,
                      width: 140,
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 30),

              ProfileTextField(
                controller: _nameController,
                label: "Full Name",
                icon: Icons.person,
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return "Name is required";
                  }

                  return null;
                },
              ),

              ProfileTextField(
                controller: _emailController,
                label: "Email",
                icon: Icons.email,
                keyboardType:
                TextInputType.emailAddress,
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return "Enter email";
                  }

                  if (!RegExp(
                    r'^[^@]+@[^@]+\.[^@]+',
                  ).hasMatch(value)) {
                    return "Invalid email";
                  }

                  return null;
                },
              ),

              ProfileTextField(
                controller: _phoneController,
                label: "Phone Number",
                icon: Icons.phone,
                keyboardType:
                TextInputType.phone,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty) {
                    return null;
                  }

                  if (value.length != 10) {
                    return "Enter 10 digit phone number";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 35),

              SaveButton(
                loading: _loading,
                onPressed: _save,
              ),
            ],
          ),
        ),
      ),
    );
  }
}