// import 'package:deliver_partner/DrawerScreens/AvailableJobs/AvailableJobsWidget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../../Constants/Colors.dart';
// import '../../Constants/back-arrow-with-container.dart';
//
// class AvailableJobs extends StatefulWidget {
//   const AvailableJobs({super.key});
//
//   @override
//   State<AvailableJobs> createState() => _AvailableJobsState();
// }
//
// class _AvailableJobsState extends State<AvailableJobs> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           elevation: 0.0,
//           backgroundColor: Colors.transparent,
//           leadingWidth: 70,
//           leading: Padding(
//             padding: const EdgeInsets.only(top: 8.0, left: 20),
//             child: GestureDetector(
//               onTap: () => Navigator.of(context).pop(),
//               child: backArrowWithContainer(context),
//             ),
//           ),
//           centerTitle: true,
//           title: Text(
//             'Available Jobs/ Fleet',
//             style: GoogleFonts.syne(
//               fontWeight: FontWeight.w700,
//               color: black,
//               fontSize: 20,
//             ),
//           ),
//         ),
//         body: SafeArea(
//           child: GlowingOverscrollIndicator(
//             axisDirection: AxisDirection.down,
//             color: orange,
//             child: SingleChildScrollView(
//               physics: BouncingScrollPhysics(),
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 20.h),
//                 child: Column(
//                   children: [
//                     ListView.builder(
//                       itemCount: 6,
//                       shrinkWrap: true,
//                       physics: BouncingScrollPhysics(),
//                       padding: EdgeInsets.zero,
//                       itemBuilder: (context, index) {
//                         return AvailableJobsWidget();
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
