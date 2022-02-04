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
            leading: IconButton(onPressed: (){
              cubit.changeAppMode();
            },icon: const Icon(Icons.brightness_4_outlined),),
            title: const Text('My Shop'),
          actions: [
            IconButton(onPressed: (){
              navigateTo(context, SearchScreen());
            }, icon: const Icon(Icons.search)),
            IconButton(onPressed: (){
              signOut(context);
            }, icon: const Icon(Icons.logout)),
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
