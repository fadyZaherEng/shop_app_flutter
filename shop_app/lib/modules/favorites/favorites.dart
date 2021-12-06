import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/layout/shop_layout/cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout/cubit/states.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/shared/components/components.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){
          if(state is ShopFavoritesSuccessStates)
            {
              if(state.model.status==true)
              {
                showToast(message: 'Deleted Successfully', state: ToastState.SUCCESS);
              }
            }
        },
        builder: (context,state){
          return ConditionalBuilder(
              condition:ShopCubit.get(context).favoritesModel.data!=null&&ShopCubit.get(context).favoritesModel.data!.listFavorites.isNotEmpty,// true,
              builder:(context)=>Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView.separated(
                      itemBuilder: (context,index)=>buildFavList(ShopCubit.get(context).favoritesModel.data!.listFavorites[index],context),
                      separatorBuilder: (context,index)=>const SizedBox(height: 20,),
                      itemCount: ShopCubit.get(context).favoritesModel.data!.listFavorites.length),
              ),
              fallback:(context)=> Center(
                child: Text(
                  'No Favourites Products',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color:HexColor('180040')
                  ),
                ),
              ));
         }
        );
  }
  Widget buildFavList(DataFavorite dataFavorite,context)
  =>Container(
    color: Colors.white,
    child: Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(dataFavorite.product!.image!),
              width: double.infinity,
              height: 150.0,
              fit: BoxFit.fill,
            ),
            if (dataFavorite.product!.discount! != 0)
              Container(
                color: Colors.red,
                child: const Text(
                  'DISCOUNT',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 15,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
               dataFavorite.product!.name!,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                   height: 1.5 //قرب من بعض السطرين
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              //const Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    dataFavorite.product!.price!.toString(),
                    style: const TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  if (dataFavorite.product!.discount! != 0)
                    Text(
                      dataFavorite.product!.oldPrice!.toString(),
                      style: const TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  const Spacer(),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor:ShopCubit.get(context).fav[dataFavorite.product!.id]==true?HexColor('180040'):Colors.grey[300],
                    child: IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(dataFavorite.product!.id);
                        },
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.white,
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
