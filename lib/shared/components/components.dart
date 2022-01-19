// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/modules/login_screen/login_screen.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);

Widget defaultButton({
  double? width = double.infinity,
  double? height = 50.0,
  Color? background = Colors.blue,
  bool isUpperCase = false,
  required String buttonText,
  double? textSize = 24.0,
  Color? textColor = Colors.white,
  required VoidCallback onPressed,
  double radius = 5,
}) =>
    Container(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(radius),
      ),
      width: width,
      height: height,
      child: MaterialButton(
        child: Text(
          isUpperCase ? buttonText.toUpperCase() : buttonText,
          style: TextStyle(fontSize: textSize, color: textColor),
        ),
        onPressed: onPressed,
      ),
    );

Widget customFormField({
  double radius = 5.0,
  required TextEditingController controller,
  required TextInputType type,
  ValueChanged? onSubmit,
  ValueChanged? onChange,
  required FormFieldValidator validate,
  required String label,
  IconData? prefix,
  IconData? suffix,
  VoidCallback? onPressed,
  GestureTapCallback? onTap,
  bool isPassword = true,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: type,
      onChanged: onChange,
      onFieldSubmitted: onSubmit,
      onTap: onTap,
      enabled: isClickable,
      validator: validate,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: IconButton(
          icon: Icon(suffix),
          onPressed: onPressed,
        ),
      ),
    );
Widget defaultTextButton({
  required VoidCallback onPressed,
  required String text,
  Color? color
})=>TextButton(onPressed: onPressed,
child: Text(text.toUpperCase(),
style: TextStyle(
  fontWeight: FontWeight.bold,
  color: color,
),));

void showToast({
  required String text,
  required ToastsStates state

}){
Fluttertoast.showToast(
msg: text,
toastLength: Toast.LENGTH_SHORT,
gravity: ToastGravity.BOTTOM,
timeInSecForIosWeb: 5,
backgroundColor: chooseToastColor(state),
textColor: Colors.white,
fontSize: 16.0
);
}
enum ToastsStates{SUCCESS,ERROR,WARNING}
Color chooseToastColor(ToastsStates state){
  Color color;
  switch(state) {

    case ToastsStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastsStates.ERROR:
      color = Colors.red;
      break;
    case ToastsStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}
void signOut(context)=>
    CacheHelper.removeData(key: 'token').then((value) {
  if(value){
    navigateAndFinish(context, const LoginScreen());
  }
});
void printAllMessage(String text){
  final pattern = RegExp('.{1, 800}');
  pattern.allMatches(text).forEach((element) {print(element.group(0));});
}

//01000688404 mohamed nafea 3azb
