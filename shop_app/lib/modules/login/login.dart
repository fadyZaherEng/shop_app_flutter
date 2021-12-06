import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/layout/shop_layout/shop_screen.dart';
import 'package:shop_app/modules/login/bloc/cubit.dart';
import 'package:shop_app/modules/login/bloc/states.dart';
import 'package:shop_app/modules/register/register.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/shared_helper.dart';

class LogInScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopAppLoginCubit(),
      child: BlocConsumer<ShopAppLoginCubit, ShopAppLogInStates>(
        listener: (context, state) {
          if (state is ShopAppLogInSuccessStates) {
            if (state.model.status) {
              showToast(
                  message: state.model.message, state: ToastState.SUCCESS);
                  SharedHelper.Save(value:state.model.data!.token , key: 'token').then((value){
                //     tokenAuth=state.model.data!.token;
                    navigateToWithoutReturn(context, ShopHomeScreen());
              }).catchError((error)=>print(error.toString()));
            } else {
              showToast(message: state.model.message, state: ToastState.ERROR);
            }
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
                    const Image(
                      image: AssetImage('assets/images/login.jpg'),
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    defaultTextForm(
                        type: TextInputType.emailAddress,
                        Controller: emailController,
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.indigo,
                        ),
                        onChanged: (){},
                        text: 'Email',
                        validate: (val) {
                          if (val.toString().isEmpty) {
                            return 'Please Enter Your Email Address';
                          }
                        },
                        onSubmitted: () {}),
                    const SizedBox(
                      height: 30,
                    ),
                    defaultTextForm(
                      onChanged: (){},
                      type: TextInputType.visiblePassword,
                      Controller: passwordController,
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.indigo,
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {
                            ShopAppLoginCubit.get(context)
                                .changeVisibilityOfEye();
                          },
                          icon: ShopAppLoginCubit.get(context).suffixIcon),
                      text: 'Password',
                      validate: (val) {
                        if (val.toString().isEmpty) {
                          return 'Password is Very Short';
                        }
                      },
                      obscure: ShopAppLoginCubit.get(context).obscure,
                      onSubmitted: () {},
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    ConditionalBuilder(
                      condition: state is! ShopAppLogInLoadingStates,
                      builder: (context) => MaterialButton(
                        height: 50,
                        minWidth: double.infinity,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            //log in
                            ShopAppLoginCubit.get(context).LogIn(
                                email: emailController.text,
                                password: passwordController.text);
                          }
                        },
                        color:HexColor('180040'),
                        child: const Text(
                          'Log In',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      fallback: (context) => const CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.indigo),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an account?',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                        ),
                        TextButton(
                          onPressed: () {
                            navigateToWithReturn(context, RegisterScreen());
                          },
                          child: Text(
                            'REGISTER',
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: HexColor('180040')),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ))),
          );
        },
      ),
    );
  }
}
