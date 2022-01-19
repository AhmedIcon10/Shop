abstract class ShopStates{}
class ShopInitialState extends ShopStates{}
class ShopChangeBottomNavBar extends ShopStates{}
class ShopHomeDataLoadingState extends ShopStates{}
class ShopHomeDataSuccessState extends ShopStates{}
class ShopHomeDataErrorState extends ShopStates{
  final String error;

  ShopHomeDataErrorState(this.error);
}
