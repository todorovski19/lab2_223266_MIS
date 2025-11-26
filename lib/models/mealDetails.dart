class MealDetail {
  final String id;
  final String name;
  final String instructions;
  final String thumbnail;
  final String? youtube;
  final List<String> ingredients;
  final List<String> measures;

  MealDetail({
    required this.id,
    required this.name,
    required this.instructions,
    required this.thumbnail,
    required this.youtube,
    required this.ingredients,
    required this.measures,
  });

  factory MealDetail.fromJson(Map<String, dynamic> json) {
    List<String> ingredients = [];
    List<String> measures = [];

    for (int i = 1; i <= 20; i++) {
      final ing = json['strIngredient$i'];
      final meas = json['strMeasure$i'];

      if (ing != null && ing.toString().isNotEmpty) {
        ingredients.add(ing);
        measures.add(meas ?? "");
      }
    }

    return MealDetail(
      id: json['idMeal'],
      name: json['strMeal'],
      instructions: json['strInstructions'],
      thumbnail: json['strMealThumb'],
      youtube: json['strYoutube'],
      ingredients: ingredients,
      measures: measures,
    );
  }
}
