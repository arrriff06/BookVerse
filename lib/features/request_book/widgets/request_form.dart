import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class RequestForm extends StatelessWidget {
  final TextEditingController bookController;
  final TextEditingController authorController;
  final TextEditingController notesController;

  final String language;
  final String category;

  final ValueChanged<String?> onLanguageChanged;
  final ValueChanged<String?> onCategoryChanged;

  final VoidCallback onSubmit;

  final bool isLoading;

  const RequestForm({
    super.key,
    required this.bookController,
    required this.authorController,
    required this.notesController,
    required this.language,
    required this.category,
    required this.onLanguageChanged,
    required this.onCategoryChanged,
    required this.onSubmit,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: AppColors.primary.withValues(alpha: .10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            TextFormField(
              controller: bookController,
              decoration: const InputDecoration(
                labelText: "Book Name",
                prefixIcon: Icon(Icons.menu_book_rounded),
              ),
            ),

            const SizedBox(height: 18),

            TextFormField(
              controller: authorController,
              decoration: const InputDecoration(
                labelText: "Author Name",
                prefixIcon: Icon(Icons.person_outline),
              ),
            ),

            const SizedBox(height: 18),

            DropdownButtonFormField<String>(
              value: language,
              decoration: const InputDecoration(
                labelText: "Language",
                prefixIcon: Icon(Icons.language),
              ),
              items: const [
                DropdownMenuItem(
                  value: "English",
                  child: Text("English"),
                ),
                DropdownMenuItem(
                  value: "Hindi",
                  child: Text("Hindi"),
                ),
                DropdownMenuItem(
                  value: "Bengali",
                  child: Text("Bengali"),
                ),
              ],
              onChanged: onLanguageChanged,
            ),

            const SizedBox(height: 18),

            DropdownButtonFormField<String>(
              value: category,
              decoration: const InputDecoration(
                labelText: "Category",
                prefixIcon: Icon(Icons.category_outlined),
              ),
              items: const [
                DropdownMenuItem(
                  value: "Self Help",
                  child: Text("Self Help"),
                ),
                DropdownMenuItem(
                  value: "Novel",
                  child: Text("Novel"),
                ),
                DropdownMenuItem(
                  value: "Business",
                  child: Text("Business"),
                ),
                DropdownMenuItem(
                  value: "Biography",
                  child: Text("Biography"),
                ),
              ],
              onChanged: onCategoryChanged,
            ),

            const SizedBox(height: 18),

            TextFormField(
              controller: notesController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Additional Notes (Optional)",
                alignLabelWithHint: true,
              ),
            ),

            const SizedBox(height: 28),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                onPressed: isLoading
                    ? null
                    : onSubmit,
                icon: isLoading
                    ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
                    : const Icon(Icons.send_rounded),
                label: Text(
                  isLoading
                      ? "Submitting..."
                      : "Request Book",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}