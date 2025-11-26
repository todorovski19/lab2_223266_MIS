import 'package:flutter/material.dart';
import '../services/apiService.dart';
import '../models/category.dart';
import '../widgets/cardCategory.dart';
import 'mealsScreen.dart';
import 'randomMeals.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<Category> categories = [];
  List<Category> filtered = [];

  @override
  void initState() {
    load();
    super.initState();
  }

  void load() async {
    categories = await ApiService.getCategories();
    setState(() => filtered = categories);
  }

  void search(String query) {
    setState(() {
      filtered = categories
          .where((c) =>
          c.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
        actions: [
          IconButton(
            icon: Icon(Icons.shuffle),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => RandomMealScreen()));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(5),
            child: TextField(
              onChanged: search,
              decoration: InputDecoration(
                hintText: "Search Categories",
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                return CategoryCard(
                  category: filtered[index],
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          MealsScreen(category: filtered[index].name),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
