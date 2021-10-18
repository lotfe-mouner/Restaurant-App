import 'package:flutter/material.dart';
import './dummy_data.dart';
import './modules/meal.dart';
import './screens/filter_Screens.dart';
import './screens/meal_detail_screen.dart';
import './screens/tabs_screen.dart';
import './screens/category_meal_screens.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> availableMeals = DUMMY_MEALS;
  List<Meal> favoriteMeals = [];

  void setFilters(Map<String, bool> filterData) {
    setState(() {
      filters = filterData;
      availableMeals = DUMMY_MEALS.where((eachMeal) {
        if (filters['gluten'] == true && !eachMeal.isGlutenFree) {
          return false;
        }
        if (filters['lactose'] == true && !eachMeal.isLactoseFree) {
          return false;
        }
        if (filters['vegan'] == true && !eachMeal.isVegan) {
          return false;
        }
        if (filters['vegetarian'] == true && !eachMeal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void toggleFavorites(String mealId){
    final existingIndex =favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if(existingIndex>=0){
      setState(() {
        favoriteMeals.removeAt(existingIndex);
      });
    }
    else  {
      setState(() {
        favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool isMealFavorite(String id){
    return favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meal App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 50, 50, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 50, 50, 1),
              ),
              subtitle1: TextStyle(
                fontSize: 24,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      // home: MyHomePage(),
      // home:CategoriesScreens(),
      routes: {
        '/': (context) => TabScreens(favoriteMeals),
        CategoryMealScreens.routeName: (context) => CategoryMealScreens(availableMeals),
        MealDetailScreen.routeName: (context) => MealDetailScreen(toggleFavorites,isMealFavorite),
        FilterScreens.routeName: (context) => FilterScreens(setFilters, filters),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meal App"),
      ),
      //body:CategoriesScreens(),
      body: null,
    );
  }
}
