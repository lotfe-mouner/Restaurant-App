import 'package:flutter/material.dart';
import 'package:meal_app/providers/meal_provider.dart';
import '../widgets/meal_item.dart';
import '../modules/meal.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    List<Meal> favoriteMeals = Provider.of<MealProvider>(context,listen: true).favoriteMeals;
    bool isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;

    var deviceWidth = MediaQuery.of(context).size.width;

    if (favoriteMeals.isEmpty) {
      return Center(
        child: Text('you have no Favorite Meals-Start adding some'),
      );
    }
    else {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: deviceWidth <= 400? 400:500,
            childAspectRatio: isLandScape ? (deviceWidth/(deviceWidth*0.8)):(deviceWidth/(deviceWidth*0.8)),
            crossAxisSpacing: 0,
            mainAxisSpacing: 0),
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