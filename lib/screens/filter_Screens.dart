import 'package:flutter/material.dart';
import 'package:meal_app/providers/language_provider.dart';
import '../providers/meal_provider.dart';
import '../widgets/main_drawer.dart';
import 'package:provider/provider.dart';


class FilterScreens extends StatefulWidget {

  static const routeName = 'Filters';


  @override
  _FilterScreensState createState() => _FilterScreensState();
}

class _FilterScreensState extends State<FilterScreens> {



  Widget buildListtile(
      String title, String subtitle, bool currentValue, Function(bool) updateValue) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: currentValue,
      onChanged: updateValue,
      inactiveTrackColor: Colors.grey,
    );
  }

  @override
  Widget build(BuildContext context) {
    var lan= Provider.of<LanguageProvider>(context,listen: true);
    Map<String, bool> currentFilters = Provider.of<MealProvider>(context,listen: true).filters;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: false,
            elevation: 5,
            title: Text(lan.getTexts('filters_appBar_title').toString()),
           actions: [
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                Provider.of<MealProvider>(context, listen: false).setFilters();
              },
            )
          ],
          ),
          SliverList(delegate: SliverChildListDelegate([
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                lan.getTexts('filters_screen_title').toString(),
                style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center),
            ),
                  buildListtile(
                    lan.getTexts('Gluten-free').toString(),
                    lan.getTexts('Gluten-free-sub').toString(),
                    currentFilters['gluten']!,
                        (newValue) {
                      setState(() {
                        currentFilters['gluten'] = newValue;
                      });
                    },
                  ),
                  buildListtile(
                    lan.getTexts('Lactose-free').toString(),
                    lan.getTexts('Lactose-free_sub').toString(),
                    currentFilters['lactose']!,
                        (newValue) {
                      setState(() {
                        currentFilters['lactose'] = newValue;
                      });
                    },
                  ),
                  buildListtile(
                    lan.getTexts('Vegetarian').toString(),
                    lan.getTexts('Vegetarian-sub').toString(),
                    currentFilters['vegetarian']!,
                        (newValue) {
                      setState(() {
                        currentFilters['vegetarian'] = newValue;
                      });
                    },
                  ),
                  buildListtile(
                    lan.getTexts('Vegan').toString(),
                    lan.getTexts('Vegan-sub').toString(),
                    currentFilters['vegan']!,
                        (newValue) {
                      setState(() {
                        currentFilters['vegan'] = newValue;
                      });
                    },
                  ),
          ]
          ))
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
