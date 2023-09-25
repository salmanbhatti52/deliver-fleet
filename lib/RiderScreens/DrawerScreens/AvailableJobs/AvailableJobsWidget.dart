// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../../Constants/Colors.dart';
// import '../../Constants/SeeDetailsOnCompletedRidesButton.dart';
// import 'FleetDetailes.dart';
//
// class AvailableJobsWidget extends StatefulWidget {
//   const AvailableJobsWidget({super.key});
//
//   @override
//   State<AvailableJobsWidget> createState() => _AvailableJobsWidgetState();
// }
//
// class _AvailableJobsWidgetState extends State<AvailableJobsWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 20.h),
//       padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
//       width: double.infinity,
//       height: 120.h,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: lightWhite,
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           GestureDetector(
//             onTap: () {
//               setState(() {});
//             },
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     Container(
//                       width: 67.w,
//                       height: 67.h,
//                       decoration: BoxDecoration(
//                         color: orange,
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(15),
//                         child: Image.asset(
//                           'assets/images/sample.jpg',
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 5.w,
//                     ),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                           width: 120.w,
//                           child: AutoSizeText(
//                             'Fleet Manger',
//                             maxLines: 2,
//                             minFontSize: 12,
//                             style: GoogleFonts.syne(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w700,
//                               color: black,
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 2.h,
//                         ),
//                         Row(
//                           children: [
//                             SvgPicture.asset('assets/images/location.svg'),
//                             Text(
//                               'Poland',
//                               style: GoogleFonts.inter(
//                                 fontSize: 11,
//                                 color: grey,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 5.h,
//                         ),
//                         Row(
//                           children: [
//                             SvgPicture.asset('assets/images/email-icon.svg'),
//                             SizedBox(
//                               width: 4.w,
//                             ),
//                             SizedBox(
//                               width: 140.w,
//                               child: AutoSizeText(
//                                 maxLines: 2,
//                                 minFontSize: 10,
//                                 'example@gmail.com ',
//                                 style: GoogleFonts.inter(
//                                   fontSize: 11,
//                                   color: grey,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 Expanded(
//                   child: GestureDetector(
//                     onTap: () {
//                       Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (context) => FleetDetailes(),
//                         ),
//                       );
//                     },
//                     child: SeeDetailsOnCompletedRidesButton(context),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Text(
//             '${45} rides on the go',
//             style: GoogleFonts.inter(
//               fontSize: 13,
//               fontWeight: FontWeight.w400,
//               color: grey,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
