import 'package:flutter/material.dart';

Widget myTextFormField({
  required BuildContext context,
  TextEditingController? controller,
  TextInputType? inputType,
  bool obsecure = false,
  String? hint,
  Widget? label,
  Widget? icon,
  int? length,
  Color? focuscolor,
  int? lines,
  Widget? suffixIcon,
  Color? hintColor,
  InputBorder? border = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15))),
}) =>
    TextFormField(
      onEditingComplete: () => FocusScope.of(context).nextFocus(),
      controller: controller,
      keyboardType: inputType,
      obscureText: obsecure,
      maxLength: length,
      maxLines: lines,
      textDirection: TextDirection.ltr,
      decoration: InputDecoration(
        filled: true,
        fillColor: focuscolor,
        focusColor: focuscolor,
        hintStyle: TextStyle(color: hintColor),
        hintText: hint,
        suffix: suffixIcon,
        label: label,
        suffixIcon: icon,
        border: border,
        contentPadding: const EdgeInsets.only(right: 20, left: 10, bottom: 10),
      ),
      validator: (value) {
        return '$controller Must Not be Empty';
      },
    );
