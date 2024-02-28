import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

const Color green = Color(0xff0ED18F);

const Color grey = Color(0xffA3A6AA);
const Color orange = Color(0xffFF6302);
const Color black = Color(0xff0A0A0A);
const Color white = Color(0xffFFFFFF);
const Color lightGrey = Color(0xffEBEBEB);
const Color mildGrey = Color(0xffF2F0EE);
const Color lightOrange = Color(0xffFFCA27);

const Color lightWhite = Color(0xffFBF9F7);
const Color red = Color(0xffFC3636);
const LinearGradient gradient = LinearGradient(
  colors: [
    Color(0xffFBC403),
    Color(0xffFF6302),
  ],
  begin: Alignment.centerRight,
  end: Alignment.centerLeft,
);

// String formatDateTime(DateTime dateTime) {
//   DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
//   DateFormat erpFormat = DateFormat("yyyy-MM-dd");
//   DateTime date = dateFormat.parse(dateTime.toString());
//   return erpFormat.format(date);
// }

String formatDateTimeERPToString(String dateTime) {
  DateFormat dateFormat = DateFormat("yyyy-MM-ddTHH:mm:ss");
  DateFormat erpFormat = DateFormat("MM/dd/yyyy");
  DateTime date = dateFormat.parse(dateTime);
  return erpFormat.format(date);
}
