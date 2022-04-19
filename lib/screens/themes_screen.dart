import 'package:flutter/material.dart';
import 'package:meal_app/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../widgets/main_drawer.dart';

class ThemesScreen extends StatelessWidget {
   final bool fromOnBoarding;
   ThemesScreen({this.fromOnBoarding = false});

  static const routeName = '/themes';


  RadioListTile<ThemeMode> buildRadioListTile(String title,IconData? icon,ThemeMode themeValue,BuildContext context) {
    return RadioListTile(

        title: Text(title),
        secondary: Icon(icon,color: Theme.of(context).iconTheme.color,),
        value: themeValue,
        groupValue:Provider.of<ThemeProvider>(context,listen: true).tm,
        onChanged: (themeValue) => Provider.of<ThemeProvider>(context,listen:false).themeModeChange(themeValue)
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: fromOnBoarding? AppBar(elevation: 0,backgroundColor: Theme.of(context).canvasColor)
        : AppBar(
          title: Text('Your Themes'),
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text('Adjust your theme selection', style: Theme.of(context).textTheme.headline6),
            ),
            Expanded(
                child: ListView(
                  children: [
                     Container(
                       padding:EdgeInsets.all(20),
                       child: Text('Choose your Theme Mode',style:Theme.of(context).textTheme.headline6),
                     ),
                    buildRadioListTile('system Default Theme', null, ThemeMode.system,context),

                    buildRadioListTile('Light Theme', Icons.wb_sunny_outlined, ThemeMode.light, context),

                    buildRadioListTile('Dark Theme', Icons.nights_stay_outlined, ThemeMode.dark, context),

                    buildListTile('primary',context),
                    buildListTile('accent',context),
                    SizedBox(height: fromOnBoarding? 80:0)
                  ],
            )
    ),
          ],
        ),
        drawer: fromOnBoarding? null: MainDrawer()
    );
  }

  ListTile buildListTile(String txt,context) {

    var primaryColor=Provider.of<ThemeProvider>(context,listen: true).primaryColor;
    var accentColor=Provider.of<ThemeProvider>(context,listen: true).accentColor;

    return ListTile(
        title: Text('Choose your $txt Color'),
        trailing: CircleAvatar(
          backgroundColor: txt == 'primary'? primaryColor:accentColor,
        ),
      onTap: (){
          showDialog(context: context,
              builder: (_)=>
                  AlertDialog(
                    title: Text('Pick your color'),
                    elevation: 4,
                    titlePadding: const EdgeInsets.all(0.0),
                    contentPadding: const EdgeInsets.all(0.0),
                    content: SingleChildScrollView(
                      child: ColorPicker(
                      pickerColor: txt =='primary'? Provider.of<ThemeProvider>(context,listen:true).primaryColor
                        : Provider.of<ThemeProvider>(context,listen:true).accentColor,

                        onColorChanged: (newColor)=>Provider.of<ThemeProvider>(context,listen: false)
                            .onChanged(newColor, txt=='primary'? 1:2),

                        colorPickerWidth: 300.0,
                        pickerAreaHeightPercent: 0.7,
                        enableAlpha: false,
                        displayThumbColor: false,
                      ),
                    ),
                  ));
      },
      );
  }


}
