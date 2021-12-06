import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/modules/login/login.dart';
import 'package:shop_app/modules/register/bloc/cubit.dart';
import 'package:shop_app/shared/network/local/shared_helper.dart';

void navigateToWithoutReturn(context,Widget screen)
=> Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (context)=>screen
      ),
          (Route<dynamic>route) => false);
void navigateToWithReturn(context,Widget screen)
=> Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context)=>screen
    ));

Widget defaultTextForm({
  required TextEditingController Controller,
  Widget? suffixIcon,
  required Widget prefixIcon,
  required String text,
  required FormFieldValidator validate,
  bool obscure=false,
  required Function onSubmitted,
  required Function onChanged,
  required TextInputType type,
})
=> TextFormField(
controller: Controller,
decoration: InputDecoration(
prefixIcon: prefixIcon,
suffixIcon: suffixIcon,
label: Text(text),
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(10),
),
),
style: const TextStyle(
fontWeight: FontWeight.bold,
fontSize: 20.0,
),
validator: validate,
obscureText:obscure ,
keyboardType: type,
onFieldSubmitted:onSubmitted(),
);

enum ToastState {SUCCESS,ERROR,WARNING}
Future<bool?> showToast({
 required String message,
 required ToastState state,
})
=> Fluttertoast.showToast(
msg:message,
gravity: ToastGravity.BOTTOM,
textColor: Colors.white,
toastLength: Toast.LENGTH_LONG,
timeInSecForIosWeb: 5,
backgroundColor: chooseToastColor(state),
);

Color chooseToastColor(ToastState state)
{
  late Color color;
  switch(state){
    case ToastState.SUCCESS:
      color=HexColor('180040');
      break;
    case ToastState.ERROR:
      color=Colors.red;
      break;
    case ToastState.WARNING:
      color=Colors.amber;
      break;
  }
  return color;
}

void SignUp({
  required context,
})
=>IconButton(onPressed: ()
{
  SharedHelper.Remove(key: 'token').then((value){
    print(value);
    navigateToWithoutReturn(context,LogInScreen());
    showToast(message: 'Log Out Successfully',
        state: ToastState.SUCCESS);
  }).catchError((error){
    print(error.toString());
  });
},
    icon: Icon(Icons.assignment_return_rounded));

Widget mySeparator(context)
    =>Container(
      color: HexColor('180040'),
      width: double.infinity,
      height: 2,
    );