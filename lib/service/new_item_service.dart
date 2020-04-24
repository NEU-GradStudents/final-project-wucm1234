

import 'dart:core';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart' as path;

class NewItemService {

//  Future<List<String>> uploadPic(BuildContext context, List<File> images, int itemId) async {
//
//    List<String> urls = List();
//    for(final _image in images){
//      if(_image != null){
//        String fileName = path.basename(_image.path);
//        StorageReference firebaseStoreRef = FirebaseStorage.instance.ref().child('chunming_images/$fileName');
//        StorageUploadTask uploadTask = firebaseStoreRef.putFile(_image);
//        StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
//        taskSnapshot.ref.getDownloadURL().then((value) {
//
//          urls.add(value);
//        });
//      }
//    }
//    images.forEach((_image)  {
//      if(_image != null){
//        String fileName = path.basename(_image.path);
//        StorageReference firebaseStoreRef = FirebaseStorage.instance.ref().child('chunming_images/$fileName');
//        StorageUploadTask uploadTask = firebaseStoreRef.putFile(_image);
//        StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
//        taskSnapshot.ref.getDownloadURL().then((value) {
//          urls.add(value);
//        });
//      }
//
//    });
//    print("ready to return $urls");
//    return urls;
//  }

}