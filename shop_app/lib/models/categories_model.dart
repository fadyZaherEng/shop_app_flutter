class CategoriesModel
{
  bool? status;
  String? message;
  Data? data;
  CategoriesModel.fromJson(Map<String,dynamic>json)
  {
    status=json['status'];
    message=json['message'];
    data=Data.fromJson(json['data']);
  }
}

class Data
{
  int? current_page;
  List<CategoryDetails>data=[];
  String? first_page_url;
  int? from;
  int? last_page;
  String? last_page_url;
  String?next_page_url;
  String? path;
  int? perPage;
  int? to;
  int?total;
  Data.fromJson(Map<String,dynamic>json)
  {
    current_page=json['current_page'];
    for(dynamic obj in json['data'])
    {
          data.add(CategoryDetails.fromJson(obj));
    }
    first_page_url=json['first_page_url'];
    from=json['from'];
    last_page=json['last_page'];
    last_page_url=json['last_page_url'];
    next_page_url=json['next_page_url'];
    path=json['path'];
    perPage=json['per_page'];
    to=json['to'];
    total=json['total'];
  }
}

class CategoryDetails
{
  int? id;
  String? name;
  String? image;
  CategoryDetails.fromJson(Map<String,dynamic>json){
    id=json['id'];
    name=json['name'];
    image=json['image'];
  }
}