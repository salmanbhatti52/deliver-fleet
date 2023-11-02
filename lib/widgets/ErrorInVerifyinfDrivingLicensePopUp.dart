// import 'package:deliver_partner/CongratulationsScreenDriving.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../Constants/Colors.dart';
// import '../Constants/buttonContainer.dart';
// import '../VerifyDrivingLisecnseManually.dart';
//
// class ErrorVerifyingDrivingLicense extends StatelessWidget {
//   const ErrorVerifyingDrivingLicense({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20),
//       ),
//       alignment: Alignment.center,
//       insetPadding: const EdgeInsets.symmetric(
//         horizontal: 20,
//       ),
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
//         width: 350.w,
//         height: 442.h,
//         child: Column(
//           // crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Align(
//               alignment: Alignment.topRight,
//               child: GestureDetector(
//                 // onTap: () => Navigator.of(context).pop(),
//                 onTap: () =>,
//                 child: SvgPicture.asset(
//                   'assets/images/close-circle.svg',
//                   fit: BoxFit.scaleDown,
//                 ),
//               ),
//             ),
//             SizedBox(
//               width: 186.w,
//               height: 175.h,
//               child:
//                   SvgPicture.asset('assets/images/error-pic-after-driving.svg'),
//             ),
//             SizedBox(
//               height: 20.h,
//             ),
//             Expanded(
//               child: Text(
//                 'Error',
//                 textAlign: TextAlign.center,
//                 style: GoogleFonts.syne(
//                   fontSize: 20,
//                   fontWeight: FontWeight.w700,
//                   color: orange,
//                 ),
//               ),
//             ),
//             // SizedBox(
//             //   height: 15.h,
//             // ),
//             Expanded(
//               child: Text(
//                 'Please verify your driving\n license manually.',
//                 textAlign: TextAlign.center,
//                 style: GoogleFonts.syne(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w400,
//                   color: black,
//                 ),
//               ),
//             ),
//             // SizedBox(
//             //   height: 15.h,
//             // ),
//             Expanded(
//               child: GestureDetector(
//                 onTap: () => Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => const VerifyDrivingLicenseManually(),
//                   ),
//                 ),
//                 child: buttonContainer(context, 'NEXT'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
