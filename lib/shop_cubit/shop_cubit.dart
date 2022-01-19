// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/home_model/home_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favourites_screen/favorites_screen.dart';
import 'package:shop_app/modules/products_screen/products_screen.dart';
import 'package:shop_app/modules/settings_screen/settings_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shop_cubit/shop_states.dart';

class ShopCubit extends Cubit<ShopStates>
{
  ShopCubit() : super(ShopInitialState());
  static ShopCubit get(context)=> BlocProvider.of(context);
  int currentIndex = 0;
  List <Widget> shopScreens = const[
     ProductsScreen(),
     CategoriesScreen(),
     FavoritesScreen(),
     SettingsScreen(),

  ];
  List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Products'),
    BottomNavigationBarItem(
        icon: Icon(Icons.category),
        label: 'Categories'),
    BottomNavigationBarItem(
        icon: Icon(Icons.favorite),
        label: 'Favorites'),
    BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: 'Settings'),
  ];
  late HomeModel homeModel;
  void changeNavBar(index){
    currentIndex = index;
    emit(ShopChangeBottomNavBar());
  }
  void getHomeData(){
      DioHelper.getData(url: home,
    token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      printAllMessage(homeModel.data.banners[0].toString());
      emit(ShopHomeDataSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(ShopHomeDataErrorState(error.toString()));
    });
  }

}// end of ShopCubit class