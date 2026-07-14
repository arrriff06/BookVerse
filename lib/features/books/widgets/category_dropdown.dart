import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class CategoryDropdown extends StatelessWidget {
  final String? value;
  final Function(String?) onChanged;

  const CategoryDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  static const List<String> categories = [
    "Fiction",
    "Literary Fiction",
    "Story Book",
    "Novel",
    "Romance",
    "fantasy romance",
    "Mystery",
    "StoryBook",
    "Thriller",
    "Fantasy",
    "Science Fiction",
    "Biography",
    "History",
    "Rom com",
    "Business",
    "Finance",
    "Programming",
    "Technology",
    "Education",
    "Children",
    "Comics",
    "Horror",
    "Poetry",
    "Religion",
    "Others",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: "Category",
          prefixIcon: const Icon(
            Icons.category_rounded,
            color: AppColors.primary,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 18,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(
              color: AppColors.primary.withOpacity(.15),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(
              color: AppColors.primary,
              width: 2,
            ),
          ),
        ),
        items: categories
            .map(
              (category) => DropdownMenuItem(
            value: category,
            child: Text(category),
          ),
        )
            .toList(),
        onChanged: onChanged,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please select a category";
          }
          return null;
        },
      ),
    );
  }
}