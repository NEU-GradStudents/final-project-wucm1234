import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garagesale2/model/grage_sale_item.dart';
import 'package:garagesale2/model/item_tile.dart';
import 'package:garagesale2/pages/new_item_form_page.dart';
import 'package:garagesale2/service/auth_service.dart';
import 'package:provider/provider.dart';


class ItemListPage extends StatefulWidget {
  @override
  ItemListState createState() => ItemListState();
}
class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'login', icon: Icons.directions_car),
  const Choice(title: 'action2', icon: Icons.directions_bike),
  const Choice(title: 'action3', icon: Icons.directions_boat),
];


class ItemListState extends State<ItemListPage> {
  final title = 'Garage Sale';
  final authService = AuthServise();
  void _select(Choice choice) async{
    if(choice.title == 'login'){
      dynamic result = await authService.signInAnon();
      if(result == null) {
        print("login error");
      }else {
        print("login success, uid=" + result.uid);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
      List<GarageSaleItem> items = Provider.of<List<GarageSaleItem>>(context);

      final AuthServise authServise = AuthServise();
      //print("itemlistpateurl++++++++++++++++++"+items[0].urls.toString());
    if(items == null) {
      items = new List<GarageSaleItem>();
    }
    return Scaffold(
      appBar: new AppBar(
        title: new Text(title),
        actions: <Widget>[      // Add 3 lines from here...
          //IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
          FlatButton.icon(
            icon: Icon(
                Icons.person,
              color: Colors.white,
            ),
            label: Text(
                "Logout",
              style: TextStyle(
                color: Colors.white
              ),
            ),
            onPressed: () async{
              await authServise.signOut();
            },
          ),
//          PopupMenuButton<Choice>(
//
//            onSelected: _select,
//            itemBuilder: (BuildContext context) {
//              return choices.map((Choice choice) {
//                return PopupMenuItem<Choice>(
//                  value: choice,
//                  child: Text(choice.title),
//
//                );
//              }).toList();
//            },
//          ),
        ],
      ),

        //body: Container(),
      body: ListView.builder(
        itemExtent: 150.0,
        itemCount: items.length,
        itemBuilder: (context, index){
          if(items!=null && items.length > 0){
            print("current item is" + items.toString());
            return ItemTile(item : items[index]);
          }
          return ItemTile();

        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NewItemForm()
              )
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );

  }
}