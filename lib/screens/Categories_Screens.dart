import 'package:flutter/material.dart';
import 'package:meal_app/providers/meal_provider.dart';
import '../widgets/Category_item.dart';
import '../dummy_data.dart';
import 'package:provider/provider.dart';

class CategoriesScreens extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView(
        padding: EdgeInsets.all(8),
        children: Provider.of<MealProvider>(context,listen: true).availableCategory.map((catData) =>
        CategoryItem(catData.imageURL,catData.id,catData.title,catData.color),
        ).toList(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 400,
          childAspectRatio: 4/2,
          crossAxisSpacing:0,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}
