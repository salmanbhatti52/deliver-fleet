// import 'package:deliver_partner/VerifyDrivingLisecnseManually.dart';
// import 'package:deliver_partner/widgets/WarninhOnDrivingVerification.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import 'Constants/Colors.dart';
// import 'Constants/buttonContainer.dart';
//
// class DrivingLisenceVerify extends StatefulWidget {
//   const DrivingLisenceVerify({super.key});
//
//   @override
//   State<DrivingLisenceVerify> createState() => _DrivingLisenceVerifyState();
// }
//
// class _DrivingLisenceVerifyState extends State<DrivingLisenceVerify> {
//   final GlobalKey<FormState> _key = GlobalKey();
//   late TextEditingController firstNameController;
//   late TextEditingController sirNameController;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     firstNameController = TextEditingController();
//     sirNameController = TextEditingController();
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     firstNameController.dispose();
//     sirNameController.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         backgroundColor: white,
//         body: SafeArea(
//           child: GlowingOverscrollIndicator(
//             color: orange,
//             axisDirection: AxisDirection.down,
//             child: LayoutBuilder(
//               builder: (context, constraints) => SingleChildScrollView(
//                 child: Form(
//                   key: _key,
//                   child: Padding(
//                     padding:
//                         EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
//                     child: Column(
//                       children: [
//                         SizedBox(
//                           height: 20.h,
//                         ),
//                         Text(
//                           'Lets verify your Driving License!',
//                           textAlign: TextAlign.center,
//                           style: GoogleFonts.syne(
//                             fontSize: 20,
//                             fontWeight: FontWeight.w700,
//                             color: black,
//                           ),
//                         ),
//                         SizedBox(
//                           height: 50.h,
//                         ),
//                         SvgPicture.asset(
//                           'assets/images/verify-driving-pic.svg',
//                           fit: BoxFit.scaleDown,
//                           width: 265.w,
//                           height: 210.h,
//                         ),
//                         SizedBox(
//                           height: 15.h,
//                         ),
//                         Text(
//                           'Please enter your\n name given on Driving License',
//                           textAlign: TextAlign.center,
//                           style: GoogleFonts.montserrat(
//                             fontSize: 20,
//                             fontWeight: FontWeight.w500,
//                             color: black,
//                           ),
//                         ),
//                         SizedBox(
//                           height: 30.h,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Text(
//                               'First Name',
//                               style: GoogleFonts.syne(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w700,
//                                 color: black,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 10.h,
//                         ),
//                         Container(
//                           width: 300.w,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             color: mildGrey,
//                           ),
//                           child: TextFormField(
//                             cursorColor: orange,
//                             keyboardType: TextInputType.name,
//                             controller: firstNameController,
//                             style: GoogleFonts.inter(
//                               fontSize: 13,
//                               fontWeight: FontWeight.w300,
//                               color: black,
//                             ),
//                             decoration: InputDecoration(
//                               border: InputBorder.none,
//                               enabledBorder: InputBorder.none,
//                               hintText: 'Jhon Doe',
//                               hintStyle: GoogleFonts.inter(
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.w300,
//                                 color: black,
//                               ),
//                               contentPadding: EdgeInsets.only(
//                                 left: 16.w,
//                                 top: 14.h,
//                                 bottom: 16.w,
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                                 borderSide: const BorderSide(
//                                   color: orange,
//                                   width: 1.5,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 15.h,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Surname',
//                               style: GoogleFonts.syne(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w700,
//                                 color: black,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 10.h,
//                         ),
//                         Container(
//                           width: 300.w,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             color: mildGrey,
//                           ),
//                           child: TextFormField(
//                             cursorColor: orange,
//                             keyboardType: TextInputType.name,
//                             controller: sirNameController,
//                             style: GoogleFonts.inter(
//                               fontSize: 13,
//                               fontWeight: FontWeight.w300,
//                               color: black,
//                             ),
//                             decoration: InputDecoration(
//                               border: InputBorder.none,
//                               enabledBorder: InputBorder.none,
//                               hintText: 'Jhon Doe',
//                               hintStyle: GoogleFonts.inter(
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.w300,
//                                 color: black,
//                               ),
//                               contentPadding: EdgeInsets.only(
//                                 left: 16.w,
//                                 top: 14.h,
//                                 bottom: 16.w,
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                                 borderSide: const BorderSide(
//                                   color: orange,
//                                   width: 1.5,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 30.h,
//                         ),
//                         warningOfNameMatching(context),
//                         SizedBox(
//                           height: 30.h,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(
//                             bottom: 20.0,
//                           ),
//                           child: GestureDetector(
//                             // onTap: () {
//                             //   Navigator.of(context).push(
//                             //     MaterialPageRoute(
//                             //       builder: (context) => VerifyingPageWithAd(),
//                             //     ),
//                             //   );
//                             // },
//                             onTap: () => showDialog(
//                               context: context,
//                               builder: (context) =>
//                                   const VerifyDrivingLicenseManually(),
//                             ),
//                             child: buttonContainer(context, 'NEXT'),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
