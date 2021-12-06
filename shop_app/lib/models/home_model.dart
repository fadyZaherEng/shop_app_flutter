class HomeModel
{
  bool?  status;
  String? message;
  Data? data;
  HomeModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
    data= Data.fromJson(json['data']);
  }

}

class Data
{
  List<BannerModel> banners=[];
  List<ProductModel> products=[];
  String? ad;
  Data.fromJson(Map<String,dynamic>json)
  {
    for(dynamic element in json['banners'] ){
      banners.add(BannerModel.fromJson(element));
    }
    for(dynamic element in json['products'] ){
      products.add(ProductModel.fromJson(element));
    }
    ad=json['ad'];
  }

}

class ProductModel
{
  dynamic id;
  String? image;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String?name;
  dynamic in_favorites;
  bool? cart;

  ProductModel.fromJson(Map<String,dynamic>json)
  {
    id=json['id'];
    image=json['image'];
    price=json['price'];
    oldPrice=json['old_price'];
    name=json['name'];
    in_favorites=json['in_favorites'];
    cart=json['in_cart'];
    discount=json['discount'];
  }

}

class BannerModel
{
  int? id;
  late String image;
  BannerModel.fromJson(Map<String,dynamic>json)
  {
    id=json['id'];
    image=json['image'];
  }
}