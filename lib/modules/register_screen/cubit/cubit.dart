// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model/login_model.dart';
import 'package:shop_app/modules/login_screen/cubit/states.dart';
import 'package:shop_app/modules/register_screen/cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());
  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? loginModel;
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
        url: REGISTER,
        data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    }).then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);
      print(value.data);
      emit(ShopRegisterSuccessState(loginModel!));
    }).catchError((error) {
      print('Error is ${error.toString()}');
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changeVisibility() {
    isPassword= !isPassword;
    isPassword
        ? suffix = Icons.visibility_outlined
        : suffix = Icons.visibility_off_outlined;
    emit(ShopRegisterChangePasswordVisibilityState());
  }
}
