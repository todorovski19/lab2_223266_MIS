import 'package:flutter/material.dart';
import '../models/mealDetails.dart';
import '../services/apiService.dart';
import 'package:url_launcher/url_launcher.dart';

class RandomMealScreen extends StatefulWidget {
  const RandomMealScreen({Key? key}) : super(key: key);

  @override
  _RandomMealScreenState createState() => _RandomMealScreenState();
}

class _RandomMealScreenState extends State<RandomMealScreen> {
  MealDetail? meal;
  bool isLoading = true;

  final api = ApiService();

  @override
  void initState() {
    super.initState();
    fetchRandomMeal();
  }

  Future<void> fetchRandomMeal() async {
    setState(() => isLoading = true);
    final randomMeal = await ApiService.loadRandomMeal();
    setState(() {
      meal = randomMeal;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Random Recipe"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: fetchRandomMeal,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : meal == null
          ? const Center(child: Text("Failed to load meal"))
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                meal!.thumbnail,
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            Text(
              meal!.name,
              style: const TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            const Text("Instructions",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(meal!.instructions),

            const SizedBox(height: 16),

            const Text("Ingredients",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...List.generate(meal!.ingredients.length, (i) {
              return ListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                title: Text(meal!.ingredients[i]),
                trailing: Text(meal!.measures[i]),
              );
            }),

            if (meal!.youtube != null && meal!.youtube!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () async {
                    final url = Uri.parse(meal!.youtube!);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    }
                  },
                  child: const Text("View on YouTube"),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
