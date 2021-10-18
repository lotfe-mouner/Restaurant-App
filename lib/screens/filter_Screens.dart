import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

// ignore: must_be_immutable
class FilterScreens extends StatefulWidget {
  static const routeName = 'Filters';

  final Function setItems;
  Map<String, bool> currentFilters;

  FilterScreens(this.setItems, this.currentFilters);

  @override
  _FilterScreensState createState() => _FilterScreensState();
}

class _FilterScreensState extends State<FilterScreens> {
  bool glutenFree = false;
  bool lactoseFree = false;
  bool vegan = false;
  bool vegetarian = false;

  @override
  void initState() {
    glutenFree = widget.currentFilters['gluten'];
    lactoseFree = widget.currentFilters['lactose'];
    vegan = widget.currentFilters['vegan'];
    vegetarian = widget.currentFilters['vegetarian'];
    super.initState();
  }

  Widget buildListtile(
      String title, String subtitle, bool currentValue, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: currentValue,
      onChanged: updateValue,
    );
  }

// bool check(currentValue){
//     if(currentValue==null) {
//       currentValue=(glutenFree = widget.currentFilters['gluten']);
//       print('currentValue is $currentValue');
//       return false;
//     }
//     else
//     {
//       print('stop here');
//     return currentValue;
//     }
// }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Filters"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final selectedFilters = {
                'glutenFree': glutenFree,
                'lactoseFree': lactoseFree,
                'vegan': vegan,
                'vegetarian': vegetarian,
              };
              widget.setItems(selectedFilters);
            },
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Adjust your meal Selection",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                buildListtile(
                  'Gluten Free',
                  'only include gluten-free meals.',
                  glutenFree,
                  (newValue) {
                    setState(() {
                      glutenFree = newValue;
                    });
                  },
                ),
                buildListtile(
                  'Lactose Free',
                  'only include Lactose-free meals.',
                  lactoseFree,
                  (newValue) {
                    setState(() {
                      lactoseFree = newValue;
                    });
                  },
                ),
                buildListtile(
                  'vegetarian ',
                  'only include vegetarian meals.',
                  vegetarian,
                  (newValue) {
                    setState(() {
                      vegetarian = newValue;
                    });
                  },
                ),
                buildListtile(
                  'Vegan',
                  'only include Vegan meals.',
                  vegan,
                  (newValue) {
                    setState(() {
                      vegan = newValue;
                    });
                  },
                ),
              ],
            ),
          )
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
