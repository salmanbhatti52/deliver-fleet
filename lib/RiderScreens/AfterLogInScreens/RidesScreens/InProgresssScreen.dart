import 'package:deliver_partner/Constants/Colors.dart';
import 'package:deliver_partner/Constants/PageLoadingKits.dart';
import 'package:deliver_partner/Constants/details-button.dart';
import 'package:deliver_partner/RiderScreens/AfterLogInScreens/RidesScreens/InProgressScreenDetails.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/API_models/API_response.dart';
import '../../../models/API_models/InProgressRidesModel.dart';
import '../../../services/API_services.dart';
import '../../../utilities/showToast.dart';

class InProgressScreen extends StatefulWidget {
  const InProgressScreen({
    super.key,
  });

  @override
  State<InProgressScreen> createState() => _InProgressScreenState();
}

class _InProgressScreenState extends State<InProgressScreen> {
  ApiServices get service => GetIt.I<ApiServices>();

  bool details = false;
  int selectedIndex = -1;

  int userID = -1;
  late SharedPreferences sharedPreferences;
  bool isPageLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
    isPageLoading = true;
  }

  APIResponse<List<InProgressRidesModel>>? inProgressResponse;
  List<InProgressRidesModel>? inProgressRidesList;

  // APIResponse<GetUserProfileModel>? getUserProfileResponse;
  // GetUserProfileModel? getUserProfile;
  String? imageHolder;

  init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userID = (sharedPreferences.getInt('userID') ?? -1);

    print("UserID $userID");

    Map data = {
      "users_fleet_id": userID.toString(),
    };

    // getUserProfileResponse = await service.getUserProfileAPI(data);
    // if (getUserProfileResponse!.status!.toLowerCase() == 'success') {
    //   getUserProfile = getUserProfileResponse!.data!;
    //   imageHolder = getUserProfile!.profile_pic!;
    // }

    inProgressResponse = await service.inProgressRidesAPI(data);
    inProgressRidesList = [];

    if (inProgressResponse!.status!.toLowerCase() == 'success') {
      if (inProgressResponse!.data != null) {
        inProgressRidesList = inProgressResponse!.data!;
      }
    } else {
      print(
          'object in progress ride:${inProgressResponse!.message} ${inProgressResponse!.status!}');
      if (mounted) {
        showToastError(inProgressResponse!.message!, FToast().init(context));
      }
    }
    if (mounted) {
      setState(() {
        isPageLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isPageLoading
        ? spinKitRotatingCircle
        : inProgressRidesList!.isEmpty
            ? Lottie.asset('assets/images/no-data.json')
            : ListView.builder(
                itemCount: inProgressRidesList!.length,
                shrinkWrap: true,
                reverse: true,
                padding: EdgeInsets.zero,
                // physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final listItem = inProgressRidesList![index];
                  DateTime time =
                      DateTime.parse(listItem.bookings!.date_added!);
                  var formattedTime = DateFormat('E,d MMM yyyy ').format(time);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        formattedTime.toString(),
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: grey,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 14.w, vertical: 14.h),
                            width: double.infinity,
                            height:
                                // details && selectedIndex == index
                                //     ? 185.h :
                                110.h,
                            decoration: BoxDecoration(
                              color: lightWhite,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 70.w,
                                      height: 70.h,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          width: 1,
                                          color: lightGrey.withOpacity(0.8),
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: listItem
                                                    .bookings!
                                                    .users_customers!
                                                    .profile_pic !=
                                                null
                                            ? Image.network(
                                                'https://deliver.eigix.net/public/${listItem.bookings!.users_customers!.profile_pic}',
                                                fit: BoxFit.cover,
                                                errorBuilder: (BuildContext
                                                        context,
                                                    Object exception,
                                                    StackTrace? stackTrace) {
                                                  return SizedBox(
                                                    child: SvgPicture.asset(
                                                      'assets/images/bike.svg',
                                                      fit: BoxFit.scaleDown,
                                                    ),
                                                  );
                                                },
                                                loadingBuilder:
                                                    (BuildContext context,
                                                        Widget child,
                                                        ImageChunkEvent?
                                                            loadingProgress) {
                                                  if (loadingProgress == null) {
                                                    return child;
                                                  }
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: orange,
                                                      value: loadingProgress
                                                                  .expectedTotalBytes !=
                                                              null
                                                          ? loadingProgress
                                                                  .cumulativeBytesLoaded /
                                                              loadingProgress
                                                                  .expectedTotalBytes!
                                                          : null,
                                                    ),
                                                  );
                                                },
                                              )
                                            : SvgPicture.asset(
                                                'assets/images/bike.svg',
                                                fit: BoxFit.scaleDown,
                                              ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15.w,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 200.w,
                                          child: AutoSizeText(
                                            '${listItem.bookings!.users_customers!.first_name} ${listItem.bookings!.users_customers!.last_name!}  ',
                                            maxLines: 2,
                                            minFontSize: 15,
                                            style: GoogleFonts.inter(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: black,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        SizedBox(
                                          width: 200.w,
                                          child: AutoSizeText(
                                            '${listItem.users_fleet_vehicles!.model}',
                                            minFontSize: 13,
                                            maxLines: 2,
                                            style: GoogleFonts.inter(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: grey,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 200.w,
                                          child: AutoSizeText(
                                            '(${listItem.users_fleet_vehicles!.vehicle_registration_no})',
                                            style: GoogleFonts.inter(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: grey,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                // selectedIndex == index
                                //     ? Expanded(
                                //         child: Visibility(
                                //           visible: details,
                                //           child: Column(
                                //             children: [
                                //               SizedBox(
                                //                 height: 30.h,
                                //               ),
                                //               Row(
                                //                 crossAxisAlignment:
                                //                     CrossAxisAlignment.start,
                                //                 children: [
                                //                   SvgPicture.asset(
                                //                       'assets/images/location.svg'),
                                //                   SizedBox(
                                //                     width: 7.h,
                                //                   ),
                                //                   Column(
                                //                     crossAxisAlignment:
                                //                         CrossAxisAlignment
                                //                             .start,
                                //                     children: [
                                //                       Text(
                                //                         'Pickup',
                                //                         style:
                                //                             GoogleFonts.inter(
                                //                           fontSize: 14,
                                //                           fontWeight:
                                //                               FontWeight.w400,
                                //                           color: grey,
                                //                         ),
                                //                       ),
                                //                       SizedBox(
                                //                         width: 290.w,
                                //                         child: Text(
                                //                           '${listItem.bookings!.pickup_address}',
                                //                           maxLines: 2,
                                //                           overflow: TextOverflow
                                //                               .ellipsis,
                                //                           style:
                                //                               GoogleFonts.inter(
                                //                             fontSize: 16,
                                //                             fontWeight:
                                //                                 FontWeight.w500,
                                //                             color: black,
                                //                           ),
                                //                         ),
                                //                       ),
                                //                     ],
                                //                   ),
                                //                 ],
                                //               ),
                                //             ],
                                //           ),
                                //         ),
                                //       )
                                //     : const SizedBox(),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: -10,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                  details = !details;
                                });
                                // Navigator.pushReplacement(context,
                                //     MaterialPageRoute(builder: (context) => InProgressDetails(inProgressRidesList: listItem, inProgressRidesList2: inProgressRidesList,)));
                                showModalBottomSheet(
                                    backgroundColor: white,
                                    // isDismissible: false,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      ),
                                    ),
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) => InProgressDetails(
                                          userID: userID.toString(),
                                          inProgressRidesList: listItem,
                                          inProgressRidesList2:
                                              inProgressRidesList,
                                        ));
                              },
                              child: details && selectedIndex == index
                                  ? detailsButtonDown(context)
                                  : detailsButtonDown(context),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
  }
}
