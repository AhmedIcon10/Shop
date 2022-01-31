import 'package:shop_app/models/change_favorites_model/change_favorites_model.dart';

abstract class ShopStates{}
class ShopInitialState extends ShopStates{}
class ShopChangeBottomNavBar extends ShopStates{}
class ShopHomeDataLoadingState extends ShopStates{}
class ShopHomeDataSuccessState extends ShopStates{}
class ShopHomeDataErrorState extends ShopStates{
  final String error;

  ShopHomeDataErrorState(this.error);
}
class ShopSuccessCategoriesState extends ShopStates{}
class ShopErrorCategoriesState extends ShopStates{
  final String error;

  ShopErrorCategoriesState(this.error);
}
class ShopSuccessChangeFavoritesState extends ShopStates{
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesState(this.model);
}
class ShopChangeFavoritesState extends ShopStates{}
class ShopErrorChangeFavoritesState extends ShopStates{
  final String error;
  ShopErrorChangeFavoritesState(this.error);
}
class ChangeAppModeState extends ShopStates{}
class GetFavoritesSuccessState extends ShopStates{}
class ShopLoadingGetFavoritesState extends ShopStates{}
class GetFavoritesErrorState extends ShopStates{
  final String error;
  GetFavoritesErrorState(this.error);
}