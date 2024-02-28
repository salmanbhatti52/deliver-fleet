import 'package:deliver_partner/Constants/Colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Constants/back-arrow-with-container.dart';
import '../../models/API models/API response.dart';
import '../../models/API models/GetAllNotificationsModel.dart';
import '../../models/API models/ReadNotificationsModel.dart';
import '../../services/API_services.dart';
import '../../utilities/showToast.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // ApiServices get service => GetIt.I<ApiServices>();

  // int userID = -1;
  // late SharedPreferences sharedPreferences;
  // bool isPageLoading = false;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   setState(() {
  //     isPageLoading = true;
  //   });
  //   init();
  // }

  // late APIResponse<List<GetAllNotificationsModel>>? getAllNotificationsResponse;
  // List<GetAllNotificationsModel>? getAllNotificationsList;

  // late APIResponse<List<ReadNotificationsModel>>? readNotificationsResponse;
  // List<ReadNotificationsModel>? readNotificationsList;

  // init() async {
  //   sharedPreferences = await SharedPreferences.getInstance();
  //   userID = (sharedPreferences.getInt('userID') ?? -1);

  //   Map data = {
  //     "users_customers_id": userID.toString(),
  //   };
  //   getAllNotificationsResponse = await service.getAllNotificationsAPI(data);
  //   getAllNotificationsList = [];

  //   if (getAllNotificationsResponse!.status!.toLowerCase() == 'success') {
  //     if (getAllNotificationsResponse!.data != null) {
  //       getAllNotificationsList!.addAll(getAllNotificationsResponse!.data!);
  //       showToastSuccess('Loading all notifications', FToast().init(context),
  //           seconds: 1);
  //     }
  //   } else {
  //     showToastError(
  //         getAllNotificationsResponse!.message, FToast().init(context));
  //   }

  //   readNotificationsResponse = await service.readNotificationsAPI(data);
  //   readNotificationsList = [];

  //   if (readNotificationsResponse!.status!.toLowerCase() == 'success') {
  //     if (readNotificationsResponse!.data != null) {
  //       readNotificationsList!.addAll(readNotificationsResponse!.data!);
  //       // showToastSuccess('Loading all notifications', FToast().init(context),
  //       //     seconds: 1);
  //     }
  //   } else {
  //     showToastError('No notification found', FToast().init(context));
  //   }
  //   setState(() {
  //     isPageLoading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leadingWidth: 70,
        leading: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 20),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: backArrowWithContainer(context),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Notification',
          style: GoogleFonts.syne(
            fontWeight: FontWeight.w700,
            color: black,
            fontSize: 20,
          ),
        ),
      ),
      // backgroundColor: lightWhite,
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 30.h),
            child: GlowingOverscrollIndicator(
              color: orange,
              axisDirection: AxisDirection.down,
              child: RefreshIndicator(
                onRefresh: onRefreshReadNotifications,
                child: ListView.builder(
                  shrinkWrap: true,
                  // physics: BouncingScrollPhysics(),
                  itemCount: 10,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 20.h),
                          width: 350.w,
                          height: 70.h,
                          decoration: BoxDecoration(
                            color: lightWhite,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: white,
                              width: 1.5,
                            ),
                          ),
                          child: ListTile(
                            // onTap: () {
                            //   getAllNotificationsList![index]
                            //               .notifications_type ==
                            //           'Requested'
                            //       ? Navigator.of(context).pushReplacement(
                            //           MaterialPageRoute(
                            //             builder: (context) =>
                            //                 RequestRideFromFleetActive(),
                            //           ),
                            //         )
                            //       : getAllNotificationsList![index]!
                            //                   .notifications_type ==
                            //               'Accepted'
                            //           ? Navigator.of(context).push(
                            //               MaterialPageRoute(
                            //                 builder: (context) =>
                            //                     BottomNavBar(),
                            //               ),
                            //             )
                            //           : Navigator.of(context).push(
                            //               MaterialPageRoute(
                            //                 builder: (context) =>
                            //                     RequestRideFromFleetActive(),
                            //               ),
                            //             );
                            // },
                            leading: SizedBox(
                              width: 50.w,
                              height: 50.h,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                // child: getAllNotificationsList![index]
                                //             .sender!
                                //             .profile_pic !=
                                //         null
                                //     ? Image.network(
                                //         'https://deliver.eigix.net/public/${getAllNotificationsList![index].sender!.profile_pic}',
                                //         fit: BoxFit.cover,
                                //         errorBuilder:
                                //             (BuildContext context,
                                //                 Object exception,
                                //                 StackTrace? stackTrace) {
                                //           return SizedBox(
                                //             child: Image.asset(
                                //               'assets/images/place-holder.png',
                                //               fit: BoxFit.cover,
                                //             ),
                                //           );
                                //         },
                                //         loadingBuilder:
                                //             (BuildContext context,
                                //                 Widget child,
                                //                 ImageChunkEvent?
                                //                     loadingProgress) {
                                //           if (loadingProgress == null) {
                                //             return child;
                                //           }
                                //           return Center(
                                //             child:
                                //                 CircularProgressIndicator(
                                //               color: orange,
                                //               value: loadingProgress
                                //                           .expectedTotalBytes !=
                                //                       null
                                //                   ? loadingProgress
                                //                           .cumulativeBytesLoaded /
                                //                       loadingProgress
                                //                           .expectedTotalBytes!
                                //                   : null,
                                //             ),
                                //           );
                                //         },
                                //       )
                                child: SvgPicture.asset(
                                    'assets/images/system-notification.svg'),
                              ),
                            ),
                            title: Text(
                              'Name',
                              style: GoogleFonts.syne(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: black,
                              ),
                            ),
                            subtitle: AutoSizeText(
                              'Message',
                              minFontSize: 12,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                color: grey,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                        // Container(
                        //   margin: EdgeInsets.only(bottom: 20.h),
                        //   width: 350.w,
                        //   height: 70.h,
                        //   decoration: BoxDecoration(
                        //     color: lightWhite,
                        //     borderRadius: BorderRadius.circular(10),
                        //     border: Border.all(
                        //       color: white,
                        //       width: 1.5,
                        //     ),
                        //   ),
                        //   child: ListTile(
                        //     leading: Container(
                        //       width: 46.w,
                        //       height: 46.h,
                        //       decoration: BoxDecoration(
                        //         color: orange,
                        //         shape: BoxShape.circle,
                        //       ),
                        //       child: SvgPicture.asset(
                        //         'assets/images/update-notification.svg',
                        //         fit: BoxFit.scaleDown,
                        //       ),
                        //     ),
                        //     title: Text(
                        //       'System',
                        //       style: GoogleFonts.syne(
                        //         fontSize: 14,
                        //         fontWeight: FontWeight.w700,
                        //         color: black,
                        //       ),
                        //     ),
                        //     subtitle: AutoSizeText(
                        //       'The notifications about the system would be shown here so that rider could see the updates and many more',
                        //       minFontSize: 12,
                        //       maxLines: 3,
                        //       overflow: TextOverflow.ellipsis,
                        //       style: GoogleFonts.inter(
                        //         color: grey,
                        //         fontWeight: FontWeight.w400,
                        //         fontSize: 12,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    );
                  },
                ),
              ),
            )),
      ),
    );
  }

  Future<void> onRefreshReadNotifications() async {
    // init();
  }
}
