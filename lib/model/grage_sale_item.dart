
class GarageSaleItem {
  String title;
  int price;
  String description;
  int itemId;
  List<String> urls;

  GarageSaleItem(this.title, this.price, this.description, this.itemId, this.urls);
  GarageSaleItem.c2(this.title, this.price, this.description, this.urls);
  GarageSaleItem.c3(this.title, this.price, this.description);
  GarageSaleItem.cDefault();


}