// import 'package:deliver_partner/Constants/MsgContainerButton.dart';
// import 'package:deliver_partner/DrawerScreens/AvailableJobs/ContactHistoryTabOnFleetDetails.dart';
// import 'package:deliver_partner/DrawerScreens/AvailableJobs/RidesTabOnFleetDetails.dart';
// import 'package:deliver_partner/DrawerScreens/AvailableJobs/requestToJoinButton.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../../Constants/Colors.dart';
// import '../../Constants/back-arrow-with-container.dart';
// import 'detailsOfExecutiveOnFleetDetails.dart';
//
// class FleetDetailes extends StatefulWidget {
//   const FleetDetailes({super.key});
//
//   @override
//   State<FleetDetailes> createState() => _FleetDetailesState();
// }
//
// class _FleetDetailesState extends State<FleetDetailes>
//     with SingleTickerProviderStateMixin {
//   late TabController tabController;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     tabController = TabController(
//       length: 2,
//       vsync: this,
//     );
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     tabController.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           elevation: 0.0,
//           backgroundColor: Colors.white,
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
//             'Fleet Detail',
//             style: GoogleFonts.syne(
//               fontWeight: FontWeight.w700,
//               color: black,
//               fontSize: 20,
//             ),
//           ),
//           actions: [
//             Padding(
//               padding: EdgeInsets.only(
//                 right: 20.0.w,
//                 top: 8.h,
//               ),
//               child: GestureDetector(
//                 onTap: null,
//                 child: msgContainerButton(context),
//               ),
//             ),
//           ],
//         ),
//         backgroundColor: white,
//         body: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 22.0.w),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(
//                 height: 30.h,
//               ),
//               Container(
//                 width: 155.w,
//                 height: 155.h,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                   border: Border.all(
//                     width: 4.5,
//                     color: lightGrey,
//                   ),
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(15),
//                   child: Image.asset(
//                     'assets/images/sample.jpg',
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 10.h,
//               ),
//               Text(
//                 'Tim Holand',
//                 style: GoogleFonts.syne(
//                   fontWeight: FontWeight.w700,
//                   color: black,
//                   fontSize: 16,
//                 ),
//               ),
//               SizedBox(
//                 height: 10.h,
//               ),
//               Text(
//                 'Chief Executive Officer ',
//                 style: GoogleFonts.syne(
//                   fontWeight: FontWeight.w400,
//                   color: grey,
//                   fontSize: 14,
//                 ),
//               ),
//               SizedBox(
//                 height: 25.h,
//               ),
//               GestureDetector(
//                 onTap: null,
//                 child: requestToJoinButton(context, 'Request to join'),
//               ),
//               SizedBox(
//                 height: 20.h,
//               ),
//               DetailsOfExecutiveOnFleetDetails(),
//               SizedBox(
//                 height: 20.h,
//               ),
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
//                 // padding: EdgeInsets.all(6),
//                 width: double.infinity,
//                 height: 50.h,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   border: Border.all(
//                     color: lightGrey,
//                     width: 1,
//                   ),
//                   color: white,
//                 ),
//                 child: TabBar(
//                   unselectedLabelColor: black,
//                   labelColor: white,
//                   controller: tabController,
//                   indicator: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         Color(0xffFF6302),
//                         Color(0xffFBC403),
//                       ],
//                       begin: Alignment.centerRight,
//                       end: Alignment.centerLeft,
//                     ),
//                     borderRadius: BorderRadius.circular(
//                       10,
//                     ),
//                   ),
//                   tabs: [
//                     Text(
//                       'Rides',
//                       textAlign: TextAlign.center,
//                       style: GoogleFonts.syne(
//                         fontWeight: FontWeight.w400,
//                         fontSize: 14,
//                       ),
//                     ),
//                     Text(
//                       'Contact History',
//                       textAlign: TextAlign.center,
//                       style: GoogleFonts.syne(
//                         fontWeight: FontWeight.w400,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: TabBarView(
//                   controller: tabController,
//                   physics: BouncingScrollPhysics(),
//                   children: [
//                     RidesTabOnFleetDetails(),
//                     ContactHistoryTabOnFleetDetails(),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
