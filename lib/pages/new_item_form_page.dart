import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garagesale2/controller/new_item_controller.dart';
import 'package:garagesale2/service/new_item_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;


class NewItemForm extends StatefulWidget {
  @override
  NewItemFormState createState() => NewItemFormState();

}
class Choice {
  Choice({this.title, this.icon, this.value});
  String title;
  IconData icon;
  String value;
  int imgIndex;
}
List<Choice> choices = <Choice>[
  Choice(title: 'Gallery', icon: Icons.directions_car, value : 'gallery'),
  Choice(title: 'Camera', icon: Icons.directions_bike, value : 'camera'),
];


class NewItemFormState extends State<NewItemForm> {
  List<File> images = List(6);

  final NewItemService newItemService = NewItemService();
  final NewItemController newItemController = NewItemController();

  Future _getImage(source, index) async {
    var image;
    if(source == 'camera'){
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    } else if(source == 'gallery'){
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    }

    setState(() {
      images[index] = image;

    });
  }



  void _formSubmit(){
    var form = _formKey.currentState;
    if(form.validate()){
      form.save();
      print('item title = ' + item_title);
      print('item price = ' + item_price);
      print('item descri = ' + item_description);

      int itemNum = NewItemController().addItem(item_title, int.parse(item_price), item_description);

      newItemController.uploadPic(context, images, itemNum).then((value) {
        print("upload conpleted");
      });

      Navigator.pop(context);
      //Scaffold.of(context).showSnackBar(SnackBar(content: Text('post success')));
    }
  }

  getList(index) {

   return PopupMenuButton<Choice>(

      icon: Icon(Icons.add,size: 40, color: Colors.black38,),
      onSelected: _select,
      itemBuilder: (BuildContext context) {
        return choices.map((Choice choice) {
          choice.imgIndex = index;
          return PopupMenuItem<Choice>(
            value: choice,
            child: Text(choice.title),
          );
        }).toList();
      },
    );
  }

  void _select(Choice choice) {
    _getImage(choice.value, choice.imgIndex);
  }

  _displaySnackBar(BuildContext context) {
    final snackBar = SnackBar(content: Text('post success'));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
  final _formKey = GlobalKey<FormState>();
  var item_title;
  var item_price;
  var item_description;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          title: Text('Post Item'),
        ),
        body: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  GridView.count(
                      crossAxisCount: 3,
                    shrinkWrap: true,
                    primary: false,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: <Widget>[

                      GestureDetector(
                        onTap: (){

                        },
                        child: Container(
                          color: Colors.black12,
                          child: images[0] == null ? getList(0) : Image.file(images[0]),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){

                        },
                        child: Container(
                          color: Colors.black12,
                          child: images[1] == null ? getList(1) : Image.file(images[1]),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){

                        },
                        child: Container(
                          color: Colors.black12,
                          child: images[2] == null ? getList(2) : Image.file(images[2]),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){

                        },
                        child: Container(
                          color: Colors.black12,
                          child: images[3] == null ? getList(3) : Image.file(images[3]),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){

                        },
                        child: Container(
                          color: Colors.black12,
                          child: images[4] == null ? getList(4) : Image.file(images[4]),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){

                        },
                        child: Container(
                          color: Colors.black12,
                          child: images[5] == null ? getList(5) : Image.file(images[5]),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Form(

                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        decoration: const InputDecoration(
                          icon: const Icon(Icons.subtitles),
                          hintText: 'Enter the title of you item',
                          labelText: 'Item',
                        ),
                        validator: (value){
                          if(value.isEmpty){
                            return "please enter the title";
                          }
                          if(value.length > 20)
                            return 'title must be no more than 20 characters';
                          return null;
                        },
                        onSaved: (value) {
                          item_title = value;
                        },
                      ),

                      TextFormField(
                        decoration: const InputDecoration(
                          icon: const Icon(Icons.monetization_on),
                          hintText: 'Enter the price of your item',
                          labelText: 'Price',
                        ),
                        inputFormatters: [WhitelistingTextInputFormatter(RegExp("[1-9]"))],
                        keyboardType: TextInputType.number,
                        validator: (value){
                          bool _isNumeric(String str) {
                            if(str == null) {
                              return false;
                            }
                            return double.tryParse(str) != null;
                          }
                          if(value.isEmpty){
                            return "please enter the price";
                          }
                          if(!_isNumeric(value)){
                            return "please enter valid price";
                          }else if(double.tryParse(value) > 10000){
                            return "price must <= 10000";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          item_price = value;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          icon: const Icon(Icons.description),
                          hintText: 'Enter the description of your item',
                          labelText: 'Description',
                        ),
                        validator: (value){
                          if(value.isEmpty){
                            return "please enter the description";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          item_description = value;
                        },
                      ),
                      SizedBox(height: 20),
                      Row(

                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                              padding: EdgeInsets.all(15.0),
                              child: Text('POST'),
                              color: Colors.blue,
                              textColor: Colors.white,
                              onPressed:this._formSubmit,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
            ),
          ],

        ),
    );
  }
}