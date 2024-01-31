import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Constants/Colors.dart';
import '../../../Constants/back-arrow-with-container.dart';
import '../../../widgets/RecentTransactionsOnBankigScreen.dart';

class AllRecentTransactions extends StatefulWidget {
  const AllRecentTransactions({super.key});

  @override
  State<AllRecentTransactions> createState() => _AllRecentTransactionsState();
}

class _AllRecentTransactionsState extends State<AllRecentTransactions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leadingWidth: 70,
        centerTitle: true,
        title: Text(
          'Recent Transactions',
          style: GoogleFonts.syne(
            fontWeight: FontWeight.w700,
            color: black,
            fontSize: 20,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 20),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: backArrowWithContainer(context),
          ),
        ),
        // actions: [
        //   Padding(
        //     padding: EdgeInsets.only(top: 8.0.h, right: 20.w),
        //     child: GestureDetector(
        //       onTap: () {},
        //       child: bankingActionButton(context),
        //     ),
        //   ),
        // ],
      ),
      body: SafeArea(
        child: GlowingOverscrollIndicator(
          axisDirection: AxisDirection.down,
          color: orange,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 50.h,
                  ),
                  ListView.builder(
                    itemBuilder: (context, index) {
                      return const RecentTransactionsOnBankingScreen(
                          nameOfTransaction: 'Transaction',
                          dateOfTransaction: '08-09-2027',
                          priceOfTransaction: '1000');
                    },
                    itemCount: 60,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const BouncingScrollPhysics(),
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
