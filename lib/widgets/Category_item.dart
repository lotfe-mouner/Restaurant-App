import 'package:flutter/material.dart';
import '../providers/language_provider.dart';
import '../screens/category_meal_screens.dart';
import 'package:provider/provider.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  CategoryItem(this.id, this.title, this.color);
  
  void selectCategory(BuildContext ctx){
    Navigator.of(ctx).pushNamed(CategoryMealScreens.routeName,
    arguments: {
      'id':id,
      'title':title,
        },
    );
  }

  @override
  Widget build(BuildContext context) {
    var lan=Provider.of<LanguageProvider>(context,listen:true);
    return InkWell(
      onTap: ()=> selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.all(15),
        child: Text(lan.getTexts('cat-$id').toString(),style: Theme.of(context).textTheme.headline6,),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withOpacity(0.5),
              color,
            ],
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
