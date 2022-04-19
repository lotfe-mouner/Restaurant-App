import 'package:flutter/material.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/screens/filter_Screens.dart';
import 'package:meal_app/screens/tabs_screen.dart';
import 'package:meal_app/screens/themes_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key?key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    var primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: ExactAssetImage('assets/images/image.jpg'),
                      fit: BoxFit.cover),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                   alignment: Alignment.center,
                      width: 300,
                      color: Colors.black.withOpacity(0.6),
                      padding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                      child: Text(
                        lan.getTexts('drawer_name').toString(),
                        style:Theme.of(context).textTheme.headline6!.copyWith(
                          color: Colors.white,  
                          fontSize: 30
                        ),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    Container(
                      width: 350,
                      color: Colors.black.withOpacity(0.6),
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      margin: EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: [
                          Text(lan.getTexts('drawer_switch_title').toString(),
                            style:Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white
                          ),textAlign: TextAlign.center,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(lan.getTexts('drawer_switch_item2').toString(),style:Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white
                              )),
                              Switch(
                                  value: lan.isEn,
                                  onChanged: (newValue){
                                    Provider.of<LanguageProvider>(context,listen: false).changeLan(newValue);
                                  }),
                              Text(lan.getTexts('drawer_switch_item1').toString(),style:Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white
                              )),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              ThemesScreen(fromOnBoarding:true),
              FilterScreens()
            ],
            onPageChanged: (newValue) => setState(() => _currentIndex = newValue),
          ),
          Indicator(_currentIndex),
          Builder(
            builder: (ctx) => Align(
              alignment: Alignment(0, 0.90),
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                  child: Text(lan.getTexts('start').toString(),
                    style: TextStyle(color: useWhiteForeground(primaryColor)?Colors.white:Colors.black)),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(lan.isEn ? EdgeInsets.all(7) : EdgeInsets.all(0)),
                    backgroundColor: MaterialStateProperty.all(primaryColor),
                  ),
                  onPressed: () async{
                     Navigator.of(ctx).pushNamed(TabScreens.routeName);

                     SharedPreferences prefs= await SharedPreferences.getInstance();
                     prefs.setBool('watched', true);
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  bool useWhiteForeground(Color backgroundColor) =>
      1.05 / (backgroundColor.computeLuminance() + 0.05) > 4.5;
}

class Indicator extends StatelessWidget {
  final int index;

  Indicator(this.index);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildContainer(context, 0),
          buildContainer(context, 1),
          buildContainer(context, 2)
        ],
      ),
    );
  }

  Widget buildContainer(BuildContext ctx, int i) {
    return index == i ? Icon(
            Icons.star,
            color: Theme.of(ctx).colorScheme.primary,
          )
        : Container(
            margin: EdgeInsets.all(4),
            height: 15,
            width: 15,
            decoration: BoxDecoration(
                color: Theme.of(ctx).colorScheme.secondary,
                shape: BoxShape.circle),
          );
  }
}
