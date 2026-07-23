import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/theme/app_colors.dart';
import '../../request_book/models/request_book_model.dart';
import '../services/complete_request_upload_service.dart';

class UploadBookDialog extends StatefulWidget {
  final RequestBookModel request;
  final VoidCallback? onUploaded;

  const UploadBookDialog({
    super.key,
    required this.request,
    this.onUploaded,
  });

  @override
  State<UploadBookDialog> createState() =>
      _UploadBookDialogState();
}

class _UploadBookDialogState
    extends State<UploadBookDialog> {
final _formKey = GlobalKey<FormState>();

late final TextEditingController titleController;
late final TextEditingController authorController;
late final TextEditingController descriptionController;
late final TextEditingController publisherController;
late final TextEditingController languageController;
late final TextEditingController categoryController;
late final TextEditingController pagesController;
late final TextEditingController pdfUrlController;

File? coverImage;

bool featured = false;
bool trending = false;
bool loading = false;

@override
void initState() {
super.initState();

titleController = TextEditingController(
text: widget.request.bookName,
);

authorController = TextEditingController(
text: widget.request.author,
);

descriptionController = TextEditingController(
text: widget.request.notes,
);

publisherController = TextEditingController();

languageController = TextEditingController(
text: widget.request.language,
);

categoryController = TextEditingController(
text: widget.request.category,
);

pagesController = TextEditingController(
text: "200",
);

pdfUrlController = TextEditingController();
}

@override
void dispose() {
titleController.dispose();
authorController.dispose();
descriptionController.dispose();
publisherController.dispose();
languageController.dispose();
categoryController.dispose();
pagesController.dispose();
pdfUrlController.dispose();
super.dispose();
}

Future<void> pickCover() async {
final image = await ImagePicker().pickImage(
source: ImageSource.gallery,
imageQuality: 80,
);

if (image == null) return;

setState(() {
coverImage = File(image.path);
});
}

Future<void> uploadBook() async {
if (!_formKey.currentState!.validate()) {
return;
}

if (coverImage == null) {
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
content: Text("Please select a cover image."),
),
);
return;
}

setState(() {
loading = true;
});

try {
await CompleteRequestUploadService.uploadRequestedBook(
requestId: widget.request.id,
uid: widget.request.uid,
cover: coverImage!,
pdfUrl: pdfUrlController.text.trim(),
title: titleController.text.trim(),
author: authorController.text.trim(),
description: descriptionController.text.trim(),
category: categoryController.text.trim(),
language: languageController.text.trim(),
publisher: publisherController.text.trim(),
pages: int.tryParse(
pagesController.text.trim(),
) ??
0,
featured: featured,
trending: trending,
);

if (!mounted) return;

Navigator.pop(context);

widget.onUploaded?.call();

ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
backgroundColor: Colors.green,
content: Text("Book uploaded successfully."),
),
);
} catch (e) {
if (!mounted) return;

setState(() {
loading = false;
});

ScaffoldMessenger.of(context).showSnackBar(
SnackBar(content: Text(e.toString())),
);
}
}
@override
Widget build(BuildContext context) {
  return Dialog(
    insetPadding: const EdgeInsets.all(20),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
    child: SizedBox(
      width: 650,
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Text(
                "Upload Requested Book",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 24),

              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "Book Title",
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Required";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: authorController,
                decoration: const InputDecoration(
                  labelText: "Author",
                ),
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: descriptionController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: "Description",
                ),
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: publisherController,
                decoration: const InputDecoration(
                  labelText: "Publisher",
                ),
              ),

              const SizedBox(height: 16),

              Row(
                children: [

                  Expanded(
                    child: TextFormField(
                      controller: languageController,
                      decoration: const InputDecoration(
                        labelText: "Language",
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: TextFormField(
                      controller: categoryController,
                      decoration: const InputDecoration(
                        labelText: "Category",
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: pagesController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Pages",
                ),
              ),

              const SizedBox(height: 24),

              TextFormField(
                controller: pdfUrlController,
                decoration: const InputDecoration(
                  labelText: "GitHub Raw PDF URL",
                  hintText:
                  "https://raw.githubusercontent.com/...",
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter PDF URL";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              const Text(
                "Book Cover",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              OutlinedButton.icon(
                onPressed: loading ? null : pickCover,
                icon: const Icon(Icons.image),
                label: Text(
                  coverImage == null
                      ? "Choose Cover Image"
                      : "Change Cover Image",
                ),
              ),

              if (coverImage != null) ...[
                const SizedBox(height: 16),

                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.file(
                      coverImage!,
                      width: 170,
                      height: 240,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 24),

              SwitchListTile(
                value: featured,
                activeColor: AppColors.primary,
                title: const Text("Featured Book"),
                onChanged: loading
                    ? null
                    : (value) {
                  setState(() {
                    featured = value;
                  });
                },
              ),

              SwitchListTile(
                value: trending,
                activeColor: AppColors.primary,
                title: const Text("Trending Book"),
                onChanged: loading
                    ? null
                    : (value) {
                  setState(() {
                    trending = value;
                  });
                },
              ),

              const SizedBox(height: 28),

              Row(
                children: [

                  Expanded(
                    child: OutlinedButton(
                      onPressed: loading
                          ? null
                          : () => Navigator.pop(context),
                      child: const Text("Cancel"),
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: FilledButton.icon(
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primary,
                      ),
                      onPressed:
                      loading ? null : uploadBook,
                      icon: loading
                          ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                          : const Icon(
                        Icons.cloud_upload,
                      ),
                      label: Text(
                        loading
                            ? "Uploading..."
                            : "Upload Book",
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
}
