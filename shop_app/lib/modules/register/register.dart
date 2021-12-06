import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/layout/shop_layout/shop_screen.dart';
import 'package:shop_app/modules/login/login.dart';
import 'package:shop_app/modules/register/bloc/cubit.dart';
import 'package:shop_app/modules/register/bloc/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/shared_helper.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopAppRegisterCubit(),
      child: BlocConsumer<ShopAppRegisterCubit, ShopAppRegisterStates>(
        listener: (context, state) {
          if (state is ShopAppRegisterSuccessStates) {
            if (state.registerModel.status == true) {
              showToast(
                  message: state.registerModel.message!,
                  state: ToastState.SUCCESS);
              SharedHelper.Save(
                      value: state.registerModel.data!.token, key: 'token')
                  .then((value) {
                tokenAuth = state.registerModel.data!.token;
                navigateToWithoutReturn(context, ShopHomeScreen());
              }).catchError((error) => print(error.toString()));
            } else {
              showToast(
                  message: state.registerModel.message!,
                  state: ToastState.ERROR);
            }
          }
          if (state is ShopAppRegisterErrorStates) {
            showToast(message: state.error, state: ToastState.ERROR);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            var image = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            ShopAppRegisterCubit.get(context).resImage = image;
                            ShopAppRegisterCubit.get(context).changeImage();
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 55.0,
                            backgroundImage:
                                ShopAppRegisterCubit.get(context).defaultImage,
                            child: ShopAppRegisterCubit.get(context).resImage ==
                                    null
                                ? null
                                : Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(

                                borderRadius: BorderRadius.all(Radius.circular(55)),
                              ),
                                  child: Image.file(File(
                                      ShopAppRegisterCubit.get(context)
                                          .resImage!
                                          .path),width: 110,height: 110,fit: BoxFit.cover,),
                                ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        defaultTextForm(
                            onChanged: () {},
                            type: TextInputType.text,
                            Controller: ShopAppRegisterCubit.get(context)
                                .nameController,
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
                            onSubmitted: () {}),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultTextForm(
                            onChanged: () {},
                            type: TextInputType.emailAddress,
                            Controller: ShopAppRegisterCubit.get(context)
                                .emailController,
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
                            onSubmitted: () {}),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultTextForm(
                            onChanged: () {},
                            type: TextInputType.phone,
                            Controller: ShopAppRegisterCubit.get(context)
                                .phoneController,
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
                            onSubmitted: () {}),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultTextForm(
                          onChanged: () {},
                          type: TextInputType.visiblePassword,
                          Controller: ShopAppRegisterCubit.get(context)
                              .passwordController,
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.indigo,
                          ),
                          text: 'Password',
                          validate: (val) {
                            if (val.toString().isEmpty) {
                              return 'Password is Very Short';
                            }
                          },
                          obscure: ShopAppRegisterCubit.get(context).obscure,
                          onSubmitted: () {},
                          suffixIcon: IconButton(
                              onPressed: () {
                                ShopAppRegisterCubit.get(context)
                                    .changeVisibilityOfEye();
                              },
                              icon:
                                  ShopAppRegisterCubit.get(context).suffixIcon),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        MaterialButton(
                          height: 50,
                          minWidth: double.infinity,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              if (ShopAppRegisterCubit.get(context).resImage !=
                                  null) {
                                ShopAppRegisterCubit.get(context).signUp();
                              } else {
                                showToast(
                                    message: 'Please Entre Your Profile Image',
                                    state: ToastState.WARNING);
                              }
                              //register

                            }
                          },
                          color:HexColor('180040'),
                          child: const Text(
                            'REGISTER NOW',
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
            ),
          );
        },
      ),
    );
  }
}
