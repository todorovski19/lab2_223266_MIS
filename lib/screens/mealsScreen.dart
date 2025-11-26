import 'package:flutter/material.dart';
import '../services/apiService.dart';
import '../models/meal.dart';
import '../widgets/mealCard.dart';
import 'mealDetailsScreen.dart';

class MealsScreen extends StatefulWidget {
  final String category;

  MealsScreen({required this.category});

  @override
  _MealsScreenState createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  List<Meal> meals = [];
  List<Meal> filtered = [];

  @override
  void initState() {
    load();
    super.initState();
  }

  void load() async {
    meals = await ApiService.getMealsByCategory(widget.category);
    setState(() => filtered = meals);
  }

  void search(String query) async {
    if (query.isEmpty) {
      setState(() => filtered = meals);
      return;
    }

    final results = await ApiService.searchMeals(query);

    setState(() {
      filtered = results
          .where((m) => m.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.category)),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              onChanged: search,
              decoration: InputDecoration(
                hintText: "Search recipes",
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: filtered.map((m) {
                return MealCard(
                  meal: m,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MealDetailScreen(id: m.id),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
