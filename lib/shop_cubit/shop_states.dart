import 'package:shop_app/models/change_favorites_model/change_favorites_model.dart';
import 'package:shop_app/models/login_model/login_model.dart';

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

class ShopLoadingGetFavoritesState extends ShopStates{}
class GetFavoritesSuccessState extends ShopStates{}
class GetFavoritesErrorState extends ShopStates{
  final String error;
  GetFavoritesErrorState(this.error);
}

class ShopLoadingUserDataState extends ShopStates{}
class ShopSuccessUserDataState extends ShopStates{
  final ShopLoginModel loginModel;

  ShopSuccessUserDataState(this.loginModel);
}
class ShopErrorUserDataState extends ShopStates{
  final String error;
  ShopErrorUserDataState(this.error);
}
class ShopLoadingUpdateDataState extends ShopStates{}
class ShopSuccessUpdateDataState extends ShopStates{
  final ShopLoginModel loginModel;

  ShopSuccessUpdateDataState(this.loginModel);
}
class ShopErrorUpdateDataState extends ShopStates{
  final String error;
  ShopErrorUpdateDataState(this.error);
}
