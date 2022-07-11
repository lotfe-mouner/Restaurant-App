import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:provider/provider.dart';

class MealDetailScreen extends StatefulWidget {
  static const routeName = 'meal_detail';

  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  bool isSelected = false;



  Widget stepsTable(Widget child, context) {
    bool isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(15),
      height: isLandScape ? deviceHeight * 0.5 : deviceHeight * 0.25,
      width: isLandScape ? (deviceWidth * 0.46) : deviceWidth,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;
    final mealId = ModalRoute.of(context)?.settings.arguments as String;
    final selectedMeal =
        DUMMY_MEALS.firstWhere((object) => object.id == mealId);
    var accentColor = Theme.of(context).colorScheme.secondary;
    bool isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    List<String> ingredientList =
        lan.getTexts('ingredients-$mealId') as List<String>;
    List<String> stepsList = lan.getTexts('steps-$mealId') as List<String>;

    Widget titleSection(BuildContext ctx, String text) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Text(
          lan.getTexts(text).toString(),
          style: Theme.of(ctx).textTheme.headline6,
          textAlign: TextAlign.center,
        ),
      );
    }

    var liIngredients = ListView.builder(
      padding: EdgeInsets.all(0),
      itemBuilder: (ctx, index) => Card(
        color: accentColor,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Text(
            ingredientList[index],
            style: TextStyle(
                color: useWhiteForeground(accentColor)
                    ? Colors.white
                    : Colors.black),
          ),
        ),
      ),
      itemCount: selectedMeal.ingredients.length,
    );

    

    var liSteps = ListView.builder(
      padding: EdgeInsets.all(0),
      itemBuilder: (ctx, index) => Column(
        children: [
          ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Text(
                  '* ${index + 1}',
                  style: TextStyle(fontSize: 13),
                ),
              ),
              title: Text(stepsList[index],
                  style: TextStyle(fontSize: 15, color: Colors.black))),
          Divider(),
        ],
      ),
      itemCount: selectedMeal.steps.length,
    );

    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 250,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(lan.getTexts('meal-$mealId').toString()),
                background: Hero(
                  tag: mealId,
                  child: InteractiveViewer(
                    child: FadeInImage(
                      placeholder: AssetImage('assets/images/a2.png'),
                      image: AssetImage(selectedMeal.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  if (isLandScape)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            titleSection(context, 'Ingredients'),
                            stepsTable(liIngredients, context),
                          ],
                        ),
                        Column(
                          children: [
                            titleSection(context, 'Steps'),
                            stepsTable(liSteps, context),
                          ],
                        )
                      ],
                    ),
                  if (!isLandScape)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                            //titleSection(context, "Ingredients"),
                               ExpansionTile(
                                title: Text(lan.getTexts("Ingredients").toString(),
                                    style: Theme.of(context).textTheme.headline6,
                                    textAlign: TextAlign.center),
                                children: [
                                  Container(
                                      height:  isLandScape ? deviceHeight * 0.5 : deviceHeight * 0.40,
                                      width: isLandScape ? (deviceWidth * 0.46) : deviceWidth,
                                      child: liIngredients)
                                ]

                              ),
                        ExpansionTile(
                            title: Text(lan.getTexts("Steps").toString(),
                                style: Theme.of(context).textTheme.headline6,
                                textAlign: TextAlign.center),
                            children: [
                              Container(
                                 margin: EdgeInsets.all(5),
                                  height:  isLandScape ? deviceHeight * 0.5 : deviceHeight * 0.4,
                                  width: isLandScape ? (deviceWidth * 0.46) : deviceWidth,
                                  child: liSteps),
                              SizedBox(height: 50,)
                            ]

                        ),
                        //stepsTable(liIngredients, context),

                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Provider.of<MealProvider>(context, listen: true).isFavorite(mealId)
                ? Icons.star
                : Icons.star_border,
          ),
          onPressed: () {
            Provider.of<MealProvider>(context, listen: false)
                .toggleFavorites(mealId);
          },
        ),
      ),
    );
  }

  bool useWhiteForeground(Color backgroundColor) =>
      1.05 / (backgroundColor.computeLuminance() + 0.05) > 4.5;
}
