

import 'package:flutter/cupertino.dart';
import 'package:garagesale2/model/grage_sale_item.dart';
import 'package:garagesale2/model/user.dart';
import 'package:garagesale2/pages/Item_list_page.dart';
import 'package:garagesale2/pages/authpage.dart';
import 'package:garagesale2/pages/new_item_form_page.dart';
import 'package:garagesale2/service/database_service.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);


    if(user == null){
      return Authenticate();
    }else {
     return StreamProvider<List<GarageSaleItem>>.value(

        value: DatabaseService.getInstance().items,
        child: ItemListPage(),
        //child: Authenticate(),

      );
    }

  }

}