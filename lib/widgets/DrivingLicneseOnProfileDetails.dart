// import 'package:deliver_partner/Constants/Colors.dart';
// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class DrivingLicneseOnProfileDetails extends StatelessWidget {
//   final String idOfDrivingLicense;
//   final String nameOfOwner;
//   final String classOfOwner;
//   final String addressOfOwner;
//   final String issueDate;
//   final String expiryDate;
//   const DrivingLicneseOnProfileDetails(
//       {super.key,
//       required this.idOfDrivingLicense,
//       required this.nameOfOwner,
//       required this.classOfOwner,
//       required this.addressOfOwner,
//       required this.issueDate,
//       required this.expiryDate});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 20.h),
//       width: 245.w,
//       height: 130.h,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: lightGrey,
//       ),
//       child: Column(
//         children: [
//           Container(
//             height: 30.h,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.vertical(
//                 top: Radius.circular(10),
//               ),
//               gradient: LinearGradient(
//                 colors: [
//                   Color(0xffFF6302),
//                   Color(0xffFBC403),
//                 ],
//                 begin: Alignment.centerRight,
//                 end: Alignment.centerLeft,
//               ),
//             ),
//             child: Center(
//               child: Text(
//                 'Driving License',
//                 style: GoogleFonts.syne(
//                   fontWeight: FontWeight.w400,
//                   fontSize: 14,
//                   color: white,
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 14.0.w, vertical: 12.h),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           width: 40.w,
//                           height: 40.h,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(5),
//                             child: Image.asset(
//                               'assets/images/sample.jpg',
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           width: 8.w,
//                         ),
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             RichText(
//                               text: TextSpan(
//                                 text: 'ID :  ',
//                                 style: GoogleFonts.inter(
//                                   fontSize: 10,
//                                   fontWeight: FontWeight.w400,
//                                   color: black,
//                                 ),
//                                 children: [
//                                   TextSpan(
//                                     text: idOfDrivingLicense,
//                                     style: GoogleFonts.inter(
//                                       fontSize: 10,
//                                       fontWeight: FontWeight.w400,
//                                       color: black,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(
//                               height: 8.h,
//                             ),
//                             SizedBox(
//                               width: 100.w,
//                               child: AutoSizeText(
//                                 nameOfOwner,
//                                 maxLines: 2,
//                                 minFontSize: 9,
//                                 style: GoogleFonts.inter(
//                                   fontSize: 10,
//                                   fontWeight: FontWeight.w400,
//                                   color: black,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     RichText(
//                       text: TextSpan(
//                         text: 'Class : ',
//                         style: GoogleFonts.inter(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w400,
//                           color: black,
//                         ),
//                         children: [
//                           TextSpan(
//                             text: classOfOwner,
//                             style: GoogleFonts.inter(
//                               fontSize: 10,
//                               fontWeight: FontWeight.w400,
//                               color: black,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 5.h,
//                 ),
//                 Text(
//                   addressOfOwner,
//                   style: GoogleFonts.inter(
//                     fontSize: 10,
//                     fontWeight: FontWeight.w400,
//                     color: black,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 5.h,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: RichText(
//                         text: TextSpan(
//                           text: 'Issued : ',
//                           style: GoogleFonts.inter(
//                             fontSize: 10,
//                             fontWeight: FontWeight.w400,
//                             color: black,
//                           ),
//                           children: [
//                             TextSpan(
//                               text: issueDate,
//                               style: GoogleFonts.inter(
//                                 fontSize: 10,
//                                 fontWeight: FontWeight.w400,
//                                 color: black,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: RichText(
//                         text: TextSpan(
//                           text: 'Expired : ',
//                           style: GoogleFonts.inter(
//                             fontSize: 10,
//                             fontWeight: FontWeight.w400,
//                             color: black,
//                           ),
//                           children: [
//                             TextSpan(
//                               text: expiryDate,
//                               style: GoogleFonts.inter(
//                                 fontSize: 10,
//                                 fontWeight: FontWeight.w400,
//                                 color: black,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
