import 'package:deliver_partner/Constants/Colors.dart';
import 'package:deliver_partner/Constants/PageLoadingKits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/API models/API response.dart';
import '../../../models/APIModelsFleet/GetAllRidersModel.dart';
import '../../../services/API_services.dart';
import 'DriverDetailsFleet.dart';

class AllDriversOfFleet extends StatefulWidget {
  const AllDriversOfFleet({super.key});

  @override
  State<AllDriversOfFleet> createState() => _AllDriversOfFleetState();
}

class _AllDriversOfFleetState extends State<AllDriversOfFleet> {
  int userID = -1;

  late SharedPreferences sharedPreferences;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      isLoading = true;
    });
    init();
  }

  ApiServices get service => GetIt.I<ApiServices>();

  late APIResponse<List<GetAllRidersModel>> _getAllRidersResponse;
  List<GetAllRidersModel>? _getAllRidersList;

  init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userID = (sharedPreferences.getInt('userID') ?? -1);

    Map userData = {
      "users_fleet_id": userID.toString(),
    };

    _getAllRidersResponse = await service.getAllRidersApi(userData);

    _getAllRidersList = [];
    if (_getAllRidersResponse.status!.toLowerCase() == 'success') {
      if (_getAllRidersResponse.data != null) {
        _getAllRidersList!.addAll(_getAllRidersResponse.data!);
      }
    }
    // else {
    //   showToastError(_getAllRidersResponse.message, FToast().init(context));
    // }

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? spinKitRotatingCircle
        : _getAllRidersResponse.status!.toLowerCase() == 'success'
            ? ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                itemCount: _getAllRidersList!.length,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final item = _getAllRidersList![index];
                  return GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DriverDetailsFleet(
                          allRiders: _getAllRidersList![index],
                          userIDOfSelectedDriver: _getAllRidersList![index]
                              .users_fleet_id
                              .toString(),
                        ),
                      ),
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      width: double.infinity,
                      height: 75.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: mildGrey,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 50.w,
                                height: 50.h,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: orange,
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    'https://deliver.eigix.net/public/${item.profile_pic}',
                                    fit: BoxFit.cover,
                                    errorBuilder: (BuildContext context,
                                        Object exception,
                                        StackTrace? stackTrace) {
                                      return SizedBox(
                                        child: Image.asset(
                                          'assets/images/place-holder.png',
                                          fit: BoxFit.scaleDown,
                                        ),
                                      );
                                    },
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return Center(
                                        child: CircularProgressIndicator(
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
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 180.w,
                                        child: Text(
                                          '${item.first_name} ${item.last_name} ',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: GoogleFonts.syne(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: black,
                                          ).copyWith(
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 40.w,
                                        height: 15.h,
                                        decoration: BoxDecoration(
                                          color: orange,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            const Icon(
                                              Icons.star_rate_rounded,
                                              color: Colors.yellow,
                                              size: 12,
                                            ),
                                            Text(
                                              item.bookings_ratings!,
                                              style: GoogleFonts.inter(
                                                fontSize: 12,
                                                color: white,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    item.date_added!,
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: black,
                            size: 14,
                          ),
                        ],
                      ),
                    ),
                  );
                })
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'No riders found',
                      style: GoogleFonts.syne(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: orange,
                      ),
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/images/no-data-found-1.svg',
                    width: 150.w,
                    height: 150.h,
                    fit: BoxFit.scaleDown,
                  ),
                ],
              );
  }
}
