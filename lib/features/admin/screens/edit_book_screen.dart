import 'package:flutter/material.dart';

import '../../books/models/book_model.dart';
import '../../books/services/book_service.dart';
import '../../books/widgets/category_dropdown.dart';
import '../../books/widgets/custom_text_field.dart';

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

  late TextEditingController _titleController;
  late TextEditingController _authorController;
  late TextEditingController _descriptionController;
  late TextEditingController _coverController;
  late TextEditingController _pdfController;
  late TextEditingController _languageController;
  late TextEditingController _publisherController;
  late TextEditingController _publishedDateController;
  late TextEditingController _publishedYearController;
  late TextEditingController _priceController;
  late TextEditingController _ratingController;
  late TextEditingController _pagesController;

  String? _category;

  bool _featured = false;
  bool _trending = false;

  @override
  void initState() {
    super.initState();

    final b = widget.book;

    _titleController = TextEditingController(text: b.title);
    _authorController = TextEditingController(text: b.author);
    _descriptionController =
        TextEditingController(text: b.description);
    _coverController =
        TextEditingController(text: b.coverImage);
    _pdfController =
        TextEditingController(text: b.pdfUrl);
    _languageController =
        TextEditingController(text: b.language);
    _publisherController =
        TextEditingController(text: b.publisher);
    _publishedDateController =
        TextEditingController(text: b.publishedDate);
    _publishedYearController =
        TextEditingController(text: b.publishedYear);

    _priceController =
        TextEditingController(text: b.price.toString());

    _ratingController =
        TextEditingController(text: b.rating.toString());

    _pagesController =
        TextEditingController(text: b.pages.toString());

    _category = b.category;

    _featured = b.featured;
    _trending = b.trending;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _descriptionController.dispose();
    _coverController.dispose();
    _pdfController.dispose();
    _languageController.dispose();
    _publisherController.dispose();
    _publishedDateController.dispose();
    _publishedYearController.dispose();
    _priceController.dispose();
    _ratingController.dispose();
    _pagesController.dispose();
    super.dispose();
  }

  Future<void> _saveBook() async {
    if (!_formKey.currentState!.validate()) return;

    final updatedBook = BookModel(
      id: widget.book.id,

      title: _titleController.text.trim(),
      author: _authorController.text.trim(),
      description: _descriptionController.text.trim(),

      category: _category ?? "",
      coverImage: _coverController.text.trim(),

      price: double.tryParse(_priceController.text) ?? 0,
      rating: double.tryParse(_ratingController.text) ?? 0,
      pages: int.tryParse(_pagesController.text) ?? 0,

      pdfUrl: _pdfController.text.trim(),
      language: _languageController.text.trim(),
      publisher: _publisherController.text.trim(),
      publishedDate: _publishedDateController.text.trim(),
      publishedYear: _publishedYearController.text.trim(),

      featured: _featured,
      trending: _trending,

      downloads: widget.book.downloads,
      readers: widget.book.readers,
    );

    await BookService.updateBook(
      widget.book.id,
      updatedBook,
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Book Updated Successfully"),
      ),
    );

    Navigator.pop(context);
  }

  Widget section(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Book"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Form(
          key: _formKey,
          child: Column(
            children: [

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
                value: _category,
                onChanged: (value) {
                  setState(() {
                    _category = value;
                  });
                },
              ),

              section("Book Information"),

              CustomTextField(
                controller: _coverController,
                label: "Cover Image URL",
                icon: Icons.image,
              ),

              CustomTextField(
                controller: _pdfController,
                label: "PDF URL",
                icon: Icons.picture_as_pdf,
              ),

              CustomTextField(
                controller: _languageController,
                label: "Language",
                icon: Icons.language,
              ),

              CustomTextField(
                controller: _publisherController,
                label: "Publisher",
                icon: Icons.business,
              ),

              CustomTextField(
                controller: _publishedDateController,
                label: "Published Date",
                icon: Icons.event,
              ),

              CustomTextField(
                controller: _publishedYearController,
                label: "Published Year",
                icon: Icons.calendar_month,
              ),

              CustomTextField(
                controller: _pagesController,
                label: "Pages",
                icon: Icons.menu_book_outlined,
                keyboardType: TextInputType.number,
              ),

              CustomTextField(
                controller: _ratingController,
                label: "Rating",
                icon: Icons.star,
                keyboardType: TextInputType.number,
              ),

              CustomTextField(
                controller: _priceController,
                label: "Price",
                icon: Icons.currency_rupee,
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 20),

              SwitchListTile(
                value: _featured,
                title: const Text("Featured"),
                onChanged: (v) {
                  setState(() {
                    _featured = v;
                  });
                },
              ),

              SwitchListTile(
                value: _trending,
                title: const Text("Trending"),
                onChanged: (v) {
                  setState(() {
                    _trending = v;
                  });
                },
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: FilledButton.icon(
                  onPressed: _saveBook,
                  icon: const Icon(Icons.save),
                  label: const Text("Save Changes"),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}