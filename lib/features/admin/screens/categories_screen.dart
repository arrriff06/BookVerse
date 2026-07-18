import 'package:flutter/material.dart';

import '../models/category_model.dart';
import '../services/admin_category_service.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() =>
      _CategoriesScreenState();
}

class _CategoriesScreenState
    extends State<CategoriesScreen> {

  final TextEditingController _searchController =
  TextEditingController();

  String search = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCategoryDialog(),
        child: const Icon(Icons.add),
      ),

      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search Category",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(15),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  search = value.toLowerCase();
                });
              },
            ),
          ),

          Expanded(
            child: StreamBuilder<List<CategoryModel>>(
              stream:
              AdminCategoryService.getCategories(),
              builder: (context, snapshot) {

                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child:
                    CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child:
                    Text(snapshot.error.toString()),
                  );
                }

                if (!snapshot.hasData ||
                    snapshot.data!.isEmpty) {
                  return const Center(
                    child:
                    Text("No Categories Found"),
                  );
                }

                List<CategoryModel> categories =
                snapshot.data!;

                if (search.isNotEmpty) {
                  categories = categories
                      .where((category) => category.name
                      .toLowerCase()
                      .contains(search))
                      .toList();
                }

                return ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, index) {

                    final category =
                    categories[index];

                    return Card(
                      margin:
                      const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: ListTile(

                        leading: CircleAvatar(
                          backgroundImage:
                          category.image.isNotEmpty
                              ? NetworkImage(
                              category.image)
                              : null,
                          child:
                          category.image.isEmpty
                              ? const Icon(
                              Icons.category)
                              : null,
                        ),

                        title: Text(category.name),

                        subtitle: Text(
                          "${category.bookCount} Books",
                        ),

                        trailing: PopupMenuButton(
                          onSelected: (value) async {

                            if (value == "edit") {
                              _showCategoryDialog(
                                category: category,
                              );
                            }

                            if (value == "delete") {
                              await AdminCategoryService
                                  .deleteCategory(
                                category.id,
                              );
                            }
                          },
                          itemBuilder: (_) => const [

                            PopupMenuItem(
                              value: "edit",
                              child: Text("Edit"),
                            ),

                            PopupMenuItem(
                              value: "delete",
                              child: Text(
                                "Delete",
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showCategoryDialog({
    CategoryModel? category,
  }) async {

    final controller = TextEditingController(
      text: category?.name ?? "",
    );

    final imageController =
    TextEditingController(
      text: category?.image ?? "",
    );

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(

        title: Text(
          category == null
              ? "Add Category"
              : "Edit Category",
        ),

        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            TextField(
              controller: controller,
              decoration:
              const InputDecoration(
                labelText: "Category Name",
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: imageController,
              decoration:
              const InputDecoration(
                labelText: "Image URL",
              ),
            ),
          ],
        ),

        actions: [

          TextButton(
            onPressed: () =>
                Navigator.pop(context),
            child: const Text("Cancel"),
          ),

          FilledButton(
            onPressed: () async {

              final model = CategoryModel(
                id: category?.id ?? "",
                name: controller.text.trim(),
                image: imageController.text.trim(),
                bookCount:
                category?.bookCount ?? 0,
                createdAt:
                category?.createdAt,
              );

              if (category == null) {
                await AdminCategoryService
                    .addCategory(model);
              } else {
                await AdminCategoryService
                    .updateCategory(
                  category.id,
                  model,
                );
              }

              if (mounted) {
                Navigator.pop(context);
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }
}