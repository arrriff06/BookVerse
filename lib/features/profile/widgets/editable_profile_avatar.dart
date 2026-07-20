import 'dart:io';

import 'package:flutter/material.dart';

class EditableProfileAvatar extends StatelessWidget {
  final File? image;
  final String? imageUrl;
  final VoidCallback onTap;

  const EditableProfileAvatar({
    super.key,
    required this.image,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    ImageProvider? provider;

    if (image != null) {
      provider = FileImage(image!);
    } else if (imageUrl != null && imageUrl!.isNotEmpty) {
      provider = NetworkImage(imageUrl!);
    }

    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Hero(
            tag: "profile_avatar",
            child: CircleAvatar(
              radius: 70,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: provider,
              child: provider == null
                  ? const Icon(
                Icons.person,
                size: 70,
                color: Colors.grey,
              )
                  : null,
            ),
          ),

          Positioned(
            bottom: 0,
            right: 0,
            child: Material(
              color: Theme.of(context).colorScheme.primary,
              elevation: 5,
              shape: const CircleBorder(),
              child: InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: onTap,
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}