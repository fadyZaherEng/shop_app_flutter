import 'package:shop_app/models/register_model.dart';

abstract class ShopAppRegisterStates{}

class ShopAppRegisterInitialStates extends ShopAppRegisterStates{}
class ShopAppRegisterLoadingStates extends ShopAppRegisterStates{}
class ShopAppRegisterSuccessStates extends ShopAppRegisterStates{
  RegisterModel registerModel;

  ShopAppRegisterSuccessStates(this.registerModel);
}
class ShopAppRegisterErrorStates extends ShopAppRegisterStates{
  String error;
  ShopAppRegisterErrorStates(this.error);
}

class ShopAppRegisterChangeEyeStates extends ShopAppRegisterStates{}
class ShopAppRegisterChangeImageStates extends ShopAppRegisterStates{}