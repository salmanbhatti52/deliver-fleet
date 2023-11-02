import 'package:deliver_partner/Constants/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MonthlyEarnings extends StatefulWidget {
  const MonthlyEarnings({super.key});

  @override
  State<MonthlyEarnings> createState() => _MonthlyEarningsState();
}

class _MonthlyEarningsState extends State<MonthlyEarnings> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Column(
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
              height: 15.h,
            ),
            Text(
              'First Week of ${'June'}',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: orange,
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
                      colorFilter:
                          const ColorFilter.mode(black, BlendMode.srcIn),
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
                      colorFilter:
                          const ColorFilter.mode(black, BlendMode.srcIn),
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
                      colorFilter:
                          const ColorFilter.mode(black, BlendMode.srcIn),
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
                      colorFilter:
                          const ColorFilter.mode(black, BlendMode.srcIn),
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
                      colorFilter:
                          const ColorFilter.mode(black, BlendMode.srcIn),
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
                      colorFilter:
                          const ColorFilter.mode(black, BlendMode.srcIn),
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
                      colorFilter:
                          const ColorFilter.mode(black, BlendMode.srcIn),
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
                      colorFilter:
                          const ColorFilter.mode(orange, BlendMode.srcIn),
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
        ),
        SizedBox(
          height: 10.h,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15.h,
            ),
            Text(
              'Second Week of ${'June'}',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: orange,
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
                      colorFilter:
                          const ColorFilter.mode(black, BlendMode.srcIn),
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
                      colorFilter:
                          const ColorFilter.mode(black, BlendMode.srcIn),
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
                      colorFilter:
                          const ColorFilter.mode(black, BlendMode.srcIn),
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
                      colorFilter:
                          const ColorFilter.mode(black, BlendMode.srcIn),
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
                      colorFilter:
                          const ColorFilter.mode(black, BlendMode.srcIn),
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
                      colorFilter:
                          const ColorFilter.mode(black, BlendMode.srcIn),
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
                      colorFilter:
                          const ColorFilter.mode(black, BlendMode.srcIn),
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
                      colorFilter:
                          const ColorFilter.mode(orange, BlendMode.srcIn),
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
        ),
        SizedBox(
          height: 10.h,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15.h,
            ),
            Text(
              'Third Week of ${'June'}',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: orange,
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
                      colorFilter:
                          const ColorFilter.mode(black, BlendMode.srcIn),
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
                      colorFilter:
                          const ColorFilter.mode(black, BlendMode.srcIn),
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
                      colorFilter:
                          const ColorFilter.mode(black, BlendMode.srcIn),
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
                      colorFilter:
                          const ColorFilter.mode(black, BlendMode.srcIn),
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
                      colorFilter:
                          const ColorFilter.mode(black, BlendMode.srcIn),
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
                      colorFilter:
                          const ColorFilter.mode(black, BlendMode.srcIn),
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
                      colorFilter:
                          const ColorFilter.mode(black, BlendMode.srcIn),
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
                      colorFilter:
                          const ColorFilter.mode(orange, BlendMode.srcIn),
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
        ),
        SizedBox(
          height: 15.h,
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 28.0.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Grand Total',
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
                    colorFilter:
                        const ColorFilter.mode(orange, BlendMode.srcIn),
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
        ),
      ],
    );
  }
}
