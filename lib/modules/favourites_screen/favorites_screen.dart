import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/get_favorites_model/get_favorites_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shop_cubit/shop_cubit.dart';
import 'package:shop_app/shop_cubit/shop_states.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesState,
          builder: (context)=> ListView.separated(
              itemBuilder: (context, index) =>
                  favoritesItem(cubit.favoritesModel!.data!.data[index], context),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: cubit.favoritesModel!.data!.data.length),
          fallback:(context) => const Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }
}

Widget favoritesItem(FavoritesData model, context) => Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120.0,
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(model.productData!.image),
                    width: 120.0,
                    height: 120.0,
                    fit: BoxFit.fill,
                  ),
                  if (model.productData!.discount != 0)
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
            ),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.productData!.name,
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
                                model.productData!.price.round().toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.blue,
                                ),
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              if (model.productData!.oldPrice != 0)
                                Text(
                                  model.productData!.oldPrice
                                      .round()
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              const Spacer(),
                              IconButton(
                                onPressed: () {
                                  ShopCubit.get(context)
                                      .changeFavorites(model.productData!.id);

                                  print(model.id);
                                },
                                icon: CircleAvatar(
                                    radius: 15,
                                    backgroundColor: ShopCubit.get(context)
                                            .favorites![model.productData!.id]!
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
            ),
          ],
        ),
      ),
    );
