import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:garagesale2/model/grage_sale_item.dart';
import 'package:garagesale2/service/database_service.dart';
import 'package:garagesale2/service/new_item_service.dart';
import 'package:path/path.dart' as path;

class NewItemController {
  NewItemService newItemService = NewItemService();
  DatabaseService databaseService = DatabaseService.getInstance();


  int addItem(String title, int price, String desc){
    GarageSaleItem item = new GarageSaleItem.c3(title, price, desc);
    return databaseService.addItem(item);
  }


  Future uploadPic(BuildContext context, List<File> images, int itemId) async {

    for(final _image in images){
      if(_image != null){
        String fileName = path.basename(_image.path);
        StorageReference firebaseStoreRef = FirebaseStorage.instance.ref().child('chunming_images/$fileName');
        StorageUploadTask uploadTask = firebaseStoreRef.putFile(_image);
        StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
        taskSnapshot.ref.getDownloadURL().then((value) {
          List<String> urlList = databaseService.getUrls(itemId);
          urlList.add(value);
          databaseService.updateUrls(itemId, urlList);
        });
      }
    }

  }
}