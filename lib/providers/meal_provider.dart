import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dummy_data.dart';
import '../modules/category.dart';
import '../modules/meal.dart';

class MealProvider with ChangeNotifier{

   Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> availableMeals = DUMMY_MEALS;
  List<Meal> favoriteMeals = [];
  List<String> prefsMealID=[];
  List<Category> availableCategory = DUMMY_CATEGORIES;



 void setFilters()  async{

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

List<Category> filteredCategory=[];

      availableMeals.forEach((meal) {
        meal.categories.forEach((categoryID) {
          DUMMY_CATEGORIES.forEach((cat) {
            if(cat.id == categoryID) {
              if(!filteredCategory.any((cat) => cat.id == categoryID)) filteredCategory.add(cat);
            }
          });
        });
      });
availableCategory = filteredCategory;

  notifyListeners();

  SharedPreferences prefs=  await SharedPreferences.getInstance();

  prefs.setBool('gluten', filters['gluten']!);
  prefs.setBool('lactose', filters['lactose']!);
  prefs.setBool('vegan', filters['vegan']!);
  prefs.setBool('vegetarian', filters['vegetarian']!);

  }


  void setData()  async{

   SharedPreferences prefs= await SharedPreferences.getInstance();

   filters['gluten']= prefs.getBool('gluten') ?? false;
   filters['lactose']= prefs.getBool('lactose') ?? false;
   filters['vegan']= prefs.getBool('vegan') ?? false;
   filters['vegetarian']= prefs.getBool('vegetarian') ?? false;


   prefsMealID = prefs.getStringList('prefsMealID') ??[];

      for (String mealId in prefsMealID){

        final existingIndex =favoriteMeals.indexWhere((meal) => meal.id == mealId);

        if(existingIndex <0)
          favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      }

      List<Meal> fm= [];

      favoriteMeals.forEach((favMeal) {
        availableMeals.forEach((meal) {
          if(favMeal.id  == meal.id) fm.add(favMeal);
        });
      });
      favoriteMeals=fm;


   notifyListeners();

  }


  void toggleFavorites(String mealId) async{

    SharedPreferences prefs= await SharedPreferences.getInstance();

    final existingIndex =favoriteMeals.indexWhere((meal) => meal.id == mealId);

    if(existingIndex>=0){
        favoriteMeals.removeAt(existingIndex);
        prefs.remove(mealId);
    }
    else  {
        favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));

        prefsMealID.add(mealId);
        print(prefsMealID);
    }

    notifyListeners();
    prefs.setStringList('prefsMealID', prefsMealID);
  }


  bool isFavorite( String mealId){
   return favoriteMeals.any((meal) => meal.id == mealId);
  }
}