import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/modules/login/login.dart';
import 'package:shop_app/modules/on_boaerd_screen/on_board.dart';
import 'package:shop_app/shared/components/components.dart';

class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
      Timer(const Duration(seconds: 3), (){
        navigateToWithoutReturn(context, OnBoardingScreen());
      });
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SafeArea(
            child:CircleAvatar(
              radius: 150,
              backgroundColor:Colors.indigo,
              child: Image(image:AssetImage('assets/images/logo.png'),
                width: 140,
                height: 140,
                fit: BoxFit.cover,
              ),
            )
        ),
      ),
    );
  }
}
