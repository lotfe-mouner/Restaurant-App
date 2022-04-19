import 'package:flutter/material.dart';
import 'package:meal_app/providers/language_provider.dart';
import '../modules/meal.dart';
import '../screens/meal_detail_screen.dart';
import 'package:provider/provider.dart';

class MealItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final String id;


  const MealItem(
      {required this.imageUrl,
      required this.title,
      required this.duration,
      required this.complexity,
      required this.affordability,
      required this. id,
      });

  String get complexityText{
    switch(complexity){
      case Complexity.Simple: return'Simple';
      case Complexity.Challenging: return 'Challenging';
      case Complexity.Hard: return 'Hard';
      default: return 'Unknown';
    }
  }
  String get affordabilityText{
    switch(affordability){
      case Affordability.Affordable: return'Affordable';
      case Affordability.Luxurious: return 'Luxurious';
      case Affordability.Pricey: return 'Pricey';
      default: return 'Unknown';
    }
  }

  void selectMeal(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
        MealDetailScreen.routeName,
      arguments:id,
    ).then((result){
    //if (result !=null) removeItem(result);
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    var lan= Provider.of<LanguageProvider>(context,listen:true);
    return InkWell(
      onTap: ()=>selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 4.0,
        margin: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)
                      ),
                      child:Hero(
                        tag: id,
                        child: InteractiveViewer(
                          child: FadeInImage(
                            width: double.infinity,
                            placeholder: AssetImage('assets/images/a2.png'),
                            image: NetworkImage(
                                imageUrl
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    ),
                    Positioned(
                      bottom:20,
                        right:10,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 5,horizontal:2),
                          width: 200,
                          color: Colors.black54,
                            child: Text(lan.getTexts('meal-$id').toString(),style: TextStyle(fontSize: 25,color: Colors.white),
                              softWrap: true,overflow:TextOverflow.fade,textAlign: TextAlign.center,)
                        )
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children:[
                      Icon(Icons.access_alarm,color: Theme.of(context).iconTheme.color),
                      SizedBox(width: 10,),
                        if(duration <= 10)
                        Text('$duration'+lan.getTexts('min2').toString()),
                        if(duration > 10)
                          Text('$duration'+lan.getTexts('min').toString()
                          )
                      ]
                    ),
                    Row(
                      children:[
                      Icon(Icons.work,color: Theme.of(context).iconTheme.color),
                      SizedBox(width: 10,),
                      Text(lan.getTexts('$complexity').toString()),
                      ]
                    ),
                    Row(
                      children:[
                      Icon(Icons.attach_money,color: Theme.of(context).iconTheme.color),
                      SizedBox(width: 10,),
                      Text(lan.getTexts('$affordability').toString()),
                      ]
                    ),
                  ]
                ),
              ),
            ],
          ),
      ),
    );
  }
}
