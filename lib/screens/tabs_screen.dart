import 'package:flutter/material.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/providers/theme_provider.dart';

import '../widgets/main_drawer.dart';
import 'Categories_Screens.dart';
import 'favorite_screen.dart';
import 'package:provider/provider.dart';

class TabScreens extends StatefulWidget {
  static const routeName = 'tab_screen';

  @override
  _TabScreensState createState() => _TabScreensState();
}

class _TabScreensState extends State<TabScreens> {


 // Future<bool> _backPressed() async{
 //    return  await showDialog(
 //      context: context,builder: (BuildContext context)=>AlertDialog(
 //      shape:RoundedRectangleBorder(
 //        borderRadius: BorderRadius.circular(15.0)
 //      ),
 //      title: Text('Do you really want to exit the app?',style: TextStyle(fontSize: 20),),
 //      actions: [
 //        TextButton(
 //          child: Text('Yes'),
 //          onPressed: ()=>Navigator.of(context).pop(true),
 //        ),
 //        TextButton(
 //          child: Text('No'),
 //          onPressed: ()=>Navigator.of(context).pop(false),
 //        ),
 //      ],
 //    ),
 //    );
 //  }



  Widget buildListtile(String title, String subtitle, bool currentValue,
      Function(bool) updateValue) {
    return SwitchListTile(
      title: Text(title,style: TextStyle(color:Colors.black)),
      subtitle: Text(subtitle,style: TextStyle(color:Colors.blueGrey)),
      value: currentValue,
      onChanged: updateValue,
      inactiveTrackColor: Colors.grey,
    );
  }

  late List<Map<String, Object>> pages;
  int pageIndex = 0;

  @override
  void initState() {
    Provider.of<MealProvider>(context, listen: false).setData();
    Provider.of<ThemeProvider>(context, listen: false).getThemeMode();
    Provider.of<ThemeProvider>(context, listen: false).getThemeColors();
    Provider.of<LanguageProvider>(context, listen: false).getLan();

    pages = [
      {'page': CategoriesScreens(), 'title': 'Categories'},
      {'page': FavoriteScreen(), 'title': 'Your Favorites'}
    ];

    super.initState();
  }

  void selected(int value) {
    setState(() {
      pageIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    Map<String, bool> currentFilters = Provider.of<MealProvider>(context, listen: true).filters;
    var tm=Provider.of<ThemeProvider>(context,listen:true).tm;

    pages = [
      {'page': CategoriesScreens(), 'title': lan.getTexts('categories')},
      {'page': FavoriteScreen(), 'title': lan.getTexts('your_favorites')}
    ];

    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
        child: WillPopScope(
          onWillPop: () async{
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(pages[pageIndex]['title'].toString()),
              actions: [
                IconButton(
                  icon: Icon(Icons.tune),
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => StatefulBuilder(
                      builder: (context, setState) => AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        insetPadding: EdgeInsets.zero,
                        title: Text('Filters',style: TextStyle(color:Colors.black),),
                        content: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              buildListtile(
                                lan.getTexts('Gluten-free').toString(),
                                lan.getTexts('Gluten-free-sub').toString(),
                                currentFilters['gluten']!,
                                (newValue) {
                                  setState(() {
                                    currentFilters['gluten'] = newValue;
                                    Provider.of<MealProvider>(context,
                                            listen: false)
                                        .setFilters();
                                  });
                                },
                              ),
                              SizedBox(height: 10),
                              buildListtile(
                                lan.getTexts('Lactose-free').toString(),
                                lan.getTexts('Lactose-free_sub').toString(),
                                currentFilters['lactose']!,
                                (newValue) {
                                  setState(() {
                                    currentFilters['lactose'] = newValue;
                                    Provider.of<MealProvider>(context,
                                            listen: false)
                                        .setFilters();
                                  });
                                },
                              ),
                              SizedBox(height: 10),
                              buildListtile(
                                lan.getTexts('Vegetarian').toString(),
                                lan.getTexts('Vegetarian-sub').toString(),
                                currentFilters['vegetarian']!,
                                (newValue) {
                                  setState(() {
                                    currentFilters['vegetarian'] = newValue;
                                    Provider.of<MealProvider>(context,
                                            listen: false)
                                        .setFilters();
                                  });
                                },
                              ),
                              SizedBox(height: 5),
                              buildListtile(
                                lan.getTexts('Vegan').toString(),
                                lan.getTexts('Vegan-sub').toString(),
                                currentFilters['vegan']!,
                                (newValue) {
                                  setState(() {
                                    currentFilters['vegan'] = newValue;
                                    Provider.of<MealProvider>(context,
                                            listen: false)
                                        .setFilters();
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(
                              'Done',
                              style: TextStyle(fontSize: 18),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            body: pages[pageIndex]['page'] as Widget,
            bottomNavigationBar: BottomNavigationBar(
              onTap: selected,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.category),
                    label: lan.getTexts('categories').toString()),
                BottomNavigationBarItem(
                    icon: Icon(Icons.star),
                    label: lan.getTexts('your_favorites').toString())
              ],
              backgroundColor: Theme.of(context).colorScheme.primary,
              selectedItemColor: Theme.of(context).colorScheme.secondary,
              unselectedItemColor: Colors.white,
              currentIndex: pageIndex,
            ),
            drawer: MainDrawer(),
          ),
        ),
      );
  }
}
