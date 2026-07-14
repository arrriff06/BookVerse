import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../books/widgets/upload_cover_widget.dart';
import '../../books/widgets/custom_text_field.dart';

import '../../books/widgets/category_dropdown.dart';
import '../../books/widgets/upload_button.dart';

import '../../books/models/book_model.dart';
import '../../books/services/book_service.dart';
import '../../books/services/cloudinary_service.dart';

class AdminUploadBookScreen extends StatefulWidget {
  const AdminUploadBookScreen({super.key});

  @override
  State<AdminUploadBookScreen> createState() =>
      _AdminUploadBookScreenState();
}

class _AdminUploadBookScreenState
    extends State<AdminUploadBookScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _ratingController = TextEditingController();
  final _pagesController = TextEditingController();
  String? _selectedCategory;

  File? _coverImage;

  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _ratingController.dispose();
    _pagesController.dispose();
    super.dispose();
  }

  Future<void> _pickCoverImage() async {
    final picker = ImagePicker();

    final image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image != null) {
      setState(() {
        _coverImage = File(image.path);
      });
    }
  }
  Future<void> _uploadBook() async {
    if (!_formKey.currentState!.validate()) return;

    if (_coverImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select a book cover"),
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Upload image to Firebase Storage
      final imageUrl =
      await CloudinaryService.uploadImage(_coverImage!);

      if (imageUrl == null) {
        throw Exception("Image upload failed.");
      }

      // Create book object
      final book = BookModel(
        id: "",
        title: _titleController.text.trim(),
        author: _authorController.text.trim(),
        description: _descriptionController.text.trim(),
        category: _selectedCategory!,
        coverImage: imageUrl,
        price: double.tryParse(_priceController.text) ?? 0,
        rating: double.tryParse(_ratingController.text) ?? 0,
        pages: int.tryParse(_pagesController.text) ?? 0,
      );

      // Save to Firestore
      await BookService.uploadBook(book);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Book uploaded successfully ✅"),
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Upload failed: $e"),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Book"),
      ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            UploadCoverWidget(
              image: _coverImage,
              onTap: _pickCoverImage,
            ),

            const SizedBox(height: 25),

            CustomTextField(
              controller: _titleController,
              label: "Book Title",
              icon: Icons.menu_book_rounded,
            ),

            CustomTextField(
              controller: _authorController,
              label: "Author",
              icon: Icons.person,
            ),

            CustomTextField(
              controller: _descriptionController,
              label: "Description",
              icon: Icons.description,
              maxLines: 5,
            ),

            CategoryDropdown(
              value: _selectedCategory,
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
            ),

            CustomTextField(
              controller: _priceController,
              label: "Price",
              icon: Icons.currency_rupee,
              keyboardType: TextInputType.number,
            ),

            CustomTextField(
              controller: _ratingController,
              label: "Rating",
              icon: Icons.star,
              keyboardType: TextInputType.number,
            ),

            CustomTextField(
              controller: _pagesController,
              label: "Pages",
              icon: Icons.menu_book_outlined,
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 25),

        UploadButton(
          isLoading: _isLoading,
          onPressed: () {
            print("UPLOAD BUTTON CLICKED");
            _uploadBook();
          },
        ),

          ],
        ),
        ),
        ),
    );
  }
}