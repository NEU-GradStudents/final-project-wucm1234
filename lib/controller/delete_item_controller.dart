import 'package:garagesale2/service/database_service.dart';

class DeleteItemController{
  DatabaseService databaseService = DatabaseService.getInstance();
  void deleteItem(int itemId){
    databaseService.deleteItem(itemId);
  }
}