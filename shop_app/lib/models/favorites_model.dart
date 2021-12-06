class FavoritesModel {
  bool? status;
  String? message;
  Data? data;

  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = (json['data'] != null ? Data.fromJson(json['data']) : null);
  }

}

class Data {
  dynamic currentPage;
  List<DataFavorite> listFavorites = [];
  String? firstPageUrl;
  dynamic from;
  dynamic lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  dynamic perPage;
  String? prevPageUrl;
  dynamic to;
  dynamic total;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    for (dynamic element in json['data']) {
      listFavorites.add(DataFavorite.fromJson(element));
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

}

class DataFavorite {
  dynamic id;
  Product? product;
  DataFavorite.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
    json['product'] != null ? Product.fromJson(json['product']) : null;
  }

}

class Product {
  dynamic id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}