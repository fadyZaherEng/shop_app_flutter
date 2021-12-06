import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit, ShopStates>(
          listener: (context, state) {},
          builder: (context, state) => categoriesBuilder(context),
    );
  }

  Widget categoriesBuilder(context)
  =>Container(
    color: Colors.white,
    child: Padding(
       padding: const EdgeInsets.all(12.0),
       child: ListView.separated(
           itemBuilder: (context,index)=>buildCategoriesItem(ShopCubit.get(context).categoriesModel!.data!.data[index]),
           separatorBuilder: (context,index)=>mySeparator(context),
           itemCount: ShopCubit.get(context).categoriesModel!.data!.data.length),
     ),
  );
  buildCategoriesItem(CategoryDetails data)
  =>Padding(
    padding: const EdgeInsets.all(15.0),
    child: Row(
      children:
      [
        Image(image: NetworkImage(data.image!),
          height: 80,
          width: 100,

        ),
        const SizedBox(width: 20.0),
        Text(
          data.name!,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const Spacer(),
        const Icon(
          Icons.arrow_right,color: Colors.grey,
        ),
      ],
    ),
  );

}
