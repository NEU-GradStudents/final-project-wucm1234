import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:garagesale2/model/grage_sale_item.dart';

class DatabaseService {
  static DatabaseService _databaseService;
  DatabaseService._internal();
  factory DatabaseService.getInstance() => _getInstance();
  static _getInstance() {
    if (_databaseService == null) {
      _databaseService = DatabaseService._internal();
    }
    return _databaseService;
  }
  
  int maxId = 0;
   final CollectionReference itemsRef = Firestore.instance.collection('chunming_garage_items');

   
   
  addItemWithUrls(GarageSaleItem item) {
   itemsRef.add({'title': item.title, 'price': item.price, 'description': item.description, 'item_id': maxId+1, 'image_urls' : item.urls});
  }

  int addItem(GarageSaleItem item) {
    print("item.url from database++++++++++++++++"+item.urls.toString());
    itemsRef.add({'title': item.title, 'price': item.price, 'description': item.description, 'item_id': maxId+1});
    return maxId+1;
  }

  
  
  List<GarageSaleItem> _itemListFromSnapshot(QuerySnapshot snapshot){

    List<GarageSaleItem> res = snapshot.documents.map((doc) {
      List<dynamic> dyList = doc.data['image_urls'];
      List<String> strList = List();
      if(dyList != null){
        dyList.forEach((element) {
          if (element != null) {
            strList.add(element.toString());
          }
        });
      }

      return GarageSaleItem(
        doc.data['title'] ?? '',
        doc.data['price'] ?? 0,
        doc.data['description'] ?? '',
        doc.data['item_id'],
        strList
      );
    }).toList();


    
    res.forEach((item) {
      if(item.itemId == null) return;
      if(item.itemId > maxId){
        maxId = item.itemId;
      }
    });
//
    return res;
  }
  
  
  

  Stream<List<GarageSaleItem>> get items {
    print('enter getitem====================+++++++');
    //CollectionReference sortRef = itemsRef.orderBy('price', descending: true).limit(1);
    Stream<List<GarageSaleItem>> result =  itemsRef.orderBy("item_id").snapshots().map(_itemListFromSnapshot);
    print("content" + result.toList().toString());
    return result;
  }
  
  
  
  void deleteItem(int itemId){
    itemsRef.where("item_id", isEqualTo: itemId).getDocuments().then((snapshot){
      snapshot.documents.first.reference.delete();

    });
  }

  void updateUrls(int itemId, List<String> urls){
    itemsRef.where("item_id", isEqualTo: itemId).getDocuments().then((snapshot){
      snapshot.documents.first.reference.updateData({'image_urls' : urls});
    });
  }

  List<String> getUrls(int itemId){
    List<String> urlList = List();
    itemsRef.where("item_id", isEqualTo: itemId).getDocuments().then((snapshot){
      Map urls = snapshot.documents.first.data;
      if(urls!=null && urls['image_urls'] != null) {
        for(var li in urls["image_urls"] ){
          urlList.add(li.toString());
        }
      }

    });
    return urlList;
  }
}