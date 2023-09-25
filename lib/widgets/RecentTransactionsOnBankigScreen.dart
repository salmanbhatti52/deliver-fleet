import 'package:Deliver_Rider/Constants/Colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class RecentTransactionsOnBankingScreen extends StatelessWidget {
  final String nameOfTransaction;
  final String dateOfTransaction;
  final String priceOfTransaction;
  const RecentTransactionsOnBankingScreen(
      {super.key,
      required this.nameOfTransaction,
      required this.dateOfTransaction,
      required this.priceOfTransaction});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          margin: EdgeInsets.only(bottom: 22.h),
          width: double.infinity,
          height: 80.h,
          decoration: BoxDecoration(
            color: lightGrey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 55.w,
                    height: 66.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: orange,
                    ),
                  ),
                  SizedBox(
                    width: 7.w,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        nameOfTransaction,
                        minFontSize: 11,
                        maxLines: 2,
                        style: GoogleFonts.syne(
                          fontWeight: FontWeight.w700,
                          color: black,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(
                        height: 9.h,
                      ),
                      Text(
                        dateOfTransaction,
                        style: GoogleFonts.inter(
                          fontSize: 9,
                          fontWeight: FontWeight.w500,
                          color: grey,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/currency.svg',
                    colorFilter: const ColorFilter.mode(green, BlendMode.srcIn),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    priceOfTransaction,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: green,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          margin: EdgeInsets.only(bottom: 22.h),
          width: double.infinity,
          height: 80.h,
          decoration: BoxDecoration(
            color: lightGrey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 55.w,
                    height: 66.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: orange,
                    ),
                  ),
                  SizedBox(
                    width: 7.w,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        nameOfTransaction,
                        minFontSize: 11,
                        maxLines: 2,
                        style: GoogleFonts.syne(
                          fontWeight: FontWeight.w700,
                          color: black,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(
                        height: 9.h,
                      ),
                      Text(
                        dateOfTransaction,
                        style: GoogleFonts.inter(
                          fontSize: 9,
                          fontWeight: FontWeight.w500,
                          color: grey,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    '-',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: red,
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/images/currency.svg',
                    colorFilter: const ColorFilter.mode(red, BlendMode.srcIn),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    priceOfTransaction,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
