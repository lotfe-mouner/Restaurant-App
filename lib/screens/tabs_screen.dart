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

   late List<Map<String,Object>> pages;
   int pageIndex=0;


  @override
  void initState() {

    Provider.of<MealProvider>(context,listen: false).setData();
    Provider.of<ThemeProvider>(context,listen: false).getThemeMode();
    Provider.of<ThemeProvider>(context,listen: false).getThemeColors();
    Provider.of<LanguageProvider>(context,listen: false).getLan();


    pages=[
    {
    'page': CategoriesScreens(),
    'title':'Categories'
    },
    {
    'page': FavoriteScreen(),
    'title':'Your Favorites'
    }
    ];

    super.initState();
  }

  void selected(int value){
    setState(() {
      pageIndex=value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context,listen:true);

    pages=[
      {
        'page': CategoriesScreens(),
        'title': lan.getTexts('categories')
      },
      {
        'page': FavoriteScreen(),
        'title': lan.getTexts('your_favorites')
      }
    ];

    return Directionality(
      textDirection: lan.isEn? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(pages[pageIndex]['title'].toString()),
        ),
        body:pages[pageIndex]['page'] as Widget,
        bottomNavigationBar: BottomNavigationBar(
          onTap: selected,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.category),label: lan.getTexts('categories').toString()),
            BottomNavigationBarItem(icon: Icon(Icons.star),label: lan.getTexts('your_favorites').toString())
          ],
          backgroundColor: Theme.of(context).colorScheme.primary,
          selectedItemColor: Theme.of(context).colorScheme.secondary,
          unselectedItemColor: Colors.white,
          currentIndex: pageIndex,

        ),
        drawer: MainDrawer(),
        ),
    );
  }

}