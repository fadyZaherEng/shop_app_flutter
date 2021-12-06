import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shop_app/bloc_observer/observer.dart';
import 'package:shop_app/layout/shop_layout/shop_screen.dart';
import 'package:shop_app/modules/splash/splash.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/shared_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:sizer/sizer.dart';

import 'layout/shop_layout/cubit/cubit.dart';
import 'layout/shop_layout/cubit/states.dart';
import 'modules/login/login.dart';
import 'modules/setting/cubit/cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = SimpleBlocObserver();
  await SharedHelper.init();
  DioHelper.Init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:
      [
        BlocProvider(
          create: (context) => ShopCubit()
            ..getHomeData()
            ..getCategoriesData()
            ..getFavoritesData(),),
         BlocProvider(
           create: (context)=>SettingCubit()..getProfileData()),
      ],
        child: BlocConsumer<ShopCubit, ShopStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return OverlaySupport(
              //check the internet
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: lightTheme(),
                themeMode: ThemeMode.light,
                darkTheme: ThemeData(),
                home: Sizer(
                    builder: (context, or, dir) => Directionality(
                          textDirection: TextDirection.ltr,
                          child: choiceStartScreen(context),
                        )),
              ),
            );
          },
        ),

    );
  }

  Widget choiceStartScreen(context) {
  //  get();
   // Connectivity().onConnectivityChanged.listen(showConnectivitySnackBar);// internet
    bool? flag = SharedHelper.Get(key: 'onBoarding');
    String? token = SharedHelper.Get(key: 'token');
    if (flag == true && token != null) {
      tokenAuth = token;
      return  ShopHomeScreen();
    } else if (flag == true) {
      return LogInScreen();
    } else {
      return SplashScreen();
    }
  }
  void get()async
  {
    final result= await Connectivity().checkConnectivity();
    showConnectivitySnackBar(result);
  }

  void showConnectivitySnackBar(ConnectivityResult result)
  {
    bool hasInternet=result!=ConnectivityResult.none;
    final message=hasInternet?'You have again ${result.toString()}':'You have no Internet';
    final color=hasInternet?Colors.green:Colors.red;
    showSimpleNotification(
      const Text('Internet Connectivity Updated'),
      background: color,
      subtitle:Text(message),
    );
  }
}
