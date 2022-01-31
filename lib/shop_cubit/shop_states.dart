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
class ShopSuccessChangeFavoritesState extends ShopStates{}
class ShopErrorChangeFavoritesState extends ShopStates{
  final String error;

  ShopErrorChangeFavoritesState(this.error);
}