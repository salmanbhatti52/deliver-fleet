import 'package:deliver_partner/Constants/Colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class RecentTransactionsOnBankingScreen extends StatelessWidget {
  final String nameOfTransaction;
  final String dateOfTransaction;
  final String priceOfTransaction;

  const RecentTransactionsOnBankingScreen({
    super.key,
    required this.nameOfTransaction,
    required this.dateOfTransaction,
    required this.priceOfTransaction,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Card(
        elevation: 2,
        child: ListTile(
          // leading: Container(
          //   width: 55.w,
          //   height: 66.h,
          //   decoration: const BoxDecoration(
          //     shape: BoxShape.circle,
          //     color: orange,
          //   ),
          // ),
          title: AutoSizeText(
            nameOfTransaction,
            minFontSize: 11,
            maxLines: 4,
            style: GoogleFonts.syne(
              fontWeight: FontWeight.w700,
              color: black,
              fontSize: 12,
            ),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/currency.svg',
                    colorFilter: const ColorFilter.mode(green, BlendMode.srcIn),
                  ),
                  SizedBox(
                    width: 4.w,
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
              Text(
                dateOfTransaction,
                style: GoogleFonts.inter(
                  fontSize: 9,
                  fontWeight: FontWeight.w500,
                  color: grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
