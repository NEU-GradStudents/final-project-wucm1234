import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garagesale2/controller/new_item_controller.dart';
import 'package:garagesale2/model/grage_sale_item.dart';
import 'package:garagesale2/model/user.dart';
import 'package:garagesale2/pages/Item_list_page.dart';
import 'package:garagesale2/pages/authpage.dart';
import 'package:garagesale2/pages/new_item_form_page.dart';
import 'package:garagesale2/pages/wrapper.dart';
import 'package:garagesale2/service/auth_service.dart';
import 'package:garagesale2/service/database_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    routes: {
      "toListRoute":(BuildContext context)=>new ItemListPage(),
      "toPostItem":(BuildContext context)=>new NewItemForm(),
    },
  ));
}

class Home extends StatefulWidget {
  @override
  AddNewItem createState() => AddNewItem();
}

class AddNewItem extends State<Home>{
  @override
  Widget build(BuildContext context) {
    //return Container();
//    return StreamProvider<List<GarageSaleItem>>.value(
//
//      value: DatabaseService.getInstance().items,
//      child: ItemListPage(),
//      //child: Authenticate(),
//
//    );

    return StreamProvider<User>.value(

      value: AuthServise().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
      //child: Authenticate(),

    );
  }
}

