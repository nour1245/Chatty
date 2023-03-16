import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget DefultButtn({
  var height = 50.0,
  var color = Colors.blue,
  var width = double.infinity,
  required String text,
  required Function function,
  var fontweight = FontWeight.bold,
  bool isUperCase = true,
}) =>
    Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUperCase ? text.toUpperCase() : text,
          style: TextStyle(
            fontWeight: fontweight,
          ),
        ),
      ),
    );

Widget DefultTFF({
  required TextEditingController controrller,
  required String label,
  required IconData prefix,
  required TextInputType keyboardtype,
  required Function validate,
  bool isPassword = false,
  IconData? suffix,
  Function? ontap,
  Function? onchange,
  Function? onfield,
  Function? onsubmit,
  Function? suffixpresed,
  isclickable = true,
  var style,
}) =>
    TextFormField(
      style: style,
      enabled: isclickable,
      onChanged: onchange != null
          ? (value) {
              onchange(value);
            }
          : null,
      onTap: ontap != null
          ? () {
              ontap();
            }
          : null,
      onFieldSubmitted: onsubmit != null ? (value) => onsubmit() : null,
      obscureText: isPassword,
      controller: controrller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(suffix),
                onPressed: () {
                  suffixpresed!();
                },
              )
            : null,
      ),
      keyboardType: keyboardtype,
      validator: (value) {
        return validate(value);
      },
    );

void navigatTO(context, Widget) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Widget,
    ),
  );
}

void navigatAndReplace(context, Widget) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => Widget,
      ),
      (route) => false);
}

void showToast({
  required msg,
  required color,
}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0);
}
