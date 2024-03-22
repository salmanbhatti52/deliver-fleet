// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get_it/get_it.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../../Constants/Colors.dart';
// import '../../Constants/PageLoadingKits.dart';
// import '../../Constants/back-arrow-with-container.dart';
// import '../../models/API_models/API_response.dart';
// import '../../models/API_models/GetAllSupportMessagesModel.dart';
// import '../../services/API_services.dart';
// import '../../utilities/showToast.dart';
//
// class ContactSupport extends StatefulWidget {
//   final String adminPicture;
//   final String adminID;
//   final String userID;
//   final String adminName;
//   final String adminAddress;
//   const ContactSupport(
//       {super.key,
//       required this.adminPicture,
//       required this.adminName,
//       required this.adminAddress,
//       required this.adminID,
//       required this.userID});
//
//   @override
//   State<ContactSupport> createState() => _ContactSupportState();
// }
//
// class _ContactSupportState extends State<ContactSupport> {
//   ApiServices get service => GetIt.I<ApiServices>();
//
//   late TextEditingController sendMessageController;
//
//   // Timer? getMessageTimer;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     init();
//     // getMessageTimer = Timer.periodic(Duration(seconds: 10), (Timer t) {
//     //   print('object api after 5 sec runs successfully');
//     //   return init();
//     // });
//   }
//
//   bool isLoading = false;
//   late APIResponse<List<GetAllSupportMessagesModel>>
//       getAllSupportMessagesResponse;
//   late List<GetAllSupportMessagesModel> getAllSupportMessagesList;
//
//   init() async {
//     setState(() {
//       isLoading = true;
//     });
//
//     sendMessageController = TextEditingController();
//
//     Map data = {
//       "request_type": "getMessages",
//       "users_type": "Rider",
//       "other_users_type": "Admin",
//       "users_id": widget.userID.toString(),
//       "other_users_id": widget.adminID.toString(),
//     };
//     print('object get all msgs:   ' + data.toString());
//     print('adminID ${widget.adminID.toString()}');
//     getAllSupportMessagesList = [];
//     getAllSupportMessagesResponse = await service.getAllSupportMessages(data);
//     if (getAllSupportMessagesResponse.data != null) {
//       print('object getting all msgs:   ' +
//           getAllSupportMessagesResponse.data.toString());
//       getAllSupportMessagesList.addAll(getAllSupportMessagesResponse.data!);
//     }
//     setState(() {
//       isLoading = false;
//     });
//   }
//
//   @override
//   void dispose() {
//     // getMessageTimer?.cancel();
//     super.dispose();
//     sendMessageController.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: white,
//       appBar: AppBar(
//         elevation: 0.0,
//         backgroundColor: Colors.white,
//         leadingWidth: 70,
//         centerTitle: true,
//         title: Text(
//           'Contact Support',
//           style: GoogleFonts.syne(
//             fontWeight: FontWeight.w700,
//             color: black,
//             fontSize: 20,
//           ),
//         ),
//         // actions: [
//         //   Padding(
//         //     padding: EdgeInsets.only(top: 8.h, right: 20.w),
//         //     child: GestureDetector(
//         //       onTap: () => init(),
//         //       child: const Icon(
//         //         Icons.refresh_rounded,
//         //         color: orange,
//         //         size: 28,
//         //       ),
//         //     ),
//         //   )
//         // ],
//         leading: Padding(
//           padding: const EdgeInsets.only(top: 8.0, left: 20),
//           child: GestureDetector(
//             onTap: () => Navigator.of(context).pop(),
//             child: backArrowWithContainer(context),
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 12.0.w),
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 20.h,
//               ),
//               SizedBox(
//                 width: double.infinity,
//                 height: 50.h,
//                 child: Row(
//                   children: [
//                     Stack(
//                       alignment: Alignment.topRight,
//                       clipBehavior: Clip.none,
//                       children: [
//                         Container(
//                           width: 50.w,
//                           height: 50.h,
//                           decoration: const BoxDecoration(
//                             // color: orange,
//                             shape: BoxShape.circle,
//                           ),
//                           child: ClipRRect(
//                               borderRadius: BorderRadius.circular(25),
//                               child: Image.network(
//                                 'https://deliver.eigix.net/public/${widget.adminPicture}',
//                                 fit: BoxFit.cover,
//                                 errorBuilder: (BuildContext context,
//                                     Object exception, StackTrace? stackTrace) {
//                                   return SizedBox(
//                                     child: Image.asset(
//                                       'assets/images/place-holder.png',
//                                       fit: BoxFit.scaleDown,
//                                     ),
//                                   );
//                                 },
//                                 loadingBuilder: (BuildContext context,
//                                     Widget child,
//                                     ImageChunkEvent? loadingProgress) {
//                                   if (loadingProgress == null) {
//                                     return child;
//                                   }
//                                   return Center(
//                                     child: CircularProgressIndicator(
//                                       color: orange,
//                                       value:
//                                           loadingProgress.expectedTotalBytes !=
//                                                   null
//                                               ? loadingProgress
//                                                       .cumulativeBytesLoaded /
//                                                   loadingProgress
//                                                       .expectedTotalBytes!
//                                               : null,
//                                     ),
//                                   );
//                                 },
//                               )),
//                         ),
//                         Positioned(
//                           right: 2,
//                           child: Container(
//                             width: 10.w,
//                             height: 10.h,
//                             decoration: const BoxDecoration(
//                                 color: Colors.green, shape: BoxShape.circle),
//                           ),
//                         )
//                       ],
//                     ),
//                     SizedBox(
//                       width: 7.w,
//                     ),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                           width: 200.w,
//                           child: Text(
//                             maxLines: 1,
//                             softWrap: true,
//                             overflow: TextOverflow.ellipsis,
//                             widget.adminName,
//                             style: GoogleFonts.inter(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500,
//                               color: black,
//                             ).copyWith(
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                         ),
//                         Row(
//                           children: [
//                             SvgPicture.asset('assets/images/location.svg'),
//                             SizedBox(
//                               width: 2.w,
//                             ),
//                             SizedBox(
//                               width: 150.w,
//                               child: Text(
//                                 widget.adminAddress,
//                                 overflow: TextOverflow.ellipsis,
//                                 softWrap: true,
//                                 maxLines: 1,
//                                 style: GoogleFonts.inter(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w400,
//                                   color: grey,
//                                 ).copyWith(overflow: TextOverflow.ellipsis),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 30.h,
//               ),
//               Expanded(
//                 child: isLoading
//                     ? spinKitRotatingCircle
//                     : ListView.builder(
//                         itemCount: getAllSupportMessagesList.length,
//                         shrinkWrap: true,
//                         physics: const BouncingScrollPhysics(),
//                         padding: EdgeInsets.zero,
//                         itemBuilder: (context, index) {
//                           bool isAdmin = getAllSupportMessagesList[index]
//                                   .user_data!
//                                   .users_system_roles_id !=
//                               -1;
//                           return isAdmin
//                               ? Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Container(
//                                       width: 50.w,
//                                       height: 50.h,
//                                       decoration: const BoxDecoration(
//                                         // color: orange,
//                                         shape: BoxShape.circle,
//                                       ),
//                                       child: ClipRRect(
//                                           borderRadius:
//                                               BorderRadius.circular(25),
//                                           child: Image.network(
//                                             'https://deliver.eigix.net/public/${widget.adminPicture}',
//                                             fit: BoxFit.cover,
//                                             errorBuilder: (BuildContext context,
//                                                 Object exception,
//                                                 StackTrace? stackTrace) {
//                                               return SizedBox(
//                                                 child: Image.asset(
//                                                   'assets/images/place-holder.png',
//                                                   fit: BoxFit.scaleDown,
//                                                 ),
//                                               );
//                                             },
//                                             loadingBuilder:
//                                                 (BuildContext context,
//                                                     Widget child,
//                                                     ImageChunkEvent?
//                                                         loadingProgress) {
//                                               if (loadingProgress == null) {
//                                                 return child;
//                                               }
//                                               return Center(
//                                                 child:
//                                                     CircularProgressIndicator(
//                                                   color: orange,
//                                                   value: loadingProgress
//                                                               .expectedTotalBytes !=
//                                                           null
//                                                       ? loadingProgress
//                                                               .cumulativeBytesLoaded /
//                                                           loadingProgress
//                                                               .expectedTotalBytes!
//                                                       : null,
//                                                 ),
//                                               );
//                                             },
//                                           )),
//                                     ),
//                                     SizedBox(
//                                       width: 5.w,
//                                     ),
//                                     Expanded(
//                                       child: Container(
//                                         // height: double.parse(
//                                         //     '${messagesList![index].message!.length}'),
//                                         width: double.infinity,
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 12, vertical: 12),
//                                         margin: const EdgeInsets.only(
//                                             bottom: 10, right: 40),
//                                         decoration: const BoxDecoration(
//                                           color: lightGrey,
//                                           borderRadius: BorderRadius.only(
//                                             bottomLeft: Radius.circular(15),
//                                             bottomRight: Radius.circular(15),
//                                             topRight: Radius.circular(15),
//                                           ),
//                                         ),
//                                         alignment: isAdmin
//                                             ? Alignment.centerLeft
//                                             : Alignment.centerRight,
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           // crossAxisAlignment:
//                                           //     CrossAxisAlignment.start,
//                                           children: [
//                                             Align(
//                                               alignment: Alignment.topLeft,
//                                               child: Text(
//                                                 getAllSupportMessagesList[index]
//                                                     .message!,
//                                                 softWrap: true,
//                                                 overflow: TextOverflow.ellipsis,
//                                                 maxLines:
//                                                     getAllSupportMessagesList[
//                                                             index]
//                                                         .message!
//                                                         .length,
//                                                 textAlign: TextAlign.start,
//                                                 style: GoogleFonts.inter(
//                                                   fontSize: 14,
//                                                   fontWeight: FontWeight.w400,
//                                                   color: black,
//                                                 ).copyWith(
//                                                     overflow:
//                                                         TextOverflow.ellipsis),
//                                               ),
//                                             ),
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.end,
//                                               children: [
//                                                 SvgPicture.asset(
//                                                   'assets/images/chat-timer-grey.svg',
//                                                   colorFilter:
//                                                       const ColorFilter.mode(
//                                                           white,
//                                                           BlendMode.srcIn),
//                                                   width: 10,
//                                                   height: 10,
//                                                 ),
//                                                 const SizedBox(
//                                                   width: 5,
//                                                 ),
//                                                 Text(
//                                                   getAllSupportMessagesList[
//                                                           index]
//                                                       .send_time!,
//                                                   style: GoogleFonts.inter(
//                                                     fontSize: 11,
//                                                     fontWeight: FontWeight.w400,
//                                                     color: black,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 )
//                               : Container(
//                                   // height: 60,
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 12, vertical: 12),
//                                   margin: const EdgeInsets.only(
//                                       bottom: 10, left: 90),
//                                   decoration: const BoxDecoration(
//                                     borderRadius: BorderRadius.only(
//                                       bottomLeft: Radius.circular(15),
//                                       bottomRight: Radius.circular(15),
//                                       topLeft: Radius.circular(15),
//                                     ),
//                                     color: orange,
//                                   ),
//                                   alignment: Alignment.centerLeft,
//
//                                   child: Column(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     // crossAxisAlignment:
//                                     //     CrossAxisAlignment.start,
//                                     children: [
//                                       Align(
//                                         alignment: Alignment.topLeft,
//                                         child: Text(
//                                           getAllSupportMessagesList[index]
//                                               .message!,
//                                           textAlign: TextAlign.start,
//                                           style: GoogleFonts.inter(
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w400,
//                                             color: white,
//                                           ).copyWith(
//                                               overflow: TextOverflow.ellipsis),
//                                         ),
//                                       ),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.end,
//                                         children: [
//                                           SvgPicture.asset(
//                                             'assets/images/chat-timer-grey.svg',
//                                             colorFilter: const ColorFilter.mode(
//                                                 white, BlendMode.srcIn),
//                                             width: 10,
//                                             height: 10,
//                                           ),
//                                           const SizedBox(
//                                             width: 5,
//                                           ),
//                                           Text(
//                                             getAllSupportMessagesList[index]
//                                                 .send_time!,
//                                             style: GoogleFonts.inter(
//                                               fontSize: 11,
//                                               fontWeight: FontWeight.w400,
//                                               color: white,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                         },
//                       ),
//               ),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 10),
//                 margin: EdgeInsets.only(
//                   bottom: 12.h,
//                   top: 12.h,
//                 ),
//                 // height:
//                 //     double.parse('${textEditingController.text.length}'),
//                 height: 50,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: lightGrey,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Expanded(
//                       child: Center(
//                         child: TextFormField(
//                           controller: sendMessageController,
//                           scrollPhysics: const BouncingScrollPhysics(),
//                           maxLines: 20,
//                           style: GoogleFonts.inter(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400,
//                             color: black,
//                           ),
//                           cursorColor: orange,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                             // contentPadding: EdgeInsets.zero,
//                             focusedBorder: InputBorder.none,
//                             contentPadding: EdgeInsets.symmetric(horizontal: 20),
//                             hintText: 'Write message here..',
//                             hintStyle: GoogleFonts.inter(
//                               height: 2.7,
//                               fontSize: 14,
//                               fontWeight: FontWeight.w400,
//                               color: black,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     isSending
//                         ? const CircularProgressIndicator(
//                             color: orange,
//                           )
//                         : GestureDetector(
//                             onTap: () {
//                               sendMessage(context);
//                             },
//                             child: SvgPicture.asset(
//                               'assets/images/pointer.svg',
//                               colorFilter: const ColorFilter.mode(
//                                   orange, BlendMode.srcIn),
//                               height: 40,
//                               width: 40,
//                             ),
//                           ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   bool isSending = false;
//   late APIResponse<APIResponse> sendMessageResponse;
//   sendMessage(BuildContext context) async {
//     setState(() {
//       isSending = true;
//     });
//     Map sendMessageData = {
//       "request_type": "sendMessage",
//       "users_type": "Rider",
//       "other_users_type": "Admin",
//       "users_id": widget.userID.toString(),
//       "other_users_id": widget.adminID.toString(),
//       "message_type": "text",
//       "message": sendMessageController.text,
//     };
//     sendMessageResponse = await service.sendMessageAPI(sendMessageData);
//     print('object send message:   ' + sendMessageData.toString());
//     if (sendMessageResponse.status!.toLowerCase() == 'success') {
//       init();
//     } else {
//       showToastError('Unable to send message', FToast().init(context));
//     }
//     setState(() {
//       isSending = false;
//     });
//   }
// }
