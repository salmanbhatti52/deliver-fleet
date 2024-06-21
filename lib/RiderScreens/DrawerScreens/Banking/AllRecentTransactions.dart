import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:deliver_partner/RiderScreens/DrivingLicensePictureVerification.dart';
import 'package:deliver_partner/models/API_models/getTransactionsRider.dart';
import 'package:deliver_partner/temploginReider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Constants/Colors.dart';
import '../../../Constants/back-arrow-with-container.dart';
import '../../../widgets/RecentTransactionsOnBankigScreen.dart';

class AllRecentTransactions extends StatefulWidget {
  const AllRecentTransactions({super.key});

  @override
  State<AllRecentTransactions> createState() => _AllRecentTransactionsState();
}

class _AllRecentTransactionsState extends State<AllRecentTransactions> {
  String? errorMessage;
  GetTransactionsRider getTransactionsRider = GetTransactionsRider();
  bool isLoading = true; // Add this line at the top of your widget

  weekly() async {
    setState(() {
      isLoading = true; // Add this line
    });
    sharedPreferences = await SharedPreferences.getInstance();
    userID = (sharedPreferences.getInt('userID') ?? -1);

    print("UserID $userID");
    var headersList = {'Accept': '*/*', 'Content-Type': 'application/json'};
    var url =
        Uri.parse('https://cs.deliverbygfl.com/api/get_transactions_fleet');

    var body = {
      "users_fleet_id": userID,
      "user_type": "Rider",
    };

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode == 200) {
      var responseJson = json.decode(resBody);
      getTransactionsRider = getTransactionsRiderFromJson(resBody);
      if (responseJson['status'] == 'error') {
        setState(() {
          errorMessage = responseJson['message'];
          isLoading = false;
        });
      } else {
        print(resBody);
        getTransactionsRider = getTransactionsRiderFromJson(resBody);
        setState(() {
          errorMessage = null;
          isLoading = false;
        });
      }
    } else {
      print(res.reasonPhrase);
      getTransactionsRider = getTransactionsRiderFromJson(resBody);
    }
  }

  @override
  void initState() {
    super.initState();
    weekly();
  }

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
                    height: 10.h,
                  ),
                  isLoading // Use the isLoading variable here
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          itemBuilder: (context, index) {
                            return RecentTransactionsOnBankingScreen(
                              nameOfTransaction:
                                  getTransactionsRider.data![index].narration,
                              dateOfTransaction:
                                  DateFormat('d MMMM yyyy, h:mm a').format(
                                      DateTime.parse(getTransactionsRider
                                          .data![index].dateAdded
                                          .toString())),
                              priceOfTransaction: getTransactionsRider
                                  .data![index].totalAmount
                                  .toString(),
                            );
                          },
                          itemCount: getTransactionsRider.data!.length,
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
