class SearchModel {
  bool? status;
  Data? data;

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  dynamic currentPage;
  List<DataProduct> data = [];
  String? firstPageUrl;
  dynamic from;
  dynamic lastPage;
  String? lastPageUrl;
  String? path;
  dynamic perPage;
  dynamic to;
  dynamic total;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    for (dynamic el in json['data']) {
      data.add(DataProduct.fromJson(el));
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }
}

class DataProduct {
  dynamic id;
  dynamic price;
  String? image;
  String? name;
  String? description;
  List<String> images=[];
  bool? inFavorites;
  bool? inCart;

  DataProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'].cast<String>();
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
