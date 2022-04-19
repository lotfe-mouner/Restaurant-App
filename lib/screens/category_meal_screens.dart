import 'package:flutter/material.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/providers/meal_provider.dart';
import '../modules/meal.dart';
import '../widgets/meal_item.dart';
import 'package:provider/provider.dart';

class CategoryMealScreens extends StatefulWidget {
  static const routeName = 'category_meals';

  @override
  _CategoryMealScreensState createState() => _CategoryMealScreensState();
}

class _CategoryMealScreensState extends State<CategoryMealScreens> {
  late String categoryTitle;
  late List<Meal> displayMeals;
  late String categoryId;

  @override
  void didChangeDependencies() {
    final List<Meal> availableMeals = Provider.of<MealProvider>(context, listen: true).availableMeals;

    final routeArg = ModalRoute.of(context)?.settings.arguments as Map<String, String>;
     categoryId = routeArg['id']!;
    categoryTitle = routeArg['title']!;
    displayMeals = availableMeals.where((meal) {return meal.categories.contains(categoryId);
    }).toList();
    super.didChangeDependencies();
  }

  void removeMeal(String mealId) {
    setState(() {
      displayMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {

    bool isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;
    var deviceWidth = MediaQuery.of(context).size.width;
    var lan=Provider.of<LanguageProvider>(context,listen: false);


    return Directionality(
      textDirection: lan.isEn? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text((lan.getTexts('cat-$categoryId')).toString()),
        ),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: deviceWidth<=400? 400:500,
              childAspectRatio: isLandScape ?  (deviceWidth/(deviceWidth*0.8)):(deviceWidth/(deviceWidth*0.8)),
              crossAxisSpacing: 0,
              mainAxisSpacing: 0),
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
      ),
    );
  }
}
