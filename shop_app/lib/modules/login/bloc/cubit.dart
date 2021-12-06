import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/login/bloc/states.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopAppLoginCubit extends Cubit<ShopAppLogInStates>{
  ShopAppLoginCubit() : super(ShopAppLogInInitialStates());

  static ShopAppLoginCubit get(context)=>BlocProvider.of(context);

  void LogIn({
  required String email,
  required String password,
}){
    emit(ShopAppLogInLoadingStates());
    DioHelper.putData(url: 'login', data: {
      'email':email,
      'password':password,
    }).then((value) {
      emit(ShopAppLogInSuccessStates(ShopLoginModel.fromJson(value.data)));
      print(value.data);
    }).catchError((onError){
      print('Errrrrrrrrr: $onError');
      emit(ShopAppLogInErrorStates(onError.toString()));
    });
  }
  Icon suffixIcon=const Icon(Icons.visibility_outlined,color: Colors.indigo,);
  bool obscure=true;
  void changeVisibilityOfEye(){
    obscure=!obscure;
    if(obscure){
      suffixIcon=Icon(Icons.remove_red_eye,color: Colors.indigo,);
    }else{
      suffixIcon=Icon(Icons.visibility_off_outlined,color: Colors.indigo,);
    }
    emit(ShopAppLogInChangeEyeStates());
  }


}