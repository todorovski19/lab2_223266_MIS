import 'package:flutter/material.dart';
import '../models/mealDetails.dart';
import '../services/apiService.dart';
import 'package:url_launcher/url_launcher.dart';

class MealDetailScreen extends StatelessWidget {
  final String id;

  MealDetailScreen({required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Details")),
      body: FutureBuilder<MealDetail>(
        future: ApiService.getMealDetail(id),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          final meal = snapshot.data!;

          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Image.network(meal.thumbnail),
                SizedBox(height: 16),
                Text(meal.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 16),

                Text("Instructions"),
                SizedBox(height: 8),
                Text(meal.instructions),

                SizedBox(height: 16),
                Text("Ingredients", style: TextStyle(fontWeight: FontWeight.bold)),
                ...List.generate(meal.ingredients.length, (i) {
                  return ListTile(
                    title: Text(meal.ingredients[i]),
                    trailing: Text(meal.measures[i]),
                  );
                }),

                if (meal.youtube != null && meal.youtube!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      onPressed: () => launchUrl(Uri.parse(meal.youtube!)),
                      child: Text("View on Youtube"),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
