import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout/cubit/states.dart';
import 'package:shop_app/models/search_model.dart';

class SearchScreen extends StatelessWidget {
  var Controller = TextEditingController();

  var searchKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Form(
                    key: searchKey,
                    child: TextFormField(
                      controller: Controller,
                      keyboardType: TextInputType.text,
                      validator: (val){
                        if(val!.isEmpty)
                          {
                            ShopCubit.get(context).searchReloadWithTextEmpty();
                            return 'Please Enter Text Search';
                          }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search,color:  Colors.indigo,),
                        label: Text('Search'),
                        border:OutlineInputBorder(),
                      ),
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                      onChanged: (val){
                      },
                      onFieldSubmitted: (val){
                        if(searchKey.currentState!.validate())
                          {
                            ShopCubit.get(context).searchProduct(val);
                          }
                      },
                    ),
                  ),
                  SizedBox(height: 20,),
                  if(state is ShopSearchLoadingStates)
                  LinearProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo),),
                  if(state is ShopSearchSuccessStates&&state.model.data!=null)
                  Expanded(
                    child:  ListView.separated(
                        itemBuilder: (context, index) => buildSearchList(
                            ShopCubit.get(context)
                                .searchModel!
                                .data!
                                .data[index],
                            context),
                        separatorBuilder: (context, index) =>
                        const SizedBox(
                          height: 20,
                        ),
                        itemCount: ShopCubit.get(context)
                            .searchModel!
                            .data!
                            .data
                            .length),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget buildSearchList(DataProduct dataProduct, context) => Container(
        color: Colors.white,
        child: Column(
          children: [
            Image(
              image: NetworkImage(dataProduct.image!),
              width: double.infinity,
              height: 150.0,
              fit: BoxFit.fill,
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    dataProduct.name!,
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
                        dataProduct.price.toString(),
                        style: const TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                        ),
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
