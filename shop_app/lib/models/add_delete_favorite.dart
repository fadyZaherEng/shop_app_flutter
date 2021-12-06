class ChangeFavorite
{
  dynamic status;
  String?message;
  ChangeFavorite.fromJson(Map<String,dynamic>json)
  {
    status=json['status'];
    message=json['message'];
  }
}