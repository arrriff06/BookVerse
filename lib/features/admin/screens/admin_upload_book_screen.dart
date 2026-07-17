import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../books/models/book_model.dart';
import '../../books/services/book_service.dart';
import '../../books/services/cloudinary_service.dart';

import '../../books/widgets/category_dropdown.dart';
import '../../books/widgets/custom_text_field.dart';
import '../../books/widgets/upload_button.dart';
import '../../books/widgets/upload_cover_widget.dart';

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

  final _pagesController = TextEditingController();

  final _pdfUrlController = TextEditingController();

  final _languageController = TextEditingController(
    text: "English",
  );

  final _publisherController = TextEditingController();

  final _publishedYearController = TextEditingController();

  String? _selectedCategory;

  File? _coverImage;

  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _descriptionController.dispose();
    _pagesController.dispose();
    _pdfUrlController.dispose();
    _languageController.dispose();
    _publisherController.dispose();
    _publishedYearController.dispose();

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
          content: Text("Please select a cover image"),
        ),
      );
      return;
    }

    if (_selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select category"),
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final imageUrl =
      await CloudinaryService.uploadImage(_coverImage!);

      if (imageUrl == null) {
        throw Exception("Image upload failed");
      }

      final book = BookModel(
        id: "",

        title: _titleController.text.trim(),
        author: _authorController.text.trim(),
        description: _descriptionController.text.trim(),

        category: _selectedCategory!,
        coverImage: imageUrl,

        // Not used in digital library
        price: 0,
        rating: 0,

        pages:
        int.tryParse(_pagesController.text.trim()) ?? 0,

        pdfUrl: _pdfUrlController.text.trim(),

        language: _languageController.text.trim(),

        publisher: _publisherController.text.trim(),

        publishedDate: "",

        publishedYear:
        _publishedYearController.text.trim(),

        featured: false,
        trending: false,

        downloads: 0,
        readers: 0,
      );

      await BookService.uploadBook(book);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Book uploaded successfully"),
        ),
      );

      Navigator.pop(context);
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
        _isLoading = false;
      });
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
            children: [

              UploadCoverWidget(
                image: _coverImage,
                onTap: _pickCoverImage,
              ),

              const SizedBox(height: 25),

              CustomTextField(
                controller: _titleController,
                label: "Book Title",
                icon: Icons.menu_book,
              ),

              const SizedBox(height: 15),

              CustomTextField(
                controller: _authorController,
                label: "Author",
                icon: Icons.person,
              ),

              const SizedBox(height: 15),

              CustomTextField(
                controller: _descriptionController,
                label: "Description",
                icon: Icons.description,
                maxLines: 5,
              ),

              const SizedBox(height: 15),

              CategoryDropdown(
                value: _selectedCategory,
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),

              const SizedBox(height: 15),

              CustomTextField(
                controller: _pagesController,
                label: "Pages",
                icon: Icons.menu_book_outlined,
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 15),

              CustomTextField(
                controller: _pdfUrlController,
                label: "PDF URL (GitHub Raw Link)",
                icon: Icons.picture_as_pdf,
              ),

              const SizedBox(height: 15),

              CustomTextField(
                controller: _languageController,
                label: "Language",
                icon: Icons.language,
              ),

              const SizedBox(height: 15),

              CustomTextField(
                controller: _publisherController,
                label: "Publisher",
                icon: Icons.business,
              ),

              const SizedBox(height: 15),

              CustomTextField(
                controller: _publishedYearController,
                label: "Published Year",
                icon: Icons.calendar_today,
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 35),

              UploadButton(
                isLoading: _isLoading,
                onPressed: _uploadBook,
              ),
            ],
          ),
        ),
      ),
    );
  }
}