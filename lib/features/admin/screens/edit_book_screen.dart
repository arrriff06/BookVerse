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

class EditBookScreen extends StatefulWidget {
  final BookModel book;

  const EditBookScreen({
    super.key,
    required this.book,
  });

  @override
  State<EditBookScreen> createState() => _EditBookScreenState();
}

class _EditBookScreenState extends State<EditBookScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _titleController;
  late final TextEditingController _authorController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _priceController;
  late final TextEditingController _ratingController;
  late final TextEditingController _pagesController;

  String? _selectedCategory;

  File? _newCoverImage;

  bool _loading = false;

  @override
  void initState() {
    super.initState();

    _titleController =
        TextEditingController(text: widget.book.title);

    _authorController =
        TextEditingController(text: widget.book.author);

    _descriptionController =
        TextEditingController(text: widget.book.description);

    _priceController =
        TextEditingController(text: widget.book.price.toString());

    _ratingController =
        TextEditingController(text: widget.book.rating.toString());

    _pagesController =
        TextEditingController(text: widget.book.pages.toString());

    _selectedCategory = widget.book.category;
  }

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

  Future<void> _pickImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image != null) {
      setState(() {
        _newCoverImage = File(image.path);
      });
    }
  }

  Future<void> _updateBook() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select category"),
        ),
      );
      return;
    }

    setState(() {
      _loading = true;
    });

    String imageUrl = widget.book.coverImage;

    if (_newCoverImage != null) {
      final uploaded =
      await CloudinaryService.uploadImage(_newCoverImage!);

      if (uploaded != null) {
        imageUrl = uploaded;
      }
    }

    await BookService.updateBook(
      bookId: widget.book.id,
      data: {
        "title": _titleController.text.trim(),
        "author": _authorController.text.trim(),
        "description":
        _descriptionController.text.trim(),
        "category": _selectedCategory,
        "coverImage": imageUrl,
        "price":
        double.tryParse(_priceController.text) ?? 0,
        "rating":
        double.tryParse(_ratingController.text) ?? 0,
        "pages":
        int.tryParse(_pagesController.text) ?? 0,
      },
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Book Updated Successfully"),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Book"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              UploadCoverWidget(
                image: _newCoverImage,
                imageUrl: widget.book.coverImage,
                onTap: _pickImage,
              ),

              const SizedBox(height: 25),

              CustomTextField(
                controller: _titleController,
                label: "Book Title",
                icon: Icons.menu_book,
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

              const SizedBox(height: 30),

              UploadButton(
                isLoading: _loading,
                text: "Update Book",
                icon: Icons.save,
                onPressed: _updateBook,
              ),
            ],
          ),
        ),
      ),
    );
  }
}