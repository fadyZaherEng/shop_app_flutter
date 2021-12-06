import 'package:shop_app/models/add_delete_favorite.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/profile_model.dart';
import 'package:shop_app/models/search_model.dart';

abstract class ShopStates{}

class ShopInitialStates extends ShopStates{}
class ShopChangeBottomNavStates extends ShopStates{}

class ShopLoadingStates extends ShopStates{}
class ShopSuccessStates extends ShopStates{
  HomeModel model;

  ShopSuccessStates(this.model);
}
class ShopErrorStates extends ShopStates{
  String error;

  ShopErrorStates(this.error);
}

class ShopCatLoadingStates extends ShopStates{}
class ShopCategoriesSuccessStates extends ShopStates{
  CategoriesModel  model;

  ShopCategoriesSuccessStates(this.model);

}
class ShopCategoriesErrorStates extends ShopStates{
  String error;

  ShopCategoriesErrorStates(this.error);
}

class ShopChangeFavoriteStates extends ShopStates {}
class ShopChangeFavoriteErrorStates extends ShopStates {
  String error;

  ShopChangeFavoriteErrorStates(this.error);
}
class ShopChangeFavoriteSuccessStates extends ShopStates {
  ChangeFavorite model;

  ShopChangeFavoriteSuccessStates(this.model);
}



class ShopFavLoadingStates extends ShopStates{}
class ShopFavoritesSuccessStates extends ShopStates{
  FavoritesModel  model;

  ShopFavoritesSuccessStates(this.model);

}
class ShopFavoritesErrorStates extends ShopStates{
  String error;

  ShopFavoritesErrorStates(this.error);
}


class ShopSearchReloadingStates extends ShopStates{}
class ShopSearchLoadingStates extends ShopStates{}
class ShopSearchSuccessStates extends ShopStates{
  SearchModel  model;

  ShopSearchSuccessStates(this.model);

}
class ShopSearchErrorStates extends ShopStates{
  String error;

  ShopSearchErrorStates(this.error);
}


