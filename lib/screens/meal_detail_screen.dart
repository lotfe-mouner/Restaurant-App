import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  final Function toggleFavorites;
  final Function  isFavorite;

  MealDetailScreen(this.toggleFavorites,this.isFavorite);

  Widget sectionTitle(BuildContext ctx, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(ctx).textTheme.subtitle1,
      ),
    );
  }

  Widget Steps(Widget child) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 200,
      width: 300,
      child: child,
    );
  }

  static const routeName = 'meal_detail';

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final mealScreen = DUMMY_MEALS.firstWhere((object) => object.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text(mealScreen.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                mealScreen.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            sectionTitle(context, "Ingredients"),
            Steps(
              ListView.builder(
                itemBuilder: (ctx, index) => Card(
                  color: Theme.of(context).accentColor,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Text(mealScreen.ingredients[index]),
                  ),
                ),
                itemCount: mealScreen.ingredients.length,
              ),
            ),
            sectionTitle(context, "Steps"),
            Steps(
              ListView.builder(
                itemBuilder: (ctx, index) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('* ${index + 1}'),
                      ),
                      title: Text(mealScreen.steps[index]),
                    ),
                    Divider(),
                  ],
                ),
                itemCount: mealScreen.steps.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(isFavorite(mealId)? Icons.star : Icons.star_border,
        ),
        onPressed: () {
          toggleFavorites(mealId);
        },
      ),
    );
  }
}
