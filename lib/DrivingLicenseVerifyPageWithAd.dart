// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import 'Constants/Colors.dart';
//
// class VerifyingPageWithAd extends StatefulWidget {
//   const VerifyingPageWithAd({super.key});
//
//   @override
//   State<VerifyingPageWithAd> createState() => _VerifyingPageWithAdState();
// }
//
// class _VerifyingPageWithAdState extends State<VerifyingPageWithAd> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         backgroundColor: grey,
//         body: SafeArea(
//           child: GlowingOverscrollIndicator(
//             axisDirection: AxisDirection.down,
//             color: orange,
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     height: 50.h,
//                   ),
//                   SizedBox(
//                     height: 30.w,
//                     width: 200.w,
//                     child: Text(
//                       'Please Wait...',
//                       textAlign: TextAlign.center,
//                       style: GoogleFonts.syne(
//                         fontWeight: FontWeight.w700,
//                         color: white,
//                         fontSize: 20,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10.h,
//                   ),
//                   SizedBox(
//                     width: 225.w,
//                     height: 30.h,
//                     child: Text(
//                       'Verifying Your License',
//                       textAlign: TextAlign.center,
//                       style: GoogleFonts.inter(
//                         fontWeight: FontWeight.w500,
//                         color: orange,
//                         fontSize: 20,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
