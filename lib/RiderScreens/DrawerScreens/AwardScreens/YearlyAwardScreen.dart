import 'package:Deliver_Rider/Constants/Colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class YearlyAwardScreen extends StatefulWidget {
  const YearlyAwardScreen({super.key});

  @override
  State<YearlyAwardScreen> createState() => _YearlyAwardScreenState();
}

class _YearlyAwardScreenState extends State<YearlyAwardScreen> {
  @override
  Widget build(BuildContext context) {
    return GlowingOverscrollIndicator(
      axisDirection: AxisDirection.down,
      color: orange,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            SvgPicture.asset('assets/images/stars.svg'),
            SizedBox(
              height: 15.h,
            ),
            Text(
              'Best Driver of The Week',
              style: GoogleFonts.syne(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: black,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    width: 175.w,
                    height: 65.h,
                    decoration: BoxDecoration(
                      color: orange,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '854',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            fontSize: 22,
                            color: white,
                          ),
                        ),
                        Text(
                          'Work Hours',
                          style: GoogleFonts.syne(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 12.w,
                ),
                Expanded(
                  child: Container(
                    width: 175.w,
                    height: 65.h,
                    decoration: BoxDecoration(
                      color: orange,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset('assets/images/currency.svg'),
                            Text(
                              '4567',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w700,
                                fontSize: 25,
                                color: white,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Earns Money',
                          style: GoogleFonts.syne(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              'Previous Awards',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: black,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            ListView.builder(
              itemCount: 40,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 30.0.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 60.w,
                                  height: 60.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      'assets/images/sample.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Rider Status',
                                        style: GoogleFonts.syne(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: black,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 180.w,
                                        child: AutoSizeText(
                                          'Lorem Ipsum is simply dummy text  of the printing',
                                          maxLines: 3,
                                          minFontSize: 11,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.inter(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: grey,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'Work Hours  ',
                                      style: GoogleFonts.inter(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: black,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: '45678',
                                          style: GoogleFonts.inter(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: orange,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'Earns Money   ',
                                      style: GoogleFonts.inter(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: black,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: '45678',
                                          style: GoogleFonts.inter(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: orange,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SvgPicture.asset('assets/images/award-trophy.svg'),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
