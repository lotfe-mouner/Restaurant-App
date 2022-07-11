import 'package:flutter/material.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/providers/theme_provider.dart';
import 'package:meal_app/screens/on_board_screen.dart';
import 'package:meal_app/screens/themes_screen.dart';
import './screens/filter_Screens.dart';
import './screens/meal_detail_screen.dart';
import './screens/tabs_screen.dart';
import './screens/category_meal_screens.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {

 WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
 //prefs.clear();

  Widget homeScreen= (prefs.getBool('watched')??false) ? TabScreens() : OnBoardingScreen();


  runApp(

      MultiProvider(
        providers: [
           ChangeNotifierProvider<MealProvider>(
             create: (ctx) => MealProvider(),
           ),
          ChangeNotifierProvider<ThemeProvider>(
            create: (ctx) => ThemeProvider(),
          ),
          ChangeNotifierProvider<LanguageProvider>(
            create: (ctx) => LanguageProvider(),
          )
        ],
        child: MyApp(homeScreen),
  ));
}

class MyApp extends StatefulWidget {
  final Widget mainScreen;
  MyApp(this.mainScreen);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    var primaryColor=Provider.of<ThemeProvider>(context,listen: true).primaryColor;
    var accentColor=Provider.of<ThemeProvider>(context,listen: true).accentColor;
    var tm=Provider.of<ThemeProvider>(context,listen: true).tm;


    return MaterialApp (
      debugShowCheckedModeBanner: false,
      title: 'Meal App',
      themeMode:  tm,
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: primaryColor).copyWith(secondary: accentColor),
        canvasColor: Color.fromRGBO(14, 22, 33, 1),
        cardColor: Color.fromRGBO(35, 34, 39, 1),
        shadowColor: Colors.white70,
        iconTheme: IconThemeData(color: Colors.white70),
        unselectedWidgetColor: Colors.white60,
        fontFamily: 'Raleway',
        textTheme: ThemeData.dark().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Colors.white60,
              ),
          headline6: TextStyle(
            color: Colors.white60,
            fontSize: 24,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
          ),
            ),
      ),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: primaryColor).copyWith(secondary: accentColor),
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        cardColor: Colors.white,
        fontFamily: 'Raleway',
        iconTheme: IconThemeData(color: Colors.black87),
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 50, 50, 1),
              ),
              headline6: TextStyle(
                color: Colors.black87,
                fontSize: 24,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      routes: {
        '/': (context) => widget.mainScreen,
        TabScreens.routeName: (context) => TabScreens(),
        CategoryMealScreens.routeName: (context) => CategoryMealScreens(),
        MealDetailScreen.routeName: (context) => MealDetailScreen(),
        FilterScreens.routeName: (context) => FilterScreens(),
        ThemesScreen.routeName: (context) => ThemesScreen(),
      },
    );
  }
}
