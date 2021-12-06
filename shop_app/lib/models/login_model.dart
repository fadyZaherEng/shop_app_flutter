class ShopLoginModel
{
  late bool status;
  late String message;
  Data? data;

  ShopLoginModel.fromJson(Map<String,dynamic>data)
  {
   message=data['message'];
   status=data['status'];
   this.data=(data['data']==null?null:Data(
       data['data']['id'],
       data['data']['name'],
       data['data']['phone'],
       data['data']['email'],
       data['data']['image'],
       data['data']['points'],
       data['data']['credit'],
       data['data']['token']
   ));
  }

}

class Data
{
  int? id;
  String? name;
  String? phone;
  String? email;
  String? image;
  int? points;
  int? credit;
  String? token;

  Data(this.id, this.name, this.phone, this.email, this.image, this.points,
      this.credit, this.token);
}