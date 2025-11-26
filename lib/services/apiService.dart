import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../models/meal.dart';
import '../models/mealDetails.dart';

class ApiService {
  static const baseUrl = "https://www.themealdb.com/api/json/v1/1";

  static Future<List<Category>> getCategories() async {
    final response = await http.get(Uri.parse("$baseUrl/categories.php"));
    final data = jsonDecode(response.body);
    return (data["categories"] as List)
        .map((e) => Category.fromJson(e))
        .toList();
  }

  static Future<List<Meal>> getMealsByCategory(String category) async {
    final response =
    await http.get(Uri.parse("$baseUrl/filter.php?c=$category"));
    final data = jsonDecode(response.body);
    return (data["meals"] as List).map((e) => Meal.fromJson(e)).toList();
  }

  static Future<List<Meal>> searchMeals(String query) async {
    final res = await http.get(Uri.parse("$baseUrl/search.php?s=$query"));
    final data = jsonDecode(res.body);
    if (data["meals"] == null) return [];
    return (data["meals"] as List).map((e) => Meal.fromJson(e)).toList();
  }

  static Future<MealDetail> getMealDetail(String id) async {
    final res = await http.get(Uri.parse("$baseUrl/lookup.php?i=$id"));
    final data = jsonDecode(res.body);
    return MealDetail.fromJson(data["meals"][0]);
  }

  static Future<MealDetail> loadRandomMeal() async {
    final res = await http.get(Uri.parse("$baseUrl/random.php"));
    final data = jsonDecode(res.body);
    return MealDetail.fromJson(data["meals"][0]);
  }
}


