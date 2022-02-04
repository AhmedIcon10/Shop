class GetFavoritesModel{
late bool status;
String? message;
Data?data;
GetFavoritesModel.fromJson(Map<String, dynamic>json){
  status = json['status'];
  message = json['message'];
  data = json['data'] != null ? Data.fromJson(json['data']): null;

}
}
class Data{
  late int currentPage;
  List<FavoritesData> data=[];
  Data.fromJson(Map<String, dynamic>json){
    currentPage = json['current_page'];
   json['data'].forEach((e){
     data.add(FavoritesData.fromJson(e));
   });
  }

}
class FavoritesData{
  late int id;
  ProductData? productData;
  FavoritesData.fromJson(Map<String, dynamic>json){
    id = json['id'];
    productData = json['product'] != null ? ProductData.fromJson(json['product']): null;
  }
}
class ProductData{
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late String description;
  ProductData.fromJson(Map<String , dynamic>json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
  }
}