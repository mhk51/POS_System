import 'package:flutter/material.dart';
import 'package:scanner_app/drawer/drawer.dart';
import 'package:scanner_app/models/category.dart';
import 'package:scanner_app/pages/routes.dart';
import 'package:scanner_app/services/categories_services.dart';
import 'package:scanner_app/shared/loading.dart';

class CategoriesPage extends StatefulWidget {
  static const String routeName = '/categories';
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  Widget tilefromCategory(Category category) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          ListTile(
            onTap: () async {
              Category? updatedCategory = await Navigator.pushNamed(
                      context, PageRoutes.addCategory, arguments: category)
                  as Category?;
              if (updatedCategory != null) {
                await CategoriesServices.updateCategory(updatedCategory);
              }
              setState(() {});
            },
            leading: Icon(
              Icons.circle,
              color: category.color,
              size: 55,
            ),
            title: Text(
              category.name,
              style: const TextStyle(fontSize: 20),
            ),
            subtitle: Text('${category.items} items'),
          ),
          const Divider(
            thickness: 0.8,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Categorie Page'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: StreamBuilder(
        stream: CategoriesServices.categories,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active &&
              !snapshot.hasError) {
            List<Category> data = snapshot.data!;
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: data.map(tilefromCategory).toList(),
                ),
              ),
            );
          } else {
            return Loading(backGroundColor: Theme.of(context).primaryColor);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Category? category =
              await Navigator.pushNamed(context, PageRoutes.addCategory)
                  as Category?;
          if (category != null) {
            await CategoriesServices.insertCategory(category);
          }
          setState(() {});
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
