import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../modules/meal.dart';
import '../screens/meal_detail_screen.dart';

class MealItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final String id;


  const MealItem(
      {@required this.imageUrl,
      @required this.title,
      @required this.duration,
      @required this.complexity,
      @required this.affordability,
      @required this. id,
      });

  String get complexityText{
    switch(complexity){
      case Complexity.Simple: return'Simple';  break;
      case Complexity.Challenging: return 'Challenging'; break;
      case Complexity.Hard: return 'Hard'; break;
      default: return 'Unknown'; break;
    }
  }
  String get affordabilityText{
    switch(affordability){
      case Affordability.Affordable: return'Affordable';  break;
      case Affordability.Luxurious: return 'Luxurious'; break;
      case Affordability.Pricey: return 'Pricey'; break;
      default: return 'Unknown'; break;
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
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)
                  ),
                  child: Image.network(
                    imageUrl,
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom:20,
                    right:10,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5,horizontal:2),
                      width: 200,
                      color: Colors.black54,
                        child: Text(title,style: TextStyle(fontSize: 25,color: Colors.white),
                          softWrap: true,overflow:TextOverflow.fade,textAlign: TextAlign.center,)
                    )
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children:[
                    Icon(Icons.access_alarm,),
                    SizedBox(width: 10,),
                    Text('$duration min'),
                    ]
                  ),
                  Row(
                    children:[
                    Icon(Icons.work,),
                    SizedBox(width: 10,),
                    Text('$complexityText'),
                    ]
                  ),
                  Row(
                    children:[
                    Icon(Icons.attach_money,),
                    SizedBox(width: 10,),
                    Text('$affordabilityText'),
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
