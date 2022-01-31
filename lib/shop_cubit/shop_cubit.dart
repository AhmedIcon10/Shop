// ignore_for_file: avoid_print


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model/categories_model.dart';
import 'package:shop_app/models/change_favorites_model/change_favorites_model.dart';
import 'package:shop_app/models/get_favorites_model/get_favorites_model.dart';
import 'package:shop_app/models/home_model/home_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favourites_screen/favorites_screen.dart';
import 'package:shop_app/modules/products_screen/products_screen.dart';
import 'package:shop_app/modules/settings_screen/settings_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
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
  String? token = CacheHelper.getData(key: 'token');
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
   HomeModel? homeModel;
  CategoriesModel? categoriesModel;
  void changeNavBar(index){
    currentIndex = index;
    emit(ShopChangeBottomNavBar());
  }
  Map<int, bool>? favorites ={};
  void getHomeData(){
      DioHelper.getData(
          url: home,
          token: token)
          .then((value) {
      homeModel = HomeModel.fromJson(value.data);
      for (var element in homeModel!.data.products) {
        favorites!.addAll({element.id : element.inFavorites});
        print(favorites.toString()); }


      printAllMessage(homeModel!.data.banners[0].toString());
      emit(ShopHomeDataSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(ShopHomeDataErrorState(error.toString()));
    });
  }
  void getCategories() {
    DioHelper.getData(url: 'categories',
        token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      printAllMessage(categoriesModel!.data.toString());
      emit(ShopHomeDataSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(ShopHomeDataErrorState(error.toString()));
    });
  }
  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int productId){
    favorites![productId] = !favorites![productId]!;
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
        url: FAVORITES,
        data: {
          'product_id': productId
        },
        token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data.toString());
      if(!changeFavoritesModel!.status!){
        favorites![productId]= !favorites![productId]!;
      }else{
        getFavorites();
      }
          emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    })
        .catchError((error){
      favorites![productId]= !favorites![productId]!;
      emit(ShopErrorChangeFavoritesState(error.toString()));
    });
  }
bool isDark = false;
  void changeAppMode({bool? fromShared}){
    if(fromShared != null){
      isDark = fromShared;
    }else{
      isDark = !isDark;
      CacheHelper.saveData(key: 'isDark', value: isDark).then((value)
      {
        emit(ChangeAppModeState());
      });}


  }
   GetFavoritesModel? favoritesModel;
  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
        url: FAVORITES,
        token: token
    ).then((value)
    {
      favoritesModel = GetFavoritesModel.fromJson(value.data);
      printAllMessage(favoritesModel!.data.toString());
      emit(GetFavoritesSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(GetFavoritesErrorState(error.toString()));
    });
  }

}// end of ShopCubit class