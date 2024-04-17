// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Constants/Colors.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  final TextStyle enterTextStyle;
  final Color cursorColor;
  final String hintText;
  VoidCallback? onTap;
  final InputBorder border;
  final TextStyle hintStyle;
  final InputBorder focusedBorder;
  final InputBorder enableBorder;
  final Widget? prefixIcon;
  String? autofillHints;
  final int length;
  final String? Function(String? value)? validator;
  String? Function(String? value)? onSaved;
  String? Function(String? value)? onChanged;
  bool? obscureText;
  final Widget? suffixIcon;
  bool? readOnly;
  final EdgeInsetsGeometry contentPadding;

  TextFormFieldWidget(
      {super.key,
      required this.controller,
      required this.textInputType,
      required this.enterTextStyle,
      this.readOnly,
      required this.cursorColor,
      required this.hintText,
      required this.border,
      required this.hintStyle,
      required this.focusedBorder,
      this.onSaved,
      this.onChanged,
      this.validator,
      this.onTap,
      this.autofillHints,
      required this.obscureText,
      this.suffixIcon,
      required this.contentPadding,
      required this.enableBorder,
      this.prefixIcon,
      required this.length});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      onTap: onTap,
      onChanged: onChanged,
      readOnly: readOnly ?? false,
      validator: validator,
      inputFormatters: [
        LengthLimitingTextInputFormatter(
          length,
        ),
      ],
      keyboardType: textInputType,
      controller: controller,
      style: enterTextStyle,
      cursorColor: cursorColor,
      obscureText: obscureText ?? false,
      autofillHints: [autofillHints ?? ''],
      decoration: InputDecoration(
        filled: true,
        fillColor: lightGrey,
        suffixIcon: suffixIcon,
        border: border,
        hintText: hintText,
        contentPadding: contentPadding,
        hintStyle: hintStyle,
        focusedBorder: focusedBorder,
        enabledBorder: enableBorder,
        prefixIcon: prefixIcon,
      ),
    );
  }
}
