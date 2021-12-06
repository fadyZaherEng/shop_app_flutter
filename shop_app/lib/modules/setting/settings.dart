
import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shop_app/modules/login/login.dart';
import 'package:shop_app/modules/setting/cubit/cubit.dart';
import 'package:shop_app/modules/setting/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/shared_helper.dart';

class SettingsScreen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();
  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var phoneController=TextEditingController();
  var image;


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingCubit,ShopSettingStates>(
        listener: (context,state){
          if(state is ShopProfileUpdateSuccessStates)
          {
            if(state.model.status==true){
              showToast(message:'Profile Updated Successfully', state: ToastState.SUCCESS);
            }
            else
              {
                showToast(message:state.model.message!, state: ToastState.ERROR);
              }
          }
          if(state is ShopProfileUpdateErrorStates)
            {
              showToast(message:state.error, state: ToastState.ERROR);
            }
        },
        builder: (context,state){
          return  ConditionalBuilder(
            condition: SettingCubit.get(context).profileModel!=null,
            builder: (context)
            {
              if(state is !ShopProfileUpdateLoadingStates) {
                dynamic model = SettingCubit
                    .get(context)
                    .profileModel;
                nameController.text = model.data.name;
                phoneController.text = model.data.phone;
                emailController.text = model.data.email;
                image=model.data.image;
              }
              return SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children:
                        [
                          defaultTextForm(
                              onChanged: (){},
                              type: TextInputType.text,
                              Controller: nameController,
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Colors.indigo,
                              ),
                              text: 'Name',
                              validate: (val) {
                                if (val.toString().isEmpty) {
                                  return 'Please Enter Your Username';
                                }
                              },
                              onSubmitted: () {
                              }),
                          const SizedBox(
                            height: 30,
                          ),
                          defaultTextForm(
                              onChanged: (){},
                              type: TextInputType.emailAddress,
                              Controller:emailController ,
                              prefixIcon: const Icon(
                                Icons.email,
                                color: Colors.indigo,
                              ),
                              text: 'Email',
                              validate: (val) {
                                if (val.toString().isEmpty) {
                                  return 'Please Enter Your Email Address';
                                }
                              },
                              onSubmitted: () {
                              }),
                          const SizedBox(
                            height: 30,
                          ),
                          defaultTextForm(
                              onChanged: (){},
                              type: TextInputType.phone,
                              Controller: phoneController,
                              prefixIcon: const Icon(
                                Icons.phone,
                                color: Colors.indigo,
                              ),
                              text: 'Phone',
                              validate: (val) {
                                if (val.toString().isEmpty) {
                                  return 'Please Enter Your Phone';
                                }
                              },
                              onSubmitted: () {
                              }),
                          const SizedBox(
                            height: 60,
                          ),
                          MaterialButton(
                            height: 50,
                            minWidth: double.infinity,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                //update profile
                                SettingCubit.get(context).updateProfileData(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    email: emailController.text);
                              }
                            },
                            color:HexColor('180040'),
                            child: const Text(
                              'Update Profile',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          MaterialButton(
                            height: 50,
                            minWidth: double.infinity,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                //sign out
                                SharedHelper.Remove(key: 'token').then((value){
                                  navigateToWithoutReturn(context,LogInScreen());
                                  showToast(message: 'Log Out Successfully',
                                      state: ToastState.SUCCESS);
                                }).catchError((error){
                                  print(error.toString());
                                });
                              }
                            },
                            color:HexColor('180040'),
                            child: const Text(
                              'Log Out',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );},
            fallback: (context)=>const Center(child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo),
            )),
          );
        },
      );
  }
}

