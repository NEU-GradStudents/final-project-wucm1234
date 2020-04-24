
import 'package:flutter/material.dart';

const testInputDecoration = InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    hintText: "Email",
    //border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
    fillColor: Colors.white,
    filled: true,
    enabledBorder: OutlineInputBorder(

        borderSide: BorderSide(
            color: Colors.blue,
            width: 2.0
        ),

    ),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: Colors.pink,
            width: 2.0
        )
    )
);

class TextDeco2 {

  InputDecoration getDeco(){
     return InputDecoration(
         contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),

         border:
         OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)));
   }

}