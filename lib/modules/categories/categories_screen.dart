
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model/categories_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shop_cubit/shop_cubit.dart';
import 'package:shop_app/shop_cubit/shop_states.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                categoryItem(cubit.categoriesModel!.data.data[index], context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: cubit.categoriesModel!.data.data.length);
      },
    );
  }
}

Widget categoryItem(DataModel? model, context) => InkWell(
  highlightColor: defaultColor,
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(model!.image),
              height: 90.0,
              width: 90.0,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 40.0,
            ),
            Text(
              model.name,
              style:  Theme.of(context).textTheme.bodyText1,
            ),

          ],
        ),
      ),
    );
