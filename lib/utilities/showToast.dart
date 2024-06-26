import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

Color filledColor = const Color(0xFFF2F0EE);
Color redColor = Colors.red;
Color hintColor = const Color(0xFF191919).withOpacity(0.5);
Color blackColor = const Color(0xFF000000);
Color transparentColor = Colors.transparent;
Color orangeColor = const Color(0xFFFF6302);

void showToastSuccess(
  String? msg,
  FToast fToast, {
  Color toastColor = Colors.white,
  int seconds = 4,
}) {
  final Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15.0),
      gradient: const LinearGradient(
        colors: [
          Color(0xffFF6302),
          Color(0xffFBC403),
        ],
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
      ),
    ),
    child: Text(
      msg ?? '',
      textAlign: TextAlign.center,
      style: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
    ),
  );

  fToast.showToast(
    child: toast,
    gravity: ToastGravity.CENTER,
    toastDuration: Duration(seconds: seconds),
  );
}

void showToastError(
  String? msg,
  FToast fToast, {
  Color toastColor = Colors.white,
  int seconds = 2,
  double fontSize = 16.0,
}) {
  final Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.red),
      borderRadius: BorderRadius.circular(15.0),
      gradient: LinearGradient(
        colors: [
          Colors.red.withOpacity(0.75),
          Colors.orange.withOpacity(0.75),
        ],
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
      ),
    ),
    child: Text(
      msg ?? '',
      textAlign: TextAlign.center,
      style: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
    ),
  );

  fToast.showToast(
    child: toast,
    gravity: ToastGravity.CENTER,
    toastDuration: Duration(seconds: seconds),
  );
}

class CustomToast {
  static void showToast({
    required String message,
    double fontSize = 12,
  }) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        fontSize: fontSize,
        textColor: Colors.white,
        backgroundColor: Colors.orange,
        webPosition: "top");
  }
}
