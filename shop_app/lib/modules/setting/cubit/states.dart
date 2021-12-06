import 'package:shop_app/models/profile_model.dart';

abstract class ShopSettingStates{}

class ShopProfileInitialStates extends ShopSettingStates{}
class ShopProfileLoadingStates extends ShopSettingStates{}
class ShopProfileSuccessStates extends ShopSettingStates{
  ProfileModel  model;
  ShopProfileSuccessStates(this.model);

}
class ShopProfileErrorStates extends ShopSettingStates{
  String error;
  ShopProfileErrorStates(this.error);
}

class ShopProfileUpdateLoadingStates extends ShopSettingStates{}
class ShopProfileUpdateSuccessStates extends ShopSettingStates{
  ProfileModel  model;
  ShopProfileUpdateSuccessStates(this.model);

}
class ShopProfileUpdateErrorStates extends ShopSettingStates{
  String error;
  ShopProfileUpdateErrorStates(this.error);
}
class ShopProfileUpdateImageStates extends ShopSettingStates{}