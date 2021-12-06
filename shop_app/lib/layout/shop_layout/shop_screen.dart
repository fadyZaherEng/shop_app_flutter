import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/layout/shop_layout/cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout/cubit/states.dart';
import 'package:shop_app/modules/search/search.dart';
import 'package:shop_app/shared/components/components.dart';

class ShopHomeScreen extends StatelessWidget {
  const ShopHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: const Text(
              'Souq',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            actions:
            [
              IconButton(onPressed: (){
                navigateToWithReturn(context, SearchScreen());
              },icon: const Icon(Icons.search,color: Colors.indigo,size: 30,)),
            ],
          ),
          body: ShopCubit.get(context).listShop[ShopCubit.get(context).currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items:ShopCubit.get(context).listBarItems,
            type:BottomNavigationBarType.fixed,
            currentIndex: ShopCubit.get(context).currentIndex,
            onTap: (idx){
              ShopCubit.get(context).changeBottomNav(idx);
            },
            selectedItemColor: HexColor('180040'),
          ),
        );
      },
    );
  }
}
