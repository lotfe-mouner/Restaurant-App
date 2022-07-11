import 'package:flutter/material.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/screens/tabs_screen.dart';
import 'package:meal_app/screens/themes_screen.dart';
import '../screens/filter_Screens.dart';
import '../screens/themes_screen.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatelessWidget {


  Widget buildListTile(String title, IconData icon, Function() tapHandler,BuildContext ctx) {
   return ListTile(
      leading: Icon(icon, size: 26,color: Theme.of(ctx).iconTheme.color),
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(ctx).textTheme.bodyText1!.color,
            fontSize: 24,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context,listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Drawer(
        elevation: 0,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 120,
                width: double.infinity,
                color: Theme.of(context).colorScheme.secondary,
                padding: EdgeInsets.all(20),
                alignment: lan.isEn?Alignment.centerLeft:Alignment.centerRight,
                child: Text(
                  lan.getTexts('drawer_name').toString(),
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ),
              SizedBox(height: 20),
              buildListTile(lan.getTexts('drawer_item1').toString(), Icons.restaurant, () {
                Navigator.of(context).pushReplacementNamed(TabScreens.routeName);
              },context
              ),
              // buildListTile(lan.getTexts('drawer_item2').toString(), Icons.settings, () {
              //   Navigator.of(context).pushReplacementNamed(FilterScreens.routeName);
              // },context
              // ),
              buildListTile(lan.getTexts('drawer_item3').toString(),Icons.color_lens, (){
                Navigator.pushReplacementNamed(context, ThemesScreen.routeName);
              },context),
              Divider(
                height: 10,
                color: Colors.black54
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top:20,right:22),
                child: Text(lan.getTexts('drawer_switch_title').toString(),
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: (lan.isEn ? 0:20),left:(lan.isEn? 20:0),bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(lan.getTexts('drawer_switch_item2').toString(),style: Theme.of(context).textTheme.headline6,),
                    Switch(value: Provider.of<LanguageProvider>(context,listen: true).isEn,
                        onChanged: (newValue){
                      Provider.of<LanguageProvider>(context,listen: false).changeLan(newValue);
                      Navigator.of(context).pop();
                        }),
                    Text(lan.getTexts('drawer_switch_item1').toString(),style: Theme.of(context).textTheme.headline6,),
                  ],
                ),
              ),
              Divider(
                height: 30,
                color: Colors.black54,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
