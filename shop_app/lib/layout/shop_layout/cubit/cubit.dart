import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/cubit/states.dart';
import 'package:shop_app/models/add_delete_favorite.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/profile_model.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/categories/categories.dart';
import 'package:shop_app/modules/favorites/favorites.dart';
import 'package:shop_app/modules/products/products.dart';
import 'package:shop_app/modules/setting/settings.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/end_points.dart';
import 'package:shop_app/shared/network/local/shared_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates>
{
  ShopCubit() : super(ShopInitialStates());

  static ShopCubit get(context)=>BlocProvider.of(context);
   CategoriesModel?  categoriesModel;
   HomeModel? homeModel;

  List<Widget>listShop=[
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen()
  ];
  List<String>listTitles=[
    'Products',
    'Categories',
    'Favorites',
    'Settings'
  ];
  List<BottomNavigationBarItem>listBarItems=
  [
  const BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
  const BottomNavigationBarItem(icon: Icon(Icons.apps),label: 'Categories'),
  const BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Favorites'),
  const BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'),
  ];
  int currentIndex=0;

  void changeBottomNav(idx){
    currentIndex=idx;
    emit(ShopChangeBottomNavStates());
  }
Map<int,dynamic> fav={};

  void getHomeData(){
    emit(ShopLoadingStates());
    DioHelper.getData(
        url:'home',
        lang: 'en',
        token:SharedHelper.Get(key: 'token'),
    ).then((value) {
      homeModel=HomeModel.fromJson(value.data);
   //   print(homeModel!.data!.products);
      for (var element in homeModel!.data!.products) {
        fav[element.id]=element.in_favorites;
      }
      print('ffffffffffff${fav.toString()}');
      emit(ShopSuccessStates(homeModel!));
    }).catchError((onError){
     // print('Errrrrrrrrr ${onError.toString()}');
      emit(ShopErrorStates(onError.toString()));
    });
 }

  void getCategoriesData(){
   categoriesModel=null;
    emit(ShopCatLoadingStates());
    DioHelper.getData(
      url:CATEGORIES,
      lang: 'en',
    ).then((value) {
     categoriesModel=CategoriesModel.fromJson(value.data);
     print(categoriesModel!.data!.data);
      emit(ShopCategoriesSuccessStates(categoriesModel!));
    }).catchError((onError){
      print('Errrrrrrrrr ${onError.toString()}');
      emit(ShopCategoriesErrorStates(onError.toString()));
    });
  }

  ChangeFavorite? changeFavorite;
  void changeFavorites(int productId) {
    fav[productId]=!fav[productId];
    emit(ShopChangeFavoriteStates());
      DioHelper.putData(
          url: FAVORITES,
          data: {
            'product_id':productId
          },
        token: tokenAuth,
        lang: 'en'
      ).then((value){
       changeFavorite=ChangeFavorite.fromJson(value.data);
       if(changeFavorite!.status==false) {
         fav[productId]=!fav[productId];
       }
       else {
         getFavoritesData();
       }
       emit(ShopChangeFavoriteSuccessStates(changeFavorite!));
      }).catchError((onError){
        fav[productId]=!fav[productId];
        emit(ShopChangeFavoriteErrorStates(onError.toString()));
      });
  }

  late  FavoritesModel favoritesModel;
  void getFavoritesData(){
    emit(ShopFavLoadingStates());
    DioHelper.getData(
      url:FAVORITES,
      lang: 'en',
      token: SharedHelper.Get(key: 'token'),
    ).then((value) {
     favoritesModel=FavoritesModel.fromJson(value.data);
      emit(ShopFavoritesSuccessStates(favoritesModel));
    }).catchError((onError){
      emit(ShopFavoritesErrorStates(onError.toString()));
    });
  }

  SearchModel? searchModel;
  void searchProduct(String name){
    emit(ShopSearchLoadingStates());
    DioHelper.putData(
        url: SEARCH,
        data: {
          'text':name,
        },
      token: SharedHelper.Get(key: 'token'),
      lang: 'en',
    ).then((value) {
      searchModel=SearchModel.fromJson(value.data);
      emit(ShopSearchSuccessStates(searchModel!));
    }).catchError((onError){
      emit(ShopSearchErrorStates(onError.toString()));
    });
  }

  void searchReloadWithTextEmpty()
  {
    searchModel=null;
    emit(ShopSearchReloadingStates());
  }

}