import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garagesale2/controller/delete_item_controller.dart';
import 'package:garagesale2/model/grage_sale_item.dart';
import 'package:garagesale2/pages/detail_page.dart';
import 'package:garagesale2/pages/item_descpritpion.dart';


class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'delete', icon: Icons.directions_car),
  const Choice(title: 'action2', icon: Icons.directions_bike),
  const Choice(title: 'action3', icon: Icons.directions_boat),
];

// ignore: must_be_immutable
class ItemTile extends StatelessWidget {

  final GarageSaleItem item;

  Widget thumbnail;
  ItemTile({ this.item});
  void _select(Choice choice) {
    if(choice.title == "delete"){
      DeleteItemController().deleteItem(item.itemId);
    }

  }



  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(top: 8.0),

      child: GestureDetector(
        onTap: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ItemDetail(),
                settings: RouteSettings(
                  arguments: item,
                ),
              )
          );
        },
        child: Card(

          elevation: 5.0,
          //margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
          child: ListTile(


            title: Row(
              children: <Widget>[
                Expanded(
                  child: item.urls == null || item.urls.length == 0 ? Image.asset(
                      "assets/flutter.png",
                      fit: BoxFit.cover,
                      width: 100.0,

                    ) : new Image.network(
                      item.urls[0],
                      //item.title,
                      fit: BoxFit.cover,
                      width: 150,

                    ),

                ),


                Expanded(

                  child: ItemDescription(
                    title: item.title,
                    price: item.price,
                    description: item.description,
                  ),
                ),

              ],
            ),
            trailing:  PopupMenuButton<Choice>(

              onSelected: _select,
              itemBuilder: (BuildContext context) {
                return choices.map((Choice choice) {
                  return PopupMenuItem<Choice>(
                    value: choice,
                    child: Text(choice.title),

                  );
                }).toList();
              },
            ),

        ),
        ),
      ),
    );
  }

}
