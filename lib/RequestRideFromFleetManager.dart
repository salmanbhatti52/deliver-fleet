import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Constants/Colors.dart';
import 'Constants/back-arrow-with-container.dart';
import 'Constants/buttonContainer.dart';

class RequestRideFromFleetManager extends StatefulWidget {
  const RequestRideFromFleetManager({super.key});

  @override
  State<RequestRideFromFleetManager> createState() =>
      _RequestRideFromFleetManagerState();
}

class _RequestRideFromFleetManagerState
    extends State<RequestRideFromFleetManager> {
  int checked = -1;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: white,
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
            'Request Ride',
            style: GoogleFonts.syne(
              fontWeight: FontWeight.w700,
              color: black,
              fontSize: 20,
            ),
          ),
        ),
        body: GlowingOverscrollIndicator(
          axisDirection: AxisDirection.down,
          color: orange,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    'Select Fleet Manager',
                    style: GoogleFonts.syne(
                      fontSize: 18,
                      color: grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  SvgPicture.asset(
                    'assets/images/bike.svg',
                    width: 150.w,
                    height: 120.h,
                    fit: BoxFit.scaleDown,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: 10,
                    padding: EdgeInsets.zero,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 20.h),
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 12.h),
                        width: double.infinity,
                        height: 120.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: lightWhite,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  checked = index;
                                });
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 67.w,
                                        height: 67.h,
                                        decoration: BoxDecoration(
                                          color: orange,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Image.asset(
                                            'assets/images/sample.jpg',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 120.w,
                                            child: AutoSizeText(
                                              'Fleet Manger',
                                              maxLines: 2,
                                              minFontSize: 12,
                                              style: GoogleFonts.syne(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: black,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                  'assets/images/location.svg'),
                                              Text(
                                                'Poland',
                                                style: GoogleFonts.inter(
                                                  fontSize: 11,
                                                  color: grey,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                  'assets/images/email-icon.svg'),
                                              SizedBox(
                                                width: 4.w,
                                              ),
                                              SizedBox(
                                                width: 140.w,
                                                child: AutoSizeText(
                                                  maxLines: 2,
                                                  minFontSize: 10,
                                                  'example@gmail.com ',
                                                  style: GoogleFonts.inter(
                                                    fontSize: 11,
                                                    color: grey,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  checked == index
                                      ? SvgPicture.asset(
                                          'assets/images/checked.svg')
                                      : SvgPicture.asset(
                                          'assets/images/unchecked.svg'),
                                ],
                              ),
                            ),
                            Text(
                              '${45} rides on the go',
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: grey,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.0.h),
                    child: GestureDetector(
                      // onTap: () {
                      //   Navigator.of(context).push(
                      //     MaterialPageRoute(
                      //       builder: (context) =>
                      //           const RequestRideFromFleetSecond(),
                      //     ),
                      //   );
                      // },
                      child: buttonContainer(context, 'NEXT'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
