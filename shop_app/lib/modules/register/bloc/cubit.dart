import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/models/register_model.dart';
import 'package:shop_app/modules/register/bloc/states.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopAppRegisterCubit extends Cubit<ShopAppRegisterStates>
{
  ShopAppRegisterCubit() : super(ShopAppRegisterInitialStates());

  static ShopAppRegisterCubit get(context)=>BlocProvider.of(context);

  Icon suffixIcon=const Icon(Icons.visibility_outlined,color: Colors.indigo,);
  bool obscure=true;
  void changeVisibilityOfEye(){
    obscure=!obscure;
    if(obscure){
      suffixIcon=Icon(Icons.remove_red_eye,color: Colors.indigo,);
    }else{
      suffixIcon=Icon(Icons.visibility_off_outlined,color: Colors.indigo,);
    }
    emit(ShopAppRegisterChangeEyeStates());
  }
  var passwordController=TextEditingController();
  var emailController=TextEditingController();
  var nameController=TextEditingController();
  var phoneController=TextEditingController();

  RegisterModel? registerModel;
  void signUp(){
    emit(ShopAppRegisterLoadingStates());
    print('xxxxxxxxxxxxxxxxxxxx ${resImage!.path.toString()}');
    DioHelper.putData(
        url: 'register', data: {
      'name':nameController.text,
      'email':emailController.text,
      'password':passwordController.text,
      'phone':phoneController.text,
      'image':resImage!.path.toString(),
    }).then((value) {
      registerModel=RegisterModel.fromJson(value.data);
      emit(ShopAppRegisterSuccessStates(registerModel!));
    }).catchError((onError){
      print(onError);
    });
  }

  XFile? resImage;
  dynamic defaultImage =const AssetImage('assets/images/user.png');

  void changeImage()
  {
    defaultImage=null;
    emit(ShopAppRegisterChangeImageStates());
  }
}