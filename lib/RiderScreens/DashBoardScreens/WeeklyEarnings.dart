import 'package:deliver_partner/Constants/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class WeeklyEarnings extends StatefulWidget {
  final String dayOfWeek;
  final String amount;
  final String date;

  const WeeklyEarnings(
      {super.key,
      required this.dayOfWeek,
      required this.amount,
      required this.date});

  @override
  State<WeeklyEarnings> createState() => _WeeklyEarningsState();
}

class _WeeklyEarningsState extends State<WeeklyEarnings> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Details of Driver Earning',
          style: GoogleFonts.syne(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: black,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '02/06/2022, Tuesday',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: black,
              ),
            ),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/images/currency.svg',
                  colorFilter: const ColorFilter.mode(black, BlendMode.srcIn),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  '567.098',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: black,
                  ),
                )
              ],
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '02/06/2022, Tuesday',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: black,
              ),
            ),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/images/currency.svg',
                  colorFilter: const ColorFilter.mode(black, BlendMode.srcIn),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  '567.098',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: black,
                  ),
                )
              ],
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '02/06/2022, Tuesday',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: black,
              ),
            ),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/images/currency.svg',
                  colorFilter: const ColorFilter.mode(black, BlendMode.srcIn),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  '567.098',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: black,
                  ),
                )
              ],
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '02/06/2022, Tuesday',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: black,
              ),
            ),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/images/currency.svg',
                  colorFilter: const ColorFilter.mode(black, BlendMode.srcIn),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  '567.098',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: black,
                  ),
                )
              ],
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '02/06/2022, Tuesday',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: black,
              ),
            ),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/images/currency.svg',
                  colorFilter: const ColorFilter.mode(black, BlendMode.srcIn),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  '567.098',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: black,
                  ),
                )
              ],
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '02/06/2022, Tuesday',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: black,
              ),
            ),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/images/currency.svg',
                  colorFilter: const ColorFilter.mode(black, BlendMode.srcIn),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  '567.098',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: black,
                  ),
                )
              ],
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '02/06/2022, Tuesday',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: black,
              ),
            ),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/images/currency.svg',
                  colorFilter: const ColorFilter.mode(black, BlendMode.srcIn),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  '567.098',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: black,
                  ),
                )
              ],
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total',
              style: GoogleFonts.syne(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: orange,
              ),
            ),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/images/currency.svg',
                  colorFilter: const ColorFilter.mode(orange, BlendMode.srcIn),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  '567.098',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: orange,
                  ),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
