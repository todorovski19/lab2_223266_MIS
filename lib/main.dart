import 'package:flutter/material.dart';
import 'screens/categoriesScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal Recipes',

      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
          brightness: Brightness.dark,
        ),

        cardTheme: const CardThemeData(
          elevation: 4,
          margin: EdgeInsets.all(8),
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
      ),

      themeMode: ThemeMode.dark,
      home: CategoriesScreen(),
    );
  }
}
