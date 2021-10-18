import 'package:flutter/material.dart';
import '../widgets/meal_item.dart';
import '../modules/meal.dart';

class FavoriteScreen extends StatelessWidget {
  List<Meal> favoriteMeals;

  FavoriteScreen(this.favoriteMeals);

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return Center(
        child: Text('you have no Favorite Meals-Start adding some'),
      );
    }
    else {
      return ListView.builder(
        itemCount: favoriteMeals.length,
        itemBuilder: (ctx, index) {
          return MealItem(
            imageUrl: favoriteMeals[index].imageUrl,
            title: favoriteMeals[index].title,
            duration: favoriteMeals[index].duration,
            complexity: favoriteMeals[index].complexity,
            affordability: favoriteMeals[index].affordability,
            id: favoriteMeals[index].id,
          );
        },
      );
    }
  }
}