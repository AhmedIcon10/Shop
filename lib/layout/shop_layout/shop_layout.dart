import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search_screen/search_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shop_cubit/shop_cubit.dart';
import 'package:shop_app/shop_cubit/shop_states.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state){},
      builder: (context, state){
        var cubit = ShopCubit.get(context);
        return  Scaffold(
          appBar: AppBar(
            title: const Text('My Shop'),
          actions: [
            IconButton(onPressed: (){
              navigateTo(context, const SearchScreen());
            }, icon: const Icon(Icons.search)),
            IconButton(onPressed: (){}, icon: const Icon(Icons.light_mode)),
          ],
          ),
          body: cubit.shopScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeNavBar(index);
            },
            items: cubit.items),
        );
      },
    );
  }
}
