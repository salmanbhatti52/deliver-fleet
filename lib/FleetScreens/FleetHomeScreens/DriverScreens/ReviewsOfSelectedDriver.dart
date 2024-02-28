import 'package:deliver_partner/Constants/PageLoadingKits.dart';
import 'package:deliver_partner/utilities/showToast.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../Constants/Colors.dart';
import '../../../../models/API models/API response.dart';
import '../../../../models/API models/GetAllRatingsModel.dart';
import '../../../../services/API_services.dart';

class ReviewsOfSelectedDriver extends StatefulWidget {
  final String userIDOfSelectedDriver;
  const ReviewsOfSelectedDriver(
      {super.key, required this.userIDOfSelectedDriver});

  @override
  State<ReviewsOfSelectedDriver> createState() =>
      _ReviewsOfSelectedDriverState();
}

class _ReviewsOfSelectedDriverState extends State<ReviewsOfSelectedDriver> {
  ApiServices get service => GetIt.I<ApiServices>();

  bool isRankingLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isRankingLoading = true;
    init();
  }

  late APIResponse<List<GetAllRatingsModel>> _allRatingsResponse;
  List<GetAllRatingsModel>? getAllRatingsList;

  init() async {
    Map allRatingsData = {
      "users_fleet_id": widget.userIDOfSelectedDriver.toString(),
    };

    _allRatingsResponse = await service.getAllRatingsAPI(allRatingsData);

    getAllRatingsList = [];
    if (_allRatingsResponse.status!.toLowerCase() == 'success') {
      if (_allRatingsResponse.data != null) {
        getAllRatingsList!.addAll(_allRatingsResponse.data!);
      }
    } else {
      showToastError('No Rating Found', FToast().init(context), seconds: 1);
    }

    setState(() {
      isRankingLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isRankingLoading
        ? spinKitRotatingCircle
        : getAllRatingsList!.isEmpty
            ? SvgPicture.asset('assets/images/no-data-found-1.svg')
            : ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(top: 14),
                itemCount: getAllRatingsList!.length,
                itemBuilder: (context, index) {
                  final item = getAllRatingsList![index];
                  DateTime dateAdded = DateTime.parse(item.date_added!);
                  var formattedDate =
                      DateFormat('MM/dd/yyyy').format(dateAdded);

                  return Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                    margin: EdgeInsets.only(bottom: 20.h),
                    height: 130.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: lightWhite,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 50.w,
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: getAllRatingsList![index]
                                                  .bookings_fleet!
                                                  .users_fleet!
                                                  .profile_pic !=
                                              null
                                          ? Image.network(
                                              'https://deliver.eigix.net/public/${getAllRatingsList![index].bookings_fleet!.users_fleet!.profile_pic}',
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (BuildContext context,
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
                                    width: 10.w,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 150.w,
                                        child: AutoSizeText(
                                          '${item.bookings_fleet!.users_fleet!.first_name}  '
                                          '${item.bookings_fleet!.users_fleet!.last_name}',
                                          maxLines: 2,
                                          minFontSize: 13,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.syne(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: black,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Row(
                                        children: [
                                          IgnorePointer(
                                            child: RatingBar.builder(
                                              glow: true,
                                              maxRating: 5,
                                              tapOnlyMode: true,
                                              unratedColor: Colors.grey,
                                              glowColor: const Color(
                                                0xffFFDF00,
                                              ),
                                              initialRating:
                                                  double.parse(item.rating!),
                                              minRating: 0,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemPadding: EdgeInsets.zero,
                                              itemSize: 10,
                                              onRatingUpdate: (rating) {},
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return const Icon(
                                                  Icons.star_rate_rounded,
                                                  color: Color(
                                                    0xffFFDF00,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          Text(
                                            '${item.rating}',
                                            style: GoogleFonts.inter(
                                              fontSize: 13,
                                              color: grey,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Text(
                                formattedDate.toString(),
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            child: AutoSizeText(
                              overflow: TextOverflow.ellipsis,
                              '${item.comment}',
                              maxLines: 3,
                              minFontSize: 13,
                              style: GoogleFonts.syne(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: black,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
  }
}
