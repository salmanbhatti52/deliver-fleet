import 'dart:convert';
import 'package:deliver_partner/Constants/PageLoadingKits.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  double? totalEarnings;
  weekly() async {
    setState(() {
      isLoading = true; // Add this line
    });
    sharedPreferences = await SharedPreferences.getInstance();
    userID = (sharedPreferences.getInt('userID') ?? -1);

    print("UserID $userID");
    var headersList = {'Accept': '*/*', 'Content-Type': 'application/json'};
    var url = Uri.parse('https://deliverbygfl.com/api/get_transactions_fleet');

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
      totalEarnings = getTransactionsRider.data!
          .fold(0.0, (sum, item) => sum! + double.parse(item.totalAmount.toString()));
      print("totalEarnings: $totalEarnings");
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
      sharedPrefs();
    } else {
      print(res.reasonPhrase);
      getTransactionsRider = getTransactionsRiderFromJson(resBody);
    }
  }

  String? userFirstName;
  String? userLastName;
  String? userProfilePic;
  sharedPrefs() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userID = (sharedPreferences.getInt('userID') ?? -1);
    userFirstName = (sharedPreferences.getString('userFirstName') ?? '');
    userLastName = (sharedPreferences.getString('userLastName') ?? '');
    userProfilePic = (sharedPreferences.getString('userProfilePic') ?? '');

    print(
        'sharedPref Data: $userID, $userFirstName, $userLastName, $userProfilePic');
    setState(() {
      isLoading = false;
    });
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
              child: isLoading // Use the isLoading variable here
                  ? Center(child: spinKitRotatingCircle)
                  : Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Card(
                            elevation: 4, // Adds shadow
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10)), // Rounded corners
                            color: Colors
                                .orangeAccent, // Background color of the card
                            child: Padding(
                              padding: EdgeInsets.all(
                                  16.h), // Inner padding for the card content
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    // To make the card wrap its content
                                    children: [
                                      Text(
                                        'Account Holder',
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        '$userFirstName $userLastName', // Assuming totalEarnings is a double
                                        style: TextStyle(
                                          fontSize: 19.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    // To make the card wrap its content
                                    children: [
                                      Text(
                                        'Total Earnings',
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/images/currency.svg',
                                            width: 20,
                                            height: 20,
                                            // colorFilter: const ColorFilter.mode(green, BlendMode.srcIn),
                                          ),
                                          SizedBox(
                                            width: 4.w,
                                          ),
                                          Text(
                                            totalEarnings!.toStringAsFixed(2),
                                            style: TextStyle(
                                              fontSize: 24.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        ListView.builder(
                          itemBuilder: (context, index) {
                            return RecentTransactionsOnBankingScreen(
                              nameOfTransaction:
                                  getTransactionsRider.data![index].narration.toString(),
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
