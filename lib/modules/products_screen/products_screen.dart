import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/models/categories_model/categories_model.dart';
import 'package:shop_app/models/home_model/home_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shop_cubit/shop_cubit.dart';
import 'package:shop_app/shop_cubit/shop_states.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if(state is ShopSuccessChangeFavoritesState){
          if(!state.model.status!){
            showToast(text: state.model.message!, state: ToastsStates.ERROR);
          }
        }
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(
            condition: cubit.homeModel != null && cubit.categoriesModel != null,
            builder: (context) => productsBuilder(
                cubit.homeModel, cubit.categoriesModel, context),
            fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ));
      },
    );
  }
}

Widget productsBuilder(
        HomeModel? model, CategoriesModel? categoriesModel, context) =>
    SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {},
            child: CarouselSlider(
                items: model!.data.banners
                    .map((e) => Image(
                          image: NetworkImage(e.image),
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ))
                    .toList(),
                options: CarouselOptions(
                  scrollDirection: Axis.horizontal,
                  autoPlay: true,
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  autoPlayInterval: const Duration(seconds: 3),
                  height: 180.0,
                  initialPage: 0,
                  reverse: false,
                  viewportFraction: 1.0,
                )),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(
                      fontSize: 24,
                      color: defaultColor,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  color: HexColor("#282828"),
                  height: 100.0,
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) =>
                          buildCategory(categoriesModel!.data.data[index]),
                      separatorBuilder: (context, index) => const SizedBox(
                            width: 10.0,
                          ),
                      itemCount: categoriesModel!.data.data.length),
                ),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  'New Products',
                  style: TextStyle(
                      fontSize: 24,
                      color: defaultColor,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              childAspectRatio: 1 / 1.65,
              children: List.generate(
                  model.data.products.length,
                  (index) =>
                      buildGridProduct(model.data.products[index], context)),
            ),
          ),
        ],
      ),
    );

Widget buildGridProduct(ProductModel model, context) => InkWell(
      onTap: () {},
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  width: double.infinity,
                  height: 200.0,
                ),
                if (model.discount != 0)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    color: Colors.red,
                    child: const Text(
                      'DISCOUNT',
                      style: TextStyle(
                          fontSize: 10.0, fontWeight: FontWeight.w600),
                    ),
                  ),
              ],
            ),
            Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(height: 1.3, fontSize: 14),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: Row(
                          children: [
                            Text(
                              model.price.round().toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.blue,
                              ),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            if (model.discount != 0)
                              Text(
                                model.oldPrice.round().toString(),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                ShopCubit.get(context)
                                    .changeFavorites(model.id);

                                print(model.id);
                              },
                              icon: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: ShopCubit.get(context)
                                          .favorites![model.id]!
                                      ? defaultColor
                                      : Colors.grey,
                                  child: const Icon(
                                    Icons.favorite_outline,
                                    color: Colors.white,
                                  )),
                              iconSize: 26,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
Widget buildCategory(DataModel? model) => InkWell(
      onTap: () {},
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage(model!.image),
            width: 100.0,
            height: 100.0,
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(.8),
            width: 100.0,
            child: Text(
              model.name,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
