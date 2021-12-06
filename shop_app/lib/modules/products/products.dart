import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/layout/shop_layout/cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/shared_helper.dart';

class ProductsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state){
          if(state is ShopChangeFavoriteSuccessStates)
          {
            if(state.model.status!)
              {
                showToast(message: state.model.message!, state: ToastState.SUCCESS );
              }
            else
              {
                showToast(message: state.model.message!, state: ToastState.ERROR);

              }
          }
          if(state is ShopChangeFavoriteErrorStates)
            {
              if(state is ShopChangeFavoriteErrorStates)
                {
                  showToast(message: state.error, state: ToastState.ERROR );
                }
            }
        }
    , builder: (context, state) {
      return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel!=null&&ShopCubit.get(context).categoriesModel!=null,
          builder: (context) => buildProductItem(ShopCubit.get(context).homeModel!,
              ShopCubit.get(context).categoriesModel!,context),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo),
            ),
          ));
    });
  }

  Widget buildProductItem(HomeModel model, CategoriesModel categoriesModel,context)
  => SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                items: model.data!.banners
                    .map((e) => Image(
                          //note
                          image: NetworkImage(e.image),
                          width: double.infinity,
                          fit: BoxFit.fill,
                          //height: 250, هحطه تحت في ارتفاع ال سليدر
                        ))
                    .toList(),
                options: CarouselOptions(
                    height: 200.0,
                    //الارتفاع
                    initialPage: 0,
                    //الصفحه الابتدائيه
                    enableInfiniteScroll: true,
                    //انه يفضل يلف حوالين نفسه
                    reverse: false,
                    //انه لما اروح لمكان ميعكس ويرجعني تاني ليه
                    autoPlay: true,
                    //مش عارف
                    autoPlayInterval: const Duration(seconds: 3),
                    //هيلف كل مده اد اي
                    autoPlayAnimationDuration: const Duration(seconds: 3),
                    //وهوبيلف ال انيميشن ياخد وقت اد اي
                    autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                    //شكله
                    scrollDirection: Axis.horizontal,
                    //يتحرك افقي
                    viewportFraction:
                        1.0 //عشان ياخد الصفحه كامله ميعرضش اتنين في نفس الصفحه
                    ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Categories',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.indigo,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 120.0,
                child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context,index)=>buildItemCat(categoriesModel.data!.data[index]),
                    separatorBuilder: (context,index)=>const SizedBox(width: 10,),
                    itemCount: categoriesModel.data!.data.length),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Products',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.indigo,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.grey[300],
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 1.5,
                  crossAxisSpacing: 1.5,
                  crossAxisCount: 2,
                  children: List.generate(
                      model.data!.products.length,
                      (index) =>
                          buildGridViewProducts(model.data!.products[index],context)),
                  childAspectRatio: 1 / 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );


  Widget buildGridViewProducts(ProductModel product,context)
  =>Container(
    color: Colors.white,
    child: Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(product.image!),
              width: double.infinity,
              height: 150.0,
            ),
            if (product.discount != 0)
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
        const SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Text(
                product.name!,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  // height: 1.3 //قرب من بعض السطرين
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              //const Spacer(),
              SizedBox(height: 7,),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    product.price.toString(),
                    style: const TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  if (product.discount != 0)
                    Text(
                      product.oldPrice.toString(),
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  const Spacer(),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor:ShopCubit.get(context).fav[product.id]==true?HexColor('180040'):Colors.grey[300],
                    child: IconButton(
                        onPressed: () {
                          print(product.id);
                          print(SharedHelper.Get(key: 'token'));
                          ShopCubit.get(context).changeFavorites(product.id);
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
  buildItemCat(CategoryDetails data)
  =>Stack(
    alignment: AlignmentDirectional.bottomStart,
    children: [
      Image(
        image: NetworkImage(
            data.image!),
        height: 120,
        width: 120,
        fit: BoxFit.cover,
      ),
      Container(
        width: 120,
        color: Colors.indigo.withOpacity(0.7),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Text(
            data.name!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
              color: Colors.white,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ),
    ],
  );
}
