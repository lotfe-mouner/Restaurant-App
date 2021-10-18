import 'package:flutter/material.dart';
import '../dummy_data.dart';
import '../modules/meal.dart';
import '../widgets/meal_item.dart';

class CategoryMealScreens extends StatefulWidget {

  static const routeName = 'category_meals';
  final List<Meal> availableMeals;


  CategoryMealScreens(this.availableMeals);

  @override
  _CategoryMealScreensState createState() => _CategoryMealScreensState();
}

class _CategoryMealScreensState extends State<CategoryMealScreens> {
  String categoryTitle;
  List <Meal> displayMeals;



  @override
  void didChangeDependencies() {
    final routeArg =
    ModalRoute.of(context).settings.arguments as Map<String, String>;
    final categoryId = routeArg['id'];
    categoryTitle = routeArg['title'];
    displayMeals = widget.availableMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
    super.didChangeDependencies();
  }

  void removeMeal(String  mealId){
setState(() {
  displayMeals.removeWhere((meal) => meal.id==mealId);
});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemCount: displayMeals.length,
        itemBuilder: (ctx, index) {
          return MealItem(
            imageUrl: displayMeals[index].imageUrl,
            title: displayMeals[index].title,
            duration: displayMeals[index].duration,
            complexity: displayMeals[index].complexity,
            affordability: displayMeals[index].affordability,
            id: displayMeals[index].id,
          );
        },
      ),
    );
  }
}
