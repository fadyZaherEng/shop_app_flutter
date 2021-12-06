import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/profile_model.dart';
import 'package:shop_app/modules/setting/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/end_points.dart';
import 'package:shop_app/shared/network/local/shared_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class SettingCubit extends Cubit<ShopSettingStates> {
  SettingCubit() : super(ShopProfileInitialStates());

  static SettingCubit get(context) => BlocProvider.of(context);

  ProfileModel? profileModel;

  void getProfileData() {
    emit(ShopProfileLoadingStates());
    DioHelper.getData(
      url: PROFILE,
      lang: 'ar',
      token: SharedHelper.Get(key: 'token'),
    ).then((value) {
      profileModel = ProfileModel.fromJson(value.data);
      print('vvvvvvvvvvvvv ${profileModel!.data!.name}');
      emit(ShopProfileSuccessStates(profileModel!));
    }).catchError((onError) {
      print('Errrrrrrrrr ${onError.toString()}');
      emit(ShopProfileErrorStates(onError.toString()));
    });
  }
  void updateProfileData({
    required String name,
    required String phone,
    required String email,
}){
    showToast(message: 'Profile Updating wait...', state: ToastState.WARNING);
    emit(ShopProfileUpdateLoadingStates());
    DioHelper.putUserUpdateData(
      url: UPDATE_PROFILE,
      data: {
        'name':name,
        'phone':phone,
        'email':email,
      },

      token: SharedHelper.Get(key: 'token'),
      lang: 'en',
    ).then((value) {
      profileModel=ProfileModel.fromJson(value.data);
      emit(ShopProfileUpdateSuccessStates(profileModel!));
    }).catchError((onError){
      print('eeeeeeeeeeeeeeeeeeeeeee${onError.toString()}');
      emit(ShopProfileUpdateErrorStates(onError.toString()));
    });
  }
  void updateImage()
  {
    emit(ShopProfileUpdateImageStates());
  }
}