import 'package:flutter/material.dart';
import '../modules/meal.dart';
import '../widgets/main_drawer.dart';
import 'Categories_Screens.dart';
import 'favorite_screen.dart';

class TabScreens extends StatefulWidget {
List <Meal> favoriteMeals;
TabScreens(this.favoriteMeals);

  @override
  _TabScreensState createState() => _TabScreensState();
}

class _TabScreensState extends State<TabScreens> {

   List<Map<String,Object>> pages;
  int pageIndex=0;


  @override
  void initState() {
    pages=[
    {
    'page': CategoriesScreens(),
    'title':'Categories'
    },
    {
    'page': FavoriteScreen(widget.favoriteMeals),
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
    return Scaffold(
      appBar: AppBar(
        title: Text(pages[pageIndex]['title'] ),
      ),
      body:pages[pageIndex]['page'] ,
      bottomNavigationBar: BottomNavigationBar(
        onTap: selected,
        backgroundColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.category),title: Text("Categories")),
          BottomNavigationBarItem(icon: Icon(Icons.star),title: Text("Favorite"))
        ],

        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.white,
        currentIndex: pageIndex,

      ),
      drawer: MainDrawer(),
      );
  }

}