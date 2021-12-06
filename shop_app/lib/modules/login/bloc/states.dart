import 'package:shop_app/models/login_model.dart';

abstract class ShopAppLogInStates{}

class ShopAppLogInInitialStates extends ShopAppLogInStates{}
class ShopAppLogInLoadingStates extends ShopAppLogInStates{}
class ShopAppLogInSuccessStates extends ShopAppLogInStates{
  ShopLoginModel model;

  ShopAppLogInSuccessStates(this.model);
}
class ShopAppLogInErrorStates extends ShopAppLogInStates{
  String error;

  ShopAppLogInErrorStates(this.error);
}

class ShopAppLogInChangeEyeStates extends ShopAppLogInStates{}
