import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shop_cubit/shop_cubit.dart';
import 'package:shop_app/shop_cubit/shop_states.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state){},
      builder: (context, state){
        var cubit = ShopCubit.get(context);
        return cubit.homeModel != null ? Column(
          children: [
            CarouselSlider(items: cubit.homeModel.data.banners.map((e) =>
                Image(
              image: NetworkImage(e.image),
              width: double.infinity,
            fit: BoxFit.cover,)).toList(),
                options: CarouselOptions(
                  scrollDirection: Axis.vertical,
                  autoPlay: true,
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  autoPlayInterval: const Duration(seconds: 3),
                  height: 350.0,
                  initialPage: 0,
                  reverse: false,
                  viewportFraction: 1.0,
                )),
          ],
        ) : const Center(child:  CircularProgressIndicator());
      },

    );
  }
}
