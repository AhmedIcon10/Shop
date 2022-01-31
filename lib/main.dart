
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/shop_layout.dart';
import 'package:shop_app/modules/login_screen/cubit/cubit.dart';
import 'package:shop_app/modules/login_screen/login_screen.dart';
import 'package:shop_app/modules/onboarding_screen/onboarding_screen.dart';
import 'package:shop_app/shared/app_themes.dart';
import 'package:shop_app/shop_cubit/shop_cubit.dart';
import 'package:shop_app/shop_cubit/shop_states.dart';

import 'shared/bloc_observer.dart';
import 'shared/network/local/cache_helper.dart';
import 'shared/network/remote/dio_helper.dart';

void main(context) async{
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
        () async{
      // Use cubits...
          await CacheHelper.init();
          DioHelper.init();
          String? token =  CacheHelper.getData(key: 'token') ;
          bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
          bool isDark = CacheHelper.getData(key: 'isDark');
          Widget widget;

          print("the token is : $token");
          if(onBoarding != null){
            if(token != null) {
              widget = const ShopLayout();
            } else{
              widget = const LoginScreen();
            }
          }else{
            widget = const OnBoardingScreen();
          }
          runApp(MyApp(onBoard: onBoarding,startWidget: widget,isDark: isDark,));

    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final bool? onBoard;
  final bool? isDark;
  final Widget? startWidget;

 const MyApp({Key? key, this.onBoard, this.startWidget, this.isDark,}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return   MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>ShopCubit()..getHomeData()..getCategories()
          ..changeAppMode(fromShared: isDark)..getFavorites()
        ),
        BlocProvider(create: (context)=>ShopLoginCubit()),
      ],
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state){},
        builder: (context, state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: startWidget,
            theme: appLightTheme,
            darkTheme: appDarkTheme,
            themeMode: ShopCubit.get(context).isDark ? ThemeMode.dark: ThemeMode.light,
          );
        },
      ),
    );
  }
}

