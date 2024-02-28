// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../../Constants/Colors.dart';
//
// class RidesTabOnFleetDetails extends StatefulWidget {
//   const RidesTabOnFleetDetails({super.key});
//
//   @override
//   State<RidesTabOnFleetDetails> createState() => _RidesTabOnFleetDetailsState();
// }
//
// class _RidesTabOnFleetDetailsState extends State<RidesTabOnFleetDetails> {
//   int checked = -1;
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemBuilder: (context, index) {
//         return Column(
//           children: [
//             SizedBox(
//               height: 20.h,
//             ),
//             Container(
//               // margin: EdgeInsets.only(bottom: 10.h),
//               padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
//               width: double.infinity,
//               height: 70.h,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: lightWhite,
//               ),
//               child: GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     checked = index;
//                   });
//                 },
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         Container(
//                           width: 67.w,
//                           height: 67.h,
//                           decoration: BoxDecoration(
//                               color: orange, shape: BoxShape.circle),
//                           child: CircleAvatar(
//                             backgroundImage: AssetImage(
//                               'assets/images/sample.jpg',
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           width: 5.w,
//                         ),
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SizedBox(
//                               width: 120.w,
//                               child: AutoSizeText(
//                                 'PO 1298F',
//                                 maxLines: 2,
//                                 minFontSize: 12,
//                                 style: GoogleFonts.syne(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w700,
//                                   color: black,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 4.h,
//                             ),
//                             Text(
//                               '8MW 318d',
//                               style: GoogleFonts.inter(
//                                 fontSize: 14,
//                                 color: grey,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     checked == index
//                         ? SvgPicture.asset('assets/images/checked.svg')
//                         : SvgPicture.asset('assets/images/unchecked.svg'),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//       itemCount: 10,
//       shrinkWrap: true,
//       physics: BouncingScrollPhysics(),
//       padding: EdgeInsets.zero,
//     );
//   }
// }
